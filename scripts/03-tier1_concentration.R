# =============================================================================
# 03-tier1_concentration.R
# Tier 1 Crime Concentration Analysis: Observed vs. Null
#
# Computes observed concentration (50-X metric, Lorenz curves, Gini) for each
# NYC crime type, compares to the analytical Poisson null baseline, and
# reports marginal concentration (Chalfin et al. 2021).
#
# References:
#   Chalfin, Kaplan & Cuellar (2021), JRCD 58(4) — marginal concentration
#   Bernasco & Steenbeek (2017), J Quant Crim 33 — generalized Gini
#   Weisburd (2015), Criminology 53(2) — law of crime concentration
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(lubridate)
library(janitor)

cat("\n")
cat(strrep("=", 70), "\n")
cat("TIER 1: CRIME CONCENTRATION ANALYSIS\n")
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

# --- Concentration metric functions ------------------------------------------

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
  pct_blocks    <- seq_len(n) / n
  pct_incidents <- cumsum(counts_sorted) / total
  idx <- unique(c(1, round(seq(1, n, length.out = n_pts)), n))
  tibble(
    pct_blocks    = pct_blocks[idx],
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

# =============================================================================
# SECTION 1: LOAD RAW DATA
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
cat("  shootings:", comma(nrow(shootings)), "records (2006-2025)\n")

# --- Shots fired (two sources, combine with temporal cutoff) -----------------

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
cat("    Date range:", as.character(min(shots_fired_combined$date)),
    "to", as.character(max(shots_fired_combined$date)), "\n")

rm(complaints_historic, complaints_ytd, sf_since_2017, shots_fired_new,
   sf_2017_std, sf_new_std, cutoff_date)

# =============================================================================
# SECTION 2: BUILD CRIME TYPE SF OBJECTS
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

# --- Complaints → sf with outdoor flag & date --------------------------------

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
  )

# --- Individual crime types from complaints ----------------------------------

murder_sf              <- compl_sf %>% filter(ky_cd == 101)
robbery_sf             <- compl_sf %>% filter(ky_cd == 105)
robbery_outdoor_sf     <- compl_sf %>% filter(ky_cd == 105, is_outdoor)
felony_assault_sf      <- compl_sf %>% filter(ky_cd == 106)
felony_assault_outdoor_sf <- compl_sf %>% filter(ky_cd == 106, is_outdoor)
burglary_sf            <- compl_sf %>% filter(ky_cd == 107)
residential_burg_sf    <- compl_sf %>% filter(ky_cd == 107, str_detect(pd_desc, "RESIDENCE"))
commercial_burg_sf     <- compl_sf %>% filter(ky_cd == 107, str_detect(pd_desc, "COMMERCIAL"))
grand_larceny_sf       <- compl_sf %>% filter(ky_cd == 109)
gla_sf                 <- compl_sf %>% filter(ky_cd == 110)
retail_theft_sf        <- compl_sf %>% filter(pd_cd %in% c(396, 433, 333))
vehicle_acc_theft_sf   <- compl_sf %>% filter(pd_cd %in% c(457, 357))
theft_from_auto_sf     <- compl_sf %>% filter(pd_cd %in% c(441, 321, 442))
# Street assaults (pd_cd 101 = Assault 3, 109 = Assault 2,1) — outdoor only
street_assault_sf      <- compl_sf %>% filter(pd_cd %in% c(101, 109), is_outdoor)
# Pickpocket: transit vs non-transit
pickpocket_transit_sf  <- complaints %>%
  filter(pd_cd %in% c(415, 406), jurisdiction_code == 1) %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE) %>%
  mutate(date = mdy(cmplnt_fr_dt), year = year(date))
pickpocket_nontransit_sf <- compl_sf %>%
  filter(pd_cd %in% c(415, 406))
  # compl_sf already filtered jurisdiction_code != 1

# --- Shootings → sf ----------------------------------------------------------

shootings_sf <- shootings %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  mutate(date = mdy(occur_date), year = year(date)) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE)

# --- Gun violence = Shootings + Shots fired (truncated to shared range) ------
# Shots fired data starts ~2018; truncate both to shared window

gun_violence_start <- as.Date("2018-01-01")
gun_violence_end   <- max(shots_fired_combined$date, na.rm = TRUE)

