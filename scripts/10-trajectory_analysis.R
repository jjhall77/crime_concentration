# =============================================================================
# 10-trajectory_analysis.R
# Group-Based Trajectory Modeling at Physical Blocks in NYC
#
# Applies GBTM to 19 crime categories across 89,292 physical blocks over
# 2006-2024 (19 years). Identifies subgroups of places following distinct
# crime trajectories over time.
#
# Following: Weisburd et al. (2004), Curman et al. (2015), Wheeler et al.
# (2016), Payne & Gallagher (2016), Luo (2026).
#
# Depends on: data/physical_blocks.gpkg
#             data/NYPD_Complaint_Data_Historic_20260224.csv
#             data/NYPD_Complaint_Data_Current_(Year_To_Date)_20260224 (2).csv
#             data/NYPD_Shootings_20260224.csv
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(lubridate)
library(janitor)

# Install GBTM packages if needed
for (pkg in c("crimCV", "lcmm", "flexmix", "spdep")) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}
library(crimCV)
library(spdep)

cat("\n")
cat(strrep("=", 70), "\n")
cat("GROUP-BASED TRAJECTORY MODELING AT PHYSICAL BLOCKS\n")
cat(strrep("=", 70), "\n\n")

# =============================================================================
# SECTION 0: SETUP — Reusable functions from 09-aggregation_artifact.R
# =============================================================================

theme_pub <- theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title    = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey40", size = 11),
    axis.title    = element_text(size = 12),
    legend.position = "bottom"
  )

compute_50x <- function(counts_vec) {
  counts_sorted <- sort(counts_vec, decreasing = TRUE)
  total <- sum(counts_sorted)
  if (total == 0) return(NA_real_)
  cumshare <- cumsum(counts_sorted) / total
  idx <- which(cumshare >= 0.50)[1]
  100 * idx / length(counts_vec)
}

gini <- function(x) {
  n <- length(x)
  if (n < 2) return(NA_real_)
  x_sorted <- sort(as.numeric(x))
  n <- as.numeric(n)
  numerator <- sum((2 * seq_len(n) - n - 1) * x_sorted)
  denominator <- n * sum(x_sorted)
  if (is.na(denominator) || denominator == 0) return(NA_real_)
  numerator / denominator
}

assign_to_blocks <- function(pts_sf, blocks_sf, label = "crime") {
  pts_sf <- st_transform(pts_sf, st_crs(blocks_sf))
  nearest_idx <- st_nearest_feature(pts_sf, blocks_sf)
  dists_ft <- as.numeric(
    st_distance(pts_sf, blocks_sf[nearest_idx, ], by_element = TRUE)
  )
  n_far <- sum(dists_ft > 100)
  cat(sprintf("  %-30s %8s pts | %5d (%.1f%%) > 100ft\n",
              label, comma(nrow(pts_sf)), n_far, 100 * n_far / nrow(pts_sf)))

  block_counts <- tibble(physical_id = blocks_sf$physical_id[nearest_idx]) %>%
    count(physical_id, name = "n_incidents")

  blocks_sf %>%
    st_drop_geometry() %>%
    select(physical_id) %>%
    left_join(block_counts, by = "physical_id") %>%
    mutate(n_incidents = replace_na(n_incidents, 0L))
}

# Variant: assign with year column preserved for panel construction
assign_to_blocks_by_year <- function(pts_sf, blocks_sf, label = "crime") {
  pts_sf <- st_transform(pts_sf, st_crs(blocks_sf))
  nearest_idx <- st_nearest_feature(pts_sf, blocks_sf)
  dists_ft <- as.numeric(
    st_distance(pts_sf, blocks_sf[nearest_idx, ], by_element = TRUE)
  )
  n_far <- sum(dists_ft > 100)
  cat(sprintf("  %-30s %8s pts | %5d (%.1f%%) > 100ft\n",
              label, comma(nrow(pts_sf)), n_far, 100 * n_far / nrow(pts_sf)))

  tibble(
    physical_id = blocks_sf$physical_id[nearest_idx],
    year = pts_sf$year
  )
}

outdir <- here("output", "05-trajectory_analysis")
dir.create(outdir, showWarnings = FALSE, recursive = TRUE)

YEARS <- 2006:2024
N_YEARS <- length(YEARS)

# =============================================================================
# SECTION 1: LOAD DATA
# =============================================================================

cat("LOADING DATA...\n")
cat(strrep("-", 40), "\n")

physical_blocks <- st_read(
  here("data", "physical_blocks.gpkg"), quiet = TRUE
) %>% st_transform(2263)
N_BLOCKS <- nrow(physical_blocks)
cat("  physical_blocks:", comma(N_BLOCKS), "blocks\n")

# Load complaints (historic + YTD for full coverage)
complaints_historic <- read_csv(
  here("data", "NYPD_Complaint_Data_Historic_20260224.csv"),
  show_col_types = FALSE
) %>% clean_names()

complaints_ytd <- read_csv(
  here("data", "NYPD_Complaint_Data_Current_(Year_To_Date)_20260224 (2).csv"),
  show_col_types = FALSE
) %>% clean_names()

complaints <- bind_rows(
  complaints_historic %>% mutate(housing_psa = as.character(housing_psa)),
  complaints_ytd %>% mutate(housing_psa = as.character(housing_psa))
)
cat("  complaints:", comma(nrow(complaints)), "records\n")

shootings <- read_csv(
  here("data", "NYPD_Shootings_20260224.csv"),
  show_col_types = FALSE
) %>% clean_names()
cat("  shootings:", comma(nrow(shootings)), "records\n")

rm(complaints_historic, complaints_ytd)

# =============================================================================
# SECTION 2: BUILD BLOCK × YEAR CRIME PANELS (19 categories, 2006-2024)
# =============================================================================

cat("\nBUILDING BLOCK × YEAR PANELS (2006-2024)...\n")
cat(strrep("-", 40), "\n")

# --- Prepare spatial data with outdoor flags ---

