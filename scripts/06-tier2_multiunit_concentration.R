# =============================================================================
# 06-tier2_multiunit_concentration.R
# Tier 2 Analysis 5: Concentration at Multiple Spatial Units
#
# Computes 50-X, Gini, marginal concentration, and Lorenz curves at four
# spatial scales (physical blocks, census tracts, NTAs, precincts) for all
# crime types plus aggregated categories.
#
# Replicates Hipp & Kim (2017) / Weisburd (2015) comparison across units.
#
# Depends on: data/block_crosswalk.rds (from 05-build_crosswalk.R)
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(lubridate)
library(janitor)

cat("\n")
cat(strrep("=", 70), "\n")
cat("TIER 2: CONCENTRATION AT MULTIPLE SPATIAL UNITS\n")
cat(strrep("=", 70), "\n\n")

# =============================================================================
# SECTION 0: SETUP — functions, theme
# =============================================================================

# --- Analytical Poisson null (from 02-null_concentration_curve.R) -----------

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

# --- Publication theme -------------------------------------------------------

theme_pub <- theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title    = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey40", size = 11),
    axis.title    = element_text(size = 12),
    legend.position = "bottom"
  )

# --- Concentration metrics ---------------------------------------------------

compute_50x <- function(counts_vec) {
  counts_sorted <- sort(counts_vec, decreasing = TRUE)
  total <- sum(counts_sorted)
  if (total == 0) return(NA_real_)
  cumshare <- cumsum(counts_sorted) / total
  k50 <- which(cumshare >= 0.50)[1]
  k50 / length(counts_sorted)
}

compute_lorenz <- function(counts_vec, n_pts = 500) {
  counts_sorted <- sort(counts_vec, decreasing = TRUE)
  total <- sum(counts_sorted)
  n <- length(counts_sorted)
  pct_units     <- seq_len(n) / n
  pct_incidents <- cumsum(counts_sorted) / total
  idx <- unique(c(1, round(seq(1, n, length.out = n_pts)), n))
  tibble(
    pct_units     = pct_units[idx],
    pct_incidents = pct_incidents[idx]
  )
}

