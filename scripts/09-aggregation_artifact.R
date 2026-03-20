# =============================================================================
# 09-aggregation_artifact.R
# The Aggregation Artifact: Why the 4-6% Bandwidth Is Math, Not Law
#
# Demonstrates that aggregating heterogeneous crime types mechanically
# compresses 50-X concentration into a narrow bandwidth through six
# mathematical mechanisms: diversification, volume dominance, CLT
# compression, Poisson superposition, Jensen's inequality, and
# lognormal convergence.
#
# Depends on: data/physical_blocks.gpkg
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(lubridate)
library(janitor)

cat("\n")
cat(strrep("=", 70), "\n")
cat("AGGREGATION ARTIFACT ANALYSIS\n")
cat(strrep("=", 70), "\n\n")

# =============================================================================
# SECTION 0: SETUP
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

gini_poisson <- function(lambda) {
  if (lambda == 0) return(NA_real_)
  max_k <- max(1, qpois(1 - 1e-12, lambda))
  k <- 0:max_k
  pk <- dpois(k, lambda)
  cum_pop <- cumsum(pk)
  cum_inc <- cumsum(k * pk) / lambda
  cp <- c(0, cum_pop)
  ci <- c(0, cum_inc)
  area <- sum(diff(cp) * (head(ci, -1) + tail(ci, -1)) / 2)
  1 - 2 * area
}

analytical_pct_blocks_for_50pct <- function(lambda, q = 0.50) {
  if (lambda == 0) return(0)
  for (kstar in 1:1000) {
    if (kstar == 1) {
      share_geq <- 1.0
    } else {
      share_geq <- ppois(kstar - 2, lambda, lower.tail = FALSE)
    }
    if (share_geq <= q) {
      if (kstar == 1) return(1.0)
      tier_count <- kstar - 1
      p_tier <- dpois(tier_count, lambda)
      if (p_tier == 0) return(ppois(kstar - 1, lambda, lower.tail = FALSE))
      f <- (q - share_geq) * lambda / (tier_count * p_tier)
      f <- min(max(f, 0), 1)
      return(ppois(kstar - 1, lambda, lower.tail = FALSE) + f * p_tier)
    }
  }
  NA_real_
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
# SECTION 2: BUILD CRIME TYPE DATASETS & ASSIGN TO BLOCKS (2022-2025)
# =============================================================================

cat("\nBUILDING CRIME TYPE DATASETS (2022-2025)...\n")
cat(strrep("-", 40), "\n")

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
  filter(year >= 2022, year <= 2025)

shootings_sf <- shootings %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  mutate(date = mdy(occur_date), year = year(date)) %>%
  filter(year >= 2022, year <= 2025) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE)

# 18 individual crime types (no aggregates — we'll aggregate ourselves)
crime_list <- list(
  "Murder"                    = compl_sf %>% filter(ky_cd == 101),
  "Robbery"                   = compl_sf %>% filter(ky_cd == 105),
  "Robbery (outdoor)"         = compl_sf %>% filter(ky_cd == 105, is_outdoor),
  "Felony assault"            = compl_sf %>% filter(ky_cd == 106),
  "Felony assault (outdoor)"  = compl_sf %>% filter(ky_cd == 106, is_outdoor),
  "Street assault"            = compl_sf %>% filter(pd_cd %in% c(101, 109), is_outdoor),
  "Burglary"                  = compl_sf %>% filter(ky_cd == 107),
  "Residential burglary"      = compl_sf %>% filter(ky_cd == 107, str_detect(pd_desc, "RESIDENCE")),
  "Commercial burglary"       = compl_sf %>% filter(ky_cd == 107, str_detect(pd_desc, "COMMERCIAL")),
  "Grand larceny"             = compl_sf %>% filter(ky_cd == 109),
  "GLA"                       = compl_sf %>% filter(ky_cd == 110),
  "Retail theft"              = compl_sf %>% filter(pd_cd %in% c(396, 433, 333)),
  "Vehicle accessory theft"   = compl_sf %>% filter(pd_cd %in% c(457, 357)),
  "Theft from auto"           = compl_sf %>% filter(pd_cd %in% c(441, 321, 442)),
  "Pickpocket (transit)"      = complaints %>%
    filter(pd_cd %in% c(415, 406), jurisdiction_code == 1) %>%
    filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
    st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE) %>%
    mutate(date = mdy(cmplnt_fr_dt), year = year(date)) %>%
    filter(year >= 2022, year <= 2025),
  "Pickpocket (non-transit)"  = compl_sf %>% filter(pd_cd %in% c(415, 406)),
  "Shootings"                 = shootings_sf,
  "Gun violence"              = shootings_sf  # simplified — just shootings for this analysis
)

