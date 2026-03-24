# =============================================================================
# 13-trajectory_diagnostics.R
# Trajectory group diagnostics: shapes, within-group distributions,
# discreteness assessment
#
# Rebuilds block × year panel for 7 Major Felonies, joins trajectory groups,
# and produces diagnostic plots for understanding what each group means
# and whether groups are discrete or continuous.
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(lubridate)
library(janitor)

cat("\n")
cat(strrep("=", 70), "\n")
cat("TRAJECTORY DIAGNOSTICS\n")
cat(strrep("=", 70), "\n\n")

theme_pub <- theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title    = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey40", size = 11),
    axis.title    = element_text(size = 12),
    legend.position = "bottom"
  )

outdir <- here("policy")
YEARS <- 2006:2024

# =============================================================================
# LOAD DATA AND REBUILD BLOCK × YEAR PANEL
# =============================================================================

cat("LOADING DATA...\n")

physical_blocks <- st_read(here("data", "physical_blocks.gpkg"), quiet = TRUE) %>%
  st_transform(2263)
N_BLOCKS <- nrow(physical_blocks)

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
rm(complaints_historic, complaints_ytd)

# 7 Major Felonies
compl_sf <- complaints %>%
  filter(ky_cd %in% c(101, 104, 105, 106, 107, 109, 110)) %>%
  filter(!is.na(x_coord_cd), !is.na(y_coord_cd)) %>%
  st_as_sf(coords = c("x_coord_cd", "y_coord_cd"), crs = 2263, remove = FALSE) %>%
  mutate(year = year(mdy(cmplnt_fr_dt))) %>%
  filter(year >= 2006, year <= 2024)

cat("  7 Major Felony incidents:", comma(nrow(compl_sf)), "\n")

# Assign to blocks
cat("  Assigning to blocks...\n")
compl_sf <- st_transform(compl_sf, st_crs(physical_blocks))
nearest_idx <- st_nearest_feature(compl_sf, physical_blocks)
incident_locs <- tibble(
  physical_id = physical_blocks$physical_id[nearest_idx],
  year = compl_sf$year
)

# Build full panel
panel_skeleton <- expand_grid(physical_id = physical_blocks$physical_id, year = YEARS)
block_year_counts <- incident_locs %>% count(physical_id, year, name = "n")

panel <- panel_skeleton %>%
  left_join(block_year_counts, by = c("physical_id", "year")) %>%
  mutate(n = replace_na(n, 0L))

cat("  Panel:", comma(nrow(panel)), "rows\n")

rm(complaints, compl_sf, nearest_idx, incident_locs, block_year_counts, panel_skeleton)
gc(verbose = FALSE)

# Load trajectory assignments
assignments <- read_csv(
  here("output", "05-trajectory_analysis", "trajectory_assignments_7majors.csv"),
  show_col_types = FALSE
)

# Proper labels
group_labels <- tribble(
  ~trajectory_group, ~traj_label, ~traj_order, ~short_label,
  0L, "Crime-free",       1, "0: Crime-free",
  2L, "Low-increasing",   2, "2: Low-increasing",
  6L, "Low-moderate",     3, "6: Low-moderate",
  1L, "Moderate",         4, "1: Moderate",
  4L, "High",             5, "4: High",
  5L, "Very high",        6, "5: Very high",
  3L, "Chronic-high",     7, "3: Chronic-high"
)

panel <- panel %>%
  left_join(assignments %>% select(physical_id, trajectory_group), by = "physical_id") %>%
  left_join(group_labels, by = "trajectory_group") %>%
  mutate(traj_label = factor(traj_label,
    levels = c("Crime-free", "Low-increasing", "Low-moderate",
               "Moderate", "High", "Very high", "Chronic-high")))

traj_colors <- c(
  "Crime-free"     = "#bdbdbd",
  "Low-increasing" = "#6baed6",
  "Low-moderate"   = "#3182bd",
  "Moderate"       = "#fcbba1",
  "High"           = "#fb6a4a",
  "Very high"      = "#cb181d",
  "Chronic-high"   = "#67001f"
)

# =============================================================================
# COMPUTE GROUP STATISTICS
# =============================================================================

cat("\nCOMPUTING GROUP STATISTICS...\n")

# Per-block summary: mean annual count across 19 years
block_summary <- panel %>%
  group_by(physical_id, trajectory_group, traj_label, traj_order) %>%
  summarize(
    mean_annual = mean(n),
    sd_annual   = sd(n),
    total_19yr  = sum(n),
    max_annual  = max(n),
    n_zero_years = sum(n == 0),
    .groups = "drop"
  )

