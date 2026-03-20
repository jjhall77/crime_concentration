# =============================================================================
# 07-tier2_variance_decomposition.R
# Tier 2 Analysis 4: Variance Decomposition Across Geographic Levels
#
# Multilevel negative binomial models estimating how much crime variance sits
# at each geographic level: block, census tract, NTA, precinct.
#
# Replicates Steenbeek & Weisburd (2016) / Schnell et al. (2017) for NYC.
#
# Depends on: data/block_crosswalk.rds (from 05-build_crosswalk.R)
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(lubridate)
library(janitor)
library(glmmTMB)

cat("\n")
cat(strrep("=", 70), "\n")
cat("TIER 2: VARIANCE DECOMPOSITION\n")
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

# --- VPC extraction for NB GLMM (latent variable method) --------------------

extract_vpc_census <- function(model) {
  vc <- VarCorr(model)$cond
  sigma2_nta   <- vc$NTA2020[1, 1]
  sigma2_tract <- vc$`BoroCT2020:NTA2020`[1, 1]

  # Latent variable approach: level-1 variance for NB
  beta0 <- fixef(model)$cond[["(Intercept)"]]
  mu <- exp(beta0)
  theta <- sigma(model)  # NB dispersion (size parameter)
  sigma2_block <- log(1 + 1/mu + 1/theta)

  total <- sigma2_nta + sigma2_tract + sigma2_block
  tibble(
    level = c("NTA", "Tract", "Block"),
    variance = c(sigma2_nta, sigma2_tract, sigma2_block),
    vpc = c(sigma2_nta, sigma2_tract, sigma2_block) / total
  )
}