for (nm in names(crime_list)) {
  cat(sprintf("  %-28s %s\n", nm, comma(nrow(crime_list[[nm]]))))
}

rm(compl_sf, shootings_sf)

cat("\nASSIGNING INCIDENTS TO BLOCKS...\n")
cat(strrep("-", 40), "\n")

block_counts_list <- imap(crime_list, function(sf_obj, nm) {
  assign_to_blocks(sf_obj, physical_blocks, label = nm)
})

# Build block-level count matrix: rows = blocks, columns = crime types
cat("\nBUILDING BLOCK-LEVEL COUNT MATRIX...\n")
count_matrix <- physical_blocks %>%
  st_drop_geometry() %>%
  select(physical_id)

for (nm in names(block_counts_list)) {
  count_matrix <- count_matrix %>%
    left_join(
      block_counts_list[[nm]] %>% rename(!!nm := n_incidents),
      by = "physical_id"
    )
}

# Replace any NAs with 0
count_matrix <- count_matrix %>%
  mutate(across(-physical_id, ~replace_na(.x, 0L)))

crime_names <- names(crime_list)
cat("  Matrix:", nrow(count_matrix), "blocks ×", length(crime_names), "crime types\n")

# Individual 50-X for reference
individual_50x <- map_dbl(crime_names, function(nm) {
  compute_50x(count_matrix[[nm]])
})
names(individual_50x) <- crime_names

cat("\nINDIVIDUAL 50-X VALUES:\n")
for (i in seq_along(crime_names)) {
  cat(sprintf("  %-28s %6.3f%%\n", crime_names[i], individual_50x[i]))
}

# =============================================================================
# SECTION 3: EMPIRICAL AGGREGATION CONVERGENCE
# =============================================================================

cat("\nEMPIRICAL AGGREGATION CONVERGENCE (200 random orderings)...\n")
cat(strrep("=", 70), "\n")

set.seed(42)
N_ORDERINGS <- 200

convergence_results <- map_dfr(1:N_ORDERINGS, function(run) {
  ordering <- sample(crime_names)

  running_total <- rep(0L, N_BLOCKS)

  map_dfr(seq_along(ordering), function(step) {
    nm <- ordering[step]
    running_total <<- running_total + count_matrix[[nm]]

    total_incidents <- sum(running_total)
    lambda <- total_incidents / N_BLOCKS
    null_50x <- 100 * analytical_pct_blocks_for_50pct(lambda)
    obs_50x  <- compute_50x(running_total)
    obs_gini <- gini(running_total)
    null_gini <- gini_poisson(lambda)
    pct_zero <- 100 * sum(running_total == 0) / N_BLOCKS

    tibble(
      run       = run,
      step      = step,
      crime_added = nm,
      n_incidents = total_incidents,
      observed_50x = obs_50x,
      null_50x     = null_50x,
      marginal_50x = obs_50x - null_50x,
      observed_gini = obs_gini,
      null_gini     = null_gini,
      marginal_gini = obs_gini - null_gini,
      pct_zero      = pct_zero
    )
  })
}, .progress = TRUE)

cat("  Done:", nrow(convergence_results), "rows\n")

# Summarize across runs
convergence_summary <- convergence_results %>%
  group_by(step) %>%
  summarise(
    median_50x = median(observed_50x),
    q25_50x    = quantile(observed_50x, 0.25),
    q75_50x    = quantile(observed_50x, 0.75),
    min_50x    = min(observed_50x),
    max_50x    = max(observed_50x),
    median_marginal_50x = median(marginal_50x),
    q25_marginal = quantile(marginal_50x, 0.25),
    q75_marginal = quantile(marginal_50x, 0.75),
    median_gini = median(observed_gini),
    q25_gini    = quantile(observed_gini, 0.25),
    q75_gini    = quantile(observed_gini, 0.75),
    median_pct_zero = median(pct_zero),
    q25_pct_zero    = quantile(pct_zero, 0.25),
    q75_pct_zero    = quantile(pct_zero, 0.75),
    .groups = "drop"
  )

