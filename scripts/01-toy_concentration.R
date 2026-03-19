# =============================================================================
# 01-toy_concentration.R
# Toy example: How much concentration does randomness alone produce?
#
# Two approaches compared:
#   1. Monte Carlo — randomly distribute n incidents across N blocks, measure
#      concentration (what % of blocks account for 50% of incidents)
#   2. Analytical — Poisson model with tie-breaking
#
# Inspired by Chalfin, Kaplan & Cuellar (2021), "Measuring Marginal Crime
# Concentration," JRCD 58(4).
# =============================================================================

library(tidyverse)

set.seed(42)

# --- Parameters --------------------------------------------------------------

N <- 10000L                        # number of hypothetical street blocks
n_sims <- 500L                     # Monte Carlo replications per incident count
incident_counts <- c(
  50, 100, 250, 500, 750,
  1000, 2000, 3000, 5000, 7500,
  10000, 15000, 20000, 30000, 50000,
  75000, 100000, 250000, 500000, 1000000
)

# --- 1. Monte Carlo simulation -----------------------------------------------

mc_one <- function(n_incidents, N_blocks) {
  # Assign each incident to a random block (uniform with replacement)
  counts <- tabulate(sample.int(N_blocks, n_incidents, replace = TRUE),
                     nbins = N_blocks)
  # Sort descending

  counts_sorted <- sort(counts, decreasing = TRUE)
  total <- sum(counts_sorted)
  cumshare <- cumsum(counts_sorted) / total
  # What fraction of blocks accounts for 50% of incidents?
  k50 <- which(cumshare >= 0.50)[1]
  k50 / N_blocks
}

mc_results <- map_dfr(incident_counts, function(n_inc) {
  pct_blocks <- replicate(n_sims, mc_one(n_inc, N))
  tibble(
    n_incidents = n_inc,
    lambda      = n_inc / N,
    method      = "Monte Carlo",
    pct_blocks_for_50pct = mean(pct_blocks),
    se          = sd(pct_blocks) / sqrt(n_sims)
  )
})

# --- 2. Analytical Poisson solution ------------------------------------------
#
# Key identity (from Poisson properties):
#   Share of incidents on blocks with count >= k equals P(X >= k-1)
#   where X ~ Poisson(lambda), lambda = n/N
#
# The "top p fraction" won't land exactly at an integer threshold (discrete).
# With k* = critical count where P(X >= k*) <= p <= P(X >= k*-1):
#
#   P(X >= k*-1) + (k*-1)/lambda * [p - P(X >= k*)] = q   (share of incidents)
#
# For small lambda (most of our range), k* = 2 and the equation simplifies to:
#   e^{-lambda} = (1 - p) - (1 - q) * lambda
#
# But we want the INVERSE problem: given N blocks and n incidents (so lambda
# is known), what fraction p of blocks holds q = 50% of incidents?
#
# General approach: for a given lambda, compute p exactly.