extract_vpc_precinct <- function(model) {
  vc <- VarCorr(model)$cond
  sigma2_pct <- vc$Precinct[1, 1]

  beta0 <- fixef(model)$cond[["(Intercept)"]]
  mu <- exp(beta0)
  theta <- sigma(model)
  sigma2_block <- log(1 + 1/mu + 1/theta)

  total <- sigma2_pct + sigma2_block
  tibble(
    level = c("Precinct", "Block"),
    variance = c(sigma2_pct, sigma2_block),
    vpc = c(sigma2_pct, sigma2_block) / total
  )
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

# --- Complaints (2022-2025) --------------------------------------------------
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
# SECTION 3: ASSIGN TO BLOCKS AND BUILD MODEL DATA
# =============================================================================

cat("\nASSIGNING INCIDENTS TO BLOCKS...\n")
cat(strrep("-", 40), "\n")

block_counts_list <- imap(crime_list, function(sf_obj, nm) {
  assign_to_blocks(sf_obj, physical_blocks, label = nm)
})

# Build model-ready data: block counts joined to crosswalk
# Filter to residential NTAs only
model_data_list <- imap(block_counts_list, function(bc, nm) {
  bc %>%
    inner_join(
      crosswalk %>% select(physical_id, BoroCT2020, NTA2020, NTAType, Precinct),
      by = "physical_id"
    ) %>%
    filter(NTAType == 0) %>%
    mutate(
      BoroCT2020 = factor(BoroCT2020),
      NTA2020    = factor(NTA2020),
      Precinct   = factor(Precinct)
    )
})

cat("\n  Model data (residential NTAs):",
    comma(nrow(model_data_list[[1]])), "blocks\n")

# =============================================================================
# SECTION 4: FIT CENSUS HIERARCHY MODELS
# =============================================================================

cat("\nFITTING CENSUS HIERARCHY MODELS (block/tract/NTA)...\n")
cat(strrep("=", 70), "\n")
cat("Model: n_incidents ~ 1 + (1|NTA2020/BoroCT2020), family = nbinom2\n")
cat("This will take a while (21 crime types x ~89K blocks)...\n\n")

census_results <- list()

for (nm in names(model_data_list)) {
  cat(sprintf("  %-28s ", nm))
  df <- model_data_list[[nm]]

  tryCatch({
    t0 <- Sys.time()
    m <- glmmTMB(
      n_incidents ~ 1 + (1 | NTA2020 / BoroCT2020),
      family = nbinom2,
      data = df,
      control = glmmTMBControl(optCtrl = list(iter.max = 500, eval.max = 1000))
    )
    elapsed <- round(difftime(Sys.time(), t0, units = "secs"), 1)

    vpc <- extract_vpc_census(m)
    vpc$crime_type <- nm
    vpc$converged <- TRUE
    vpc$theta <- sigma(m)
    vpc$mu <- exp(fixef(m)$cond[["(Intercept)"]])
    vpc$n_incidents <- sum(df$n_incidents)
    vpc$elapsed_sec <- as.numeric(elapsed)

    census_results[[nm]] <- vpc
    cat(sprintf("done (%.0fs) | NTA=%.1f%% Tract=%.1f%% Block=%.1f%%\n",
                elapsed,
                vpc$vpc[vpc$level == "NTA"] * 100,
                vpc$vpc[vpc$level == "Tract"] * 100,
                vpc$vpc[vpc$level == "Block"] * 100))
  }, error = function(e) {
    cat(sprintf("FAILED: %s\n", conditionMessage(e)))
    census_results[[nm]] <<- tibble(
      level = c("NTA", "Tract", "Block"),
      variance = NA_real_, vpc = NA_real_,
      crime_type = nm, converged = FALSE,
      theta = NA_real_, mu = NA_real_,
      n_incidents = sum(df$n_incidents),
      elapsed_sec = NA_real_
    )
  })
}

census_vpc <- bind_rows(census_results)

# =============================================================================
# SECTION 5: FIT PRECINCT MODELS
# =============================================================================

cat("\nFITTING PRECINCT MODELS (block/precinct)...\n")
cat(strrep("=", 70), "\n")
cat("Model: n_incidents ~ 1 + (1|Precinct), family = nbinom2\n\n")

precinct_results <- list()

for (nm in names(model_data_list)) {
  cat(sprintf("  %-28s ", nm))
  df <- model_data_list[[nm]]

  tryCatch({
    t0 <- Sys.time()
    m <- glmmTMB(
      n_incidents ~ 1 + (1 | Precinct),
      family = nbinom2,
      data = df,
      control = glmmTMBControl(optCtrl = list(iter.max = 500, eval.max = 1000))
    )
    elapsed <- round(difftime(Sys.time(), t0, units = "secs"), 1)

    vpc <- extract_vpc_precinct(m)
    vpc$crime_type <- nm
    vpc$converged <- TRUE
    vpc$elapsed_sec <- as.numeric(elapsed)

    precinct_results[[nm]] <- vpc
    cat(sprintf("done (%.0fs) | Precinct=%.1f%% Block=%.1f%%\n",
                elapsed,
                vpc$vpc[vpc$level == "Precinct"] * 100,
                vpc$vpc[vpc$level == "Block"] * 100))
  }, error = function(e) {
    cat(sprintf("FAILED: %s\n", conditionMessage(e)))
    precinct_results[[nm]] <<- tibble(
      level = c("Precinct", "Block"),
      variance = NA_real_, vpc = NA_real_,
      crime_type = nm, converged = FALSE,
      elapsed_sec = NA_real_
    )
  })
}

precinct_vpc <- bind_rows(precinct_results)

# =============================================================================
# SECTION 6: SUMMARY TABLE
# =============================================================================

cat("\n")
cat(strrep("=", 70), "\n")
cat("CENSUS HIERARCHY VPC (NTA / Tract / Block)\n")
cat(strrep("=", 70), "\n\n")

census_wide <- census_vpc %>%
  filter(converged) %>%
  select(crime_type, level, vpc) %>%
  pivot_wider(names_from = level, values_from = vpc, names_prefix = "vpc_") %>%
  arrange(desc(vpc_Block))

census_wide %>%
  mutate(across(starts_with("vpc_"), ~ sprintf("%.1f%%", . * 100))) %>%
  print(n = 25, width = Inf)

cat("\n")
cat(strrep("=", 70), "\n")
cat("PRECINCT VPC (Precinct / Block)\n")
cat(strrep("=", 70), "\n\n")

precinct_wide <- precinct_vpc %>%
  filter(converged) %>%
  select(crime_type, level, vpc) %>%
  pivot_wider(names_from = level, values_from = vpc, names_prefix = "vpc_") %>%
  arrange(desc(vpc_Block))

precinct_wide %>%
  mutate(across(starts_with("vpc_"), ~ sprintf("%.1f%%", . * 100))) %>%
  print(n = 25, width = Inf)

# =============================================================================
# SECTION 7: PLOTS
# =============================================================================

cat("\nGENERATING PLOTS...\n")
cat(strrep("-", 40), "\n")

dir.create(here("output", "03-tier2_spatial_scale"), showWarnings = FALSE, recursive = TRUE)

level_colors <- c(
  "NTA"      = "#2c7bb6",
  "Tract"    = "#fdae61",
  "Block"    = "#d7191c",
  "Precinct" = "#1a9641"
)

# --- Plot 1: Census hierarchy stacked bar chart ------------------------------

p1_data <- census_vpc %>%
  filter(converged) %>%
  select(crime_type, level, vpc) %>%
  mutate(
    level = factor(level, levels = c("Block", "Tract", "NTA")),
    crime_type = fct_reorder(crime_type, vpc * (level == "Block"), .fun = max)
  )

p1 <- ggplot(p1_data, aes(x = crime_type, y = vpc * 100, fill = level)) +
  geom_col(position = "stack", width = 0.75) +
  scale_fill_manual(values = level_colors) +
  coord_flip() +
  labs(
    title = "Variance partition: block / tract / NTA",
    subtitle = "Negative binomial GLMM, latent variable VPC | 2022-2025",
    x = NULL,
    y = "Variance partition (%)",
    fill = "Level"
  ) +
  theme_pub +
  theme(legend.position = "right")

ggsave(here("output", "03-tier2_spatial_scale", "vpc_census_hierarchy.png"), p1,
       width = 10, height = 8, dpi = 300, bg = "white")
cat("  vpc_census_hierarchy.png saved\n")

# --- Plot 2: Precinct vs block -----------------------------------------------

p2_data <- precinct_vpc %>%
  filter(converged) %>%
  select(crime_type, level, vpc) %>%
  mutate(
    level = factor(level, levels = c("Block", "Precinct")),
    crime_type = fct_reorder(crime_type, vpc * (level == "Block"), .fun = max)
  )

p2 <- ggplot(p2_data, aes(x = crime_type, y = vpc * 100, fill = level)) +
  geom_col(position = "stack", width = 0.75) +
  scale_fill_manual(values = level_colors) +
  coord_flip() +
  labs(
    title = "Variance partition: block / precinct",
    subtitle = "Negative binomial GLMM, latent variable VPC | 2022-2025",
    x = NULL,
    y = "Variance partition (%)",
    fill = "Level"
  ) +
  theme_pub +
  theme(legend.position = "right")

ggsave(here("output", "03-tier2_spatial_scale", "vpc_precinct.png"), p2,
       width = 10, height = 8, dpi = 300, bg = "white")
cat("  vpc_precinct.png saved\n")

# --- Plot 3: Combined dot plot — all 4 levels --------------------------------

combined_vpc <- bind_rows(
  census_vpc %>% filter(converged) %>% select(crime_type, level, vpc) %>%
    mutate(model = "Census"),
  precinct_vpc %>% filter(converged, level == "Precinct") %>%
    select(crime_type, level, vpc) %>%
    mutate(model = "Precinct")
) %>%
  mutate(
    level = factor(level, levels = c("Block", "Tract", "NTA", "Precinct")),
    crime_type = fct_reorder(crime_type, vpc * (level == "Block"), .fun = max)
  )

p3 <- ggplot(combined_vpc %>% filter(level != "Block"),
             aes(x = vpc * 100, y = crime_type, color = level, shape = level)) +
  geom_point(size = 3.5) +
  scale_color_manual(values = level_colors) +
  scale_x_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title = "Share of variance at each geographic level",
    subtitle = "Higher-level shares only (remainder = block) | 2022-2025",
    x = "Variance partition (%)",
    y = NULL,
    color = "Level",
    shape = "Level"
  ) +
  theme_pub +
  theme(legend.position = "right")

ggsave(here("output", "03-tier2_spatial_scale", "vpc_combined_dotplot.png"), p3,
       width = 10, height = 8, dpi = 300, bg = "white")
cat("  vpc_combined_dotplot.png saved\n")

# =============================================================================
# SECTION 8: SAVE
# =============================================================================

write_csv(census_vpc, here("output", "03-tier2_spatial_scale",
                            "vpc_census_hierarchy.csv"))
write_csv(precinct_vpc, here("output", "03-tier2_spatial_scale",
                              "vpc_precinct.csv"))

# Combined wide format for easy reading
combined_wide <- census_wide %>%
  left_join(
    precinct_wide %>% select(crime_type, vpc_Precinct),
    by = "crime_type"
  )
write_csv(combined_wide, here("output", "03-tier2_spatial_scale",
                               "vpc_combined_summary.csv"))

cat("\n  CSVs saved to output/03-tier2_spatial_scale/\n")

cat("\n")
cat(strrep("=", 70), "\n")
cat("TIER 2 VARIANCE DECOMPOSITION COMPLETE\n")
cat(strrep("=", 70), "\n")