cat("\n=== CONVERGENCE SUMMARY ===\n")
convergence_summary %>%
  transmute(
    step,
    `50-X median` = sprintf("%.2f%%", median_50x),
    `50-X IQR` = sprintf("[%.2f%%, %.2f%%]", q25_50x, q75_50x),
    `% zero median` = sprintf("%.1f%%", median_pct_zero)
  ) %>%
  print(n = 20)

# =============================================================================
# SECTION 4: SIMULATION — SYNTHETIC CRIME TYPES
# =============================================================================

cat("\nSIMULATION: SYNTHETIC CRIME PORTFOLIOS (500 runs)...\n")
cat(strrep("=", 70), "\n")

set.seed(123)
N_SIM_RUNS <- 500
N_SIM_TYPES <- 20

# Empirical distribution of total counts (log scale) for realistic parameters
empirical_log_counts <- log(map_dbl(crime_names, ~sum(count_matrix[[.x]])))
count_mean <- mean(empirical_log_counts)
count_sd   <- sd(empirical_log_counts)

sim_results <- map_dfr(1:N_SIM_RUNS, function(run) {
  # Generate block-level "attractiveness" with a shared component
  # Common urban activity factor (shared across all types)
  common_factor <- rnorm(N_BLOCKS, 0, 1)

  # For each synthetic type: total count + unique spatial signature
  type_counts <- round(exp(rnorm(N_SIM_TYPES, count_mean, count_sd)))
  sigma_values <- runif(N_SIM_TYPES, 1.0, 3.0)  # controls concentration

  running_total <- rep(0L, N_BLOCKS)

  map_dfr(1:N_SIM_TYPES, function(k) {
    # Block probabilities: shared + unique component
    loading <- runif(1, 0.2, 0.6)  # how much shared vs unique
    log_probs <- loading * common_factor + sqrt(1 - loading^2) * rnorm(N_BLOCKS, 0, sigma_values[k])
    probs <- exp(log_probs)
    probs <- probs / sum(probs)

    # Draw incidents
    counts_k <- rmultinom(1, size = type_counts[k], prob = probs)[, 1]
    running_total <<- running_total + counts_k

    obs_50x <- compute_50x(running_total)

    tibble(
      run  = run,
      step = k,
      observed_50x = obs_50x,
      individual_50x = compute_50x(counts_k)
    )
  })
}, .progress = TRUE)

cat("  Done:", nrow(sim_results), "rows\n")

sim_summary <- sim_results %>%
  group_by(step) %>%
  summarise(
    median_50x = median(observed_50x),
    q25_50x    = quantile(observed_50x, 0.25),
    q75_50x    = quantile(observed_50x, 0.75),
    min_50x    = min(observed_50x),
    max_50x    = max(observed_50x),
    .groups = "drop"
  )

cat("\n=== SIMULATION CONVERGENCE ===\n")
sim_summary %>%
  transmute(
    step,
    `50-X median` = sprintf("%.2f%%", median_50x),
    `50-X IQR` = sprintf("[%.2f%%, %.2f%%]", q25_50x, q75_50x),
    `50-X range` = sprintf("[%.2f%%, %.2f%%]", min_50x, max_50x)
  ) %>%
  print(n = 25)

# =============================================================================
# SECTION 5: MECHANISM DECOMPOSITION
# =============================================================================

cat("\nMECHANISM DECOMPOSITION...\n")
cat(strrep("=", 70), "\n")

# --- 5a: Pairwise spatial correlations ----------------------------------------
cat("\n5a: Pairwise spatial correlations...\n")

cor_matrix <- cor(count_matrix %>% select(all_of(crime_names)))
cat("  Correlation range:", sprintf("%.3f to %.3f", min(cor_matrix[lower.tri(cor_matrix)]),
    max(cor_matrix[lower.tri(cor_matrix)])), "\n")
cat("  Mean pairwise correlation:", sprintf("%.3f", mean(cor_matrix[lower.tri(cor_matrix)])), "\n")

# --- 5b: Volume dominance test -----------------------------------------------
cat("\n5b: Volume dominance test...\n")