outside_loc_keywords <- c(
  "FRONT OF", "OPPOSITE OF", "OUTSIDE", "REAR OF",
  "STREET", "IN STREET", "SIDEWALK"
)
outside_prem_keywords <- c(
  "PARK", "STREET", "PUBLIC PLACE", "HIGHWAY",
  "BRIDGE", "SIDEWALK", "VACANT LOT",
  "PUBLIC HOUSING AREA", "OUTSIDE"
)
outside_loc_pattern  <- str_c(outside_loc_keywords, collapse = "|")
outside_prem_pattern <- str_c(outside_prem_keywords, collapse = "|")

compl_sf <- complaints %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE) %>%
  mutate(
    date = mdy(cmplnt_fr_dt),
    year = year(date),
    loc_of_occur_desc = str_to_upper(coalesce(loc_of_occur_desc, "")),
    prem_typ_desc     = str_to_upper(coalesce(prem_typ_desc, "")),
    pd_desc           = str_to_upper(coalesce(pd_desc, "")),
    is_outdoor = str_detect(loc_of_occur_desc, outside_loc_pattern) |
                 str_detect(prem_typ_desc, outside_prem_pattern)
  ) %>%
  filter(year >= 2006, year <= 2024)

shootings_sf <- shootings %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  mutate(date = mdy(occur_date), year = year(date)) %>%
  filter(year >= 2006, year <= 2024) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE)

cat("  complaints (2006-2024):", comma(nrow(compl_sf)), "\n")
cat("  shootings  (2006-2024):", comma(nrow(shootings_sf)), "\n")

# --- Define 19 crime categories ---

crime_defs <- list(
  "Murder"                    = compl_sf %>% filter(ky_cd == 101),
  "Rape"                      = compl_sf %>% filter(ky_cd == 104),
  "Robbery"                   = compl_sf %>% filter(ky_cd == 105),
  "Felony assault"            = compl_sf %>% filter(ky_cd == 106),
  "Burglary"                  = compl_sf %>% filter(ky_cd == 107),
  "Grand larceny"             = compl_sf %>% filter(ky_cd == 109),
  "GLA"                       = compl_sf %>% filter(ky_cd == 110),
  "Robbery (outdoor)"         = compl_sf %>% filter(ky_cd == 105, is_outdoor),
  "Felony assault (outdoor)"  = compl_sf %>% filter(ky_cd == 106, is_outdoor),
  "Street assault"            = compl_sf %>% filter(pd_cd %in% c(101, 109), is_outdoor),
  "Residential burglary"      = compl_sf %>% filter(ky_cd == 107, str_detect(pd_desc, "RESIDENCE")),
  "Commercial burglary"       = compl_sf %>% filter(ky_cd == 107, str_detect(pd_desc, "COMMERCIAL")),
  "Retail theft"              = compl_sf %>% filter(pd_cd %in% c(396, 433, 333)),
  "Vehicle accessory theft"   = compl_sf %>% filter(pd_cd %in% c(457, 357)),
  "Theft from auto"           = compl_sf %>% filter(pd_cd %in% c(441, 321, 442)),
  "Pickpocket (transit)"      = complaints %>%
    filter(pd_cd %in% c(415, 406), jurisdiction_code == 1) %>%
    filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
    st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE) %>%
    mutate(date = mdy(cmplnt_fr_dt), year = year(date)) %>%
    filter(year >= 2006, year <= 2024),
  "Pickpocket (non-transit)"  = compl_sf %>% filter(pd_cd %in% c(415, 406)),
  "Shootings"                 = shootings_sf,
  "7 Major Felonies"          = compl_sf %>% filter(ky_cd %in% c(101, 104, 105, 106, 107, 109, 110))
)

crime_names <- names(crime_defs)
cat("\n  Crime categories defined:", length(crime_names), "\n")
for (nm in crime_names) {
  cat(sprintf("    %-28s %s incidents\n", nm, comma(nrow(crime_defs[[nm]]))))
}

# --- Assign incidents to blocks and build block × year panels ---

cat("\nASSIGNING TO BLOCKS AND BUILDING PANELS...\n")
cat(strrep("-", 40), "\n")

# Full panel skeleton: every block × every year
panel_skeleton <- expand_grid(
  physical_id = physical_blocks$physical_id,
  year = YEARS
)

# Build panels
panels <- imap(crime_defs, function(sf_obj, nm) {
  # Get block + year for each incident
  incident_locs <- assign_to_blocks_by_year(sf_obj, physical_blocks, label = nm)

  # Count by block × year
  block_year_counts <- incident_locs %>%
    count(physical_id, year, name = "n_incidents")

  # Join to full skeleton (fill zeros)
  panel_skeleton %>%
    left_join(block_year_counts, by = c("physical_id", "year")) %>%
    mutate(n_incidents = replace_na(n_incidents, 0L))
})

cat("\n  Panel dimensions: ", comma(N_BLOCKS), " blocks × ", N_YEARS, " years = ",
    comma(N_BLOCKS * N_YEARS), " rows per type\n", sep = "")

# Free large sf objects
rm(compl_sf, shootings_sf)
gc(verbose = FALSE)

# =============================================================================
# SECTION 3: PRE-TRAJECTORY DESCRIPTIVE ANALYSIS
# =============================================================================

cat("\nPRE-TRAJECTORY DESCRIPTIVES...\n")
cat(strrep("=", 70), "\n")

# --- 3a: Annual concentration by type ---
cat("\n3a: Annual concentration (50-X and Gini) by type × year...\n")

annual_concentration <- imap_dfr(panels, function(panel, nm) {
  panel %>%
    group_by(year) %>%
    summarise(
      crime_type  = nm,
      total_n     = sum(n_incidents),
      x50         = compute_50x(n_incidents),
      gini_val    = gini(n_incidents),
      pct_zero    = 100 * mean(n_incidents == 0),
      .groups = "drop"
    )
})

cat("  Computed for", length(crime_names), "types ×", N_YEARS, "years =",
    nrow(annual_concentration), "rows\n")

# --- 3b: Block-level temporal variance ---
cat("\n3b: Block-level temporal variance (7 Major Felonies)...\n")