gini <- function(x) {
  n <- length(x)
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

# --- Scale colors and labels -------------------------------------------------

scale_colors <- c(
  "Block"    = "#d7191c",
  "Tract"    = "#fdae61",
  "NTA"      = "#2c7bb6",
  "Precinct" = "#1a9641"
)

scale_levels <- c("Block", "Tract", "NTA", "Precinct")

# =============================================================================
# SECTION 1: LOAD DATA
# =============================================================================

cat("LOADING DATA...\n")
cat(strrep("-", 40), "\n")

# --- Crosswalk ---------------------------------------------------------------
crosswalk <- readRDS(here("data", "block_crosswalk.rds"))
cat("  crosswalk:", comma(nrow(crosswalk)), "blocks\n")

# --- Physical blocks ---------------------------------------------------------
physical_blocks <- st_read(
  here("data", "physical_blocks.gpkg"), quiet = TRUE
) %>% st_transform(2263)
N_BLOCKS <- nrow(physical_blocks)
cat("  physical_blocks:", comma(N_BLOCKS), "blocks\n")

# --- Unit counts (excluding non-residential NTAs) ----------------------------
residential_ntas <- crosswalk %>% filter(NTAType == 0) %>% pull(NTA2020) %>% unique()
residential_blocks <- crosswalk %>% filter(NTAType == 0) %>% pull(physical_id)

N_TRACTS    <- length(unique(crosswalk$BoroCT2020))
N_NTAS      <- length(residential_ntas)
N_PRECINCTS <- length(unique(crosswalk$Precinct))

cat("  Tracts:", N_TRACTS, "\n")
cat("  NTAs (residential):", N_NTAS, "\n")
cat("  Precincts:", N_PRECINCTS, "\n")

# --- Complaints --------------------------------------------------------------
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

# --- Shootings ---------------------------------------------------------------
shootings <- read_csv(
  here("data", "NYPD_Shootings_20260224.csv"),
  show_col_types = FALSE
) %>% clean_names()
cat("  shootings:", comma(nrow(shootings)), "records\n")

# --- Shots fired -------------------------------------------------------------
sf_since_2017 <- read_csv(
  here("data", "sf_since_2017.csv"), show_col_types = FALSE
) %>% clean_names()

shots_fired_new <- read_csv(
  here("data", "shots_fired_new.csv"), show_col_types = FALSE
) %>% clean_names() %>%
  mutate(date = mdy(rec_create_dt))

cutoff_date <- min(shots_fired_new$date, na.rm = TRUE)

sf_2017_std <- sf_since_2017 %>%
  mutate(date = mdy(rpt_dt)) %>%
  filter(date < cutoff_date) %>%
  transmute(
    cmplnt_key, date = as.Date(date), year = year(date),
    x = as.numeric(x_coord_cd), y = as.numeric(y_coord_cd)
  )

sf_new_std <- shots_fired_new %>%
  filter(date >= cutoff_date) %>%
  transmute(
    cmplnt_key, date = as.Date(date), year = year(date),
    x = as.numeric(x_coordinate_code), y = as.numeric(y_coordinate_code)
  )

shots_fired_combined <- bind_rows(
  sf_2017_std %>% filter(!is.na(x), !is.na(y)) %>%
    st_as_sf(coords = c("x", "y"), crs = 2263, remove = FALSE),
  sf_new_std %>% filter(!is.na(x), !is.na(y)) %>%
    st_as_sf(coords = c("x", "y"), crs = 2263, remove = FALSE)
) %>% distinct(cmplnt_key, .keep_all = TRUE)

cat("  shots_fired:", comma(nrow(shots_fired_combined)), "records\n")

rm(complaints_historic, complaints_ytd, sf_since_2017, shots_fired_new,
   sf_2017_std, sf_new_std, cutoff_date)

# =============================================================================
# SECTION 2: BUILD CRIME TYPE SF OBJECTS (2022-2025)
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

gun_violence_start <- as.Date("2022-01-01")
gun_violence_end   <- as.Date("2025-12-31")

shootings_for_gv <- shootings_sf %>%
  transmute(date, year, source = "shooting", geometry)

shots_for_gv <- shots_fired_combined %>%
  filter(date >= gun_violence_start, date <= gun_violence_end) %>%
  transmute(date, year, source = "shots_fired", geometry)

gun_violence_sf <- bind_rows(shootings_for_gv, shots_for_gv)

# --- Individual crime types --------------------------------------------------
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
  "Gun violence"              = gun_violence_sf,
  # --- Aggregated categories ---
  "Violent crime"             = compl_sf %>% filter(ky_cd %in% c(101, 104, 105, 106)),
  "Property crime"            = compl_sf %>% filter(ky_cd %in% c(107, 109, 110)),
  "7 Major Felonies"          = compl_sf %>% filter(ky_cd %in% c(101, 104, 105, 106, 107, 109, 110))
)

for (nm in names(crime_list)) {
  cat(sprintf("  %-28s %s\n", nm, comma(nrow(crime_list[[nm]]))))
}

rm(compl_sf, shootings_for_gv, shots_for_gv)

# =============================================================================
# SECTION 3: ASSIGN TO BLOCKS
# =============================================================================

cat("\nASSIGNING INCIDENTS TO BLOCKS...\n")
cat(strrep("-", 40), "\n")

block_counts_list <- imap(crime_list, function(sf_obj, nm) {
  assign_to_blocks(sf_obj, physical_blocks, label = nm)
})

# =============================================================================
# SECTION 4: AGGREGATE TO HIGHER UNITS
# =============================================================================

cat("\nAGGREGATING TO TRACTS, NTAs, PRECINCTS...\n")
cat(strrep("-", 40), "\n")

# All tracts (including those in non-residential NTAs)
all_tracts    <- unique(crosswalk$BoroCT2020)
# Residential NTAs only
res_ntas      <- crosswalk %>% filter(NTAType == 0) %>% pull(NTA2020) %>% unique()
all_precincts <- unique(crosswalk$Precinct)