shootings_for_gv <- shootings_sf %>%
  filter(date >= gun_violence_start, date <= gun_violence_end) %>%
  transmute(date, year, source = "shooting", geometry)

shots_for_gv <- shots_fired_combined %>%
  filter(date >= gun_violence_start, date <= gun_violence_end) %>%
  transmute(date, year, source = "shots_fired", geometry)

gun_violence_sf <- bind_rows(shootings_for_gv, shots_for_gv)

cat("  murder:", comma(nrow(murder_sf)), "\n")
cat("  robbery:", comma(nrow(robbery_sf)), "\n")
cat("  robbery (outdoor):", comma(nrow(robbery_outdoor_sf)), "\n")
cat("  felony assault:", comma(nrow(felony_assault_sf)), "\n")
cat("  felony assault (outdoor):", comma(nrow(felony_assault_outdoor_sf)), "\n")
cat("  street assault:", comma(nrow(street_assault_sf)), "\n")
cat("  burglary:", comma(nrow(burglary_sf)), "\n")
cat("  residential burglary:", comma(nrow(residential_burg_sf)), "\n")
cat("  commercial burglary:", comma(nrow(commercial_burg_sf)), "\n")
cat("  grand larceny:", comma(nrow(grand_larceny_sf)), "\n")
cat("  GLA:", comma(nrow(gla_sf)), "\n")
cat("  retail theft:", comma(nrow(retail_theft_sf)), "\n")
cat("  vehicle accessory theft:", comma(nrow(vehicle_acc_theft_sf)), "\n")
cat("  theft from auto:", comma(nrow(theft_from_auto_sf)), "\n")
cat("  pickpocket (transit):", comma(nrow(pickpocket_transit_sf)), "\n")
cat("  pickpocket (non-transit):", comma(nrow(pickpocket_nontransit_sf)), "\n")
cat("  shootings:", comma(nrow(shootings_sf)), "(2006-2025)\n")
cat("  gun violence:", comma(nrow(gun_violence_sf)),
    sprintf("(%s to %s)\n", gun_violence_start, gun_violence_end))

rm(compl_sf, shootings_for_gv, shots_for_gv)

# --- Crime list ---------------------------------------------------------------

crime_list <- list(
  "Murder"                    = murder_sf,
  "Robbery"                   = robbery_sf,
  "Robbery (outdoor)"         = robbery_outdoor_sf,
  "Felony assault"            = felony_assault_sf,
  "Felony assault (outdoor)"  = felony_assault_outdoor_sf,
  "Street assault"            = street_assault_sf,
  "Burglary"                  = burglary_sf,
  "Residential burglary"      = residential_burg_sf,
  "Commercial burglary"       = commercial_burg_sf,
  "Grand larceny"             = grand_larceny_sf,
  "GLA"                       = gla_sf,
  "Retail theft"              = retail_theft_sf,
  "Vehicle accessory theft"   = vehicle_acc_theft_sf,
  "Theft from auto"           = theft_from_auto_sf,
  "Pickpocket (transit)"      = pickpocket_transit_sf,
  "Pickpocket (non-transit)"  = pickpocket_nontransit_sf,
  "Shootings"                 = shootings_sf,
  "Gun violence"              = gun_violence_sf
)

# --- Color palette (18 types) ------------------------------------------------
# Group by family: red = violent/gun, blue = property, green/brown = theft

crime_colors <- c(
  "Murder"                    = "#67001f",
  "Robbery"                   = "#b2182b",
  "Robbery (outdoor)"         = "#d6604d",
  "Felony assault"            = "#f4a582",
  "Felony assault (outdoor)"  = "#fddbc7",
  "Street assault"            = "#e41a1c",
  "Burglary"                  = "#2166ac",
  "Residential burglary"      = "#4393c3",
  "Commercial burglary"       = "#92c5de",
  "Grand larceny"             = "#053061",
  "GLA"                       = "#313695",
  "Retail theft"              = "#4daf4a",
  "Vehicle accessory theft"   = "#984ea3",
  "Theft from auto"           = "#ff7f00",
  "Pickpocket (transit)"      = "#a65628",
  "Pickpocket (non-transit)"  = "#f781bf",
  "Shootings"                 = "#e31a1c",
  "Gun violence"              = "#800026"
)