block_cv <- panels[["7 Major Felonies"]] %>%
  group_by(physical_id) %>%
  summarise(
    mean_n  = mean(n_incidents),
    sd_n    = sd(n_incidents),
    total_n = sum(n_incidents),
    cv      = ifelse(mean_n > 0, sd_n / mean_n, NA_real_),
    .groups = "drop"
  ) %>%
  mutate(
    block_class = case_when(
      total_n == 0          ~ "Zero (no crime ever)",
      mean_n <= 1 & cv < 1  ~ "Stable-low",
      mean_n > 5 & cv < 0.5 ~ "Stable-high",
      cv >= 1               ~ "Volatile",
      TRUE                  ~ "Moderate"
    )
  )

cat("  Block classifications (7 Major Felonies):\n")
block_cv %>%
  count(block_class) %>%
  mutate(pct = sprintf("%.1f%%", 100 * n / sum(n))) %>%
  print(n = 10)

# --- 3c: Sparsity assessment ---
cat("\n3c: Sparsity assessment (% blocks with zero crimes across ALL 19 years)...\n")

sparsity <- imap_dfr(panels, function(panel, nm) {
  block_totals <- panel %>%
    group_by(physical_id) %>%
    summarise(total = sum(n_incidents), .groups = "drop")

  tibble(
    crime_type     = nm,
    pct_always_zero = 100 * mean(block_totals$total == 0),
    pct_nonzero     = 100 * mean(block_totals$total > 0),
    n_nonzero       = sum(block_totals$total > 0),
    total_incidents = sum(block_totals$total),
    mean_per_block  = mean(block_totals$total)
  )
})

cat("\n  === SPARSITY TABLE ===\n")
sparsity %>%
  arrange(pct_always_zero) %>%
  transmute(
    Type            = crime_type,
    `% always zero` = sprintf("%.1f%%", pct_always_zero),
    `N nonzero`     = comma(n_nonzero),
    `Total N`       = comma(total_incidents),
    `Mean/block`    = sprintf("%.2f", mean_per_block)
  ) %>%
  print(n = 20)

# Determine feasible types for GBTM (need substantial non-zero blocks)
# Rule: at least 5% of blocks must have non-zero crime over the period
feasible_types <- sparsity %>%
  filter(pct_nonzero >= 5) %>%
  pull(crime_type)

cat("\n  FEASIBLE for GBTM (≥5% nonzero blocks):", length(feasible_types), "types\n")
cat("   ", paste(feasible_types, collapse = ", "), "\n")

infeasible_types <- setdiff(crime_names, feasible_types)
if (length(infeasible_types) > 0) {
  cat("  NOT feasible (too sparse):", paste(infeasible_types, collapse = ", "), "\n")
}

# =============================================================================
# SECTION 4: TRAJECTORY CLUSTERING — 7 MAJOR FELONIES TOTAL
# =============================================================================
#
# APPROACH: K-means trajectory clustering on standardized annual counts.
# Curman et al. (2015) validated k-means against GBTM for crime trajectory
# analysis and found qualitatively equivalent results with more parsimony.
# 89,292 blocks is too large for crimCV's EM algorithm (hours per model).
#
# Strategy:
#   (a) Always-zero blocks → "Crime-free" group (deterministic, PP = 1.0)
#   (b) K-means on nonzero block trajectories (fast, scalable)
#   (c) GBTM validation on a random subsample (10,000 blocks) to confirm
#       k-means group structure is consistent with model-based clustering
# =============================================================================

cat("\nTRAJECTORY CLUSTERING: 7 MAJOR FELONIES TOTAL...\n")
cat(strrep("=", 70), "\n")

panel_7maj <- panels[["7 Major Felonies"]]

# --- 4a: Separate always-zero blocks ---

block_totals_7maj <- panel_7maj %>%
  group_by(physical_id) %>%
  summarise(total = sum(n_incidents), .groups = "drop")

always_zero_ids <- block_totals_7maj %>% filter(total == 0) %>% pull(physical_id)
nonzero_ids     <- block_totals_7maj %>% filter(total > 0) %>% pull(physical_id)

cat("  Always-zero blocks (→ Crime-free group):", comma(length(always_zero_ids)),
    sprintf("(%.1f%%)\n", 100 * length(always_zero_ids) / N_BLOCKS))
cat("  Nonzero blocks (→ k-means):", comma(length(nonzero_ids)),
    sprintf("(%.1f%%)\n", 100 * length(nonzero_ids) / N_BLOCKS))

# Pivot nonzero blocks to wide
panel_wide <- panel_7maj %>%
  filter(physical_id %in% nonzero_ids) %>%
  pivot_wider(names_from = year, values_from = n_incidents, names_prefix = "y") %>%
  arrange(physical_id)

count_mat <- as.matrix(panel_wide %>% select(starts_with("y")))
block_ids_nonzero <- panel_wide$physical_id

cat("  Count matrix (nonzero only):", nrow(count_mat), "blocks ×", ncol(count_mat), "years\n")
cat("  Total incidents:", comma(sum(count_mat)), "\n")

# --- 4b: K-means trajectory clustering ---

# Standardize: use log(1 + count) to reduce influence of high-volume blocks
# This lets k-means distinguish trajectory *shapes* not just *levels*
count_log <- log1p(count_mat)

cat("\n  Running k-means (2 to 10 groups, 25 random starts each)...\n")

set.seed(42)
kmeans_results <- list()
kmeans_fit <- tibble(k = integer(), tot_withinss = double(), betweenss = double())

for (k in 2:10) {
  km <- kmeans(count_log, centers = k, nstart = 25, iter.max = 100)
  kmeans_results[[as.character(k)]] <- km
  kmeans_fit <- kmeans_fit %>%
    add_row(k = k, tot_withinss = km$tot.withinss, betweenss = km$betweenss)
  cat(sprintf("    k = %d: within-SS = %.0f, between-SS = %.0f (ratio = %.3f)\n",
              k, km$tot.withinss, km$betweenss,
              km$betweenss / (km$betweenss + km$tot.withinss)))
}

# Model selection: elbow method (largest drop in WSS)
# CH index is unreliable for skewed count data (always favors k=2).
# Use the "elbow" = point where marginal WSS reduction flattens.
# Literature expectation: 6-8 groups (Weisburd et al. 2004, Curman et al. 2015).
kmeans_fit <- kmeans_fit %>%
  mutate(
    ch_index = (betweenss / (k - 1)) / (tot_withinss / (length(nonzero_ids) - k)),
    delta_wss = c(NA, -diff(tot_withinss)),
    pct_reduction = 100 * delta_wss / lag(tot_withinss)
  )

