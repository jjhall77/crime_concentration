# =============================================================================
# 02-null_concentration_curve.R
# Null concentration curve for NYC's 89,292 physical blocks
#
# Analytical Poisson solution: for a given number of randomly distributed
# incidents on N blocks, what % of blocks accounts for 50% of incidents?
#
# x-axis: number of incidents
# y-axis: % of blocks holding 50% of incidents (under pure randomness)
# =============================================================================

library(tidyverse)

# --- Core function (from 01-toy_concentration.R) -----------------------------

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

# --- Parameters --------------------------------------------------------------

N_nyc <- 89292L   # physical blocks in NYC

# Dense grid of incident counts for a smooth curve
n_seq <- c(
  seq(100, 1000, by = 50),
  seq(1000, 10000, by = 250),
  seq(10000, 50000, by = 1000),
  seq(50000, 200000, by = 5000),
  seq(200000, 1000000, by = 25000),
  seq(1000000, 5000000, by = 100000)
) %>% unique() %>% sort()

# --- Compute curve -----------------------------------------------------------

curve_data <- tibble(n_incidents = n_seq) %>%
  mutate(
    lambda = n_incidents / N_nyc,
    pct_blocks = map_dbl(lambda, analytical_pct_blocks_for_50pct) * 100
  )

# --- Inverse: find n for specific concentration thresholds -------------------

find_n_for_target_pct <- function(target_pct, N_blocks, tol = 1e-6) {
  lo <- 1e-6
  hi <- 500
  while (hi - lo > tol) {
    mid <- (lo + hi) / 2
    p <- analytical_pct_blocks_for_50pct(mid)
    if (p < target_pct) {
      lo <- mid
    } else {
      hi <- mid
    }
  }
  round((lo + hi) / 2 * N_blocks)
}

targets <- c(0.01, 0.02, 0.032, 0.045, 0.05, 0.057, 0.10, 0.15, 0.20, 0.25)

key_values <- tibble(
  pct_blocks_target = targets * 100,
  n_incidents = map_dbl(targets, ~ find_n_for_target_pct(.x, N_nyc)),
  lambda = n_incidents / N_nyc
)

cat("\n=== Key thresholds: N =", scales::comma(N_nyc), "blocks (NYC) ===\n")
cat("How many RANDOM incidents produce Weisburd-level concentration?\n\n")
key_values %>%
  mutate(
    label = case_when(
      pct_blocks_target == 3.2 ~ "Weisburd IQR lower",
      pct_blocks_target == 4.5 ~ "Weisburd median",
      pct_blocks_target == 5.7 ~ "Weisburd IQR upper",
      pct_blocks_target == 5.0 ~ "Weisburd ~midpoint",
      TRUE ~ ""
    ),
    incidents_per_block = sprintf("%.3f", lambda)
  ) %>%
  print(n = 20)

# --- Plot --------------------------------------------------------------------

theme_pub <- theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey40", size = 11),
    axis.title = element_text(size = 12),
    legend.position = "none"
  )

# Weisburd bandwidth shading
weisburd_lower <- 3.2
weisburd_upper <- 5.7
weisburd_median <- 4.5

# Corresponding incident counts
n_lower <- find_n_for_target_pct(0.032, N_nyc)
n_upper <- find_n_for_target_pct(0.057, N_nyc)
n_median <- find_n_for_target_pct(0.045, N_nyc)

fmt_k <- function(x) {
  ifelse(x >= 1e6, paste0(x / 1e6, "M"),
  ifelse(x >= 1e3, paste0(x / 1e3, "K"),
  as.character(x)))
}

p <- ggplot(curve_data, aes(x = n_incidents, y = pct_blocks)) +
  # Weisburd bandwidth band
  annotate("rect",
           xmin = -Inf, xmax = Inf,
           ymin = weisburd_lower, ymax = weisburd_upper,
           fill = "#e8e8e8", alpha = 0.6) +
  # Null concentration curve
  geom_line(linewidth = 0.9, color = "#2c7bb6") +
  # Weisburd median dashed line
  geom_hline(yintercept = weisburd_median, linetype = "dashed",
             color = "grey50", linewidth = 0.35) +
  # Vertical drops at key thresholds
  annotate("segment", x = n_lower, xend = n_lower, y = 0, yend = weisburd_lower,
           linetype = "dotted", color = "grey60", linewidth = 0.35) +
  annotate("segment", x = n_median, xend = n_median, y = 0, yend = weisburd_median,
           linetype = "dotted", color = "grey60", linewidth = 0.35) +
  annotate("segment", x = n_upper, xend = n_upper, y = 0, yend = weisburd_upper,
           linetype = "dotted", color = "grey60", linewidth = 0.35) +
  # Points at key thresholds
  geom_point(data = tibble(
    n_incidents = c(n_lower, n_median, n_upper),
    pct_blocks = c(weisburd_lower, weisburd_median, weisburd_upper)
  ), size = 2.5, color = "#d7191c") +
  # Labels — stagger vertically to avoid overlap
  annotate("text", x = n_lower * 0.35, y = 1.8,
           label = sprintf("%s\n(3.2%%)", scales::comma(n_lower)),
           size = 3, color = "#d7191c", fontface = "bold", lineheight = 0.9) +
  annotate("text", x = n_median * 2.8, y = 6.8,
           label = sprintf("%s\n(4.5%%)", scales::comma(n_median)),
           size = 3, color = "#d7191c", fontface = "bold", lineheight = 0.9) +
  annotate("text", x = n_upper * 3, y = 4.0,
           label = sprintf("%s\n(5.7%%)", scales::comma(n_upper)),
           size = 3, color = "#d7191c", fontface = "bold", lineheight = 0.9) +
  # Band label — right side
  annotate("text", x = 2e6, y = 4.5,
           label = "Weisburd bandwidth",
           size = 3.3, color = "grey35", fontface = "italic") +
  scale_x_log10(
    labels = fmt_k,
    breaks = c(100, 500, 1000, 5000, 10000, 50000, 100000, 500000, 2000000)
  ) +
  scale_y_continuous(breaks = seq(0, 50, by = 5),
                     labels = function(x) paste0(x, "%")) +
  coord_cartesian(ylim = c(0, 50)) +
  labs(
    title = "Null concentration: what randomness alone produces",
    subtitle = sprintf("N = %s physical blocks (NYC), incidents distributed uniformly at random",
                       scales::comma(N_nyc)),
    x = "Number of incidents (log scale)",
    y = "% of blocks accounting for 50% of incidents"
  ) +
  theme_pub

ggsave(here::here("output", "00-null_baseline", "null_concentration_curve_nyc.png"), p,
       width = 9, height = 6, dpi = 300, bg = "white")

cat("\nPlot saved to output/null_concentration_curve_nyc.png\n")
cat("Done.\n")
