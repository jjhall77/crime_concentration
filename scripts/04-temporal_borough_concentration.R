# =============================================================================
# 04-temporal_borough_concentration.R
# Follow-up: concentration by year, by season, and by borough for selected
# crime types. Extends the Tier 1 analysis (03) with finer temporal and
# geographic disaggregations.
#
# Analyses:
#   A. By year (full range): retail theft, commercial burglary, shootings,
#      robbery (outdoor)
#   B1. By month-of-year (2022-2025 pooled): shootings, gun violence,
#       pickpocket (non-transit) — seasonal concentration profile
#   B2. By quarter-year (2022-2025): same 3 crime types — quarterly time
#       series preserving both seasonal and year-over-year trends
#   C. By borough (2022-2025): residential burglary, theft from auto,
#      vehicle accessory theft
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(lubridate)
library(janitor)

cat("\n")
cat(strrep("=", 70), "\n")
cat("TEMPORAL & BOROUGH CONCENTRATION DISAGGREGATIONS\n")
cat(strrep("=", 70), "\n\n")

# =============================================================================
# SECTION 0: FUNCTIONS (reused from 03)
# =============================================================================

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

compute_50x <- function(counts_vec) {
  counts_sorted <- sort(counts_vec, decreasing = TRUE)
  total <- sum(counts_sorted)
  if (total == 0) return(NA_real_)
  cumshare <- cumsum(counts_sorted) / total
  k50 <- which(cumshare >= 0.50)[1]
  k50 / length(counts_sorted)
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
  if (nrow(pts_sf) == 0) {
    return(
      blocks_sf %>%
        st_drop_geometry() %>%
        select(physical_id) %>%
        mutate(n_incidents = 0L)
    )
  }
  pts_sf <- st_transform(pts_sf, st_crs(blocks_sf))
  nearest_idx <- st_nearest_feature(pts_sf, blocks_sf)
  dists_ft <- as.numeric(
    st_distance(pts_sf, blocks_sf[nearest_idx, ], by_element = TRUE)
  )
  n_far <- sum(dists_ft > 100)
  cat(sprintf("  %-40s %8s pts | %5d (%.1f%%) > 100ft\n",
              label, comma(nrow(pts_sf)), n_far, 100 * n_far / nrow(pts_sf)))

  block_counts <- tibble(physical_id = blocks_sf$physical_id[nearest_idx]) %>%
    count(physical_id, name = "n_incidents")

  blocks_sf %>%
    st_drop_geometry() %>%
    select(physical_id) %>%
    left_join(block_counts, by = "physical_id") %>%
    mutate(n_incidents = replace_na(n_incidents, 0L))
}

# Helper: compute all metrics for a set of block counts
compute_metrics <- function(block_counts, n_blocks) {
  n_inc <- sum(block_counts$n_incidents)
  lambda_val <- n_inc / n_blocks
  tibble(
    n_incidents   = n_inc,
    lambda        = lambda_val,
    observed_50x  = compute_50x(block_counts$n_incidents),
    null_50x      = analytical_pct_blocks_for_50pct(lambda_val),
    marginal_50x  = observed_50x - null_50x,
    observed_gini = gini(block_counts$n_incidents),
    null_gini     = gini_poisson(lambda_val),
    marginal_gini = observed_gini - null_gini
  )
}

theme_pub <- theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title    = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey40", size = 11),
    axis.title    = element_text(size = 12),
    legend.position = "bottom"
  )

# =============================================================================
# SECTION 1: LOAD DATA (same as 03)
# =============================================================================

cat("LOADING DATA...\n")
cat(strrep("-", 40), "\n")

physical_blocks <- st_read(
  here("data", "physical_blocks.gpkg"), quiet = TRUE
) %>% st_transform(2263)

N_BLOCKS <- nrow(physical_blocks)
cat("  physical_blocks:", comma(N_BLOCKS), "blocks\n")

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
# SECTION 2: BUILD CRIME TYPE SF OBJECTS (only what we need)
# =============================================================================

