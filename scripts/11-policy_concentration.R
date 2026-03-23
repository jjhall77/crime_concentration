# =============================================================================
# 11-policy_concentration.R
# Policy-facing concentration analysis: violence types with annual MCC
#
# Produces:
#   - Annual 50-X and MCC (null-adjusted) for shootings, murder, outdoor
#     robbery, outdoor felony assault
#   - Gun violence (shootings + shots fired) annual series, 2017 onward
#   - Clean policy-style plots saved to policy/
#   - CSV summaries for the Word document
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(lubridate)
library(janitor)

cat("\n")
cat(strrep("=", 70), "\n")
cat("POLICY CONCENTRATION ANALYSIS: VIOLENCE TYPES\n")
cat(strrep("=", 70), "\n\n")

# =============================================================================
# FUNCTIONS
# =============================================================================

theme_policy <- theme_minimal(base_size = 13) +
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

# Analytical Poisson null: what % of blocks would account for 50% of crime
# if incidents were randomly distributed
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
  cat(sprintf("  %-35s %8s pts | %5d (%.1f%%) > 100ft\n",
              label, comma(nrow(pts_sf)), n_far, 100 * n_far / nrow(pts_sf)))

  tibble(
    physical_id = blocks_sf$physical_id[nearest_idx],
    year = pts_sf$year
  )
}

outdir <- here("policy")

# =============================================================================
# SECTION 1: LOAD DATA
# =============================================================================

cat("LOADING DATA...\n")

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

shootings <- read_csv(
  here("data", "NYPD_Shootings_20260224.csv"),
  show_col_types = FALSE
) %>% clean_names()

# Shots fired data (two sources)
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
# SECTION 2: BUILD CRIME SF OBJECTS
# =============================================================================

cat("\nBUILDING CRIME TYPE DATASETS...\n")

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
  )

shootings_sf <- shootings %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  mutate(date = mdy(occur_date), year = year(date)) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE)

# --- Gun violence composite: shootings + shots fired (2017+) ---
gv_start_year <- 2017

shootings_for_gv <- shootings_sf %>%
  filter(year >= gv_start_year) %>%
  transmute(date, year, source = "shooting", geometry)

shots_for_gv <- shots_fired_combined %>%
  filter(year(date) >= gv_start_year) %>%
  mutate(year = year(date)) %>%
  transmute(date, year, source = "shots_fired", geometry)

gun_violence_sf <- bind_rows(shootings_for_gv, shots_for_gv)

# Define the policy-relevant crime types
policy_crimes <- list(
  "Shootings"                 = shootings_sf %>% filter(year >= 2006, year <= 2024),
  "Murder"                    = compl_sf %>% filter(ky_cd == 101, year >= 2006, year <= 2024),
  "Outdoor robbery"           = compl_sf %>% filter(ky_cd == 105, is_outdoor, year >= 2006, year <= 2024),
  "Outdoor felony assault"    = compl_sf %>% filter(ky_cd == 106, is_outdoor, year >= 2006, year <= 2024),
  "Gun violence"              = gun_violence_sf %>% filter(year >= gv_start_year, year <= 2024)
)

for (nm in names(policy_crimes)) {
  cat(sprintf("  %-30s %s incidents\n", nm, comma(nrow(policy_crimes[[nm]]))))
}

rm(compl_sf, shootings_for_gv, shots_for_gv, complaints, shootings, shots_fired_combined)
gc(verbose = FALSE)

# =============================================================================
# SECTION 3: ASSIGN TO BLOCKS AND COMPUTE ANNUAL CONCENTRATION
# =============================================================================

cat("\nASSIGNING TO BLOCKS...\n")

