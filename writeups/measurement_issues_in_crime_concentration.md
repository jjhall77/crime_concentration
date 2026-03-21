# Measurement Issues and Debates in Crime Concentration Research

How we measure crime concentration shapes what we find, what we conclude about its strength, and what policy implications follow. This guide surveys the major measurement problems, the competing metrics, and the unresolved arguments that make concentration harder to pin down than the tidy "4-6% bandwidth" suggests.

---

## 1. The Sparse-Data Problem

The most consequential measurement issue in the concentration literature is the mismatch between the number of places and the number of crimes.

### The Core Problem

When the number of spatial units far exceeds the number of crime events — a near-universal condition for serious crimes — standard concentration metrics mechanically inflate apparent concentration. NYC has approximately 120,000 street segments but only about 300 annual homicides. Even under a perfectly random allocation of crimes to places, the vast majority of places will have zero crimes, and the Lorenz curve will appear highly concentrated. This mathematical inevitability masquerades as substantive finding (Chalfin, Kaplan, & Cuellar, 2021).

The problem worsens as the geographic unit gets finer. At the address level, where O'Brien and Winship (2017) found that less than 1% of addresses generated 25% of Boston's crime reports, the ratio of places to crimes becomes extreme. A portion of that extreme concentration is arithmetically guaranteed.

### Three Proposed Solutions

**Randomization counterfactual (Chalfin et al., 2021).** Simulate the distribution of crimes that would occur if events were allocated randomly across places. The difference between observed and random concentration is "marginal" concentration — the portion attributable to substantive spatial processes rather than sparse-data mechanics. Applied to Chicago homicides, marginal concentration is considerably weaker than raw metrics suggest.

**Generalized Lorenz curve and Gini (Bernasco & Steenbeek, 2017).** Standard Lorenz curves and Gini coefficients assume a continuous distribution. When applied to discrete, sparse count data, they systematically overestimate concentration. Bernasco and Steenbeek proposed corrected versions that account for the discrete nature of crime counts. The corrections are computationally simple and improve comparability across cities, crime types, and time periods.

**Poisson-Gamma estimation (Mohler et al., 2019).** Model crime counts as negative binomial (Poisson-Gamma) and compute Lorenz curves and Gini indices analytically from the inferred continuous Gamma distribution. This recovers the "true" concentration even with only several hundred events. Applied to Chicago homicides, yearly concentration was less than half what standard estimators indicated.

### How Much Does It Matter?

The three approaches agree on direction: standard metrics overestimate concentration. They disagree on magnitude. Chalfin et al. (2021) suggest that for rare crimes like homicide, the overestimation is severe. For high-volume crimes (all Part 1 offenses combined, calls for service), the bias is smaller because the crime-to-place ratio is more favorable. The implication is that the "law of crime concentration" may hold more tightly for aggregate crime indices than for individual crime types — but for reasons that are partly mathematical rather than substantive.

---

## 2. The Metric Wars: 50-X vs. 5-X vs. Gini

The concentration literature has no agreed-upon metric, and different metrics tell different stories.

### The 50-X Metric

The most common formulation: what percentage of places (X) contain 50% of crime? This is the metric Weisburd (2015) used to define the "law" — 4-6% of street segments for 50% of crime. Weisburd, Zastrowa, Kuen, and Andresen (2024) used it in their systematic review of 47 papers (median 4.5%, IQR 3.2-5.7%).

**Strengths:** Intuitive, policy-relevant (tells you how much of the city to target), directly comparable across studies.

**Weaknesses:** Insensitive to the shape of the distribution away from the 50% threshold. Two cities with identical 50-X values could have very different distributions in the tails.

### The 5-X Metric (Inverted)

What percentage of crime is concentrated in the top 5% of places? Hipp and Kim (2017) used this across 42 southern California cities, finding bandwidths ranging from 15-90% — far wider than Weisburd's "narrow bandwidth" would suggest.

Andresen and Weisburd (2025) argued that the apparent disagreement is largely an artifact of metric choice. The 5-X metric amplifies small differences in concentration because it reads a fixed point on the Lorenz curve rather than inverting it. Converting Hipp and Kim's 5-X values back to the 50-X form restores a much narrower range.

