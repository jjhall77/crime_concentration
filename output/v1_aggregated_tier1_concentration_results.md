# Tier 1: Crime Concentration — Observed vs. Null Baseline

*Analysis for: Crime Concentration in NYC*
*Date: March 2026*

---

## 1. Purpose

This analysis measures observed crime concentration across six crime types on NYC's 89,292 physical blocks, then compares each to the analytical Poisson null baseline established in the prior analysis. The difference — **marginal concentration** — is the signal that survives after accounting for the statistical artifact of sparse data (Chalfin et al. 2021).

Three complementary metrics are computed:
- **50-X metric**: What percentage of blocks accounts for 50% of incidents?
- **Gini coefficient**: Overall inequality of crime distribution across blocks
- **Marginal versions of both**: Observed minus Poisson null

---

## 2. Crime Types Analyzed

| Crime Type | Description | All-Years n | All-Years λ |
|:---|:---|---:|---:|
| Shootings | NYPD shooting incidents (victim hit) | 23,988 | 0.269 |
| Shots fired | Shots fired reports (no victim hit) | 20,892 | 0.234 |
| Violent crime | Murder, robbery, felony/misdemeanor assault | 1,636,608 | 18.33 |
| Violent street crime | Violent crime, outdoor locations only | 766,741 | 8.59 |
| Property crime | Burglary, grand larceny, GLA motor vehicle | 1,376,797 | 15.42 |
| Property street crime | Property crime, outdoor locations only | 560,103 | 6.27 |

---

## 3. All-Years Results

### 3.1 The 50-X Metric

| Crime Type | Observed 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|
| Shootings | 2.23% | 10.13% | −7.90 pp |
| Shots fired | 2.25% | 9.16% | −6.91 pp |
| Violent crime | 5.76% | 40.89% | −35.13 pp |
| Violent street crime | 6.00% | 36.90% | −30.90 pp |
| Property crime | 8.04% | 40.09% | −32.05 pp |
| Property street crime | 10.44% | 35.04% | −24.61 pp |

**Reading the table**: The 50-X metric asks "what fraction of blocks accounts for 50% of crime?" Lower = more concentrated. The null column shows what pure randomness would produce at the same event volume. Negative marginals mean observed concentration is *tighter* than random — the real spatial signal.

For high-volume crime types (violent crime, property crime), the observed concentration is dramatically tighter than the null. With 1.6 million violent crime incidents, randomness would spread them across 41% of blocks to reach 50% — but the observed data needs only 5.8%. That 35-percentage-point gap is genuine spatial concentration.

For sparse crimes (shootings, shots fired), the observed values look impressively concentrated (2.2% of blocks), but the null is also quite concentrated (10%). The marginal of 8 percentage points is real but modest relative to the raw number.

### 3.2 Gini Coefficients

| Crime Type | Observed Gini | Null Gini | Marginal |
|:---|---:|---:|---:|
| Shootings | 0.930 | 0.790 | +0.140 |
| Shots fired | 0.929 | 0.812 | +0.118 |
| Violent crime | 0.784 | 0.131 | +0.652 |
| Violent street crime | 0.785 | 0.191 | +0.594 |
| Property crime | 0.718 | 0.143 | +0.575 |
| Property street crime | 0.682 | 0.223 | +0.459 |

The Gini tells the same story from a different angle. For high-volume types, the null Gini is low (~0.13–0.22, because with λ > 6 incidents per block on average, randomness produces a fairly even distribution). The observed Gini remains high (~0.72–0.78), yielding massive marginal Ginis of 0.46–0.65.

For sparse types, null Ginis are already high (~0.79–0.81) simply because most blocks get zero incidents under randomness. The observed Ginis are slightly higher (~0.93), giving modest marginals of 0.12–0.14.

![Lorenz curves](lorenz_curves_by_crime_type.png)

*Figure 1. Lorenz curves for all six crime types. The diagonal represents perfect equality; curves bowing toward the upper-left indicate greater concentration. Zoomed to 0–25% of blocks.*

![Marginal concentration](marginal_concentration_dotplot.png)

*Figure 2. Marginal concentration: the gap between null (blue) and observed (red) for each crime type. Ordered by marginal size.*

![Gini comparison](gini_comparison.png)

*Figure 3. Gini coefficients: observed vs. Poisson null.*

![Observed on null curve](observed_vs_null_curve.png)

*Figure 4. Observed concentration overlaid on the Poisson null curve. Vertical distance from curve to point is the marginal concentration.*

---

## 4. Single-Year Snapshot (2025)