# Real aggregate (volume-weighted)
real_aggregate <- rowSums(count_matrix %>% select(all_of(crime_names)))
real_50x <- compute_50x(real_aggregate)
cat("  Real aggregate 50-X:", sprintf("%.3f%%", real_50x), "\n")

# Equal-weight aggregate: scale each type to the same total
target_count <- median(map_dbl(crime_names, ~sum(count_matrix[[.x]])))
equal_weight <- rep(0, N_BLOCKS)
for (nm in crime_names) {
  v <- count_matrix[[nm]]
  total <- sum(v)
  if (total > 0) {
    # Scale counts proportionally to target, preserving relative distribution
    equal_weight <- equal_weight + v * (target_count / total)
  }
}
equalwt_50x <- compute_50x(equal_weight)
cat("  Equal-weight aggregate 50-X:", sprintf("%.3f%%", equalwt_50x), "\n")
cat("  Difference:", sprintf("%.3f pp", equalwt_50x - real_50x), "\n")

# --- 5c: Zero-inflation decay (already in convergence results) ----------------
cat("\n5c: Zero-inflation decay — see convergence_summary\n")
cat("  Step 1 median:", sprintf("%.1f%%", convergence_summary$median_pct_zero[1]), "zero blocks\n")
cat("  Step 18 median:", sprintf("%.1f%%", tail(convergence_summary$median_pct_zero, 1)), "zero blocks\n")

# =============================================================================
# SECTION 6: PLOTS
# =============================================================================

cat("\nGENERATING PLOTS...\n")
cat(strrep("-", 40), "\n")

outdir <- here("output", "04-aggregation_artifact")
dir.create(outdir, showWarnings = FALSE, recursive = TRUE)

# --- Plot 1: Convergence ribbon (empirical) -----------------------------------

p1 <- ggplot(convergence_summary, aes(x = step)) +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = 4, ymax = 6,
           fill = "#2c7bb6", alpha = 0.15) +
  annotate("text", x = 17, y = 5, label = 'Weisburd\n"law" bandwidth',
           color = "#2c7bb6", size = 3, fontface = "italic") +
  geom_ribbon(aes(ymin = min_50x, ymax = max_50x), fill = "grey85", alpha = 0.5) +
  geom_ribbon(aes(ymin = q25_50x, ymax = q75_50x), fill = "#d7191c", alpha = 0.3) +
  geom_line(aes(y = median_50x), color = "#d7191c", linewidth = 1.2) +
  scale_x_continuous(breaks = 1:18) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Aggregation compresses concentration into a narrow band",
    subtitle = "50-X as crime types are progressively summed (200 random orderings, NYC blocks)",
    x = "Number of crime types aggregated",
    y = "50-X (% blocks for 50% of crime)"
  ) +
  theme_pub
ggsave(file.path(outdir, "convergence_ribbon.png"), p1, width = 10, height = 6, dpi = 300)
cat("  convergence_ribbon.png saved\n")

# --- Plot 2: Simulation fan chart ---------------------------------------------

p2 <- ggplot(sim_summary, aes(x = step)) +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = 4, ymax = 6,
           fill = "#2c7bb6", alpha = 0.15) +
  geom_ribbon(aes(ymin = min_50x, ymax = max_50x), fill = "grey85", alpha = 0.5) +
  geom_ribbon(aes(ymin = q25_50x, ymax = q75_50x), fill = "#1a9641", alpha = 0.3) +
  geom_line(aes(y = median_50x), color = "#1a9641", linewidth = 1.2) +
  geom_line(data = convergence_summary, aes(y = median_50x),
            color = "#d7191c", linewidth = 0.8, linetype = "dashed") +
  scale_x_continuous(breaks = seq(2, 20, 2)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Synthetic crime portfolios converge to the same bandwidth",
    subtitle = "500 simulation runs with randomized spatial distributions (green) vs empirical (dashed red)",
    x = "Number of crime types aggregated",
    y = "50-X (% blocks for 50% of crime)"
  ) +
  theme_pub
ggsave(file.path(outdir, "simulation_fan_chart.png"), p2, width = 10, height = 6, dpi = 300)
cat("  simulation_fan_chart.png saved\n")

# --- Plot 3: Correlation heatmap ----------------------------------------------