aggregate_counts <- function(block_counts, crosswalk, level) {
  bc <- block_counts %>%
    inner_join(crosswalk %>% select(physical_id, BoroCT2020, NTA2020, NTAType, Precinct),
               by = "physical_id")

  if (level == "Tract") {
    agg <- bc %>%
      group_by(unit_id = BoroCT2020) %>%
      summarise(n_incidents = sum(n_incidents), .groups = "drop")
    # Ensure all tracts present
    all_units <- tibble(unit_id = all_tracts)
  } else if (level == "NTA") {
    agg <- bc %>%
      filter(NTAType == 0) %>%
      group_by(unit_id = NTA2020) %>%
      summarise(n_incidents = sum(n_incidents), .groups = "drop")
    all_units <- tibble(unit_id = res_ntas)
  } else if (level == "Precinct") {
    agg <- bc %>%
      group_by(unit_id = as.character(Precinct)) %>%
      summarise(n_incidents = sum(n_incidents), .groups = "drop")
    all_units <- tibble(unit_id = as.character(all_precincts))
  }

  all_units %>%
    left_join(agg, by = "unit_id") %>%
    mutate(n_incidents = replace_na(n_incidents, 0L))
}

# =============================================================================
# SECTION 5: COMPUTE CONCENTRATION METRICS AT EACH SCALE
# =============================================================================

cat("\nCOMPUTING CONCENTRATION METRICS...\n")
cat(strrep("-", 40), "\n")

results <- imap_dfr(block_counts_list, function(bc, crime_nm) {
  cat("  ", crime_nm, "\n")

  # Block level
  block_row <- tibble(
    crime_type   = crime_nm,
    spatial_unit = "Block",
    n_units      = nrow(bc),
    n_incidents  = sum(bc$n_incidents),
    lambda       = n_incidents / n_units,
    observed_50x = compute_50x(bc$n_incidents),
    null_50x     = analytical_pct_blocks_for_50pct(lambda),
    observed_gini = gini(bc$n_incidents),
    null_gini    = gini_poisson(lambda)
  )

  # Higher levels
  higher <- map_dfr(c("Tract", "NTA", "Precinct"), function(level) {
    agg <- aggregate_counts(bc, crosswalk, level)
    n_u <- nrow(agg)
    n_i <- sum(agg$n_incidents)
    lam <- n_i / n_u
    tibble(
      crime_type   = crime_nm,
      spatial_unit = level,
      n_units      = n_u,
      n_incidents  = n_i,
      lambda       = lam,
      observed_50x = compute_50x(agg$n_incidents),
      null_50x     = analytical_pct_blocks_for_50pct(lam),
      observed_gini = gini(agg$n_incidents),
      null_gini    = gini_poisson(lam)
    )
  })

  bind_rows(block_row, higher)
}) %>%
  mutate(
    marginal_50x  = observed_50x - null_50x,
    marginal_gini = observed_gini - null_gini,
    spatial_unit  = factor(spatial_unit, levels = scale_levels)
  )

cat("\n=== MULTI-UNIT CONCENTRATION SUMMARY (2022-2025) ===\n\n")
results %>%
  mutate(
    across(c(observed_50x, null_50x, marginal_50x), ~ sprintf("%.2f%%", . * 100)),
    across(c(observed_gini, null_gini, marginal_gini), ~ sprintf("%.4f", .)),
    lambda = sprintf("%.2f", lambda),
    n_incidents = comma(n_incidents)
  ) %>%
  print(n = 100, width = Inf)

# =============================================================================
# SECTION 6: LORENZ CURVE DATA
# =============================================================================

cat("\nCOMPUTING LORENZ CURVES...\n")
cat(strrep("-", 40), "\n")

lorenz_data <- imap_dfr(block_counts_list, function(bc, crime_nm) {
  # Block level
  block_lorenz <- compute_lorenz(bc$n_incidents) %>%
    mutate(crime_type = crime_nm, spatial_unit = "Block")

  # Higher levels
  higher_lorenz <- map_dfr(c("Tract", "NTA", "Precinct"), function(level) {
    agg <- aggregate_counts(bc, crosswalk, level)
    compute_lorenz(agg$n_incidents) %>%
      mutate(crime_type = crime_nm, spatial_unit = level)
  })

  bind_rows(block_lorenz, higher_lorenz)
}) %>%
  mutate(spatial_unit = factor(spatial_unit, levels = scale_levels))