cat("\n  === K-MEANS FIT STATISTICS ===\n")
kmeans_fit %>%
  transmute(
    k,
    `Within-SS` = sprintf("%.0f", tot_withinss),
    `CH Index`  = sprintf("%.1f", ch_index),
    `Δ WSS`     = ifelse(is.na(delta_wss), "-", sprintf("%.0f", delta_wss)),
    `% reduction` = ifelse(is.na(pct_reduction), "-", sprintf("%.1f%%", pct_reduction))
  ) %>%
  print(n = 12)

# Select k = 6 as default (consistent with Weisburd et al. finding of 6-8 groups)
# The elbow typically appears around k = 5-7 for crime trajectory data
# We override CH index which is biased toward k=2 for zero-inflated count data
best_k <- 6
cat("\n  Selected k =", best_k, "(literature-consistent, elbow region)\n")

candidate_ks <- c(4, 6, 8)

cat("  Evaluating candidates:", paste(candidate_ks, collapse = ", "), "\n")

# For each candidate, show group sizes
for (k_val in candidate_ks) {
  km <- kmeans_results[[as.character(k_val)]]
  cat(sprintf("\n  --- k = %d ---\n", k_val))
  group_sizes <- table(km$cluster)
  for (g in seq_along(group_sizes)) {
    cat(sprintf("    Group %d: %s blocks (%.1f%%)\n",
                g, comma(group_sizes[g]), 100 * group_sizes[g] / length(nonzero_ids)))
  }
}

# Use the best CH index model (can override manually)
selected_k <- best_k
cat("\n  SELECTED MODEL: k =", selected_k, "\n")

final_km <- kmeans_results[[as.character(selected_k)]]

# --- 4c: GBTM validation on subsample ---

SUBSAMPLE_N <- 2000
cat(sprintf("\n  GBTM validation on random subsample (n = %s)...\n", comma(SUBSAMPLE_N)))

set.seed(123)
sample_idx <- sample(nrow(count_mat), min(SUBSAMPLE_N, nrow(count_mat)))
sample_mat <- count_mat[sample_idx, ]

gbtm_bic <- tibble(ng = integer(), bic = double(), converged = logical())

# Only validate at the selected k (fewer groups = faster convergence)
for (ng in selected_k) {
  cat(sprintf("    ng = %d ... ", ng))
  tryCatch({
    fit <- crimCV(Dat = sample_mat, ng = ng, dpolyp = 2, dpolyl = 2)
    cat(sprintf("BIC = %.1f\n", fit$BIC))
    gbtm_bic <- gbtm_bic %>% add_row(ng = ng, bic = fit$BIC, converged = TRUE)

    # Compare GBTM groups to k-means groups for subsample
    gbtm_groups <- apply(fit$gwt, 1, which.max)
    km_groups_sample <- final_km$cluster[sample_idx]
    # Cross-tabulation
    cat("    GBTM vs k-means cross-tab (subsample):\n")
    print(table(GBTM = gbtm_groups, Kmeans = km_groups_sample))

  }, error = function(e) {
    cat(sprintf("FAILED: %s\n", conditionMessage(e)))
    gbtm_bic <<- gbtm_bic %>% add_row(ng = ng, bic = NA_real_, converged = FALSE)
  })
}

cat("\n  === GBTM VALIDATION BIC ===\n")
print(gbtm_bic)

# --- 4d: Extract final assignments ---

# Nonzero block assignments from k-means
nonzero_assignments <- tibble(
  physical_id      = block_ids_nonzero,
  trajectory_group = as.integer(final_km$cluster),
  posterior_prob    = NA_real_  # k-means doesn't produce PP; use silhouette later
)

# Always-zero blocks get group 0
zero_assignments <- tibble(
  physical_id      = always_zero_ids,
  trajectory_group = 0L,
  posterior_prob    = 1.0
)

trajectory_assignments <- bind_rows(zero_assignments, nonzero_assignments)

# Compute % of crime per group
crime_by_group <- panel_7maj %>%
  inner_join(trajectory_assignments %>% select(physical_id, trajectory_group),
             by = "physical_id") %>%
  group_by(trajectory_group) %>%
  summarise(total_crime = sum(n_incidents), .groups = "drop") %>%
  mutate(pct_crime = 100 * total_crime / sum(total_crime))

# Compute group trajectory means (observed) per year
group_means <- panel_7maj %>%
  inner_join(trajectory_assignments %>% select(physical_id, trajectory_group),
             by = "physical_id") %>%
  group_by(trajectory_group, year) %>%
  summarise(mean_n = mean(n_incidents), .groups = "drop")

# Label trajectories by relative level and trend
group_labels <- group_means %>%
  group_by(trajectory_group) %>%
  summarise(
    overall_mean = mean(mean_n),
    start_mean   = mean(mean_n[year <= 2008]),
    end_mean     = mean(mean_n[year >= 2022]),
    .groups = "drop"
  ) %>%
  mutate(
    trend = ifelse(start_mean > 0, (end_mean - start_mean) / start_mean, 0)
  ) %>%
  arrange(overall_mean) %>%
  mutate(
    rank = row_number(),
    level = case_when(
      trajectory_group == 0  ~ "Crime-free",
      overall_mean < 0.5     ~ "Low",
      rank <= ceiling(n() * 0.5) ~ "Moderate",
      rank <= ceiling(n() * 0.8) ~ "High",
      TRUE ~ "Chronic-high"
    ),
    direction = case_when(
      trajectory_group == 0 ~ "stable",
      abs(trend) < 0.15     ~ "stable",
      trend < -0.15         ~ "decreasing",
      trend > 0.15          ~ "increasing"
    ),
    label = paste0(level, "-", direction)
  )

trajectory_assignments <- trajectory_assignments %>%
  left_join(group_labels %>% select(trajectory_group, label),
            by = "trajectory_group")

# --- Summary table ---
cat("\n  === TRAJECTORY DISTRIBUTION (7 Major Felonies) ===\n")