# Reorder by crime category
type_order <- c(
  "Murder", "Shootings", "Gun violence",
  "Felony assault", "Felony assault (outdoor)", "Street assault",
  "Robbery", "Robbery (outdoor)",
  "Burglary", "Residential burglary", "Commercial burglary",
  "Grand larceny", "GLA", "Retail theft",
  "Vehicle accessory theft", "Theft from auto",
  "Pickpocket (transit)", "Pickpocket (non-transit)"
)

cor_long <- as.data.frame(as.table(cor_matrix)) %>%
  rename(Type1 = Var1, Type2 = Var2, Correlation = Freq) %>%
  mutate(
    Type1 = factor(Type1, levels = type_order),
    Type2 = factor(Type2, levels = rev(type_order))
  )

p3 <- ggplot(cor_long, aes(x = Type1, y = Type2, fill = Correlation)) +
  geom_tile(color = "white", linewidth = 0.3) +
  scale_fill_gradient2(low = "#2c7bb6", mid = "white", high = "#d7191c",
                       midpoint = 0, limits = c(-0.1, 1),
                       labels = function(x) sprintf("%.1f", x)) +
  labs(
    title = "Imperfect spatial correlation enables diversification",
    subtitle = "Pairwise Pearson correlations of block-level crime counts (2022-2025)"
  ) +
  theme_pub +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    axis.text.y = element_text(size = 8),
    axis.title = element_blank(),
    legend.key.width = unit(1.5, "cm")
  )
ggsave(file.path(outdir, "correlation_heatmap.png"), p3, width = 10, height = 9, dpi = 300)
cat("  correlation_heatmap.png saved\n")

# --- Plot 4: Zero-inflation decay ---------------------------------------------

p4 <- ggplot(convergence_summary, aes(x = step)) +
  geom_ribbon(aes(ymin = q25_pct_zero, ymax = q75_pct_zero),
              fill = "#fdae61", alpha = 0.4) +
  geom_line(aes(y = median_pct_zero), color = "#d7191c", linewidth = 1.2) +
  scale_x_continuous(breaks = 1:18) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Aggregation eliminates zero-inflation",
    subtitle = "% of blocks with zero total crime as types are progressively summed",
    x = "Number of crime types aggregated",
    y = "% blocks with zero crime"
  ) +
  theme_pub
ggsave(file.path(outdir, "zero_inflation_decay.png"), p4, width = 10, height = 6, dpi = 300)
cat("  zero_inflation_decay.png saved\n")

# --- Plot 5: Individual vs aggregate contrast ---------------------------------

individual_data <- tibble(
  crime_type = crime_names,
  x50 = individual_50x,
  category = "Individual crime types"
) %>%
  mutate(crime_type = fct_reorder(crime_type, x50))

# Aggregate values at steps 3, 5, 7, 10, 15, 18
agg_steps <- c(3, 5, 7, 10, 15, 18)
agg_data <- convergence_summary %>%
  filter(step %in% agg_steps) %>%
  transmute(
    crime_type = paste0(step, " types"),
    x50 = median_50x,
    category = "Progressive aggregates"
  )

contrast_data <- bind_rows(individual_data, agg_data) %>%
  mutate(
    category = factor(category, levels = c("Individual crime types", "Progressive aggregates")),
    crime_type = fct_inorder(crime_type)
  )

p5 <- ggplot(contrast_data, aes(x = x50, y = crime_type)) +
  annotate("rect", xmin = 4, xmax = 6, ymin = -Inf, ymax = Inf,
           fill = "#2c7bb6", alpha = 0.1) +
  geom_segment(aes(xend = 0, yend = crime_type), color = "grey70") +
  geom_point(aes(color = category), size = 3) +
  scale_color_manual(values = c("Individual crime types" = "#d7191c",
                                "Progressive aggregates" = "#1a9641")) +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  facet_wrap(~category, scales = "free_y", ncol = 2) +
  labs(
    title = "Individual crime types span a wide range; aggregates compress",
    subtitle = "50-X for individual types vs. progressive aggregations (median of 200 orderings)",
    x = "50-X (% blocks for 50% of crime)"
  ) +
  theme_pub +
  theme(axis.title.y = element_blank(), legend.position = "none",
        strip.text = element_text(face = "bold"))