# =============================================================================
# SECTION 7: PLOTS
# =============================================================================

cat("\nGENERATING PLOTS...\n")
cat(strrep("-", 40), "\n")

dir.create(here("output", "03-tier2_spatial_scale"), showWarnings = FALSE, recursive = TRUE)

# --- Subset for plots: focus on key types ------------------------------------
key_types <- c("Murder", "Robbery (outdoor)", "Felony assault", "Burglary",
               "Grand larceny", "Shootings", "Gun violence",
               "Violent crime", "Property crime", "7 Major Felonies")

# --- Plot 1: Marginal 50-X by spatial scale ---------------------------------

p1_data <- results %>%
  filter(crime_type %in% key_types) %>%
  mutate(crime_type = factor(crime_type, levels = key_types))

p1 <- ggplot(p1_data, aes(x = spatial_unit, y = marginal_50x * 100,
                            fill = spatial_unit)) +
  geom_col(width = 0.7) +
  facet_wrap(~ crime_type, scales = "free_y", ncol = 5) +
  scale_fill_manual(values = scale_colors) +
  labs(
    title = "Marginal concentration by spatial scale",
    subtitle = "Observed minus Poisson null (50-X metric) | 2022-2025",
    x = NULL,
    y = "Marginal 50-X (percentage points)",
    fill = NULL
  ) +
  theme_pub +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 8),
    strip.text = element_text(face = "bold", size = 9),
    legend.position = "none"
  )

ggsave(here("output", "03-tier2_spatial_scale", "marginal_50x_by_scale.png"), p1,
       width = 14, height = 8, dpi = 300, bg = "white")
cat("  marginal_50x_by_scale.png saved\n")

# --- Plot 2: Observed 50-X dot plot (all types) ------------------------------

p2_data <- results %>%
  mutate(crime_type = fct_reorder(crime_type, observed_50x,
                                   .fun = function(x) x[1]))  # order by block 50x

p2 <- ggplot(p2_data, aes(x = observed_50x * 100, y = crime_type,
                            color = spatial_unit, shape = spatial_unit)) +
  geom_point(size = 3, alpha = 0.85) +
  scale_color_manual(values = scale_colors) +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Crime concentration across spatial scales",
    subtitle = "50-X metric: % of units accounting for 50% of incidents | 2022-2025",
    x = "% of units → 50% of incidents",
    y = NULL,
    color = "Spatial unit",
    shape = "Spatial unit"
  ) +
  theme_pub +
  theme(legend.position = "right")

ggsave(here("output", "03-tier2_spatial_scale", "50x_dotplot_all_scales.png"), p2,
       width = 11, height = 9, dpi = 300, bg = "white")
cat("  50x_dotplot_all_scales.png saved\n")

# --- Plot 3: Lorenz curves faceted by crime type, colored by scale -----------

p3_data <- lorenz_data %>%
  filter(crime_type %in% key_types) %>%
  mutate(crime_type = factor(crime_type, levels = key_types))

p3 <- ggplot(p3_data, aes(x = pct_units * 100, y = pct_incidents * 100,
                            color = spatial_unit)) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed",
              color = "grey70", linewidth = 0.3) +
  geom_line(linewidth = 0.8) +
  facet_wrap(~ crime_type, ncol = 5) +
  scale_color_manual(values = scale_colors) +
  scale_x_continuous(breaks = c(0, 25, 50, 75, 100),
                     labels = function(x) paste0(x, "%")) +
  scale_y_continuous(breaks = c(0, 25, 50, 75, 100),
                     labels = function(x) paste0(x, "%")) +
  labs(
    title = "Lorenz curves at four spatial scales",
    subtitle = "2022-2025",
    x = "Cumulative % of units",
    y = "Cumulative % of incidents",
    color = "Spatial unit"
  ) +
  theme_pub +
  theme(
    strip.text = element_text(face = "bold", size = 9),
    legend.position = "bottom"
  )