# Group-level summary
group_summary <- block_summary %>%
  group_by(traj_label, traj_order) %>%
  summarize(
    n_blocks         = n(),
    mean_of_means    = mean(mean_annual),
    median_of_means  = median(mean_annual),
    sd_of_means      = sd(mean_annual),
    p25_mean         = quantile(mean_annual, 0.25),
    p75_mean         = quantile(mean_annual, 0.75),
    min_mean         = min(mean_annual),
    max_mean         = max(mean_annual),
    cv               = sd_of_means / mean_of_means,
    .groups = "drop"
  ) %>%
  arrange(traj_order)

cat("\n=== GROUP SUMMARY ===\n")
group_summary %>%
  mutate(across(where(is.numeric) & !c(n_blocks, traj_order), ~ round(., 3))) %>%
  print(width = Inf)

# =============================================================================
# PLOT 1: FACETED TRAJECTORY SHAPES (group means ± within-group variation)
# =============================================================================

cat("\nGENERATING PLOTS...\n")

# Annual stats by group
annual_by_group <- panel %>%
  group_by(traj_label, traj_order, year) %>%
  summarize(
    mean_n  = mean(n),
    sd_n    = sd(n),
    p25     = quantile(n, 0.25),
    p75     = quantile(n, 0.75),
    p10     = quantile(n, 0.10),
    p90     = quantile(n, 0.90),
    median_n = median(n),
    .groups = "drop"
  )

# Faceted: each group gets its own panel with appropriate y-scale
p1 <- ggplot(annual_by_group, aes(x = year)) +
  geom_ribbon(aes(ymin = p25, ymax = p75), fill = "#fb6a4a", alpha = 0.2) +
  geom_ribbon(aes(ymin = p10, ymax = p90), fill = "#fb6a4a", alpha = 0.1) +
  geom_line(aes(y = mean_n), color = "#cb181d", linewidth = 0.9) +
  geom_line(aes(y = median_n), color = "#2171b5", linewidth = 0.7, linetype = "dashed") +
  facet_wrap(~ traj_label, scales = "free_y", ncol = 2) +
  scale_x_continuous(breaks = seq(2006, 2024, by = 4)) +
  labs(
    title = "Trajectory group shapes: mean and within-group spread",
    subtitle = "Red = group mean  |  Blue dashed = median  |  Dark band = IQR  |  Light band = 10th–90th percentile",
    x = NULL, y = "Incidents per block per year"
  ) +
  theme_pub +
  theme(strip.text = element_text(face = "bold", size = 10))

ggsave(here("policy", "trajectory_shapes_faceted.png"), p1,
       width = 11, height = 12, dpi = 300, bg = "white")
cat("  trajectory_shapes_faceted.png saved\n")

# =============================================================================
# PLOT 2: WITHIN-GROUP DISTRIBUTION OF BLOCK MEANS (discreteness test)
# =============================================================================

# Histogram of mean annual count by group
p2 <- ggplot(block_summary %>% filter(traj_label != "Crime-free"),
             aes(x = mean_annual, fill = traj_label)) +
  geom_histogram(bins = 50, color = "white", linewidth = 0.1) +
  facet_wrap(~ traj_label, scales = "free", ncol = 2) +
  scale_fill_manual(values = traj_colors, guide = "none") +
  labs(
    title = "Distribution of block-level mean annual crime within each trajectory group",
    subtitle = "If groups are discrete, distributions should be tight with minimal overlap between groups",
    x = "Mean annual incidents (19-year average)", y = "Number of blocks"
  ) +
  theme_pub +
  theme(strip.text = element_text(face = "bold", size = 10))

ggsave(here("policy", "trajectory_within_group_distributions.png"), p2,
       width = 11, height = 10, dpi = 300, bg = "white")
cat("  trajectory_within_group_distributions.png saved\n")

# =============================================================================
# PLOT 3: OVERLAPPING DENSITY — ALL GROUPS ON ONE AXIS
# =============================================================================

# Density of mean annual count, all groups overlaid
p3 <- ggplot(block_summary %>% filter(traj_label != "Crime-free"),
             aes(x = mean_annual, fill = traj_label, color = traj_label)) +
  geom_density(alpha = 0.3, linewidth = 0.6) +
  scale_fill_manual(values = traj_colors, name = NULL) +
  scale_color_manual(values = traj_colors, name = NULL) +
  scale_x_continuous(breaks = seq(0, 50, by = 5)) +
  coord_cartesian(xlim = c(0, 40)) +
  labs(
    title = "Are trajectory groups discrete or continuous?",
    subtitle = "Overlapping densities of block-level mean annual crime by group (crime-free excluded)",
    x = "Mean annual incidents per block", y = "Density"
  ) +
  theme_pub

