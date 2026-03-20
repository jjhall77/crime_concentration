# =============================================================================
# 08-tier2_nested_gini.R
# Tier 2: Nested Gini Coefficients (O'Brien 2018)
#
# Disentangles concentration at multiple spatial scales by computing Gini
# coefficients *within* each containing unit, then averaging. This separates
# scale-specific concentration from concentration inherited from higher levels.
#
# Nesting: blocks within tracts within NTAs
#   - NTA-level Gini: concentration across NTAs (city-wide)
#   - Tract-level nested Gini: mean Gini of tracts within each NTA
#   - Block-level nested Gini: mean Gini of blocks within each tract
#
# Replicates O'Brien (2018) "The Action Is Everywhere" for NYC using
# streets (physical blocks) instead of addresses.
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
cat("TIER 2: NESTED GINI COEFFICIENTS (O'BRIEN 2018)\n")
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

# --- Gini coefficient --------------------------------------------------------

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

# --- Modified Gini (Bernasco & Steenbeek 2017) ------------------------------
# Corrects for situations where units outnumber events by comparing to
# the minimum possible inequality (most equitable distribution).

gini_modified <- function(x) {
  n <- length(x)
  if (n < 2) return(NA_real_)
  total <- sum(x)
  if (total == 0) return(NA_real_)

  g_obs <- gini(x)

  # Minimum Gini: distribute events as evenly as possible
  base <- floor(total / n)
  remainder <- total - base * n
  x_min <- c(rep(base, n - remainder), rep(base + 1, remainder))
  g_min <- gini(x_min)

  # Modified Gini: observed relative to minimum
  if (g_min >= 1) return(g_obs)
  (g_obs - g_min) / (1 - g_min)
}

# --- Poisson-expected Gini ---------------------------------------------------
# Expected Gini under random Poisson distribution (from Tier 1)

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

# --- Block assignment --------------------------------------------------------

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

crosswalk <- readRDS(here("data", "block_crosswalk.rds"))
cat("  crosswalk:", comma(nrow(crosswalk)), "blocks\n")

physical_blocks <- st_read(
  here("data", "physical_blocks.gpkg"), quiet = TRUE
) %>% st_transform(2263)
cat("  physical_blocks:", comma(nrow(physical_blocks)), "blocks\n")

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

gun_violence_sf <- bind_rows(
  shootings_sf %>% transmute(date, year, source = "shooting", geometry),
  shots_fired_combined %>%
    filter(date >= as.Date("2022-01-01"), date <= as.Date("2025-12-31")) %>%
    transmute(date, year, source = "shots_fired", geometry)
)

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
  "Violent crime"             = compl_sf %>% filter(ky_cd %in% c(101, 104, 105, 106)),
  "Property crime"            = compl_sf %>% filter(ky_cd %in% c(107, 109, 110)),
  "7 Major Felonies"          = compl_sf %>% filter(ky_cd %in% c(101, 104, 105, 106, 107, 109, 110))
)

for (nm in names(crime_list)) {
  cat(sprintf("  %-28s %s\n", nm, comma(nrow(crime_list[[nm]]))))
}

rm(compl_sf)

# =============================================================================
# SECTION 3: ASSIGN TO BLOCKS
# =============================================================================

cat("\nASSIGNING INCIDENTS TO BLOCKS...\n")
cat(strrep("-", 40), "\n")

block_counts_list <- imap(crime_list, function(sf_obj, nm) {
  assign_to_blocks(sf_obj, physical_blocks, label = nm)
})

# =============================================================================
# SECTION 4: BUILD NESTED DATA
# =============================================================================

cat("\nBUILDING NESTED BLOCK-TRACT-NTA DATA...\n")
cat(strrep("-", 40), "\n")

# Residential NTAs only
xwalk <- crosswalk %>%
  filter(NTAType == 0) %>%
  select(physical_id, BoroCT2020, NTA2020)

cat("  Residential blocks:", comma(nrow(xwalk)), "\n")
cat("  Tracts:", length(unique(xwalk$BoroCT2020)), "\n")
cat("  NTAs:", length(unique(xwalk$NTA2020)), "\n")

# =============================================================================
# SECTION 5: COMPUTE NESTED GINI COEFFICIENTS
# =============================================================================

cat("\nCOMPUTING NESTED GINI COEFFICIENTS...\n")
cat(strrep("=", 70), "\n\n")