**The lesson:** The same data can appear to support or challenge the "law" depending on which metric you report.

### The Gini Coefficient

A summary statistic for the entire Lorenz curve, ranging from 0 (perfect equality) to 1 (maximum concentration). Used by Bernasco and Steenbeek (2017), O'Brien et al. (2022), Amemiya and Ohyama (2019), and Gao and Andresen (2025).

**Strengths:** Captures the full distribution, not just a single threshold. Has well-understood statistical properties.

**Weaknesses:** Less intuitive for practitioners. Biased under sparse data (see Section 1). Hard to translate directly into policy (what does a Gini of 0.85 mean operationally?). Andresen and Weisburd (2025) note that the Gini is more statistically sophisticated but harder for practitioners to interpret.

### The Generalized 50-X

Andresen and Weisburd (2025) proposed a corrected 50-X metric that adjusts for the sparse-data bias. Seven metrics compared in their analysis show that different metrics answer different questions — there is no single "best" measure.

### Gao and Andresen's Local Diagnostic

Gao and Andresen (2025) argued that the Gini coefficient is an excellent global metric but needs local diagnostics to be interpretable. A few places with extreme crime counts can drive a high global Gini, making it appear that crime is broadly concentrated when it may be a handful of outliers. Their local approach identifies the specific places driving concentration, bridging the gap between global summary statistics and place-specific identification.

---

## 3. The Spatial Unit Problem (MAUP)

The Modifiable Areal Unit Problem — the finding that results change depending on how geographic boundaries are drawn — is pervasive in crime concentration research.

### No Consensus on the Right Unit

The literature uses at least five different micro-units, each with different properties:

| Unit | Key studies | Concentration finding |
|------|-----------|----------------------|
| **Addresses** | O'Brien & Winship (2017) | <1% of addresses → 25% of crime; 95-99% of variance |
| **Street segments** | Weisburd (2015); most studies | 4-6% → 50% of crime; 56-69% of variance |
| **Intersections** | Andresen et al. (2017) | Similar to segments |
| **Grid cells (200m)** | Hardyns et al. (2019) | Consistent with the law |
| **Census districts** | Amemiya & Ohyama (2019) | Weaker but present |

Concentration intensifies dramatically as the unit gets finer. This is mathematically expected — smaller units have more zero-crime places — but it also reflects genuine spatial processes. O'Brien and Winship (2017) showed that the address level provides genuinely new information beyond what street-segment analysis reveals: problem properties are identifiable and relatively stable.

### The Ecological Approach

Alazawi, Jiang, and Messner (2022) used Ripley's K function — adapted from ecology — to identify a data-driven characteristic scale for residential burglary (2.2 km in Columbus, Ohio). This avoids imposing administrative boundaries and instead asks at what scale crime naturally clusters. The approach has not been widely adopted but offers a principled alternative to the arbitrary choice of street segments, blocks, or grid cells.

### Scale and the Variance Decomposition

Spencer (2021) conducted a systematic review showing the field lacks methodological cohesion in measuring spatial variability. The MAUP complicates all cross-scale comparisons: how much variance is attributed to street segments vs. neighborhoods depends on how those levels are defined. Schnell et al. (2024) noted that the finding of "most variance at the micro level" is partly a mathematical artifact of having far more micro-units than crimes — echoing the sparse-data problem at the decomposition level.

---

## 4. Crime-Type Aggregation

### The Aggregation Problem

Most tests of the "law" use aggregate crime indices — total Part 1 offenses, "all crime," or broad categories like "violent crime." But different crime types have different spatial distributions. De Melo, Matias, and Andresen (2015) showed in Campinas, Brazil that sixteen crime types exhibited distinct spatial patterns, and the ability to aggregate crime types at the street segment level did not generalize from North American contexts.

### Mathematical Compression

When multiple crime types with imperfectly correlated spatial distributions are summed, concentration metrics mechanically compress toward a narrow bandwidth. This occurs through several mechanisms:

- **Portfolio diversification:** Like financial assets, combining spatially uncorrelated crime types reduces "concentration risk." A place that is a hotspot for robbery but not burglary will appear less concentrated in a combined index than in either type alone.
- **Volume dominance:** High-count crime types (e.g., petit larceny in NYC) swamp rare types (e.g., homicide) in the aggregate, so the aggregate concentration tracks the most common offense regardless of how other types distribute.
- **Zero-inflation reduction:** Individual crime types have many zero-crime places. Summing types fills in zeros, pushing the distribution toward a less extreme shape.

The tight 4-6% bandwidth may be partly a property of aggregation — a mathematical attractor rather than (or in addition to) a substantive spatial regularity. Weisburd et al. (2024) noted that specific crime types show tighter concentration than aggregate measures, but the evidence base for type-specific analysis remains thin.

---

## 5. Temporal Measurement Choices

### What Time Window?

Hipp and Kim (2017) identified temporal assumptions as a major complication. Annualized data, multi-year pooled data, and monthly data all produce different concentration values. Longer time windows allow rare events to accumulate, reducing apparent concentration; shorter windows amplify it by increasing zero-crime places.

### Stability vs. Mobility

Levin, Rosenfeld, and Deckard (2017) introduced the crucial distinction between two temporal properties that get conflated:

- **Spatial inequality** — the overall concentration level — is highly stable over 15 years in St. Louis. Roughly 50% of crime stays in the top 5% of segments year after year.
- **Spatial mobility** — which specific segments constitute the top 5% — shifts over time. The hot 5% is not the same 5% from year to year.

Measuring only spatial inequality (as most studies do) creates the misleading impression that the same places stay hot, which is the implicit assumption behind static hot spots policing deployment. Walter, Tillyer, and Acolin (2023) found that 47-69% of segments maintained stable classifications across six cities — substantial stability, but far from universal.

### Temporal Scale Invariance

Haberman, Sorg, and Ratcliffe (2017) tested whether concentration holds at every temporal slice — hour of day, day of week, season — and found that it does. The bandwidth at each time slice closely matches the overall Weisburd bandwidth. Prieto Curiel (2023) extended this to weekly "heartbeat" patterns, showing that temporal concentration is a stable signature of crime types. This temporal invariance is genuine evidence that concentration reflects something structural about places, not just the accumulation of independent events over time.

---

## 6. Data Source Validity

### The Reporting Problem

All crime concentration research relies on administrative data — police reports, calls for service, 311 requests — that reflect organizational routines as much as underlying crime. Chalfin et al. (2021) and Bernasco and Steenbeek (2017) highlight that geocoding errors, reporting biases, and the denominator problem all shape what appears as concentration.

### 311 and Calls-for-Service Validity

Taylor, Lockwood, and Wyant (2024) demonstrated a fundamental validity problem with 311 data. While litter-call shifts modestly predicted actual litter changes (convergent validity present), theoretically unrelated 311 categories — information requests — predicted assessed litter equally well (discriminant validity absent). This suggests 311 call patterns reflect a general propensity to call, shaped by technology acceptance and demographics, rather than specific on-the-ground conditions. Any study using 311 or calls-for-service data as disorder proxies must contend with this finding.

### The Denominator Problem

Andresen (2006) showed that the choice of population denominator fundamentally affects conclusions about spatial concentration. Using ambient populations (estimates of the 24-hour average of people in an area) rather than residential populations produces qualitatively different — and theoretically superior — crime rate maps. High crime *counts* in central business districts may simply reflect population density, not elevated *risk*. In a city like NYC, where Manhattan's daytime population is several multiples of its residential population, this distinction matters enormously.

### Multi-Source Comparison as a Validity Test

No published study has systematically compared concentration patterns across data sources (calls for service vs. complaints vs. 311 vs. arrests vs. shootings) at the same micro-units. If concentration patterns diverge across sources, the "law" is partly a measurement property. If they converge, the substantive claim is strengthened. This remains an open empirical question.

---

## 7. Is Crime Concentration Distinctive?