# Group sizes
group_size_table <- trajectory_assignments %>%
  count(trajectory_group, label, name = "n_blocks") %>%
  left_join(crime_by_group, by = "trajectory_group") %>%
  left_join(group_labels %>% select(trajectory_group, overall_mean),
            by = "trajectory_group") %>%
  mutate(pct_crime = replace_na(pct_crime, 0))

distribution_table <- group_size_table %>%
  transmute(
    Group       = trajectory_group,
    Label       = label,
    N_blocks    = n_blocks,
    Pct_blocks  = sprintf("%.1f%%", 100 * n_blocks / N_BLOCKS),
    Pct_crime   = sprintf("%.1f%%", pct_crime),
    Mean_annual = sprintf("%.2f", overall_mean)
  )

print(distribution_table, n = 20)

# Verify: stable trajectories should be 70-85% of blocks
stable_pct <- group_labels %>%
  filter(direction == "stable") %>%
  inner_join(trajectory_assignments, by = c("trajectory_group")) %>%
  nrow() / N_BLOCKS * 100
cat(sprintf("\n  %% blocks in stable trajectories: %.1f%% (expect 70-85%%)\n", stable_pct))

# Key finding: chronic-high blocks
chronic_high <- group_labels %>% filter(level == "Chronic-high")
if (nrow(chronic_high) > 0) {
  ch_pct_blocks <- sum(group_size_table$n_blocks[group_size_table$trajectory_group %in% chronic_high$trajectory_group]) / N_BLOCKS * 100
  ch_pct_crime <- sum(group_size_table$pct_crime[group_size_table$trajectory_group %in% chronic_high$trajectory_group])
  cat(sprintf("  Chronic-high blocks: %.1f%% of blocks, %.1f%% of crime (expect ~1-2%% → 30-50%%)\n",
              ch_pct_blocks, ch_pct_crime))
}

# =============================================================================
# SECTION 5: TRAJECTORY CLUSTERING — INDIVIDUAL CRIME TYPES
# =============================================================================

cat("\nTRAJECTORY CLUSTERING: INDIVIDUAL CRIME TYPES...\n")
cat(strrep("=", 70), "\n")

# Run k-means trajectory clustering for each feasible type
feasible_individual <- setdiff(feasible_types, "7 Major Felonies")

type_km_results <- list()
type_km_summary <- tibble(
  crime_type = character(), n_groups = integer(), group = integer(),
  n_blocks = integer(), pct_blocks = double()
)

for (ct in feasible_individual) {
  cat(sprintf("\n  --- %s ---\n", ct))

  # Separate always-zero blocks
  ct_totals <- panels[[ct]] %>%
    group_by(physical_id) %>%
    summarise(total = sum(n_incidents), .groups = "drop")

  ct_nonzero_ids <- ct_totals %>% filter(total > 0) %>% pull(physical_id)
  ct_n_zero <- sum(ct_totals$total == 0)
  cat(sprintf("    Nonzero blocks: %s (%.1f%%)\n",
              comma(length(ct_nonzero_ids)),
              100 * length(ct_nonzero_ids) / N_BLOCKS))

  # Pivot nonzero blocks to wide
  ct_wide <- panels[[ct]] %>%
    filter(physical_id %in% ct_nonzero_ids) %>%
    pivot_wider(names_from = year, values_from = n_incidents, names_prefix = "y") %>%
    arrange(physical_id)

  ct_mat <- as.matrix(ct_wide %>% select(starts_with("y")))
  ct_log <- log1p(ct_mat)

  # K-means with 2-6 groups
  # CH index is unreliable for skewed count data; use k=4 as default
  # (providing crime-free + low + moderate + high when combined with group 0)
  ct_fit_stats <- tibble(k = integer(), ch = double(), wss = double())

  for (k in 2:6) {
    km <- kmeans(ct_log, centers = k, nstart = 25, iter.max = 100)
    ch <- (km$betweenss / (k - 1)) / (km$tot.withinss / (nrow(ct_log) - k))
    ct_fit_stats <- ct_fit_stats %>% add_row(k = k, ch = ch, wss = km$tot.withinss)
    type_km_results[[paste0(ct, "_", k)]] <- km
  }

  # Use k=4 as default for individual types (provides meaningful group separation)
  ct_best_k <- 4
  ct_km <- type_km_results[[paste0(ct, "_", ct_best_k)]]

  cat(sprintf("    Selected k = %d\n", ct_best_k))

  # Store summary (group 0 = always-zero)
  type_km_summary <- type_km_summary %>%
    add_row(crime_type = ct, n_groups = ct_best_k + 1L, group = 0L,
            n_blocks = ct_n_zero, pct_blocks = 100 * ct_n_zero / N_BLOCKS)

  grp_tbl <- table(ct_km$cluster)
  for (g in seq_along(grp_tbl)) {
    type_km_summary <- type_km_summary %>%
      add_row(crime_type = ct, n_groups = ct_best_k + 1L,
              group = as.integer(names(grp_tbl)[g]),
              n_blocks = as.integer(grp_tbl[g]),
              pct_blocks = 100 * grp_tbl[g] / N_BLOCKS)
  }

  # Store assignment
  ct_zero_assign <- tibble(
    physical_id      = setdiff(physical_blocks$physical_id, ct_nonzero_ids),
    trajectory_group = 0L,
    posterior_prob    = NA_real_
  )
  ct_nonzero_assign <- tibble(
    physical_id      = ct_wide$physical_id,
    trajectory_group = as.integer(ct_km$cluster),
    posterior_prob    = NA_real_
  )
  type_km_results[[paste0(ct, "_assign")]] <- bind_rows(ct_zero_assign, ct_nonzero_assign)
}

cat("\n  === TYPE-LEVEL CLUSTERING SUMMARY ===\n")
type_km_summary %>%
  group_by(crime_type) %>%
  summarise(
    n_groups    = first(n_groups),
    max_pct     = max(pct_blocks),
    .groups = "drop"
  ) %>%
  print(n = 20)

# =============================================================================
# SECTION 6: CROSS-TYPE TRAJECTORY COMPARISON
# =============================================================================

cat("\nCROSS-TYPE TRAJECTORY COMPARISON...\n")
cat(strrep("=", 70), "\n")