cat("\nBUILDING CRIME TYPE DATASETS...\n")
cat(strrep("-", 40), "\n")

# --- Outdoor classification keywords ----------------------------------------

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

# --- Complaints -> sf -------------------------------------------------------

compl_sf <- complaints %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE) %>%
  mutate(
    date = mdy(cmplnt_fr_dt),
    year = year(date),
    month = floor_date(date, "month"),
    loc_of_occur_desc = str_to_upper(coalesce(loc_of_occur_desc, "")),
    prem_typ_desc     = str_to_upper(coalesce(prem_typ_desc, "")),
    pd_desc           = str_to_upper(coalesce(pd_desc, "")),
    is_outdoor = str_detect(loc_of_occur_desc, outside_loc_pattern) |
                 str_detect(prem_typ_desc, outside_prem_pattern)
  )

# Crime types needed for this script:
# A (by year):   retail theft, commercial burglary, shootings, robbery (outdoor)
# B (by month):  shootings, gun violence, pickpocket (non-transit)
# C (by boro):   residential burglary, theft from auto, vehicle accessory theft

retail_theft_sf        <- compl_sf %>% filter(pd_cd %in% c(396, 433, 333))
commercial_burg_sf     <- compl_sf %>% filter(ky_cd == 107, str_detect(pd_desc, "COMMERCIAL"))
robbery_outdoor_sf     <- compl_sf %>% filter(ky_cd == 105, is_outdoor)
residential_burg_sf    <- compl_sf %>% filter(ky_cd == 107, str_detect(pd_desc, "RESIDENCE"))
vehicle_acc_theft_sf   <- compl_sf %>% filter(pd_cd %in% c(457, 357))
theft_from_auto_sf     <- compl_sf %>% filter(pd_cd %in% c(441, 321, 442))
pickpocket_nontransit_sf <- compl_sf %>% filter(pd_cd %in% c(415, 406))

shootings_sf <- shootings %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  mutate(
    date = mdy(occur_date),
    year = year(date),
    month = floor_date(date, "month")
  ) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE)

# Gun violence = shootings + shots fired (shared window)
gun_violence_start <- as.Date("2018-01-01")
gun_violence_end   <- max(shots_fired_combined$date, na.rm = TRUE)

shootings_for_gv <- shootings_sf %>%
  filter(date >= gun_violence_start, date <= gun_violence_end) %>%
  transmute(date, year, month = floor_date(date, "month"),
            source = "shooting", geometry)

shots_for_gv <- shots_fired_combined %>%
  filter(date >= gun_violence_start, date <= gun_violence_end) %>%
  mutate(month = floor_date(date, "month")) %>%
  transmute(date, year, month, source = "shots_fired", geometry)

gun_violence_sf <- bind_rows(shootings_for_gv, shots_for_gv)

cat("  retail theft:", comma(nrow(retail_theft_sf)), "\n")
cat("  commercial burglary:", comma(nrow(commercial_burg_sf)), "\n")
cat("  robbery (outdoor):", comma(nrow(robbery_outdoor_sf)), "\n")
cat("  residential burglary:", comma(nrow(residential_burg_sf)), "\n")
cat("  vehicle accessory theft:", comma(nrow(vehicle_acc_theft_sf)), "\n")
cat("  theft from auto:", comma(nrow(theft_from_auto_sf)), "\n")
cat("  pickpocket (non-transit):", comma(nrow(pickpocket_nontransit_sf)), "\n")
cat("  shootings:", comma(nrow(shootings_sf)), "\n")
cat("  gun violence:", comma(nrow(gun_violence_sf)),
    sprintf(" (%s to %s)\n", gun_violence_start, gun_violence_end))

rm(compl_sf, shootings_for_gv, shots_for_gv)

# =============================================================================
# SECTION 3A: CONCENTRATION BY YEAR
# =============================================================================

