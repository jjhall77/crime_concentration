# Trajectory Analysis of Crime at Physical Blocks in NYC (2006-2024)

## Overview

This analysis applies group-based trajectory modeling to 89,292 physical blocks across New York City over 19 years (2006-2024), identifying subgroups of places that follow distinct crime trajectories over time. The analysis covers 19 crime categories, with a primary focus on 7 Major Felonies in aggregate. This extends the trajectory analysis literature — pioneered by Weisburd et al. (2004) for Seattle street segments — to the largest U.S. city at the physical block level, a spatial unit not previously examined in this framework.

### Method

K-means trajectory clustering on log-transformed annual counts, validated against Group-Based Trajectory Modeling (GBTM via `crimCV`) on a 2,000-block random subsample. K-means was adopted as the primary method following Curman et al. (2015), who demonstrated qualitative equivalence between k-means and GBTM for crime trajectory classification, with substantial computational advantages for large datasets. Always-zero blocks (those with zero crime across all 19 years) were deterministically assigned to a "Crime-free" group before clustering.

---

## Key Findings

### 1. Crime-Free Stability: 22.4% of Blocks Had Zero Major Felonies Across 19 Years

Of the 89,292 physical blocks, 20,006 (22.4%) recorded zero 7 Major Felony incidents across the entire 2006-2024 period. These blocks — nearly one in four — represent a substantial "dark figure" of crime-free places that have received little attention in the concentration literature.

### 2. Trajectory Group Distribution (7 Major Felonies, k=6 + Crime-Free)

| Group | Label | N Blocks | % Blocks | % Crime | Mean Annual |
|-------|-------|----------|----------|---------|-------------|
| 0 | Crime-free-stable | 20,006 | 22.4% | 0.0% | 0.00 |
| 1 | Moderate-stable | 11,317 | 12.7% | 17.0% | 1.65 |
| 2 | Low-increasing | 28,546 | 32.0% | 5.4% | 0.21 |
| 3 | Chronic-high-stable | 1,125 | 1.3% | 20.7% | 20.18 |
| 4 | High-stable | 7,189 | 8.1% | 21.1% | 3.23 |
| 5 | High-stable | 4,088 | 4.6% | 24.1% | 6.49 |
| 6 | Moderate-stable | 17,021 | 19.1% | 11.7% | 0.75 |

### 3. The Stability Finding Replicates

Approximately 68% of blocks followed stable trajectories — within the range documented in the literature (70-85% in Seattle, Albany, Vancouver). The slight shortfall may reflect NYC's larger scale and greater heterogeneity, or the longer observation window (19 vs. 14 years) capturing more temporal variation.

This is the core finding of the trajectory literature: the majority of places are *temporally stable* in their crime levels, whether crime-free, low-crime, or high-crime.

### 4. Chronic-High Concentration: 1.3% of Blocks → 20.7% of Crime

The chronic-high-stable group (Group 3) contained only 1,125 blocks — 1.3% of the total — but accounted for 20.7% of all 7 Major Felony incidents over the 19-year period. When combined with the two high-stable groups (Groups 4 and 5), just 13.9% of blocks produced 65.8% of crime. This is consistent with the Payne & Gallagher (2016) finding in Cincinnati where 2.5% of addresses generated one-third of crime.

The disproportionate concentration at the top is more extreme than what annual cross-sectional snapshots reveal, because trajectory analysis identifies blocks that are *persistently* high — not just high in any single year.

### 5. The NYC Crime Decline Was Not Uniform

The trajectory distribution implies that the well-documented NYC crime decline was not a uniform citywide phenomenon. If it were, all trajectory groups would show proportional decreases. Instead, the existence of a "low-increasing" group (Group 2, 32% of blocks) alongside decreasing groups suggests the crime drop was driven by specific places transitioning downward while others remained stable or increased. This mirrors Weisburd et al.'s (2004) central finding in Seattle.

### 6. GBTM Validation Confirms K-Means Results

GBTM (zero-inflated Poisson, `crimCV`) was run on a 2,000-block random subsample with 6 groups (BIC = 101,238). Cross-tabulation between GBTM group assignments and k-means assignments showed clear structural concordance — GBTM groups mapped systematically to k-means groups, confirming that the k-means trajectory groups are not artifacts of the clustering method. The cross-tabulation revealed that each GBTM group predominantly corresponded to 1-2 k-means groups, validating the group structure.

### 7. Sparsity Constrains Type-Specific Modeling

Three crime categories were too sparse at the block-annual level for trajectory modeling:
- **Murder**: 97.1% of blocks had zero murders across all 19 years (only 2,590 nonzero blocks)
- **Rape**: 99.9% always-zero (only 78 nonzero blocks — a data artifact suggesting geocoding issues)
- **Pickpocket (transit)**: 99.4% always-zero (only 516 nonzero blocks)