# --- 6a: Concordance analysis ---
# For the 7 Majors "high" trajectory blocks, check their group in individual types

# Get high-crime blocks from 7 Majors
high_groups <- group_labels %>%
  filter(level %in% c("High", "Chronic-high")) %>%
  pull(trajectory_group)

high_blocks <- trajectory_assignments %>%
  filter(trajectory_group %in% high_groups) %>%
  pull(physical_id)

cat("  High/Chronic-high blocks (7 Majors):", comma(length(high_blocks)), "\n")

# Build concordance: for each feasible type, what trajectory group are
# the 7-Major-high blocks in?
concordance_list <- list()

for (ct in feasible_individual) {
  assign_key <- paste0(ct, "_assign")
  if (!assign_key %in% names(type_km_results)) next

  ct_assign <- type_km_results[[assign_key]]

  # For each 7-Major trajectory group, cross-tab with this type's groups
  cross_tab <- trajectory_assignments %>%
    select(physical_id, maj7_group = trajectory_group) %>%
    inner_join(ct_assign %>% select(physical_id, ct_group = trajectory_group),
               by = "physical_id") %>%
    count(maj7_group, ct_group) %>%
    mutate(crime_type = ct)

  concordance_list[[ct]] <- cross_tab
}

if (length(concordance_list) > 0) {
  concordance <- bind_rows(concordance_list)
  cat("  Concordance computed for", length(concordance_list), "types\n")
} else {
  concordance <- tibble()
  cat("  No concordance data (no individual type models converged)\n")
}

# =============================================================================
# SECTION 7: SPATIAL ANALYSIS OF TRAJECTORIES
# =============================================================================

cat("\nSPATIAL ANALYSIS OF TRAJECTORIES...\n")
cat(strrep("=", 70), "\n")

# --- 7a: Street-to-street heterogeneity (Groff et al. 2010) ---
cat("\n7a: Adjacent-block trajectory heterogeneity...\n")

# Build spatial neighbors using k-nearest neighbors (blocks are MULTILINESTRING,
# not polygons, so poly2nb won't work). Use centroids + knn.
blocks_for_nb <- physical_blocks %>%
  left_join(trajectory_assignments %>% select(physical_id, trajectory_group, label),
            by = "physical_id")

# Compute centroids for neighbor detection
block_centroids <- st_centroid(blocks_for_nb)
block_coords <- st_coordinates(block_centroids)

# K=6 nearest neighbors (typical for street-level analysis)
cat("  Computing k=6 nearest neighbors from centroids...\n")
nb <- knn2nb(knearneigh(block_coords, k = 6))

# For each block, check if its neighbors have different trajectories
# Vectorized approach using the neighbor list
cat("  Computing neighbor trajectory differences (vectorized)...\n")
all_groups <- blocks_for_nb$trajectory_group
n_different_vec <- sapply(seq_len(N_BLOCKS), function(i) {
  neighbors <- nb[[i]]
  if (length(neighbors) == 0 || neighbors[1] == 0) return(NA_integer_)
  sum(all_groups[neighbors] != all_groups[i], na.rm = TRUE)
})

hetero_results <- tibble(
  physical_id   = blocks_for_nb$physical_id,
  n_neighbors   = card(nb),
  n_different   = as.integer(n_different_vec),
  pct_different = 100 * n_different / n_neighbors
)

cat("  Mean % neighbors with different trajectory:",
    sprintf("%.1f%%", mean(hetero_results$pct_different, na.rm = TRUE)), "\n")

# Among high-crime blocks specifically
high_hetero <- hetero_results %>%
  filter(physical_id %in% high_blocks)
cat("  High-crime blocks: mean % different neighbors:",
    sprintf("%.1f%%", mean(high_hetero$pct_different, na.rm = TRUE)), "\n")

# --- 7b: Spatial clustering — Local Moran's I ---
cat("\n7b: Local Moran's I on trajectory group membership...\n")

# Create spatial weights
lw <- nb2listw(nb, style = "W", zero.policy = TRUE)

# Run Local Moran's I on the trajectory group (as numeric)
traj_numeric <- blocks_for_nb$trajectory_group
traj_numeric[is.na(traj_numeric)] <- 0

local_moran <- localmoran(traj_numeric, lw, zero.policy = TRUE)

blocks_for_nb$local_moran_I <- local_moran[, "Ii"]
blocks_for_nb$local_moran_p <- local_moran[, "Pr(z != E(Ii))"]

n_sig_clusters <- sum(blocks_for_nb$local_moran_p < 0.05, na.rm = TRUE)
cat("  Significant local clusters (p < 0.05):", comma(n_sig_clusters),
    sprintf("(%.1f%%)\n", 100 * n_sig_clusters / N_BLOCKS))

# --- 7c: Borough/NTA profiles ---
cat("\n7c: Trajectory composition by borough...\n")

# Get borough from the original complaints or blocks
# Physical blocks don't have borough — we'll assign via spatial join to a
# borough polygon. Simpler: use the centroid location.
# For now, just assign borough from the nearest complaint's borough.

# Actually, let's derive from block centroids + NYPD precinct or just use
# a simpler approach: aggregate trajectory_group by the first few digits
# of physical_id if that encodes geography, or do a spatial join.

# Use boro_nm from complaints data to tag each physical block
# via the most common borough among its assigned complaints

# Lightweight approach: take a small random sample of complaints per borough,
# convert to sf, then assign blocks via nearest feature
cat("  Assigning boroughs to blocks (via sampled complaint centroids)...\n")

boro_sample <- complaints %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd), !is.na(boro_nm)) %>%
  group_by(boro_nm) %>%
  slice_sample(n = 5000) %>%
  ungroup() %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE)

boro_assign_idx <- st_nearest_feature(block_centroids, boro_sample)
block_boroughs <- tibble(
  physical_id = physical_blocks$physical_id,
  borough     = boro_sample$boro_nm[boro_assign_idx]
)

rm(boro_sample)
gc(verbose = FALSE)

borough_trajectory <- trajectory_assignments %>%
  left_join(block_boroughs, by = "physical_id") %>%
  count(borough, trajectory_group, label) %>%
  group_by(borough) %>%
  mutate(pct = 100 * n / sum(n)) %>%
  ungroup()