annual_results <- imap_dfr(policy_crimes, function(sf_obj, crime_nm) {
  # Assign each incident to nearest block
  incident_locs <- assign_to_blocks(sf_obj, physical_blocks, label = crime_nm)

  # Get the year range for this crime type
  years <- sort(unique(sf_obj$year))

  # For each year, compute concentration on all N_BLOCKS
  map_dfr(years, function(yr) {
    yr_counts <- incident_locs %>%
      filter(year == yr) %>%
      count(physical_id, name = "n_incidents")

    # Full block vector (zeros for blocks with no incidents)
    all_blocks <- tibble(physical_id = physical_blocks$physical_id) %>%
      left_join(yr_counts, by = "physical_id") %>%
      mutate(n_incidents = replace_na(n_incidents, 0L))

    total_n <- sum(all_blocks$n_incidents)
    lambda  <- total_n / N_BLOCKS

    obs_50x  <- compute_50x(all_blocks$n_incidents) / 100  # as proportion
    null_50x <- analytical_pct_blocks_for_50pct(lambda)
    mcc_50x  <- obs_50x - null_50x

    obs_gini  <- gini(all_blocks$n_incidents)
    null_gini <- gini_poisson(lambda)
    mcc_gini  <- obs_gini - null_gini

    pct_zero <- 100 * sum(all_blocks$n_incidents == 0) / N_BLOCKS

    tibble(
      crime_type = crime_nm,
      year       = yr,
      total_n    = total_n,
      lambda     = lambda,
      obs_50x    = obs_50x * 100,   # as percentage
      null_50x   = null_50x * 100,
      mcc_50x    = mcc_50x * 100,   # marginal in percentage points
      obs_gini   = obs_gini,
      null_gini  = null_gini,
      mcc_gini   = mcc_gini,
      pct_zero   = pct_zero
    )
  })
})

cat("\nAnnual results computed.\n")

# =============================================================================
# SECTION 4: FULL-PERIOD CONCENTRATION SUMMARY
# =============================================================================

cat("\nFULL-PERIOD CONCENTRATION...\n")

fullperiod <- imap_dfr(policy_crimes, function(sf_obj, crime_nm) {
  incident_locs <- assign_to_blocks(sf_obj, physical_blocks,
                                     label = paste0(crime_nm, " (full)"))

  yr_counts <- incident_locs %>%
    count(physical_id, name = "n_incidents")

  all_blocks <- tibble(physical_id = physical_blocks$physical_id) %>%
    left_join(yr_counts, by = "physical_id") %>%
    mutate(n_incidents = replace_na(n_incidents, 0L))

  total_n <- sum(all_blocks$n_incidents)
  lambda  <- total_n / N_BLOCKS
  obs_50x  <- compute_50x(all_blocks$n_incidents) / 100
  null_50x <- analytical_pct_blocks_for_50pct(lambda)

  obs_50x_pct  <- obs_50x * 100
  null_50x_pct <- null_50x * 100

  tibble(
    crime_type = crime_nm,
    period     = if (crime_nm == "Gun violence") "2017-2024" else "2006-2024",
    total_n    = total_n,
    obs_50x    = obs_50x_pct,
    null_50x   = null_50x_pct,
    mcc_50x    = obs_50x_pct - null_50x_pct,
    obs_gini   = gini(all_blocks$n_incidents),
    null_gini  = gini_poisson(lambda),
    mcc_gini   = obs_gini - null_gini
  )
})

cat("\n=== FULL-PERIOD SUMMARY ===\n")
fullperiod %>%
  mutate(
    obs_50x  = sprintf("%.2f%%", obs_50x),
    null_50x = sprintf("%.2f%%", null_50x),
    mcc_50x  = sprintf("%.2f pp", mcc_50x),
    obs_gini = sprintf("%.4f", obs_gini),
    null_gini = sprintf("%.4f", null_gini),
    mcc_gini  = sprintf("%.4f", mcc_gini),
    total_n   = comma(total_n)
  ) %>%
  print(width = Inf)

# =============================================================================
# SECTION 5: PLOTS
# =============================================================================

cat("\nGENERATING POLICY PLOTS...\n")