ggsave(here("output", "03-tier2_spatial_scale", "lorenz_curves_by_scale.png"), p3,
       width = 14, height = 8, dpi = 300, bg = "white")
cat("  lorenz_curves_by_scale.png saved\n")

# --- Plot 4: Gini comparison across scales -----------------------------------

p4_data <- results %>%
  filter(crime_type %in% key_types) %>%
  mutate(crime_type = factor(crime_type, levels = key_types))

p4 <- ggplot(p4_data) +
  geom_segment(aes(x = null_gini, xend = observed_gini,
                   y = spatial_unit, yend = spatial_unit),
               color = "grey60", linewidth = 0.6) +
  geom_point(aes(x = null_gini, y = spatial_unit),
             color = "#2c7bb6", size = 2.5) +
  geom_point(aes(x = observed_gini, y = spatial_unit),
             color = "#d7191c", size = 2.5) +
  facet_wrap(~ crime_type, scales = "free_x", ncol = 5) +
  labs(
    title = "Gini coefficients by spatial scale",
    subtitle = "Blue = Poisson null | Red = observed | 2022-2025",
    x = "Gini coefficient",
    y = NULL
  ) +
  theme_pub +
  theme(
    strip.text = element_text(face = "bold", size = 9),
    legend.position = "none"
  )

ggsave(here("output", "03-tier2_spatial_scale", "gini_by_scale.png"), p4,
       width = 14, height = 8, dpi = 300, bg = "white")
cat("  gini_by_scale.png saved\n")

# --- Plot 5: Observed vs null on same axes, all 4 scales --------------------

# Build null curves for each scale
unit_counts <- c(Block = N_BLOCKS, Tract = N_TRACTS,
                 NTA = N_NTAS, Precinct = N_PRECINCTS)

null_curves <- map_dfr(names(unit_counts), function(scale_nm) {
  n_u <- unit_counts[scale_nm]
  n_seq <- unique(sort(c(
    seq(10, 100, by = 10), seq(100, 1000, by = 50),
    seq(1000, 10000, by = 250), seq(10000, 50000, by = 1000),
    seq(50000, 200000, by = 5000), seq(200000, 1000000, by = 25000)
  )))
  tibble(n_incidents = n_seq) %>%
    mutate(
      lambda = n_incidents / n_u,
      pct_units = map_dbl(lambda, analytical_pct_blocks_for_50pct) * 100,
      spatial_unit = scale_nm
    )
}) %>%
  mutate(spatial_unit = factor(spatial_unit, levels = scale_levels))

obs_pts <- results %>%
  filter(crime_type %in% key_types) %>%
  mutate(crime_type = factor(crime_type, levels = key_types))

p5 <- ggplot() +
  geom_line(data = null_curves, aes(x = n_incidents, y = pct_units,
                                      color = spatial_unit),
            linewidth = 0.6, alpha = 0.5) +
  geom_point(data = obs_pts, aes(x = n_incidents, y = observed_50x * 100,
                                   color = spatial_unit),
             size = 2.5) +
  scale_x_log10(labels = comma) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  scale_color_manual(values = scale_colors) +
  coord_cartesian(ylim = c(0, 60)) +
  labs(
    title = "Observed concentration vs. null baselines at four scales",
    subtitle = "Curves = Poisson null | Points = observed | 2022-2025",
    x = "Number of incidents (log scale)",
    y = "% of units → 50% of incidents",
    color = "Spatial unit"
  ) +
  theme_pub

ggsave(here("output", "03-tier2_spatial_scale", "observed_vs_null_multiscale.png"), p5,
       width = 11, height = 7, dpi = 300, bg = "white")
cat("  observed_vs_null_multiscale.png saved\n")

# =============================================================================
# SECTION 8: SAVE
# =============================================================================

write_csv(results, here("output", "03-tier2_spatial_scale",
                         "multiunit_concentration_summary.csv"))
cat("\n  multiunit_concentration_summary.csv saved\n")

cat("\n")
cat(strrep("=", 70), "\n")
cat("TIER 2 MULTI-UNIT CONCENTRATION COMPLETE\n")
cat(strrep("=", 70), "\n")