cat("\n")
cat(strrep("=", 70), "\n")
cat("ANALYSIS A: CONCENTRATION BY YEAR\n")
cat(strrep("=", 70), "\n\n")

yearly_crimes <- list(
  "Retail theft"        = retail_theft_sf,
  "Commercial burglary" = commercial_burg_sf,
  "Shootings"           = shootings_sf,
  "Robbery (outdoor)"   = robbery_outdoor_sf
)

yearly_results <- imap_dfr(yearly_crimes, function(sf_obj, crime_nm) {
  years <- sort(unique(sf_obj$year))
  years <- years[!is.na(years) & years >= 2006 & years <= 2025]
  cat(sprintf("  %s: %d years (%d-%d)\n", crime_nm, length(years),
              min(years), max(years)))

  map_dfr(years, function(yr) {
    sf_yr <- sf_obj %>% filter(year == yr)
    bc <- assign_to_blocks(sf_yr, physical_blocks,
                           label = paste0(crime_nm, " ", yr))
    compute_metrics(bc, N_BLOCKS) %>%
      mutate(crime_type = crime_nm, year = yr, .before = 1)
  })
})

cat("\n=== CONCENTRATION BY YEAR ===\n\n")
yearly_results %>%
  mutate(across(c(observed_50x, null_50x, marginal_50x), ~ sprintf("%.3f%%", . * 100)),
         across(c(observed_gini, null_gini, marginal_gini), ~ sprintf("%.4f", .)),
         lambda = sprintf("%.3f", lambda),
         n_incidents = comma(n_incidents)) %>%
  print(n = 200, width = Inf)

write_csv(yearly_results, here("output", "concentration_by_year.csv"))
cat("\nSaved: output/concentration_by_year.csv\n")

# =============================================================================
# SECTION 3B1: SEASONAL CONCENTRATION — POOLED MONTH-OF-YEAR (2022-2025)
# =============================================================================
# Pool all Januaries, all Februaries, etc. across 2022-2025 to get a seasonal
# concentration profile with ~4x the power of a single month.

cat("\n")
cat(strrep("=", 70), "\n")
cat("ANALYSIS B1: SEASONAL CONCENTRATION — MONTH-OF-YEAR (2022-2025)\n")
cat(strrep("=", 70), "\n\n")

seasonal_crimes <- list(
  "Shootings"                = shootings_sf,
  "Gun violence"             = gun_violence_sf,
  "Pickpocket (non-transit)" = pickpocket_nontransit_sf
)

seasonal_results <- imap_dfr(seasonal_crimes, function(sf_obj, crime_nm) {
  sf_filtered <- sf_obj %>%
    filter(year >= 2022, year <= 2025) %>%
    mutate(month_of_year = month(date))

  months_avail <- sort(unique(sf_filtered$month_of_year))
  cat(sprintf("  %s: %d months-of-year, n = %s incidents (2022-2025)\n",
              crime_nm, length(months_avail), comma(nrow(sf_filtered))))

  map_dfr(months_avail, function(mo) {
    sf_mo <- sf_filtered %>% filter(month_of_year == mo)
    bc <- assign_to_blocks(sf_mo, physical_blocks,
                           label = sprintf("%s month %02d", crime_nm, mo))
    compute_metrics(bc, N_BLOCKS) %>%
      mutate(crime_type = crime_nm, month_of_year = mo, .before = 1)
  })
})

# Add month labels for readability
seasonal_results <- seasonal_results %>%
  mutate(month_label = month.abb[month_of_year])

cat("\n=== SEASONAL CONCENTRATION (POOLED MONTH-OF-YEAR, 2022-2025) ===\n\n")
seasonal_results %>%
  mutate(across(c(observed_50x, null_50x, marginal_50x), ~ sprintf("%.4f%%", . * 100)),
         across(c(observed_gini, null_gini, marginal_gini), ~ sprintf("%.4f", .)),
         lambda = sprintf("%.4f", lambda),
         n_incidents = comma(n_incidents)) %>%
  print(n = 50, width = Inf)