analytical_pct_blocks_for_50pct <- function(lambda) {
  if (lambda == 0) return(0)
  q <- 0.50  # target share of incidents

  # Find k*: smallest k such that P(X >= k) <= some candidate p
  # Actually, we solve directly: sweep over possible k* values
  # For each candidate k*, the fraction p of blocks in the "top" group is:
  #
  # The top group = all blocks with count >= k*, plus a fraction of the
  # blocks with count == k*-1
  #
  # Share of incidents from blocks with count >= k* is P(X >= k*-1) [identity]
  # We need to figure out how many blocks from the (k*-1) tier to include
  # so that total incident share = q.
  #
  # incident_share_from_geq_kstar = sum_{j>=k*} j*P(j) / lambda = P(X >= k*-1)
  # incident_share_from_tier      = (k*-1)/lambda * f, where f = fraction of
  #                                 the (k*-1) tier we include
  # blocks_share = P(X >= k*) + f * P(X = k*-1)
  #
  # Setting total incident share = q:
  #   P(X >= k*-1) + (k*-1)/lambda * f * P(X = k*-1) ... wait
  #
  # Let me be more careful. The identity gives us:
  #   sum_{j>=k} j P(j) = lambda * P(X >= k-1)
  #
  # So incidents from blocks with count >= k* :
  #   share_geq = P(X >= k*-1)       [as fraction of total = lambda]
  #

  # If share_geq >= q already, k* is too low. Increase k*.
  # If share_geq < q, we need to dip into the (k*-1) tier.
  #
  # Each block in the (k*-1) tier contributes (k*-1)/lambda share of total.
  # Wait — each block contributes (k*-1) incidents out of lambda*N total,
  # so as a share of total incidents: (k*-1)/(lambda*N) per block.
  # Number of blocks in the tier: N * P(X = k*-1).
  # We take f of them, so incident share from tier = f * N * P(X=k*-1) * (k*-1) / (lambda*N)
  #                                                = f * P(X=k*-1) * (k*-1) / lambda
  #
  # Total incident share = P(X >= k*-1) + f * P(X=k*-1) * (k*-1)/lambda = q
  # => f = (q - P(X >= k*-1)) * lambda / ((k*-1) * P(X=k*-1))
  #
  # Block share = P(X >= k*) + f * P(X = k*-1)

  # Find k*: the threshold count
  # k* is smallest integer such that the incident share from >= k* alone is <= q
  # i.e., P(X >= k*-1) <= q
  # i.e., k*-1 >= qpois(1-q, lambda)  ... roughly

  # Sweep from k*=1 upward
  for (kstar in 1:1000) {
    share_geq <- ppois(kstar - 2, lambda, lower.tail = FALSE)
    # share_geq = P(X >= kstar-1) = incident share from blocks with count >= kstar
    # Wait: P(X >= kstar-1) = 1 - P(X <= kstar-2)
    # When kstar=1: share_geq = P(X >= 0) = 1. That's all incidents. Too much.
    # When kstar=2: share_geq = P(X >= 1) = 1 - P(X=0) = 1 - e^{-lambda}

    if (kstar == 1) {
      share_geq <- 1.0
    } else {
      share_geq <- ppois(kstar - 2, lambda, lower.tail = FALSE)
    }

    if (share_geq <= q) {
      # k* found. Now compute f.
      if (kstar == 1) {
        # All blocks contribute; p = 1 trivially (shouldn't happen for q<1)
        return(1.0)
      }

      tier_count <- kstar - 1
      p_tier <- dpois(tier_count, lambda)

      if (p_tier == 0) {
        # Degenerate — all mass above kstar, just return P(X >= kstar)
        return(ppois(kstar - 1, lambda, lower.tail = FALSE))
      }

      f <- (q - share_geq) * lambda / (tier_count * p_tier)
      f <- min(max(f, 0), 1)  # clamp

      p_blocks <- ppois(kstar - 1, lambda, lower.tail = FALSE) + f * p_tier
      return(p_blocks)
    }
  }
  return(NA_real_)
}

analytical_results <- tibble(
  n_incidents = incident_counts,
  lambda      = incident_counts / N,
  method      = "Analytical (Poisson)"
) %>%
  rowwise() %>%
  mutate(pct_blocks_for_50pct = analytical_pct_blocks_for_50pct(lambda)) %>%
  ungroup()

# --- 3. Combine and compare --------------------------------------------------

comparison <- bind_rows(
  mc_results %>% select(n_incidents, lambda, method, pct_blocks_for_50pct),
  analytical_results
)

cat("\n=== Comparison: Monte Carlo vs Analytical ===\n\n")
comparison_wide <- comparison %>%
  select(n_incidents, lambda, method, pct_blocks_for_50pct) %>%
  pivot_wider(names_from = method, values_from = pct_blocks_for_50pct) %>%
  mutate(
    difference = `Monte Carlo` - `Analytical (Poisson)`,
    ratio_n_to_N = n_incidents / N
  )
print(comparison_wide, n = 30)

# --- 4. Find incident counts for Weisburd bandwidths -------------------------
#
# What lambda (and hence n) yields exactly 3.2% or 5.7% of blocks = 50% of
# incidents under pure randomness?

find_lambda_for_target_pct <- function(target_pct, N_blocks = 10000,
                                        tol = 1e-6) {
  # Binary search over lambda
  # As lambda increases, pct_blocks increases (monotonic), so:
  #   if p(mid) < target => lambda too small => raise lo
  #   if p(mid) > target => lambda too large => lower hi
  lo <- 1e-6
  hi <- 200
  while (hi - lo > tol) {
    mid <- (lo + hi) / 2
    p <- analytical_pct_blocks_for_50pct(mid)
    if (p < target_pct) {
      lo <- mid
    } else {
      hi <- mid
    }
  }
  (lo + hi) / 2
}

lambda_32 <- find_lambda_for_target_pct(0.032)
lambda_57 <- find_lambda_for_target_pct(0.057)

cat("\n=== Weisburd Bandwidth: What random incident count produces these? ===\n")
cat(sprintf(
  "\n  3.2%% of blocks = 50%% of incidents => lambda = %.4f, n = %.0f incidents on %d blocks",
  lambda_32, lambda_32 * N, N
))
cat(sprintf(
  "\n  5.7%% of blocks = 50%% of incidents => lambda = %.4f, n = %.0f incidents on %d blocks",
  lambda_57, lambda_57 * N, N
))
cat("\n")