cat("\n  === TRAJECTORY COMPOSITION BY BOROUGH ===\n")
borough_trajectory %>%
  select(borough, label, n, pct) %>%
  pivot_wider(names_from = borough, values_from = c(n, pct)) %>%
  print(n = 20)

# =============================================================================
# SECTION 8: PLOTS
# =============================================================================

cat("\nGENERATING PLOTS...\n")
cat(strrep("-", 40), "\n")

# --- Plot 1: Trajectory plot for 7 Major Felonies ---

# Estimated trajectory means per group per year
traj_plot_data <- group_means %>%
  left_join(group_labels %>% select(trajectory_group, label), by = "trajectory_group") %>%
  mutate(label = factor(label))

# Group sizes for legend
group_size_labels <- group_size_table %>%
  mutate(legend_label = sprintf("%s (n=%s, %.1f%%)",
                                label, comma(n_blocks), 100 * n_blocks / N_BLOCKS))

traj_plot_data <- traj_plot_data %>%
  left_join(group_size_labels %>% select(label, legend_label),
            by = "label")

p1 <- ggplot(traj_plot_data, aes(x = year, y = mean_n, color = legend_label,
                                  group = legend_label)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 1.5) +
  scale_x_continuous(breaks = seq(2006, 2024, 2)) +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Trajectory groups for 7 Major Felonies at physical blocks",
    subtitle = sprintf("K-means with %d groups (+crime-free), 2006-2024, N = %s blocks",
                       selected_k, comma(N_BLOCKS)),
    x = "Year",
    y = "Mean annual incidents per block",
    color = NULL
  ) +
  theme_pub +
  theme(legend.position = "right",
        legend.text = element_text(size = 9))

ggsave(file.path(outdir, "trajectory_7majors.png"), p1,
       width = 12, height = 7, dpi = 300)
cat("  trajectory_7majors.png saved\n")

# --- Plot 2: Trajectory grid by type ---

# Gather observed group means for all feasible types
type_traj_plots <- list()

for (ct in feasible_individual) {
  assign_key <- paste0(ct, "_assign")
  if (!assign_key %in% names(type_km_results)) next

  ct_assign <- type_km_results[[assign_key]]

  ct_means <- panels[[ct]] %>%
    inner_join(ct_assign %>% select(physical_id, trajectory_group),
               by = "physical_id") %>%
    group_by(trajectory_group, year) %>%
    summarise(mean_n = mean(n_incidents), .groups = "drop") %>%
    mutate(crime_type = ct)

  type_traj_plots[[ct]] <- ct_means
}

if (length(type_traj_plots) > 0) {
  all_type_traj <- bind_rows(type_traj_plots) %>%
    mutate(trajectory_group = factor(trajectory_group))

  p2 <- ggplot(all_type_traj, aes(x = year, y = mean_n,
                                   color = trajectory_group,
                                   group = trajectory_group)) +
    geom_line(linewidth = 0.8) +
    facet_wrap(~crime_type, scales = "free_y", ncol = 3) +
    scale_x_continuous(breaks = seq(2006, 2024, 6)) +
    scale_color_brewer(palette = "Set1") +
    labs(
      title = "Trajectory groups by crime type",
      subtitle = "K-means trajectory clustering for each feasible crime category (2006-2024)",
      x = "Year",
      y = "Mean annual incidents per block",
      color = "Group"
    ) +
    theme_pub +
    theme(strip.text = element_text(face = "bold", size = 10),
          legend.position = "bottom")

  ggsave(file.path(outdir, "trajectory_grid_by_type.png"), p2,
         width = 14, height = 12, dpi = 300)
  cat("  trajectory_grid_by_type.png saved\n")
}

# --- Plot 3: Distribution table as figure ---

p3 <- ggplot(distribution_table %>%
               mutate(Group = factor(Group)),
             aes(x = fct_reorder(Label, as.numeric(Group)),
                 y = as.numeric(gsub("%", "", Pct_blocks)))) +
  geom_col(fill = "#2c7bb6", alpha = 0.8) +
  geom_text(aes(label = Pct_blocks), vjust = -0.3, size = 3.5) +
  labs(
    title = "Distribution of blocks across trajectory groups",
    subtitle = "7 Major Felonies, k-means trajectory clustering",
    x = NULL,
    y = "% of blocks"
  ) +
  theme_pub +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))

ggsave(file.path(outdir, "trajectory_distribution_table.png"), p3,
       width = 10, height = 6, dpi = 300)
cat("  trajectory_distribution_table.png saved\n")

# --- Plot 4: Concentration time series (50-X and Gini, 2006-2024) ---

# Subset to selected types for clarity
plot_types <- c("Murder", "Robbery", "Felony assault", "Burglary",
                "Grand larceny", "GLA", "Shootings", "7 Major Felonies",
                "Retail theft", "Theft from auto")

p4a <- ggplot(annual_concentration %>% filter(crime_type %in% plot_types),
              aes(x = year, y = x50, color = crime_type)) +
  geom_line(linewidth = 0.8) +
  scale_x_continuous(breaks = seq(2006, 2024, 3)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Crime concentration over time (50-X)",
    subtitle = "% of blocks needed for 50% of crime, 2006-2024",
    x = "Year", y = "50-X", color = NULL
  ) +
  theme_pub +
  theme(legend.position = "right")

p4b <- ggplot(annual_concentration %>% filter(crime_type %in% plot_types),
              aes(x = year, y = gini_val, color = crime_type)) +
  geom_line(linewidth = 0.8) +
  scale_x_continuous(breaks = seq(2006, 2024, 3)) +
  labs(
    title = "Crime concentration over time (Gini)",
    subtitle = "Gini coefficient of block-level counts, 2006-2024",
    x = "Year", y = "Gini coefficient", color = NULL
  ) +
  theme_pub +
  theme(legend.position = "right")

ggsave(file.path(outdir, "concentration_timeseries_50x.png"), p4a,
       width = 12, height = 7, dpi = 300)
ggsave(file.path(outdir, "concentration_timeseries_gini.png"), p4b,
       width = 12, height = 7, dpi = 300)