# =============================================================================
# SECTION 3: ASSIGN INCIDENTS TO PHYSICAL BLOCKS
# =============================================================================

cat("\nASSIGNING INCIDENTS TO BLOCKS (st_nearest_feature)...\n")
cat(strrep("-", 40), "\n")
cat("This will take a while with 18 crime types.\n\n")

block_counts_list <- imap(crime_list, function(sf_obj, nm) {
  assign_to_blocks(sf_obj, physical_blocks, label = nm)
})

# =============================================================================
# SECTION 4: CONCENTRATION METRICS (ALL YEARS)
# =============================================================================

cat("\nCOMPUTING CONCENTRATION METRICS...\n")
cat(strrep("-", 40), "\n")

summary_all <- tibble(
  crime_type    = names(crime_list),
  n_incidents   = map_int(block_counts_list, ~ sum(.x$n_incidents)),
  lambda        = n_incidents / N_BLOCKS,
  observed_50x  = map_dbl(block_counts_list, ~ compute_50x(.x$n_incidents)),
  null_50x      = map_dbl(lambda, analytical_pct_blocks_for_50pct),
  marginal_50x  = observed_50x - null_50x,
  observed_gini = map_dbl(block_counts_list, ~ gini(.x$n_incidents)),
  null_gini     = map_dbl(lambda, gini_poisson),
  marginal_gini = observed_gini - null_gini
)

cat("\n=== ALL-YEARS SUMMARY (N =", comma(N_BLOCKS), "blocks) ===\n\n")
summary_all %>%
  mutate(across(c(observed_50x, null_50x, marginal_50x), ~ sprintf("%.2f%%", . * 100)),
         across(c(observed_gini, null_gini, marginal_gini), ~ sprintf("%.4f", .)),
         lambda = sprintf("%.3f", lambda),
         n_incidents = comma(n_incidents)) %>%
  print(n = 20, width = Inf)

# =============================================================================
# SECTION 5: SINGLE-YEAR COMPARISON
# =============================================================================

cat("\nCOMPUTING SINGLE-YEAR COMPARISON...\n")
cat(strrep("-", 40), "\n")

max_years <- map_int(crime_list, ~ max(.x$year, na.rm = TRUE))
target_year <- min(max_years)
cat("  Target year:", target_year, "\n")

crime_list_yr <- map(crime_list, ~ filter(.x, year == target_year))

cat("  Assigning single-year incidents to blocks...\n")
block_counts_yr <- imap(crime_list_yr, function(sf_obj, nm) {
  assign_to_blocks(sf_obj, physical_blocks, label = paste0(nm, " (", target_year, ")"))
})

summary_yr <- tibble(
  crime_type    = names(crime_list_yr),
  n_incidents   = map_int(block_counts_yr, ~ sum(.x$n_incidents)),
  lambda        = n_incidents / N_BLOCKS,
  observed_50x  = map_dbl(block_counts_yr, ~ compute_50x(.x$n_incidents)),
  null_50x      = map_dbl(lambda, analytical_pct_blocks_for_50pct),
  marginal_50x  = observed_50x - null_50x,
  observed_gini = map_dbl(block_counts_yr, ~ gini(.x$n_incidents)),
  null_gini     = map_dbl(lambda, gini_poisson),
  marginal_gini = observed_gini - null_gini
)

cat(sprintf("\n=== %d SINGLE-YEAR SUMMARY ===\n\n", target_year))
summary_yr %>%
  mutate(across(c(observed_50x, null_50x, marginal_50x), ~ sprintf("%.2f%%", . * 100)),
         across(c(observed_gini, null_gini, marginal_gini), ~ sprintf("%.4f", .)),
         lambda = sprintf("%.3f", lambda),
         n_incidents = comma(n_incidents)) %>%
  print(n = 20, width = Inf)

write_csv(summary_all, here("output", "01-tier1_main", "tier1_concentration_summary.csv"))
write_csv(summary_yr, here("output", "01-tier1_main", "tier1_concentration_summary_single_year.csv"))
cat("\nSummaries saved to output/\n")

# =============================================================================
# SECTION 6: BOROUGH-LEVEL MARGINAL CONCENTRATION (2021–2025)
# =============================================================================

cat("\nBOROUGH-LEVEL MARGINAL CONCENTRATION (2021-2025)...\n")
cat(strrep("-", 40), "\n")