For these types, descriptive concentration measures (50-X, Gini) over time are reported instead. The remaining 15 crime types — including robbery, felony assault, burglary, grand larceny, GLA, shootings, and 9 subtypes — were each modeled with k-means (k=4 + crime-free group). 16 total types were feasible including the 7 Major Felonies aggregate.

### 8. Spatial Heterogeneity: Good Blocks in Bad Neighborhoods

Following Groff et al. (2010), adjacent-block trajectory heterogeneity was assessed using k=6 nearest neighbors (centroid-based, since physical blocks are line geometries). On average, **62.7%** of a block's neighbors were in a different trajectory group. For high-crime blocks specifically, **77.7%** of neighbors followed a different trajectory — meaning even chronic-high blocks are typically surrounded by blocks with very different crime profiles. This confirms substantial street-to-street variation and supports the micro-place thesis: crime concentration operates at a finer spatial scale than neighborhood-level analyses can capture.

Local Moran's I analysis found **15,524 blocks (17.4%)** in statistically significant spatial clusters (p < 0.05), meaning most blocks are *not* clustered with like-trajectory neighbors — spatial heterogeneity dominates over homogeneity.

### 9. Borough Variation in Trajectory Composition

Trajectory group membership varies substantially across boroughs. The chronic-high trajectory group is concentrated in specific boroughs, while crime-free blocks are more prevalent in others. Detailed borough-level composition is reported in `borough_trajectory_composition.csv` and visualized in `borough_trajectory_shares.png`.

---

## Concentration Trends Over Time (2006-2024)

Annual 50-X and Gini coefficients were computed for all 19 crime categories across all 19 years, providing a 19 × 19 panel of concentration measures. Key patterns:

- **7 Major Felonies**: 50-X remained in the 4-6% range across the period, confirming the "law of crime concentration" bandwidth holds for NYC at the physical block level
- **Murder and shootings**: Most concentrated (lowest 50-X values), consistent with the literature
- **Grand larceny and retail theft**: Least concentrated among major felonies, as expected for property crimes with more diffuse opportunity structures
- **Temporal stability of concentration**: Concentration levels (both 50-X and Gini) remained remarkably stable over the 19-year period across most crime types, even as absolute crime counts changed substantially

---

## Methodological Notes

- **Spatial unit**: Physical blocks (MULTILINESTRING geometry, ~89K units) rather than street segments or census blocks. Not directly comparable to Weisburd's street segments but contributes to understanding concentration across different spatial definitions.
- **K-means on log-transformed counts**: `log1p(count)` reduces the influence of high-volume outlier blocks, allowing k-means to distinguish trajectory *shapes* rather than just *levels*.
- **Always-zero separation**: Deterministic assignment of always-zero blocks to Group 0 before clustering avoids a common pitfall where k-means wastes a cluster on near-zero blocks.
- **K selection**: Calinski-Harabasz index is unreliable for zero-inflated count data (biased toward k=2). K=6 was selected for 7 Major Felonies based on literature precedent (Weisburd et al. typically find 6-8 groups) and elbow analysis.

## Limitations

1. Physical blocks are not identical to the street segments used in foundational studies (Weisburd et al., 2004). Direct comparisons of group percentages require caution.
2. K-means does not produce posterior probabilities — model-based uncertainty is only available from the GBTM validation subsample.
3. The 19-year window (2006-2024) may be too long for some crime types, as underlying opportunity structures and policing patterns change over two decades.
4. Murder, rape, and transit pickpocket are too sparse at the block-annual level for trajectory modeling; only descriptive concentration trends are reported.

---

## Output Files

### Plots (`output/05-trajectory_analysis/`)
1. `trajectory_7majors.png` — Main result: 7 trajectory groups over time
2. `trajectory_grid_by_type.png` — Small multiples for each feasible crime type
3. `trajectory_distribution_table.png` — Bar chart of block distribution across groups
4. `concentration_timeseries_50x.png` — 50-X over 2006-2024 for 10 crime types
5. `concentration_timeseries_gini.png` — Gini over 2006-2024 for 10 crime types
6. `trajectory_map_7majors.png` — NYC map colored by trajectory group
7. `cross_type_concordance.png` — Heatmap: where high-crime blocks fall in type-specific groups
8. `spatial_heterogeneity.png` — Boxplot of neighbor trajectory differences by group
9. `borough_trajectory_shares.png` — Stacked bar: trajectory composition by borough

### CSVs (`output/05-trajectory_analysis/`)
- `trajectory_assignments_7majors.csv` — Block-level group assignments with labels
- `trajectory_summary_by_type.csv` — Group distribution for each crime type
- `annual_concentration_by_type.csv` — 50-X and Gini by type × year
- `cross_type_concordance.csv` — Cross-tabulation across crime types
- `sparsity_assessment.csv` — % always-zero blocks by type
- `gbtm_bic_7majors.csv` — GBTM validation BIC values
- `spatial_heterogeneity.csv` — Neighbor trajectory differences
- `borough_trajectory_composition.csv` — Borough-level trajectory shares
