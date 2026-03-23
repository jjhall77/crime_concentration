# =============================================================================
# 12-precinct_trajectory_maps.R
# Precinct-level trajectory maps and within-precinct distribution
# =============================================================================

library(tidyverse)
library(sf)
library(here)
library(scales)
library(janitor)

cat("\n")
cat(strrep("=", 70), "\n")
cat("PRECINCT-LEVEL TRAJECTORY MAPS\n")
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

# =============================================================================
# LOAD DATA
# =============================================================================

cat("LOADING DATA...\n")

physical_blocks <- st_read(here("data", "physical_blocks.gpkg"), quiet = TRUE) %>%
  st_transform(2263)

precincts <- st_read(here("data", "nypp_25d", "nypp.shp"), quiet = TRUE) %>%
  st_transform(2263) %>%
  clean_names() %>%
  mutate(precinct = as.integer(precinct))

assignments <- read_csv(
  here("output", "05-trajectory_analysis", "trajectory_assignments_7majors.csv"),
  show_col_types = FALSE
)

cat("  blocks:", comma(nrow(physical_blocks)), "\n")
cat("  precincts:", nrow(precincts), "\n")
cat("  assignments:", comma(nrow(assignments)), "\n")

# =============================================================================
# JOIN AND LABEL
# =============================================================================

# Proper labels matching the writeup (group numbers from k-means)
group_labels <- tribble(
  ~trajectory_group, ~traj_label, ~traj_order,
  0L, "Crime-free",       1,
  2L, "Low-increasing",   2,
  6L, "Low-moderate",     3,
  1L, "Moderate",         4,
  4L, "High",             5,
  5L, "Very high",        6,
  3L, "Chronic-high",     7
)

blocks_traj <- physical_blocks %>%
  left_join(assignments %>% select(physical_id, trajectory_group), by = "physical_id") %>%
  left_join(group_labels, by = "trajectory_group") %>%
  mutate(traj_label = factor(traj_label,
    levels = c("Crime-free", "Low-increasing", "Low-moderate",
               "Moderate", "High", "Very high", "Chronic-high")))

# Color palette: cool to hot
traj_colors <- c(
  "Crime-free"     = "#f0f0f0",
  "Low-increasing" = "#c6dbef",
  "Low-moderate"   = "#6baed6",
  "Moderate"       = "#fcbba1",
  "High"           = "#fb6a4a",
  "Very high"      = "#cb181d",
  "Chronic-high"   = "#67001f"
)

# =============================================================================
# ASSIGN BLOCKS TO PRECINCTS (spatial join)
# =============================================================================

cat("\nASSIGNING BLOCKS TO PRECINCTS...\n")

# Use block centroids for precinct assignment (lines don't have clean containment)
block_centroids <- blocks_traj %>%
  st_centroid()

block_pct <- st_join(block_centroids, precincts %>% select(precinct, geometry),
                      join = st_within) %>%
  st_drop_geometry() %>%
  select(physical_id, precinct, trajectory_group, traj_label, traj_order)

# Some blocks may not fall in any precinct (water, parks)
cat("  Blocks assigned:", comma(sum(!is.na(block_pct$precinct))), "\n")
cat("  Unassigned:", sum(is.na(block_pct$precinct)), "\n")

# =============================================================================
# TARGET PRECINCTS
# =============================================================================

target_pcts <- c(75, 111, 14, 47, 120, 34)

cat("\nTARGET PRECINCTS:\n")
for (p in target_pcts) {
  n <- sum(block_pct$precinct == p, na.rm = TRUE)
  cat(sprintf("  Pct %3d: %s blocks\n", p, comma(n)))
}

# =============================================================================
# PRECINCT MAPS
# =============================================================================

cat("\nGENERATING MAPS...\n")

for (p in target_pcts) {
  pct_boundary <- precincts %>% filter(precinct == p)
  pct_blocks <- blocks_traj %>%
    filter(physical_id %in% (block_pct %>% filter(precinct == p) %>% pull(physical_id)))

  # Get distribution for subtitle
  dist <- pct_blocks %>%
    st_drop_geometry() %>%
    count(traj_label) %>%
    mutate(pct = n / sum(n) * 100)

  chronic_n <- dist %>% filter(traj_label == "Chronic-high") %>% pull(n)
  chronic_pct <- dist %>% filter(traj_label == "Chronic-high") %>% pull(pct)
  if (length(chronic_n) == 0) { chronic_n <- 0; chronic_pct <- 0 }

  total_blocks <- sum(dist$n)

  subtitle_text <- sprintf(
    "%s blocks  |  %d chronic-high (%.1f%%)",
    comma(total_blocks), chronic_n, chronic_pct
  )

  p_map <- ggplot() +
    geom_sf(data = pct_boundary, fill = NA, color = "grey40",
            linewidth = 0.8, linetype = "solid") +
    geom_sf(data = pct_blocks, aes(color = traj_label), linewidth = 0.6) +
    scale_color_manual(values = traj_colors, drop = FALSE, name = NULL) +
    labs(
      title = sprintf("Precinct %d — 7 Major Felony Trajectories, 2006–2024", p),
      subtitle = subtitle_text
    ) +
    theme_void(base_size = 12) +
    theme(
      plot.title    = element_text(face = "bold", size = 14, margin = margin(b = 4)),
      plot.subtitle = element_text(color = "grey40", size = 10, margin = margin(b = 8)),
      legend.position = "bottom",
      legend.text = element_text(size = 9),
      plot.margin = margin(10, 10, 10, 10)
    ) +
    guides(color = guide_legend(nrow = 1, override.aes = list(linewidth = 3)))

  fname <- sprintf("precinct_%03d_trajectory_map.png", p)
  ggsave(here("policy", fname), p_map,
         width = 8, height = 8, dpi = 300, bg = "white")
  cat(sprintf("  %s saved\n", fname))
}