boro_lookup <- c("1" = "Manhattan", "2" = "Bronx", "3" = "Brooklyn",
                 "4" = "Queens", "5" = "Staten Island")

block_boro <- physical_blocks %>%
  st_drop_geometry() %>%
  select(physical_id, boro) %>%
  mutate(boro_name = boro_lookup[as.character(boro)]) %>%
  filter(!is.na(boro_name))

blocks_per_boro <- block_boro %>% count(boro_name, name = "n_blocks")
cat("  Blocks per borough:\n")
print(blocks_per_boro)

crime_list_2125 <- map(crime_list, ~ filter(.x, year >= 2021 & year <= 2025))

cat("\n  Assigning 2021-2025 incidents to blocks...\n")
block_counts_2125 <- imap(crime_list_2125, function(sf_obj, nm) {
  assign_to_blocks(sf_obj, physical_blocks, label = paste0(nm, " (21-25)"))
})

boro_results <- imap_dfr(block_counts_2125, function(bc, crime_nm) {
  bc_boro <- bc %>% inner_join(block_boro, by = "physical_id")

  map_dfr(unique(bc_boro$boro_name), function(b) {
    bc_b <- bc_boro %>% filter(boro_name == b)
    n_blocks_b <- nrow(bc_b)
    n_inc <- sum(bc_b$n_incidents)
    lambda_b <- n_inc / n_blocks_b

    tibble(
      crime_type    = crime_nm,
      borough       = b,
      n_blocks      = n_blocks_b,
      n_incidents   = n_inc,
      lambda        = lambda_b,
      observed_50x  = compute_50x(bc_b$n_incidents),
      null_50x      = analytical_pct_blocks_for_50pct(lambda_b),
      marginal_50x  = observed_50x - null_50x,
      observed_gini = gini(bc_b$n_incidents),
      null_gini     = gini_poisson(lambda_b),
      marginal_gini = observed_gini - null_gini
    )
  })
})

cat("\n=== BOROUGH-LEVEL MARGINAL CONCENTRATION (2021-2025) ===\n\n")
boro_results %>%
  mutate(across(c(observed_50x, null_50x, marginal_50x), ~ sprintf("%.2f%%", . * 100)),
         across(c(observed_gini, null_gini, marginal_gini), ~ sprintf("%.4f", .)),
         lambda = sprintf("%.3f", lambda),
         n_incidents = comma(n_incidents)) %>%
  print(n = 100, width = Inf)

write_csv(boro_results, here("output", "01-tier1_main", "tier1_boro_concentration_2021_2025.csv"))
cat("\nBorough results saved to output/tier1_boro_concentration_2021_2025.csv\n")

# =============================================================================
# SECTION 7: PLOTS
# =============================================================================

cat("\nGENERATING PLOTS...\n")
cat(strrep("-", 40), "\n")

# --- Plot 1: Lorenz curves ---------------------------------------------------

lorenz_data <- imap_dfr(block_counts_list, function(df, nm) {
  compute_lorenz(df$n_incidents) %>% mutate(crime_type = nm)
}) %>%
  mutate(crime_type = factor(crime_type, levels = names(crime_colors)))

p1 <- ggplot(lorenz_data, aes(x = pct_blocks * 100, y = pct_incidents * 100,
                               color = crime_type)) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed",
              color = "grey70", linewidth = 0.4) +
  geom_hline(yintercept = 50, linetype = "dotted", color = "grey50",
             linewidth = 0.35) +
  geom_line(linewidth = 0.7) +
  scale_color_manual(values = crime_colors) +
  scale_x_continuous(breaks = seq(0, 25, by = 5),
                     labels = function(x) paste0(x, "%")) +
  scale_y_continuous(breaks = seq(0, 100, by = 10),
                     labels = function(x) paste0(x, "%")) +
  coord_cartesian(xlim = c(0, 25), ylim = c(0, 100)) +
  labs(
    title = "Crime concentration: Lorenz curves by crime type",
    subtitle = sprintf("N = %s physical blocks, all years", comma(N_BLOCKS)),
    x = "Cumulative % of blocks (ranked by count, descending)",
    y = "Cumulative % of incidents",
    color = NULL
  ) +
  theme_pub +
  guides(color = guide_legend(nrow = 4, override.aes = list(linewidth = 2)))