nested_results <- imap_dfr(block_counts_list, function(bc, crime_nm) {
  cat(sprintf("  %-28s ", crime_nm))

  # Join block counts to crosswalk (left join from full crosswalk to include zero-count blocks)
  df <- xwalk %>%
    left_join(bc, by = "physical_id") %>%
    mutate(n_incidents = replace_na(n_incidents, 0L))

  total_incidents <- sum(df$n_incidents)

  # =========================================================================
  # Level 1: NTA-level Gini (city-wide)
  # Concentration of crime across NTAs
  # =========================================================================

  nta_counts <- df %>%
    group_by(NTA2020) %>%
    summarise(n = sum(n_incidents), .groups = "drop")

  gini_nta          <- gini(nta_counts$n)
  gini_mod_nta      <- gini_modified(nta_counts$n)
  lambda_nta        <- mean(nta_counts$n)
  gini_poisson_nta  <- gini_poisson(lambda_nta)

  # =========================================================================
  # Level 2: Tract-level nested Gini
  # For each NTA, compute Gini of tract counts within that NTA, then average
  # (weighted by number of incidents in each NTA)
  # =========================================================================

  tract_within_nta <- df %>%
    group_by(NTA2020, BoroCT2020) %>%
    summarise(n = sum(n_incidents), .groups = "drop") %>%
    group_by(NTA2020) %>%
    summarise(
      n_tracts     = n(),
      n_incidents  = sum(n),
      gini_raw     = gini(n),
      gini_mod     = gini_modified(n),
      lambda_local = mean(n),
      gini_poisson_local = gini_poisson(lambda_local),
      .groups = "drop"
    ) %>%
    filter(n_tracts >= 2, n_incidents > 0)  # need >= 2 tracts and > 0 incidents

  # Weighted mean (by incidents, excluding NAs)
  valid_t <- tract_within_nta %>% filter(!is.na(gini_raw))
  w <- valid_t$n_incidents / sum(valid_t$n_incidents)
  nested_gini_tract     <- sum(w * valid_t$gini_raw)
  nested_gini_mod_tract <- sum(w * valid_t$gini_mod, na.rm = TRUE)
  nested_gini_poi_tract <- sum(w * valid_t$gini_poisson_local, na.rm = TRUE)
  n_ntas_used_tract     <- nrow(tract_within_nta)

  # =========================================================================
  # Level 3: Block-level nested Gini
  # For each tract, compute Gini of block counts within that tract, then average
  # (weighted by number of incidents in each tract)
  # =========================================================================

  block_within_tract <- df %>%
    group_by(BoroCT2020) %>%
    summarise(
      n_blocks     = n(),
      gini_raw     = gini(n_incidents),
      gini_mod     = gini_modified(n_incidents),
      lambda_local = mean(n_incidents),
      gini_poisson_local = gini_poisson(lambda_local),
      n_incidents  = sum(n_incidents),
      .groups = "drop"
    ) %>%
    filter(n_blocks >= 2, n_incidents > 0)  # need >= 2 blocks and > 0 incidents

  # Weighted mean (by incidents, excluding NAs)
  valid_b <- block_within_tract %>% filter(!is.na(gini_raw))
  w2 <- valid_b$n_incidents / sum(valid_b$n_incidents)
  nested_gini_block     <- sum(w2 * valid_b$gini_raw)
  nested_gini_mod_block <- sum(w2 * valid_b$gini_mod, na.rm = TRUE)
  nested_gini_poi_block <- sum(w2 * valid_b$gini_poisson_local, na.rm = TRUE)
  n_tracts_used_block   <- nrow(block_within_tract)

  cat(sprintf("NTA=%.3f  Tract(nested)=%.3f  Block(nested)=%.3f\n",
              gini_nta, nested_gini_tract, nested_gini_block))

  tibble(
    crime_type = crime_nm,
    n_incidents = total_incidents,

    # NTA level (city-wide)
    gini_nta          = gini_nta,
    gini_mod_nta      = gini_mod_nta,
    gini_poisson_nta  = gini_poisson_nta,
    marginal_nta      = gini_nta - gini_poisson_nta,

    # Tract level (nested within NTAs)
    nested_gini_tract     = nested_gini_tract,
    nested_gini_mod_tract = nested_gini_mod_tract,
    nested_gini_poi_tract = nested_gini_poi_tract,
    marginal_tract        = nested_gini_tract - nested_gini_poi_tract,
    n_ntas_used_tract     = n_ntas_used_tract,

    # Block level (nested within tracts)
    nested_gini_block     = nested_gini_block,
    nested_gini_mod_block = nested_gini_mod_block,
    nested_gini_poi_block = nested_gini_poi_block,
    marginal_block        = nested_gini_block - nested_gini_poi_block,
    n_tracts_used_block   = n_tracts_used_block
  )
})

cat("\n=== NESTED GINI SUMMARY (2022-2025) ===\n\n")
nested_results %>%
  transmute(
    crime_type,
    n_incidents = comma(n_incidents),
    `NTA (city)` = sprintf("%.3f", gini_nta),
    `Tract|NTA`  = sprintf("%.3f", nested_gini_tract),
    `Block|Tract` = sprintf("%.3f", nested_gini_block),
    `NTA marginal` = sprintf("%.3f", marginal_nta),
    `Tract marginal` = sprintf("%.3f", marginal_tract),
    `Block marginal` = sprintf("%.3f", marginal_block)
  ) %>%
  print(n = 25, width = Inf)