# =============================================================================
# WITHIN-PRECINCT DISTRIBUTION: ALL PRECINCTS
# =============================================================================

cat("\nCOMPUTING PRECINCT-LEVEL DISTRIBUTIONS...\n")

pct_dist <- block_pct %>%
  filter(!is.na(precinct)) %>%
  count(precinct, traj_label) %>%
  group_by(precinct) %>%
  mutate(
    total_blocks = sum(n),
    pct_of_precinct = n / total_blocks * 100
  ) %>%
  ungroup()

# Summary for target precincts
target_summary <- pct_dist %>%
  filter(precinct %in% target_pcts) %>%
  select(precinct, traj_label, n, pct_of_precinct) %>%
  pivot_wider(names_from = traj_label, values_from = c(n, pct_of_precinct),
              values_fill = 0)

# Print clean summary
cat("\n=== TRAJECTORY DISTRIBUTION BY PRECINCT ===\n\n")
for (p in target_pcts) {
  d <- pct_dist %>% filter(precinct == p) %>% arrange(traj_label)
  total <- sum(d$n)
  cat(sprintf("Precinct %d (%s blocks):\n", p, comma(total)))
  for (i in seq_len(nrow(d))) {
    cat(sprintf("  %-16s %5d  (%5.1f%%)\n",
                d$traj_label[i], d$n[i], d$pct_of_precinct[i]))
  }
  cat("\n")
}

# =============================================================================
# STACKED BAR CHART: TARGET PRECINCTS
# =============================================================================

cat("GENERATING DISTRIBUTION PLOT...\n")

target_dist <- pct_dist %>%
  filter(precinct %in% target_pcts) %>%
  mutate(
    precinct_label = sprintf("Pct %d\n(%s blocks)",
                              precinct,
                              comma(total_blocks)),
    precinct_label = fct_reorder(precinct_label, precinct)
  )

p_dist <- ggplot(target_dist,
                  aes(x = precinct_label, y = pct_of_precinct, fill = traj_label)) +
  geom_col(width = 0.7, color = "white", linewidth = 0.2) +
  geom_text(aes(label = ifelse(pct_of_precinct >= 4,
                                 sprintf("%.0f%%", pct_of_precinct), "")),
            position = position_stack(vjust = 0.5),
            size = 3, color = "black") +
  scale_fill_manual(values = traj_colors, name = NULL) +
  scale_y_continuous(labels = function(x) paste0(x, "%"), expand = expansion(mult = c(0, 0.02))) +
  labs(
    title = "Block trajectory composition by precinct",
    subtitle = "7 Major Felonies, 2006–2024",
    x = NULL, y = "% of blocks"
  ) +
  theme_pub +
  theme(legend.position = "bottom") +
  guides(fill = guide_legend(nrow = 1))

ggsave(here("policy", "precinct_trajectory_distribution.png"), p_dist,
       width = 10, height = 6, dpi = 300, bg = "white")
cat("  precinct_trajectory_distribution.png saved\n")

# =============================================================================
# CITYWIDE PRECINCT COMPARISON: Chronic-high share
# =============================================================================

cat("GENERATING CITYWIDE PRECINCT RANKING...\n")

chronic_by_pct <- pct_dist %>%
  filter(traj_label == "Chronic-high") %>%
  arrange(desc(pct_of_precinct)) %>%
  mutate(rank = row_number())

# Highlight target precincts
chronic_by_pct <- chronic_by_pct %>%
  mutate(is_target = precinct %in% target_pcts)

p_rank <- ggplot(chronic_by_pct, aes(x = fct_reorder(factor(precinct), pct_of_precinct),
                                       y = pct_of_precinct)) +
  geom_col(aes(fill = is_target), width = 0.7, show.legend = FALSE) +
  scale_fill_manual(values = c("FALSE" = "grey70", "TRUE" = "#cb181d")) +
  geom_text(data = chronic_by_pct %>% filter(is_target),
            aes(label = precinct), hjust = -0.3, size = 3, fontface = "bold") +
  scale_y_continuous(labels = function(x) paste0(x, "%"), expand = expansion(mult = c(0, 0.08))) +
  coord_flip() +
  labs(
    title = "Chronic-high blocks as % of precinct total",
    subtitle = "All NYPD precincts  |  Target precincts highlighted in red",
    x = NULL, y = "% of blocks classified as chronic-high"
  ) +
  theme_pub +
  theme(
    axis.text.y = element_text(size = 6),
    panel.grid.major.y = element_blank()
  )

ggsave(here("policy", "precinct_chronic_high_ranking.png"), p_rank,
       width = 8, height = 12, dpi = 300, bg = "white")
cat("  precinct_chronic_high_ranking.png saved\n")

# Save data
write_csv(pct_dist, here("policy", "precinct_trajectory_distribution.csv"))
write_csv(chronic_by_pct, here("policy", "precinct_chronic_high_ranking.csv"))

cat("\n")
cat(strrep("=", 70), "\n")
cat("PRECINCT MAPS COMPLETE\n")
cat(strrep("=", 70), "\n")