ggsave(here("output", "01-tier1_main", "lorenz_curves_by_crime_type.png"), p1,
       width = 10, height = 7.5, dpi = 300, bg = "white")
cat("  lorenz_curves_by_crime_type.png saved\n")

# --- Plot 2: Marginal concentration dot plot ---------------------------------

dotplot_data <- summary_all %>%
  mutate(crime_type = fct_reorder(crime_type, marginal_50x))

p2 <- ggplot(dotplot_data) +
  geom_segment(aes(x = null_50x * 100, xend = observed_50x * 100,
                   y = crime_type, yend = crime_type),
               color = "grey60", linewidth = 0.7) +
  geom_point(aes(x = null_50x * 100, y = crime_type),
             color = "#2c7bb6", size = 3, shape = 16) +
  geom_point(aes(x = observed_50x * 100, y = crime_type),
             color = "#d7191c", size = 3, shape = 16) +
  geom_text(aes(x = (null_50x + observed_50x) / 2 * 100, y = crime_type,
                label = sprintf("%.1f pp", marginal_50x * 100)),
            vjust = -1, size = 2.5, color = "grey30") +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Marginal concentration: observed minus null",
    subtitle = "Blue = Poisson null  |  Red = observed  |  Gap = marginal (Chalfin et al. 2021)",
    x = "% of blocks accounting for 50% of incidents",
    y = NULL
  ) +
  theme_pub +
  theme(legend.position = "none")

ggsave(here("output", "01-tier1_main", "marginal_concentration_dotplot.png"), p2,
       width = 9, height = 7, dpi = 300, bg = "white")
cat("  marginal_concentration_dotplot.png saved\n")

# --- Plot 3: Gini comparison -------------------------------------------------

gini_data <- summary_all %>%
  mutate(crime_type = fct_reorder(crime_type, marginal_gini))

p3 <- ggplot(gini_data) +
  geom_segment(aes(x = null_gini, xend = observed_gini,
                   y = crime_type, yend = crime_type),
               color = "grey60", linewidth = 0.7) +
  geom_point(aes(x = null_gini, y = crime_type),
             color = "#2c7bb6", size = 3, shape = 16) +
  geom_point(aes(x = observed_gini, y = crime_type),
             color = "#d7191c", size = 3, shape = 16) +
  geom_text(aes(x = (null_gini + observed_gini) / 2, y = crime_type,
                label = sprintf("+%.3f", marginal_gini)),
            vjust = -1, size = 2.5, color = "grey30") +
  labs(
    title = "Gini coefficients: observed vs. Poisson null",
    subtitle = "Blue = null Gini (random Poisson)  |  Red = observed Gini",
    x = "Gini coefficient",
    y = NULL
  ) +
  theme_pub +
  theme(legend.position = "none")

ggsave(here("output", "01-tier1_main", "gini_comparison.png"), p3,
       width = 9, height = 7, dpi = 300, bg = "white")
cat("  gini_comparison.png saved\n")

# --- Plot 4: Observed points on null concentration curve ---------------------

n_seq <- c(
  seq(100, 1000, by = 50), seq(1000, 10000, by = 250),
  seq(10000, 50000, by = 1000), seq(50000, 200000, by = 5000),
  seq(200000, 1000000, by = 25000), seq(1000000, 5000000, by = 100000)
) %>% unique() %>% sort()

null_curve <- tibble(n_incidents = n_seq) %>%
  mutate(
    lambda     = n_incidents / N_BLOCKS,
    pct_blocks = map_dbl(lambda, analytical_pct_blocks_for_50pct) * 100
  )

obs_pts <- summary_all %>%
  transmute(crime_type, n_incidents, pct_blocks = observed_50x * 100) %>%
  mutate(crime_type = factor(crime_type, levels = names(crime_colors)))

null_pts <- summary_all %>%
  transmute(crime_type, n_incidents, pct_blocks = null_50x * 100)