# =============================================================================
# SECTION 6: DISTRIBUTION OF WITHIN-UNIT GINIS
# =============================================================================

cat("\nCOMPUTING WITHIN-UNIT GINI DISTRIBUTIONS...\n")
cat(strrep("-", 40), "\n")

# For selected crime types, save the full distribution of within-NTA and
# within-tract Ginis (for violin/boxplot)

key_types <- c("Murder", "Robbery (outdoor)", "Felony assault", "Burglary",
               "Grand larceny", "Shootings", "Gun violence",
               "Violent crime", "Property crime", "7 Major Felonies")

within_nta_ginis <- imap_dfr(block_counts_list[key_types], function(bc, crime_nm) {
  df <- xwalk %>% left_join(bc, by = "physical_id") %>% mutate(n_incidents = replace_na(n_incidents, 0L))
  df %>%
    group_by(NTA2020, BoroCT2020) %>%
    summarise(n = sum(n_incidents), .groups = "drop") %>%
    group_by(NTA2020) %>%
    summarise(
      n_tracts    = n(),
      n_incidents = sum(n),
      gini_tracts = gini(n),
      .groups = "drop"
    ) %>%
    filter(n_tracts >= 2) %>%
    mutate(crime_type = crime_nm)
})

within_tract_ginis <- imap_dfr(block_counts_list[key_types], function(bc, crime_nm) {
  df <- xwalk %>% left_join(bc, by = "physical_id") %>% mutate(n_incidents = replace_na(n_incidents, 0L))
  df %>%
    group_by(BoroCT2020) %>%
    summarise(
      n_blocks    = n(),
      gini_blocks = gini(n_incidents),
      n_incidents = sum(n_incidents),
      .groups = "drop"
    ) %>%
    filter(n_blocks >= 2) %>%
    mutate(crime_type = crime_nm)
})

# =============================================================================
# SECTION 7: PLOTS
# =============================================================================

cat("\nGENERATING PLOTS...\n")
cat(strrep("-", 40), "\n")

dir.create(here("output", "03-tier2_spatial_scale"), showWarnings = FALSE, recursive = TRUE)

level_colors <- c(
  "NTA (city-wide)"        = "#2c7bb6",
  "Tract (within NTA)"     = "#fdae61",
  "Block (within tract)"   = "#d7191c"
)

# --- Plot 1: Nested Gini dot plot (raw) --------------------------------------

p1_data <- nested_results %>%
  select(crime_type, gini_nta, nested_gini_tract, nested_gini_block) %>%
  pivot_longer(-crime_type, names_to = "level", values_to = "gini_value") %>%
  mutate(
    level = recode(level,
      gini_nta          = "NTA (city-wide)",
      nested_gini_tract = "Tract (within NTA)",
      nested_gini_block = "Block (within tract)"
    ),
    level = factor(level, levels = names(level_colors)),
    crime_type = fct_reorder(crime_type, gini_value, .fun = max)
  )

p1 <- ggplot(p1_data, aes(x = gini_value, y = crime_type,
                            color = level, shape = level)) +
  geom_point(size = 3.5) +
  scale_color_manual(values = level_colors) +
  labs(
    title = "Nested Gini coefficients by spatial scale",
    subtitle = "O'Brien (2018) method: concentration within containing unit | 2022-2025",
    x = "Gini coefficient",
    y = NULL,
    color = NULL, shape = NULL
  ) +
  theme_pub +
  theme(legend.position = "right")

ggsave(here("output", "03-tier2_spatial_scale", "nested_gini_dotplot.png"), p1,
       width = 11, height = 9, dpi = 300, bg = "white")
cat("  nested_gini_dotplot.png saved\n")

# --- Plot 2: Marginal nested Gini (observed minus Poisson null) --------------

p2_data <- nested_results %>%
  select(crime_type, marginal_nta, marginal_tract, marginal_block) %>%
  pivot_longer(-crime_type, names_to = "level", values_to = "marginal") %>%
  mutate(
    level = recode(level,
      marginal_nta   = "NTA (city-wide)",
      marginal_tract = "Tract (within NTA)",
      marginal_block = "Block (within tract)"
    ),
    level = factor(level, levels = names(level_colors)),
    crime_type = fct_reorder(crime_type, marginal, .fun = max)
  )

p2 <- ggplot(p2_data, aes(x = marginal, y = crime_type,
                            color = level, shape = level)) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey60") +
  geom_point(size = 3.5) +
  scale_color_manual(values = level_colors) +
  labs(
    title = "Marginal nested Gini: observed minus Poisson null",
    subtitle = "Concentration above random expectation at each nested scale | 2022-2025",
    x = "Marginal Gini (observed - Poisson expected)",
    y = NULL,
    color = NULL, shape = NULL
  ) +
  theme_pub +
  theme(legend.position = "right")

