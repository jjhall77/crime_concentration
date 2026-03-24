
## Next Steps — Trajectory Refinement (2026-03-23)

3. **Re-run k-means with k=8 and k=10 to subdivide chronic-high group**: The chronic-high group (Group 3, n=1,125) has CV=0.96 and spans 10–336 felonies/year. It's doing double duty — Times Square blocks and busy Bronx intersections in the same category. Re-run with higher k, compare whether new subgroups differ in temporal shape (declining vs stable vs increasing) or just in level. The lower five groups should stay intact; extra clusters should resolve the tail.

---

## Next Steps — Trajectory Analysis Follow-Up (2026-03-21)

1. **Distribution of block trajectory types by neighborhood (NTA/precinct)**: Examine trajectory group composition at the neighborhood level. We want to verify that the spatial heterogeneity finding (62.7% of neighbors in different groups) isn't an artifact of a continuous underlying distribution being artificially discretized into groups. If blocks within a neighborhood are actually drawn from a smooth gradient rather than distinct clusters, the "heterogeneity" could be a measurement artifact.

2. **Apply Chalfin et al. (2021) sparse-data correction to trajectory analysis**: Use Chalfin's empirical Bayes / measurement error framework to test whether the trajectory group assignments — especially the chronic-high designation — are robust to the sparse-data critique. Are some blocks classified as "chronic-high" simply because of noise in small counts?