# Verify with Monte Carlo
verify_mc <- function(n_inc, N_blocks, n_reps = 2000) {
  pcts <- replicate(n_reps, mc_one(n_inc, N_blocks))
  c(mean = mean(pcts), se = sd(pcts) / sqrt(n_reps))
}

cat("\n=== Verification (Monte Carlo, 2000 reps) ===\n")
v32 <- verify_mc(round(lambda_32 * N), N)
cat(sprintf("  n=%d: MC mean = %.4f (SE=%.5f), target = 0.0320\n",
            round(lambda_32 * N), v32["mean"], v32["se"]))
v57 <- verify_mc(round(lambda_57 * N), N)
cat(sprintf("  n=%d: MC mean = %.4f (SE=%.5f), target = 0.0570\n",
            round(lambda_57 * N), v57["mean"], v57["se"]))

# --- 5. Plots ----------------------------------------------------------------

theme_pub <- theme_minimal(base_size = 13) +
  theme(
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(color = "grey40", size = 11),
    axis.title = element_text(size = 12),
    legend.position = "bottom"
  )

# Plot 1: MC vs Analytical across incident counts
p1 <- ggplot(comparison, aes(x = lambda, y = pct_blocks_for_50pct * 100,
                              color = method, shape = method)) +
  geom_point(size = 2.5) +
  geom_line(linewidth = 0.6) +
  geom_hline(yintercept = c(3.2, 5.7), linetype = "dashed", color = "grey50",
             linewidth = 0.4) +
  annotate("text", x = max(comparison$lambda) * 0.7, y = 3.2 + 0.8,
           label = "3.2% (Weisburd IQR lower)", size = 3, color = "grey40") +
  annotate("text", x = max(comparison$lambda) * 0.7, y = 5.7 + 0.8,
           label = "5.7% (Weisburd IQR upper)", size = 3, color = "grey40") +
  scale_x_log10(labels = scales::comma) +
  scale_color_manual(values = c("Monte Carlo" = "#2c7bb6",
                                 "Analytical (Poisson)" = "#d7191c")) +
  labs(
    title = "Random concentration: % of blocks holding 50% of incidents",
    subtitle = sprintf("N = %s blocks, incidents distributed uniformly at random",
                       scales::comma(N)),
    x = expression(lambda ~~ "(incidents per block)"),
    y = "% of blocks for 50% of incidents",
    color = NULL, shape = NULL
  ) +
  theme_pub

ggsave(here::here("output", "00-null_baseline", "toy_mc_vs_analytical.png"), p1,
       width = 8, height = 5.5, dpi = 300, bg = "white")

# Plot 2: Zoomed in on the low-lambda region (where Weisburd bandwidths fall)
comparison_low <- comparison %>% filter(lambda <= 2)

p2 <- ggplot(comparison_low, aes(x = lambda, y = pct_blocks_for_50pct * 100,
                                  color = method, shape = method)) +
  geom_point(size = 3) +
  geom_line(linewidth = 0.7) +
  geom_hline(yintercept = c(3.2, 5.7), linetype = "dashed", color = "grey50",
             linewidth = 0.4) +
  geom_vline(xintercept = c(lambda_32, lambda_57), linetype = "dotted",
             color = "grey60", linewidth = 0.4) +
  annotate("text", x = lambda_32 + 0.02, y = 1.5,
           label = sprintf("n = %d", round(lambda_32 * N)),
           size = 3, color = "grey30", hjust = 0) +
  annotate("text", x = lambda_57 + 0.02, y = 2.5,
           label = sprintf("n = %d", round(lambda_57 * N)),
           size = 3, color = "grey30", hjust = 0) +
  annotate("text", x = 1.5, y = 3.2 + 0.5,
           label = "3.2%", size = 3, color = "grey40") +
  annotate("text", x = 1.5, y = 5.7 + 0.5,
           label = "5.7%", size = 3, color = "grey40") +
  scale_color_manual(values = c("Monte Carlo" = "#2c7bb6",
                                 "Analytical (Poisson)" = "#d7191c")) +
  labs(
    title = "Low-density regime: where Weisburd bandwidths fall under randomness",
    subtitle = sprintf("N = %s blocks", scales::comma(N)),
    x = expression(lambda ~~ "(incidents per block)"),
    y = "% of blocks for 50% of incidents",
    color = NULL, shape = NULL
  ) +
  theme_pub

ggsave(here::here("output", "00-null_baseline", "toy_low_lambda_zoom.png"), p2,
       width = 8, height = 5.5, dpi = 300, bg = "white")

cat("\nPlots saved to output/\n")
cat("Done.\n")