policy_colors <- c(
  "Shootings"              = "#e31a1c",
  "Murder"                 = "#67001f",
  "Outdoor robbery"        = "#d6604d",
  "Outdoor felony assault" = "#f4a582",
  "Gun violence"           = "#800026"
)

# --- Plot 1: Annual shooting concentration (50-X) ---
shooting_annual <- annual_results %>% filter(crime_type == "Shootings")

p1 <- ggplot(shooting_annual, aes(x = year)) +
  geom_ribbon(aes(ymin = null_50x, ymax = obs_50x), fill = "#e31a1c", alpha = 0.15) +
  geom_line(aes(y = obs_50x), color = "#e31a1c", linewidth = 1) +
  geom_line(aes(y = null_50x), color = "#2c7bb6", linewidth = 0.8, linetype = "dashed") +
  geom_point(aes(y = obs_50x), color = "#e31a1c", size = 2) +
  annotate("text", x = 2008, y = max(shooting_annual$obs_50x) * 0.95,
           label = "Observed", color = "#e31a1c", fontface = "bold", size = 3.5, hjust = 0) +
  annotate("text", x = 2008, y = max(shooting_annual$null_50x) * 1.15,
           label = "Random baseline", color = "#2c7bb6", size = 3.5, hjust = 0) +
  annotate("text", x = 2016, y = mean(c(shooting_annual$obs_50x[12], shooting_annual$null_50x[12])),
           label = "Marginal\nconcentration", color = "#e31a1c", alpha = 0.6,
           size = 3, fontface = "italic") +
  scale_x_continuous(breaks = seq(2006, 2024, by = 2)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Shooting concentration at city blocks, 2006-2024",
    subtitle = paste0("% of NYC's ", comma(N_BLOCKS), " blocks accounting for 50% of shootings"),
    x = NULL, y = "% of blocks for 50% of shootings"
  ) +
  theme_policy

ggsave(here("policy", "shooting_concentration_annual.png"), p1,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  shooting_concentration_annual.png saved\n")

# --- Plot 2: Gun violence concentration by year (2017+) ---
gv_annual <- annual_results %>% filter(crime_type == "Gun violence")

p2 <- ggplot(gv_annual, aes(x = year)) +
  geom_ribbon(aes(ymin = null_50x, ymax = obs_50x), fill = "#800026", alpha = 0.15) +
  geom_line(aes(y = obs_50x), color = "#800026", linewidth = 1) +
  geom_line(aes(y = null_50x), color = "#2c7bb6", linewidth = 0.8, linetype = "dashed") +
  geom_point(aes(y = obs_50x), color = "#800026", size = 2) +
  annotate("text", x = 2018.5, y = max(gv_annual$obs_50x) * 0.92,
           label = "Observed", color = "#800026", fontface = "bold", size = 3.5, hjust = 0) +
  annotate("text", x = 2018.5, y = max(gv_annual$null_50x) * 1.12,
           label = "Random baseline", color = "#2c7bb6", size = 3.5, hjust = 0) +
  scale_x_continuous(breaks = 2017:2024) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Gun violence concentration at city blocks, 2017-2024",
    subtitle = paste0("Shootings + shots fired across ", comma(N_BLOCKS), " blocks"),
    x = NULL, y = "% of blocks for 50% of gun violence"
  ) +
  theme_policy