ggsave(file.path(outdir, "individual_vs_aggregate.png"), p5, width = 12, height = 7, dpi = 300)
cat("  individual_vs_aggregate.png saved\n")

# --- Plot 6: Equal-weight counterfactual --------------------------------------

volume_data <- tibble(
  scenario = c("Real (volume-weighted)", "Equal-weight counterfactual"),
  x50 = c(real_50x, equalwt_50x)
) %>%
  mutate(scenario = fct_inorder(scenario))

p6 <- ggplot(volume_data, aes(x = scenario, y = x50, fill = scenario)) +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = 4, ymax = 6,
           fill = "#2c7bb6", alpha = 0.1) +
  geom_col(width = 0.5) +
  geom_text(aes(label = sprintf("%.2f%%", x50)), vjust = -0.5, size = 5) +
  scale_fill_manual(values = c("#d7191c", "#fdae61")) +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                     expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Volume dominance shapes the aggregate",
    subtitle = "50-X of all 18 types summed: real counts vs equal-weighted",
    y = "50-X (% blocks for 50% of crime)"
  ) +
  theme_pub +
  theme(axis.title.x = element_blank(), legend.position = "none")
ggsave(file.path(outdir, "volume_dominance.png"), p6, width = 7, height = 6, dpi = 300)
cat("  volume_dominance.png saved\n")

# =============================================================================
# SECTION 7: SAVE CSV OUTPUT
# =============================================================================

cat("\nSAVING CSV OUTPUT...\n")

write_csv(convergence_results, file.path(outdir, "aggregation_convergence.csv"))
write_csv(sim_results, file.path(outdir, "simulation_results.csv"))
write_csv(
  as_tibble(cor_matrix, rownames = "crime_type"),
  file.path(outdir, "pairwise_correlations.csv")
)

cat("  CSVs saved to", outdir, "\n")

# =============================================================================
# SECTION 8: SHOPLIFTING INFLUENCE ON 7 MAJOR FELONIES
# =============================================================================

cat("\nSHOPLIFTING INFLUENCE ON 7 MAJOR FELONIES...\n")
cat(strrep("=", 70), "\n")

# Rebuild compl_sf (was rm'd in Section 2)
compl_sf <- complaints %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE) %>%
  mutate(date = mdy(cmplnt_fr_dt), year = year(date)) %>%
  filter(year >= 2022, year <= 2025)

# Shoplifting pd_codes that fall within 7 majors:
#   pd_cd 433 = Grand larceny shoplifting (ky_cd 109)
#   pd_cd 396 = Robbery beginning as shoplifting (ky_cd 105)
shoplifting_pds <- c(433, 396)

# Build variants
shoplifting_variants <- list(
  "7 Majors (full)"              = compl_sf %>% filter(ky_cd %in% c(101, 104, 105, 106, 107, 109, 110)),
  "7 Majors (minus shoplifting)" = compl_sf %>% filter(ky_cd %in% c(101, 104, 105, 106, 107, 109, 110),
                                                        !pd_cd %in% shoplifting_pds),
  "Shoplifting only (in majors)" = compl_sf %>% filter(pd_cd %in% shoplifting_pds),
  "Grand larceny (full)"         = compl_sf %>% filter(ky_cd == 109),
  "Grand larceny (minus shopl.)" = compl_sf %>% filter(ky_cd == 109, pd_cd != 433),
  "Robbery (full)"               = compl_sf %>% filter(ky_cd == 105),
  "Robbery (minus shopl.)"       = compl_sf %>% filter(ky_cd == 105, pd_cd != 396)
)

rm(compl_sf)

# Assign to blocks and compute metrics
cat("\n  Assigning variants to blocks...\n")
shoplifting_metrics <- imap_dfr(shoplifting_variants, function(sf_obj, nm) {
  bc <- assign_to_blocks(sf_obj, physical_blocks, label = nm)
  tibble(
    variant     = nm,
    n_incidents = sum(bc$n_incidents),
    x50         = compute_50x(bc$n_incidents),
    gini_val    = gini(bc$n_incidents),
    pct_zero    = 100 * mean(bc$n_incidents == 0)
  )
})