| Crime Type | n (2025) | λ | Observed 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|---:|---:|
| Shootings | 688 | 0.008 | 0.34% | 0.38% | −0.04 pp |
| Shots fired | 1,818 | 0.020 | 0.64% | 1.00% | −0.36 pp |
| Violent crime | 91,121 | 1.020 | 4.48% | 20.06% | −15.58 pp |
| Violent street crime | 38,813 | 0.435 | 4.04% | 13.52% | −9.48 pp |
| Property crime | 70,408 | 0.789 | 5.92% | 16.92% | −10.99 pp |
| Property street crime | 36,145 | 0.405 | 6.33% | 13.05% | −6.72 pp |

At annual resolution, the sparse-data problem becomes acute. With only 688 shootings on 89,292 blocks (λ = 0.008), the observed and null concentrations are virtually identical — nearly all the apparent concentration is artifact. Even violent crime (91K incidents, λ ≈ 1) sees its marginal concentration cut roughly in half compared to the multi-year pooling.

---

## 5. Borough-Level Marginal Concentration (2021–2025)

Breaking concentration down by borough reveals substantial geographic variation.

### Shootings (2021–2025)

| Borough | n Blocks | n Incidents | Observed 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|---:|---:|
| Bronx | 12,659 | 1,812 | 2.85% | 6.18% | −3.33 pp |
| Manhattan | 8,082 | 881 | 2.03% | 4.88% | −2.85 pp |
| Brooklyn | 20,795 | 1,837 | 1.94% | 4.04% | −2.10 pp |
| Queens | 33,339 | 775 | 0.79% | 1.14% | −0.34 pp |
| Staten Island | 14,381 | 117 | 0.29% | 0.40% | −0.12 pp |

The Bronx shows the largest marginal concentration for shootings — real clustering beyond what sparsity explains. Queens and Staten Island marginals are near zero, meaning their apparent concentration is almost entirely artifact.

### Violent Crime (2021–2025)

| Borough | n Incidents | Observed 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|---:|
| Bronx | 117,722 | 7.70% | 37.47% | −29.77 pp |
| Manhattan | 89,871 | 8.70% | 38.47% | −29.77 pp |
| Brooklyn | 119,413 | 7.90% | 34.25% | −26.35 pp |
| Queens | 94,511 | 5.44% | 28.83% | −23.39 pp |
| Staten Island | 15,249 | 2.76% | 20.50% | −17.74 pp |

All boroughs show large marginal concentration for violent crime. The Bronx and Manhattan lead with ~30 percentage point gaps. Even Staten Island, with only 15K incidents, shows a substantial 18-point marginal.

![Borough marginal concentration](marginal_concentration_by_borough.png)

*Figure 5. Marginal concentration by borough (2021–2025) for all crime types.*

---

## 6. The Punchline

Crime concentration in NYC is real and substantial — but not uniformly so.

**For high-volume crime types** (violent crime, property crime, ~100K+ incidents per year), observed concentration massively exceeds what randomness produces. Only 5–10% of blocks account for 50% of crime, versus 35–41% under the null. The marginal Gini coefficients are 0.46–0.65. These are crime types where place-based interventions have genuine spatial targets — the hot spots are not artifacts.

**For sparse crime types** (shootings, shots fired, ~1K–5K/year), the picture is more cautious. The raw concentration numbers look dramatic (2% of blocks hold 50% of shootings), but most of that is mechanical sparsity. The marginal concentration exists but is modest (~8 percentage points all-years, near zero single-year). At annual resolution, shooting concentration is almost entirely indistinguishable from random.

**The borough decomposition** sharpens this further. Shooting concentration is a Bronx/Manhattan/Brooklyn phenomenon with real spatial structure; in Queens and Staten Island the signal vanishes into noise. For violent and property crime, all boroughs show large marginals, but the size varies — the Bronx and Manhattan consistently show the tightest real concentration.

**The methodological implication** is clear: the standard "X% of places account for Y% of crime" metric, taken at face value, systematically overstates concentration for rare crime types. Any credible place-based analysis must compare to the null. The marginal concentration — not the raw concentration — is the quantity that matters.

---

## References

- Chalfin, A., Kaplan, J., & Cuellar, M. (2021). Measuring marginal crime concentration. *JRCD*, 58(4), 467–504.
- Bernasco, W., & Steenbeek, W. (2017). More places than crimes. *J Quant Crim*, 33, 451–467.
- Weisburd, D. (2015). The law of crime concentration. *Criminology*, 53(2), 133–157.
- Weisburd, D., et al. (2024). Crime concentrations at micro places: A review. *Aggression & Violent Behavior*, 78.

---

*Script: `scripts/03-tier1_concentration.R`*
*Data: NYPD Complaint Data, Shootings, Shots Fired on 89,292 physical blocks (EPSG:2263)*