### The Eck Challenge

Eck, Lee, O, and Martinez (2017) asked the most disruptive measurement question: compared to what? They showed that crime concentrates at roughly the same level as hospital visits, traffic accidents, code violations, and many other spatial phenomena. The J-curve distribution that characterizes crime concentration is practically universal in spatial data.

If concentration is a generic property of any spatially distributed count variable, then the policy implications change. The argument for hot spots policing rests partly on the claim that crime is *unusually* concentrated — that a small investment in targeted patrol can capture a disproportionate share of the problem. If everything concentrates similarly, then the logic applies equally to hospitals, fire stations, and schools. Crime concentration may be a specific instance of a universal spatial regularity, not a distinctive insight from criminology.

### The Poisson Baseline

The sparse-data problem and the Eck challenge are related. A Poisson process — crimes occurring randomly and independently at a uniform rate — produces a Lorenz curve that looks concentrated when the rate is low. Much of the observed concentration may be indistinguishable from what a Poisson process would generate. Mohler et al. (2019) and Chalfin et al. (2021) both use Poisson-based baselines to separate "expected" from "excess" concentration. The question is how much excess remains after accounting for the Poisson baseline, and whether that excess is specific to crime or common to all spatial count data.

---

## 8. The Bandwidth Question

### What Counts as "Narrow"?

Weisburd (2015) claimed the 4-6% bandwidth is narrow enough to warrant the term "law." But Hipp and Kim (2017) pointed out that the field has no agreed definition of what constitutes a "narrow bandwidth." Is a 2-percentage-point range narrow? Compared to what benchmark? The term "law" implies the precision of a physical constant, but the concentration bandwidth has nothing like that precision.

### City Size Effects

Hipp and Kim (2017) found that smaller cities tend to show more extreme concentration statistics, partly as a mathematical artifact (fewer crimes, more zero-crime places). Comparing a city of 50,000 to New York City using the same metric conflates population size effects with substantive concentration differences.

Spencer and Schnell (2022) found that results were mixed regarding whether cities exert an independent influence on spatial variability. One modeling strategy estimated meaningful city-level impact; an alternative found almost none. Different statistical strategies yielded different conclusions, underscoring the need for methodological refinement in cross-city comparisons.

### The Systematic Review Evidence

Weisburd et al. (2024) reported the tightest bandwidth claim: a median of 4.5% with an IQR of 3.2-5.7% across 47 papers. But this review includes studies using different spatial units, different crime types, different time windows, and different metrics. The IQR may understate true variability because of selective reporting, similar methodological choices across studies, and the aggregation effects discussed in Section 4.

Andresen and Weisburd (2025) acknowledge that both 50-X and 5-X are biased when crimes are fewer than places, and that the apparent tightness of the bandwidth depends on which metric is used. The law's precision is thus partly a function of the lens through which it is viewed.

---

## 9. Summary: What We Know and What Remains Uncertain

**Established:**
- Crime does concentrate dramatically at micro-places. This is a robust empirical regularity confirmed across dozens of cities worldwide.
- The concentration pattern is temporally stable in the aggregate, holding across time periods, temporal scales, and crime drops.
- Different metrics produce different bandwidths for the same data.

**Contested:**
- How much of observed concentration is substantive vs. artifactual (sparse-data bias, aggregation effects).
- Whether the 4-6% bandwidth is narrow enough to justify the term "law."
- Whether crime concentration is distinctive or a generic spatial property.
- Which metric best captures "true" concentration.

**Unknown:**
- Whether concentration patterns converge or diverge across data sources at the same micro-units.
- The full extent of aggregation artifacts when combining crime types.
- How ambient population denominators affect concentration metrics at the micro-place level.
- Whether the measurement artifacts compound or cancel when multiple corrections are applied simultaneously.

---

## References

Alazawi, M. A., Jiang, S., & Messner, S. F. (2022). What is the appropriate spatial scale for analyzing residential burglary? *PLOS ONE*, 17(2), e0264718.

Amemiya, M. & Ohyama, T. (2019). Toward a test of the "Law of Crime Concentration" in Japanese cities. *Crime Science*, 8, 11.