ggsave(here("policy", "trajectory_discreteness_density.png"), p3,
       width = 11, height = 6, dpi = 300, bg = "white")
cat("  trajectory_discreteness_density.png saved\n")

# =============================================================================
# PLOT 4: INDIVIDUAL BLOCK TRAJECTORIES (random sample within each group)
# =============================================================================

set.seed(42)

# Sample blocks within each group to show individual variation
sample_blocks <- block_summary %>%
  filter(traj_label != "Crime-free") %>%
  group_by(traj_label) %>%
  slice_sample(n = 30) %>%
  ungroup()

individual_trajs <- panel %>%
  filter(physical_id %in% sample_blocks$physical_id)

group_means <- annual_by_group %>% select(traj_label, year, mean_n)

p4 <- ggplot() +
  geom_line(data = individual_trajs,
            aes(x = year, y = n, group = physical_id),
            alpha = 0.15, linewidth = 0.3, color = "grey40") +
  geom_line(data = group_means,
            aes(x = year, y = mean_n),
            color = "#cb181d", linewidth = 1.1) +
  facet_wrap(~ traj_label, scales = "free_y", ncol = 2) +
  scale_x_continuous(breaks = seq(2006, 2024, by = 6)) +
  labs(
    title = "Individual block trajectories within each group",
    subtitle = "Grey = 30 randomly sampled blocks  |  Red = group mean  |  Do individuals follow the group pattern?",
    x = NULL, y = "Incidents per year"
  ) +
  theme_pub +
  theme(strip.text = element_text(face = "bold", size = 10))

ggsave(here("policy", "trajectory_individual_spaghetti.png"), p4,
       width = 11, height = 12, dpi = 300, bg = "white")
cat("  trajectory_individual_spaghetti.png saved\n")

# =============================================================================
# PLOT 5: BOX PLOTS — MEAN ANNUAL COUNT BY GROUP (discreteness)
# =============================================================================

p5 <- ggplot(block_summary %>% filter(traj_label != "Crime-free"),
             aes(x = traj_label, y = mean_annual, fill = traj_label)) +
  geom_boxplot(outlier.size = 0.3, outlier.alpha = 0.3, width = 0.6) +
  scale_fill_manual(values = traj_colors, guide = "none") +
  labs(
    title = "Block-level mean annual crime by trajectory group",
    subtitle = "Box = IQR, whiskers = 1.5×IQR. Overlap between adjacent groups indicates continuity.",
    x = NULL, y = "Mean annual incidents (19-year average)"
  ) +
  theme_pub +
  theme(axis.text.x = element_text(angle = 20, hjust = 1))

ggsave(here("policy", "trajectory_boxplot_discreteness.png"), p5,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  trajectory_boxplot_discreteness.png saved\n")

# =============================================================================
# OVERLAP STATISTICS
# =============================================================================

cat("\n=== OVERLAP ANALYSIS ===\n\n")

# For adjacent groups, what % of blocks in the lower group have higher
# mean crime than the median of the upper group?
ordered_groups <- group_labels %>% arrange(traj_order) %>% filter(traj_order > 1)

for (i in 1:(nrow(ordered_groups) - 1)) {
  lower_label <- ordered_groups$traj_label[i]
  upper_label <- ordered_groups$traj_label[i + 1]

  lower_vals <- block_summary %>% filter(traj_label == lower_label) %>% pull(mean_annual)
  upper_vals <- block_summary %>% filter(traj_label == upper_label) %>% pull(mean_annual)

  upper_median <- median(upper_vals)
  lower_above <- mean(lower_vals > median(upper_vals)) * 100

  upper_p25 <- quantile(upper_vals, 0.25)
  lower_above_p25 <- mean(lower_vals > upper_p25) * 100

  cat(sprintf("  %s → %s:\n", lower_label, upper_label))
  cat(sprintf("    Lower range:  [%.2f, %.2f], Upper range: [%.2f, %.2f]\n",
              min(lower_vals), max(lower_vals), min(upper_vals), max(upper_vals)))
  cat(sprintf("    %% of lower > upper median (%.2f): %.1f%%\n",
              upper_median, lower_above))
  cat(sprintf("    %% of lower > upper P25 (%.2f):    %.1f%%\n",
              upper_p25, lower_above_p25))
  cat("\n")
}

# =============================================================================
# SAVE DATA
# =============================================================================

write_csv(group_summary, here("policy", "trajectory_group_summary.csv"))
write_csv(block_summary, here("policy", "trajectory_block_summary.csv"))

cat(strrep("=", 70), "\n")
cat("TRAJECTORY DIAGNOSTICS COMPLETE\n")
cat(strrep("=", 70), "\n")