write_csv(seasonal_results, here("output", "concentration_seasonal_2022_2025.csv"))
cat("\nSaved: output/concentration_seasonal_2022_2025.csv\n")

# =============================================================================
# SECTION 3B2: QUARTERLY CONCENTRATION TIME SERIES (2022-2025)
# =============================================================================
# 3-month windows per year: Q1 (Jan-Mar), Q2 (Apr-Jun), Q3 (Jul-Sep), Q4 (Oct-Dec)
# Preserves both seasonal and year-over-year trends with ~3x monthly power.

cat("\n")
cat(strrep("=", 70), "\n")
cat("ANALYSIS B2: QUARTERLY CONCENTRATION (2022-2025)\n")
cat(strrep("=", 70), "\n\n")

quarterly_results <- imap_dfr(seasonal_crimes, function(sf_obj, crime_nm) {
  sf_filtered <- sf_obj %>%
    filter(year >= 2022, year <= 2025) %>%
    mutate(quarter = quarter(date),
           year_quarter = paste0(year, "-Q", quarter))

  yqs <- sort(unique(sf_filtered$year_quarter))
  cat(sprintf("  %s: %d quarters\n", crime_nm, length(yqs)))

  map_dfr(yqs, function(yq) {
    sf_q <- sf_filtered %>% filter(year_quarter == yq)
    bc <- assign_to_blocks(sf_q, physical_blocks,
                           label = paste0(crime_nm, " ", yq))
    yr <- as.integer(str_sub(yq, 1, 4))
    qtr <- as.integer(str_sub(yq, 7, 7))
    compute_metrics(bc, N_BLOCKS) %>%
      mutate(crime_type = crime_nm, year = yr, quarter = qtr,
             year_quarter = yq, .before = 1)
  })
})

cat("\n=== QUARTERLY CONCENTRATION (2022-2025) ===\n\n")
quarterly_results %>%
  mutate(across(c(observed_50x, null_50x, marginal_50x), ~ sprintf("%.4f%%", . * 100)),
         across(c(observed_gini, null_gini, marginal_gini), ~ sprintf("%.4f", .)),
         lambda = sprintf("%.4f", lambda),
         n_incidents = comma(n_incidents)) %>%
  print(n = 60, width = Inf)

write_csv(quarterly_results, here("output", "concentration_quarterly_2022_2025.csv"))
cat("\nSaved: output/concentration_quarterly_2022_2025.csv\n")

# =============================================================================
# SECTION 3C: CONCENTRATION BY BOROUGH (2022-2025)
# =============================================================================

cat("\n")
cat(strrep("=", 70), "\n")
cat("ANALYSIS C: CONCENTRATION BY BOROUGH (2022-2025)\n")
cat(strrep("=", 70), "\n\n")

boro_lookup <- c("1" = "Manhattan", "2" = "Bronx", "3" = "Brooklyn",
                 "4" = "Queens", "5" = "Staten Island")

block_boro <- physical_blocks %>%
  st_drop_geometry() %>%
  select(physical_id, boro) %>%
  mutate(boro_name = boro_lookup[as.character(boro)]) %>%
  filter(!is.na(boro_name))

blocks_per_boro <- block_boro %>% count(boro_name, name = "n_blocks")

boro_crimes <- list(
  "Residential burglary"    = residential_burg_sf,
  "Theft from auto"         = theft_from_auto_sf,
  "Vehicle accessory theft" = vehicle_acc_theft_sf
)

# Filter to 2022-2025 and assign to blocks
boro_crimes_2225 <- map(boro_crimes, ~ filter(.x, year >= 2022, year <= 2025))

cat("Assigning 2022-2025 incidents to blocks...\n")
boro_block_counts <- imap(boro_crimes_2225, function(sf_obj, nm) {
  assign_to_blocks(sf_obj, physical_blocks, label = paste0(nm, " (22-25)"))
})