ggsave(here("output", "03-tier2_spatial_scale", "nested_gini_marginal.png"), p2,
       width = 11, height = 9, dpi = 300, bg = "white")
cat("  nested_gini_marginal.png saved\n")

# --- Plot 3: Violin plots — distribution of within-tract block Ginis ---------

p3_data <- within_tract_ginis %>%
  filter(crime_type %in% key_types) %>%
  mutate(crime_type = factor(crime_type, levels = key_types))

p3 <- ggplot(p3_data, aes(x = crime_type, y = gini_blocks)) +
  geom_violin(fill = "#d7191c", alpha = 0.3, color = "#d7191c") +
  geom_boxplot(width = 0.15, outlier.size = 0.5, color = "grey30") +
  coord_flip() +
  labs(
    title = "Distribution of block-level Gini within each census tract",
    subtitle = "Each point is one tract's within-tract block Gini | 2022-2025",
    x = NULL,
    y = "Gini (blocks within tract)"
  ) +
  theme_pub

ggsave(here("output", "03-tier2_spatial_scale", "nested_gini_block_violins.png"), p3,
       width = 10, height = 7, dpi = 300, bg = "white")
cat("  nested_gini_block_violins.png saved\n")

# --- Plot 4: Violin plots — distribution of within-NTA tract Ginis ----------

p4_data <- within_nta_ginis %>%
  filter(crime_type %in% key_types) %>%
  mutate(crime_type = factor(crime_type, levels = key_types))

p4 <- ggplot(p4_data, aes(x = crime_type, y = gini_tracts)) +
  geom_violin(fill = "#fdae61", alpha = 0.3, color = "#fdae61") +
  geom_boxplot(width = 0.15, outlier.size = 0.5, color = "grey30") +
  coord_flip() +
  labs(
    title = "Distribution of tract-level Gini within each NTA",
    subtitle = "Each point is one NTA's within-NTA tract Gini | 2022-2025",
    x = NULL,
    y = "Gini (tracts within NTA)"
  ) +
  theme_pub

ggsave(here("output", "03-tier2_spatial_scale", "nested_gini_tract_violins.png"), p4,
       width = 10, height = 7, dpi = 300, bg = "white")
cat("  nested_gini_tract_violins.png saved\n")

# --- Plot 5: Stacked bar — decomposing concentration across levels -----------

p5_data <- nested_results %>%
  filter(crime_type %in% key_types) %>%
  select(crime_type, marginal_nta, marginal_tract, marginal_block) %>%
  mutate(
    total = marginal_nta + marginal_tract + marginal_block,
    share_nta   = marginal_nta / total,
    share_tract = marginal_tract / total,
    share_block = marginal_block / total
  ) %>%
  select(crime_type, share_nta, share_tract, share_block) %>%
  pivot_longer(-crime_type, names_to = "level", values_to = "share") %>%
  mutate(
    level = recode(level,
      share_nta   = "NTA (city-wide)",
      share_tract = "Tract (within NTA)",
      share_block = "Block (within tract)"
    ),
    level = factor(level, levels = rev(names(level_colors))),
    crime_type = factor(crime_type, levels = key_types)
  )

p5 <- ggplot(p5_data, aes(x = crime_type, y = share * 100, fill = level)) +
  geom_col(position = "stack", width = 0.75) +
  scale_fill_manual(values = level_colors) +
  coord_flip() +
  labs(
    title = "Share of marginal concentration at each nested level",
    subtitle = "Marginal Gini decomposed into NTA, tract, and block contributions | 2022-2025",
    x = NULL,
    y = "Share of total marginal concentration (%)",
    fill = NULL
  ) +
  theme_pub +
  theme(legend.position = "right")

ggsave(here("output", "03-tier2_spatial_scale", "nested_gini_decomposition.png"), p5,
       width = 11, height = 7, dpi = 300, bg = "white")
cat("  nested_gini_decomposition.png saved\n")

# =============================================================================
# SECTION 8: SAVE
# =============================================================================

write_csv(nested_results, here("output", "03-tier2_spatial_scale",
                                "nested_gini_summary.csv"))
write_csv(within_tract_ginis, here("output", "03-tier2_spatial_scale",
                                    "nested_gini_within_tract_distribution.csv"))
write_csv(within_nta_ginis, here("output", "03-tier2_spatial_scale",
                                  "nested_gini_within_nta_distribution.csv"))

cat("\n  CSVs saved to output/03-tier2_spatial_scale/\n")

cat("\n")
cat(strrep("=", 70), "\n")
cat("NESTED GINI ANALYSIS COMPLETE\n")
cat(strrep("=", 70), "\n")