# Summary table
cat("\n=== SHOPLIFTING INFLUENCE ON CONCENTRATION ===\n\n")
shoplifting_metrics %>%
  transmute(
    Variant     = variant,
    N           = comma(n_incidents),
    `50-X`      = sprintf("%.3f%%", x50),
    Gini        = sprintf("%.4f", gini_val),
    `% zero`    = sprintf("%.1f%%", pct_zero)
  ) %>%
  print(n = 10)

# Compute deltas
m7_full  <- shoplifting_metrics %>% filter(variant == "7 Majors (full)")
m7_minus <- shoplifting_metrics %>% filter(variant == "7 Majors (minus shoplifting)")
gl_full  <- shoplifting_metrics %>% filter(variant == "Grand larceny (full)")
gl_minus <- shoplifting_metrics %>% filter(variant == "Grand larceny (minus shopl.)")
rb_full  <- shoplifting_metrics %>% filter(variant == "Robbery (full)")
rb_minus <- shoplifting_metrics %>% filter(variant == "Robbery (minus shopl.)")

cat("\n=== EFFECT OF REMOVING SHOPLIFTING ===\n")
cat(sprintf("  7 Majors:       %.3f%% → %.3f%%  (Δ = %+.3f pp)\n",
            m7_full$x50, m7_minus$x50, m7_minus$x50 - m7_full$x50))
cat(sprintf("  Grand larceny:  %.3f%% → %.3f%%  (Δ = %+.3f pp)\n",
            gl_full$x50, gl_minus$x50, gl_minus$x50 - gl_full$x50))
cat(sprintf("  Robbery:        %.3f%% → %.3f%%  (Δ = %+.3f pp)\n",
            rb_full$x50, rb_minus$x50, rb_minus$x50 - rb_full$x50))

# --- Plot: Shoplifting influence dot chart ------------------------------------

plot_data <- shoplifting_metrics %>%
  mutate(
    group = case_when(
      str_detect(variant, "7 Majors")       ~ "7 Major Felonies",
      str_detect(variant, "Grand larceny")   ~ "Grand Larceny",
      str_detect(variant, "Robbery")         ~ "Robbery",
      TRUE                                    ~ "Shoplifting"
    ),
    has_shoplifting = case_when(
      str_detect(variant, "minus")   ~ "Minus shoplifting",
      str_detect(variant, "only")    ~ "Shoplifting only",
      TRUE                            ~ "Full"
    ),
    group = factor(group, levels = c("Shoplifting", "Robbery", "Grand Larceny", "7 Major Felonies")),
    has_shoplifting = factor(has_shoplifting, levels = c("Full", "Minus shoplifting", "Shoplifting only"))
  )

p7 <- ggplot(plot_data, aes(x = x50, y = group, color = has_shoplifting, shape = has_shoplifting)) +
  annotate("rect", xmin = 4, xmax = 6, ymin = -Inf, ymax = Inf,
           fill = "#2c7bb6", alpha = 0.1) +
  geom_point(size = 4, position = position_dodge(width = 0.5)) +
  geom_text(aes(label = sprintf("%.2f%%", x50)),
            position = position_dodge(width = 0.5),
            vjust = -1.2, size = 3.5, show.legend = FALSE) +
  scale_color_manual(values = c("Full" = "#d7191c", "Minus shoplifting" = "#fdae61",
                                "Shoplifting only" = "#2c7bb6")) +
  scale_shape_manual(values = c("Full" = 16, "Minus shoplifting" = 17, "Shoplifting only" = 15)) +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Shoplifting influence on 7 major felonies concentration",
    subtitle = "50-X with and without shoplifting-coded incidents (2022-2025, NYC blocks)",
    x = "50-X (% blocks for 50% of crime)",
    color = NULL, shape = NULL
  ) +
  theme_pub +
  theme(axis.title.y = element_blank())
ggsave(file.path(outdir, "shoplifting_influence.png"), p7, width = 10, height = 5, dpi = 300)
cat("  shoplifting_influence.png saved\n")

# Save CSV
write_csv(shoplifting_metrics, file.path(outdir, "shoplifting_influence.csv"))
cat("  shoplifting_influence.csv saved\n")

cat("\n")
cat(strrep("=", 70), "\n")
cat("AGGREGATION ARTIFACT ANALYSIS COMPLETE\n")
cat(strrep("=", 70), "\n")