boro_results <- imap_dfr(boro_block_counts, function(bc, crime_nm) {
  bc_boro <- bc %>% inner_join(block_boro, by = "physical_id")

  map_dfr(unique(bc_boro$boro_name), function(b) {
    bc_b <- bc_boro %>% filter(boro_name == b)
    n_blocks_b <- nrow(bc_b)

    compute_metrics(bc_b, n_blocks_b) %>%
      mutate(crime_type = crime_nm, borough = b, n_blocks = n_blocks_b,
             .before = 1)
  })
})

cat("\n=== CONCENTRATION BY BOROUGH (2022-2025) ===\n\n")
boro_results %>%
  mutate(across(c(observed_50x, null_50x, marginal_50x), ~ sprintf("%.2f%%", . * 100)),
         across(c(observed_gini, null_gini, marginal_gini), ~ sprintf("%.4f", .)),
         lambda = sprintf("%.3f", lambda),
         n_incidents = comma(n_incidents)) %>%
  print(n = 50, width = Inf)

write_csv(boro_results, here("output", "concentration_by_borough_2022_2025.csv"))
cat("\nSaved: output/concentration_by_borough_2022_2025.csv\n")

# =============================================================================
# SECTION 4: PLOTS
# =============================================================================

cat("\n")
cat(strrep("=", 70), "\n")
cat("GENERATING PLOTS\n")
cat(strrep("=", 70), "\n\n")

# Colors for subsets used here
yearly_colors <- c(
  "Retail theft"        = "#4daf4a",
  "Commercial burglary" = "#92c5de",
  "Shootings"           = "#e31a1c",
  "Robbery (outdoor)"   = "#d6604d"
)

seasonal_colors <- c(
  "Shootings"                = "#e31a1c",
  "Gun violence"             = "#800026",
  "Pickpocket (non-transit)" = "#f781bf"
)

boro_colors <- c(
  "Residential burglary"    = "#4393c3",
  "Theft from auto"         = "#ff7f00",
  "Vehicle accessory theft" = "#984ea3"
)

# --- Plot A: Marginal 50-X by year ------------------------------------------

p_yearly <- ggplot(yearly_results,
                   aes(x = year, y = marginal_50x * 100, color = crime_type)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60",
             linewidth = 0.3) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 1.8) +
  scale_color_manual(values = yearly_colors) +
  scale_y_continuous(labels = function(x) paste0(x, " pp")) +
  labs(
    title = "Marginal concentration by year",
    subtitle = paste0("50-X metric: observed minus Poisson null  |  ",
                      "N = ", comma(N_BLOCKS), " blocks"),
    x = "Year",
    y = "Marginal 50-X (percentage points)",
    color = NULL
  ) +
  theme_pub +
  guides(color = guide_legend(nrow = 1))

ggsave(here("output", "marginal_50x_by_year.png"), p_yearly,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  marginal_50x_by_year.png saved\n")

# --- Plot B1: Seasonal concentration (month-of-year, pooled 2022-2025) ------

p_seasonal <- ggplot(seasonal_results,
                     aes(x = month_of_year, y = marginal_50x * 100,
                         color = crime_type)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60",
             linewidth = 0.3) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 2.2) +
  scale_color_manual(values = seasonal_colors) +
  scale_x_continuous(breaks = 1:12, labels = month.abb) +
  scale_y_continuous(labels = function(x) paste0(x, " pp")) +
  labs(
    title = "Seasonal concentration: month-of-year profile",
    subtitle = paste0("2022-2025 pooled  |  50-X marginal: observed minus Poisson null  |  ",
                      "N = ", comma(N_BLOCKS), " blocks"),
    x = "Month",
    y = "Marginal 50-X (percentage points)",
    color = NULL
  ) +
  theme_pub +
  guides(color = guide_legend(nrow = 1))