Andresen, M. A. (2006). Crime measures and the spatial analysis of criminal activity. *British Journal of Criminology*, 46(2), 258-285.

Andresen, M. A., Linning, S. J., & Malleson, N. (2017). Crime at places and spatial concentrations. *Journal of Quantitative Criminology*, 33(2), 255-275.

Andresen, M. A. & Weisburd, D. (2025). Ockham's razor and the measurement of crime concentrations. *Journal of Quantitative Criminology*, 41, 1-25.

Bernasco, W. & Steenbeek, W. (2017). More places than crimes. *Journal of Quantitative Criminology*, 33(3), 451-467.

Chalfin, A., Kaplan, J., & Cuellar, M. (2021). Measuring marginal crime concentration. *Journal of Research in Crime and Delinquency*, 58(4), 467-504.

de Melo, S. N., Matias, L. F., & Andresen, M. A. (2015). Crime concentrations and similarities in spatial crime patterns in a Brazilian context. *Applied Geography*, 62, 314-324.

Eck, J. E., Lee, Y., O, S., & Martinez, N. N. (2017). Compared to what? *Crime Science*, 6, 8.

Gao, Y. & Andresen, M. A. (2025). Generalized Gini coefficient, its statistical significance, and the local areas driving the global result. *Journal of Criminal Justice*, 101, 102524.

Haberman, C. P., Sorg, E. T., & Ratcliffe, J. H. (2017). Assessing the validity of the law of crime concentration across different temporal scales. *Journal of Quantitative Criminology*, 33(3), 547-567.

Hardyns, W., Snaphaan, T., & Pauwels, L. J. R. (2019). Crime concentrations and micro places in Belgium. *Australian & New Zealand Journal of Criminology*, 52(3), 390-410.

Hipp, J. R. & Kim, Y.-A. (2017). Measuring crime concentration across cities of varying sizes. *Journal of Quantitative Criminology*, 33(3), 595-632.

Levin, A., Rosenfeld, R., & Deckard, M. (2017). The law of crime concentration in St. Louis. *Journal of Quantitative Criminology*, 33(3), 635-648.

Mohler, G., Brantingham, P. J., Carter, J., & Short, M. B. (2019). Reducing bias in estimates for the law of crime concentration. *Journal of Quantitative Criminology*, 35, 747-765.

O'Brien, D. T., Ciomek, A., & Tucker, R. (2022). Crime concentration variation across neighborhoods. *Journal of Quantitative Criminology*, 38, 975-1000.

O'Brien, D. T. & Winship, C. (2017). The gains of greater granularity. *Journal of Quantitative Criminology*, 33(3), 649-675.

Prieto Curiel, R. (2023). Weekly crime concentration. *Journal of Quantitative Criminology*, 39, 97-124.

Schnell, C., DeWitt, S. E., & Spencer, M. D. (2024). The role of neighborhoods in the age of crime hot spots. *Crime & Delinquency*, 70(11), 2679-2707.

Spencer, M. D. (2021). *The spatial variability of crime: A review of methodological choices, measurements, and analytical techniques* (Doctoral dissertation). University of South Carolina.

Spencer, M. D. & Schnell, C. (2022). Reinvestigating cities and the spatial distribution of robbery. *Journal of Criminal Justice*, 82, 101988.

Taylor, R. B., Lockwood, B., & Wyant, B. R. (2024). Can streetblock 311 physical incivility call count shifts predict later changing on-site conditions? *Journal of Crime and Justice*, 47(1), 1-22.

Walter, R. J., Tillyer, M. S., & Acolin, A. (2023). Spatiotemporal crime patterns across six U.S. cities. *Journal of Quantitative Criminology*, 39, 983-1011.

Weisburd, D. (2015). The law of crime concentration and the criminology of place. *Criminology*, 53(2), 133-157.

Weisburd, D., Zastrowa, T., Kuen, K., & Andresen, M. A. (2024). Crime concentrations at micro places: A review of the evidence. *Aggression and Violent Behavior*, 78, 101936.