ggsave(here("policy", "gun_violence_concentration_annual.png"), p2,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  gun_violence_concentration_annual.png saved\n")

# --- Plot 3: Multi-type annual MCC comparison ---
violence_annual <- annual_results %>%
  filter(crime_type %in% c("Shootings", "Murder", "Outdoor robbery", "Outdoor felony assault")) %>%
  mutate(crime_type = factor(crime_type, levels = names(policy_colors)))

p3 <- ggplot(violence_annual, aes(x = year, y = mcc_50x, color = crime_type)) +
  geom_hline(yintercept = 0, linetype = "dotted", color = "grey50") +
  geom_line(linewidth = 0.9) +
  geom_point(size = 1.5) +
  scale_color_manual(values = policy_colors) +
  scale_x_continuous(breaks = seq(2006, 2024, by = 2)) +
  scale_y_continuous(labels = function(x) paste0(x, " pp")) +
  labs(
    title = "How much more concentrated is crime than random chance?",
    subtitle = "Marginal concentration: observed minus random baseline (percentage points)",
    x = NULL, y = "Marginal concentration (pp)",
    color = NULL
  ) +
  theme_policy

ggsave(here("policy", "marginal_concentration_comparison.png"), p3,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  marginal_concentration_comparison.png saved\n")

# --- Plot 4: Full-period dot plot (observed vs null) ---
fp_plot <- fullperiod %>%
  mutate(crime_type = fct_reorder(crime_type, as.numeric(obs_50x)))

p4 <- ggplot(fp_plot) +
  geom_segment(aes(x = null_50x, xend = obs_50x,
                   y = crime_type, yend = crime_type),
               color = "grey60", linewidth = 0.8) +
  geom_point(aes(x = null_50x, y = crime_type),
             color = "#2c7bb6", size = 4, shape = 16) +
  geom_point(aes(x = obs_50x, y = crime_type),
             color = "#d7191c", size = 4, shape = 16) +
  geom_text(aes(x = (null_50x + obs_50x) / 2, y = crime_type,
                label = sprintf("%.1f pp", mcc_50x)),
            vjust = -1.2, size = 3.2, color = "grey30") +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Crime concentration: observed vs. random baseline",
    subtitle = "Blue = what random chance produces  |  Red = what we observe  |  Gap = real concentration signal",
    x = "% of blocks accounting for 50% of incidents",
    y = NULL
  ) +
  theme_policy +
  theme(legend.position = "none")

ggsave(here("policy", "concentration_dotplot_violence.png"), p4,
       width = 9, height = 5, dpi = 300, bg = "white")
cat("  concentration_dotplot_violence.png saved\n")

# --- Plot 5: Shooting 50-X time series with incident count overlay ---
p5 <- ggplot(shooting_annual, aes(x = year)) +
  geom_col(aes(y = total_n / max(total_n) * max(obs_50x)),
           fill = "grey85", width = 0.7) +
  geom_line(aes(y = obs_50x), color = "#e31a1c", linewidth = 1) +
  geom_point(aes(y = obs_50x), color = "#e31a1c", size = 2) +
  scale_x_continuous(breaks = seq(2006, 2024, by = 2)) +
  scale_y_continuous(
    name = "% of blocks for 50% of shootings",
    labels = function(x) paste0(x, "%"),
    sec.axis = sec_axis(
      ~ . / max(shooting_annual$obs_50x) * max(shooting_annual$total_n),
      name = "Number of shootings",
      labels = comma
    )
  ) +
  labs(
    title = "Shooting concentration stays stable even as volume changes",
    subtitle = "Grey bars = number of shootings  |  Red line = concentration (50-X)",
    x = NULL
  ) +
  theme_policy

ggsave(here("policy", "shooting_concentration_vs_volume.png"), p5,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  shooting_concentration_vs_volume.png saved\n")

# =============================================================================
# SECTION 6: SAVE DATA
# =============================================================================

write_csv(annual_results, here("policy", "annual_concentration_violence.csv"))
write_csv(fullperiod, here("policy", "fullperiod_concentration_violence.csv"))

cat("\n")
cat(strrep("=", 70), "\n")
cat("POLICY ANALYSIS COMPLETE\n")
cat(strrep("=", 70), "\n")
cat("\nOutputs in policy/:\n")
cat("  shooting_concentration_annual.png\n")
cat("  gun_violence_concentration_annual.png\n")
cat("  marginal_concentration_comparison.png\n")
cat("  concentration_dotplot_violence.png\n")
cat("  shooting_concentration_vs_volume.png\n")
cat("  annual_concentration_violence.csv\n")
cat("  fullperiod_concentration_violence.csv\n")
cat("\nDone.\n")