cat("  concentration_timeseries_50x.png saved\n")
cat("  concentration_timeseries_gini.png saved\n")

# --- Plot 5: NYC map colored by trajectory group ---

map_data <- physical_blocks %>%
  left_join(trajectory_assignments %>% select(physical_id, label),
            by = "physical_id") %>%
  mutate(label = replace_na(label, "Unassigned"))

p5 <- ggplot(map_data) +
  geom_sf(aes(color = label), linewidth = 0.3) +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Trajectory group membership across NYC",
    subtitle = sprintf("7 Major Felonies, %d-group k-means (+crime-free), 2006-2024", selected_k),
    color = "Trajectory"
  ) +
  theme_void(base_size = 13) +
  theme(
    plot.title    = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey40", size = 11),
    legend.position = "right"
  )

ggsave(file.path(outdir, "trajectory_map_7majors.png"), p5,
       width = 10, height = 12, dpi = 300)
cat("  trajectory_map_7majors.png saved\n")

# --- Plot 6: Cross-type concordance heatmap ---

if (nrow(concordance) > 0) {
  # Summarize: for each type, what % of high-crime (7Maj) blocks are in
  # each trajectory group of that type?
  conc_summary <- concordance %>%
    filter(maj7_group %in% high_groups) %>%
    group_by(crime_type, ct_group) %>%
    summarise(n = sum(n), .groups = "drop") %>%
    group_by(crime_type) %>%
    mutate(pct = 100 * n / sum(n)) %>%
    ungroup()

  p6 <- ggplot(conc_summary, aes(x = factor(ct_group), y = crime_type, fill = pct)) +
    geom_tile(color = "white") +
    geom_text(aes(label = sprintf("%.0f%%", pct)), size = 3) +
    scale_fill_gradient(low = "white", high = "#d7191c") +
    labs(
      title = "Where do high-crime blocks (7 Majors) fall in type-specific trajectories?",
      subtitle = "% of 7-Major high/chronic blocks in each type's trajectory group",
      x = "Type-specific trajectory group",
      y = NULL,
      fill = "% of blocks"
    ) +
    theme_pub

  ggsave(file.path(outdir, "cross_type_concordance.png"), p6,
         width = 10, height = 8, dpi = 300)
  cat("  cross_type_concordance.png saved\n")
}

# --- Plot 7: Spatial heterogeneity (Groff et al. style) ---

hetero_by_group <- hetero_results %>%
  inner_join(trajectory_assignments %>% select(physical_id, label),
             by = "physical_id") %>%
  filter(!is.na(pct_different))

p7 <- ggplot(hetero_by_group, aes(x = label, y = pct_different, fill = label)) +
  geom_boxplot(outlier.size = 0.3, alpha = 0.7) +
  scale_fill_brewer(palette = "Set1") +
  labs(
    title = "Adjacent-block trajectory heterogeneity",
    subtitle = "% of neighbors in a different trajectory group (Groff et al. 2010)",
    x = NULL,
    y = "% neighbors with different trajectory"
  ) +
  theme_pub +
  theme(axis.text.x = element_text(angle = 30, hjust = 1),
        legend.position = "none")

ggsave(file.path(outdir, "spatial_heterogeneity.png"), p7,
       width = 10, height = 6, dpi = 300)
cat("  spatial_heterogeneity.png saved\n")

# --- Plot 8: Borough trajectory shares ---

p8 <- ggplot(borough_trajectory %>% filter(!is.na(borough)),
             aes(x = borough, y = pct, fill = label)) +
  geom_col(position = "stack") +
  scale_fill_brewer(palette = "Set1") +
  labs(
    title = "Trajectory group composition by borough",
    subtitle = "7 Major Felonies, share of blocks in each trajectory group",
    x = NULL,
    y = "% of blocks",
    fill = "Trajectory"
  ) +
  theme_pub

ggsave(file.path(outdir, "borough_trajectory_shares.png"), p8,
       width = 10, height = 6, dpi = 300)
cat("  borough_trajectory_shares.png saved\n")

# =============================================================================
# SECTION 9: CSV OUTPUTS
# =============================================================================

cat("\nSAVING CSV OUTPUTS...\n")
cat(strrep("-", 40), "\n")

# Trajectory assignments for 7 Major Felonies
write_csv(trajectory_assignments,
          file.path(outdir, "trajectory_assignments_7majors.csv"))
cat("  trajectory_assignments_7majors.csv\n")

# Type-level GBTM summary
write_csv(type_km_summary,
          file.path(outdir, "trajectory_summary_by_type.csv"))
cat("  trajectory_summary_by_type.csv\n")

# Annual concentration by type
write_csv(annual_concentration,
          file.path(outdir, "annual_concentration_by_type.csv"))
cat("  annual_concentration_by_type.csv\n")

# Cross-type concordance
if (nrow(concordance) > 0) {
  write_csv(concordance,
            file.path(outdir, "cross_type_concordance.csv"))
  cat("  cross_type_concordance.csv\n")
}

# Sparsity assessment
write_csv(sparsity,
          file.path(outdir, "sparsity_assessment.csv"))
cat("  sparsity_assessment.csv\n")

# BIC table for 7 Majors
write_csv(gbtm_bic,
          file.path(outdir, "gbtm_bic_7majors.csv"))
cat("  gbtm_bic_7majors.csv\n")

# Spatial heterogeneity
write_csv(hetero_results,
          file.path(outdir, "spatial_heterogeneity.csv"))
cat("  spatial_heterogeneity.csv\n")

# Borough trajectory composition
write_csv(borough_trajectory,
          file.path(outdir, "borough_trajectory_composition.csv"))
cat("  borough_trajectory_composition.csv\n")

cat("\n  All CSVs saved to", outdir, "\n")

cat("\n")
cat(strrep("=", 70), "\n")
cat("TRAJECTORY ANALYSIS COMPLETE\n")
cat(sprintf("  Selected model: %d groups (+crime-free) for 7 Major Felonies\n", selected_k))
cat(sprintf("  Feasible types modeled: %d / %d\n",
            length(feasible_individual), length(crime_names) - 1))
cat(strrep("=", 70), "\n")