p4 <- ggplot() +
  annotate("rect", xmin = -Inf, xmax = Inf, ymin = 3.2, ymax = 5.7,
           fill = "#e8e8e8", alpha = 0.6) +
  annotate("text", x = 3e6, y = 4.5, label = "Weisburd bandwidth",
           size = 3.3, color = "grey35", fontface = "italic") +
  geom_line(data = null_curve, aes(x = n_incidents, y = pct_blocks),
            linewidth = 0.9, color = "#2c7bb6") +
  geom_segment(data = summary_all,
               aes(x = n_incidents, xend = n_incidents,
                   y = null_50x * 100, yend = observed_50x * 100),
               linetype = "dotted", color = "grey50", linewidth = 0.4) +
  geom_point(data = null_pts, aes(x = n_incidents, y = pct_blocks),
             color = "#2c7bb6", size = 1.5, shape = 1) +
  geom_point(data = obs_pts, aes(x = n_incidents, y = pct_blocks,
                                  color = crime_type), size = 3) +
  ggrepel::geom_text_repel(
    data = obs_pts,
    aes(x = n_incidents, y = pct_blocks, label = crime_type, color = crime_type),
    size = 2.5, fontface = "bold", show.legend = FALSE,
    nudge_y = 1.5, segment.color = "grey70", segment.size = 0.2,
    max.overlaps = 30
  ) +
  scale_x_log10(labels = comma,
                breaks = c(100, 500, 1000, 5000, 10000, 50000,
                           100000, 500000, 2000000)) +
  scale_y_continuous(breaks = seq(0, 50, by = 5),
                     labels = function(x) paste0(x, "%")) +
  scale_color_manual(values = crime_colors) +
  coord_cartesian(ylim = c(0, 35)) +
  labs(
    title = "Observed concentration vs. null baseline",
    subtitle = sprintf("N = %s blocks  |  Curve = Poisson null  |  Points = observed  |  Gap = marginal",
                       comma(N_BLOCKS)),
    x = "Number of incidents (log scale)",
    y = "% of blocks accounting for 50% of incidents"
  ) +
  theme_pub +
  theme(legend.position = "none")

ggsave(here("output", "01-tier1_main", "observed_vs_null_curve.png"), p4,
       width = 10, height = 7, dpi = 300, bg = "white")
cat("  observed_vs_null_curve.png saved\n")

# --- Plot 5: Borough marginal dot plot (faceted) -----------------------------

boro_dotplot_data <- boro_results %>%
  mutate(
    crime_type = factor(crime_type, levels = names(crime_colors)),
    borough    = factor(borough, levels = c("Manhattan", "Bronx", "Brooklyn",
                                             "Queens", "Staten Island"))
  )

p_boro <- ggplot(boro_dotplot_data) +
  geom_segment(aes(x = null_50x * 100, xend = observed_50x * 100,
                   y = borough, yend = borough),
               color = "grey60", linewidth = 0.6) +
  geom_point(aes(x = null_50x * 100, y = borough),
             color = "#2c7bb6", size = 2) +
  geom_point(aes(x = observed_50x * 100, y = borough),
             color = "#d7191c", size = 2) +
  facet_wrap(~ crime_type, scales = "free_x", ncol = 4) +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Marginal concentration by borough (2021-2025)",
    subtitle = "Blue = Poisson null  |  Red = observed  |  Gap = marginal concentration",
    x = "% of blocks accounting for 50% of incidents",
    y = NULL
  ) +
  theme_pub +
  theme(
    legend.position = "none",
    strip.text = element_text(face = "bold", size = 8)
  )

ggsave(here("output", "01-tier1_main", "marginal_concentration_by_borough.png"), p_boro,
       width = 14, height = 12, dpi = 300, bg = "white")
cat("  marginal_concentration_by_borough.png saved\n")

# =============================================================================
# SECTION 8: DONE
# =============================================================================

cat("\n")
cat(strrep("=", 70), "\n")
cat("TIER 1 ANALYSIS COMPLETE\n")
cat(strrep("=", 70), "\n")
cat("\nOutputs:\n")
cat("  output/tier1_concentration_summary.csv\n")
cat("  output/tier1_concentration_summary_single_year.csv\n")
cat("  output/tier1_boro_concentration_2021_2025.csv\n")
cat("  output/lorenz_curves_by_crime_type.png\n")
cat("  output/marginal_concentration_dotplot.png\n")
cat("  output/gini_comparison.png\n")
cat("  output/observed_vs_null_curve.png\n")
cat("  output/marginal_concentration_by_borough.png\n")
cat("\nDone.\n")
