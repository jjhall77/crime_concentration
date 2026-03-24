
## Methods/Results/Discussion Write-Ups (2026-03-23)

Each subtopic needs a methods paragraph, results paragraph, and brief discussion.

4. **Null baseline and marginal concentration**: Derive analytical Poisson null (equations in V3 draft). Present null curve for 89,292 blocks. Define MCC. Show how null 50-X falls inside Weisburd bandwidth for rare crimes.

5. **Crime-type-specific concentration**: 18-type observed vs. marginal 50-X and Gini. The reranking finding (murder flips from most to least concentrated). Temporal stability of annual 50-X/Gini (19 years). Borough-level MCC decomposition. Bandwidth critique with NYC-specific ranges.

6. **Multi-scale and aggregation effects**: Nested Gini / variance decomposition across block → tract → NTA → precinct. Portfolio effect and convergence ribbon. Shoplifting influence test. Link aggregation to resource allocation.

7. **Trajectory analysis and discreteness**: K-means GBTM method (k=6 + crime-free). 7 group descriptions with operational meaning. Temporal stability (68% stable). GBTM validation on subsample. Discreteness assessment — lower 5 groups discrete (<1% overlap), chronic-high continuous (CV=0.96).

8. **Spatial heterogeneity**: Neighbor trajectory differences (62.7% in different groups). Moran's I (17.4% clustered). Precinct-level trajectory composition maps. O'Brien/Weisburd "where the action is" framing.

---

## Next Steps — Trajectory Refinement (2026-03-23)

3. **Re-run k-means with k=8 and k=10 to subdivide chronic-high group**: The chronic-high group (Group 3, n=1,125) has CV=0.96 and spans 10–336 felonies/year. It's doing double duty — Times Square blocks and busy Bronx intersections in the same category. Re-run with higher k, compare whether new subgroups differ in temporal shape (declining vs stable vs increasing) or just in level. The lower five groups should stay intact; extra clusters should resolve the tail.

---

## Next Steps — Trajectory Analysis Follow-Up (2026-03-21)

1. **Distribution of block trajectory types by neighborhood (NTA/precinct)**: Examine trajectory group composition at the neighborhood level. We want to verify that the spatial heterogeneity finding (62.7% of neighbors in different groups) isn't an artifact of a continuous underlying distribution being artificially discretized into groups. If blocks within a neighborhood are actually drawn from a smooth gradient rather than distinct clusters, the "heterogeneity" could be a measurement artifact.

2. **Apply Chalfin et al. (2021) sparse-data correction to trajectory analysis**: Use Chalfin's empirical Bayes / measurement error framework to test whether the trajectory group assignments — especially the chronic-high designation — are robust to the sparse-data critique. Are some blocks classified as "chronic-high" simply because of noise in small counts?