ggsave(here("output", "seasonal_concentration_month_of_year.png"), p_seasonal,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  seasonal_concentration_month_of_year.png saved\n")

# --- Plot B2: Quarterly concentration time series (2022-2025) ---------------

# Create a date midpoint for each quarter for smooth x-axis
quarterly_plot_data <- quarterly_results %>%
  mutate(
    quarter_date = as.Date(paste0(year, "-", (quarter - 1) * 3 + 2, "-15"))
  )

p_quarterly <- ggplot(quarterly_plot_data,
                      aes(x = quarter_date, y = marginal_50x * 100,
                          color = crime_type)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey60",
             linewidth = 0.3) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 2) +
  scale_color_manual(values = seasonal_colors) +
  scale_x_date(date_breaks = "3 months", date_labels = "%b\n%Y") +
  scale_y_continuous(labels = function(x) paste0(x, " pp")) +
  labs(
    title = "Quarterly marginal concentration (2022-2025)",
    subtitle = paste0("50-X metric: observed minus Poisson null  |  ",
                      "N = ", comma(N_BLOCKS), " blocks"),
    x = NULL,
    y = "Marginal 50-X (percentage points)",
    color = NULL
  ) +
  theme_pub +
  guides(color = guide_legend(nrow = 1))

ggsave(here("output", "quarterly_concentration_2022_2025.png"), p_quarterly,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  quarterly_concentration_2022_2025.png saved\n")

# --- Plot C: Borough marginal dot plot (2022-2025) ---------------------------

boro_dotplot <- boro_results %>%
  mutate(
    crime_type = factor(crime_type, levels = names(boro_colors)),
    borough    = factor(borough, levels = c("Manhattan", "Bronx", "Brooklyn",
                                             "Queens", "Staten Island"))
  )

p_boro <- ggplot(boro_dotplot) +
  geom_segment(aes(x = null_50x * 100, xend = observed_50x * 100,
                   y = borough, yend = borough),
               color = "grey60", linewidth = 0.7) +
  geom_point(aes(x = null_50x * 100, y = borough),
             color = "#2c7bb6", size = 3, shape = 16) +
  geom_point(aes(x = observed_50x * 100, y = borough),
             color = "#d7191c", size = 3, shape = 16) +
  geom_text(aes(x = (null_50x + observed_50x) / 2 * 100, y = borough,
                label = sprintf("%.1f pp", marginal_50x * 100)),
            vjust = -1, size = 2.8, color = "grey30") +
  facet_wrap(~ crime_type, scales = "free_x", ncol = 3) +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Marginal concentration by borough (2022-2025)",
    subtitle = "Blue = Poisson null  |  Red = observed  |  Gap = marginal concentration",
    x = "% of blocks accounting for 50% of incidents",
    y = NULL
  ) +
  theme_pub +
  theme(
    legend.position = "none",
    strip.text = element_text(face = "bold", size = 11)
  )

ggsave(here("output", "marginal_concentration_by_borough_2022_2025.png"), p_boro,
       width = 12, height = 5.5, dpi = 300, bg = "white")
cat("  marginal_concentration_by_borough_2022_2025.png saved\n")

# =============================================================================
# DONE
# =============================================================================

cat("\n")
cat(strrep("=", 70), "\n")
cat("TEMPORAL & BOROUGH DISAGGREGATIONS COMPLETE\n")
cat(strrep("=", 70), "\n")
cat("\nOutputs:\n")
cat("  output/concentration_by_year.csv\n")
cat("  output/concentration_seasonal_2022_2025.csv\n")
cat("  output/concentration_quarterly_2022_2025.csv\n")
cat("  output/concentration_by_borough_2022_2025.csv\n")
cat("  output/marginal_50x_by_year.png\n")
cat("  output/seasonal_concentration_month_of_year.png\n")
cat("  output/quarterly_concentration_2022_2025.png\n")
cat("  output/marginal_concentration_by_borough_2022_2025.png\n")
cat("\nDone.\n")
