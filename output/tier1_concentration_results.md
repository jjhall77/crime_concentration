# Tier 1: Crime Concentration — Observed vs. Poisson Null Baseline

*Analysis for: Crime Concentration in NYC*
*Date: March 2026*

---

## 1. Purpose

This analysis measures observed crime concentration across 18 specific crime types on NYC's 89,292 physical street blocks, then compares each to an analytical Poisson null baseline. The difference — **marginal concentration** — isolates the genuine spatial signal after removing the statistical artifact of sparse data (Chalfin et al. 2021).

Three complementary metrics:
- **50-X**: What percentage of blocks accounts for 50% of incidents? Lower = more concentrated.
- **Gini coefficient**: Overall inequality of crime across blocks (0 = perfectly even, 1 = all crime on one block).
- **Marginal versions of both**: Observed minus Poisson null — the real spatial signal.

The Poisson null represents what concentration would look like if the same total number of incidents were distributed randomly across blocks with equal probability. Any concentration beyond that null is genuine place-based clustering.

---

## 2. Crime Types Analyzed

| Crime Type | Definition | All-Years n | All-Years lambda |
|:---|:---|---:|---:|
| Murder | KY 101 | 8,192 | 0.09 |
| Robbery | KY 105 | 346,591 | 3.88 |
| Robbery (outdoor) | KY 105, outdoor | 223,405 | 2.50 |
| Felony assault | KY 106 | 423,237 | 4.74 |
| Felony assault (outdoor) | KY 106, outdoor | 178,137 | 1.99 |
| Street assault | PD 101/109, outdoor | 504,862 | 5.65 |
| Burglary | KY 107 | 323,089 | 3.62 |
| Residential burglary | KY 107, residence | 208,114 | 2.33 |
| Commercial burglary | KY 107, commercial | 84,192 | 0.94 |
| Grand larceny | KY 109 | 880,025 | 9.86 |
| GLA | KY 110 | 201,642 | 2.26 |
| Retail theft | PD 396/433/333 | 675,073 | 7.56 |
| Vehicle accessory theft | PD 457/357 | 108,637 | 1.22 |
| Theft from auto | PD 441/321/442 | 450,185 | 5.04 |
| Pickpocket (transit) | PD 415/406, subway | 6,251 | 0.07 |
| Pickpocket (non-transit) | PD 415/406, non-subway | 40,519 | 0.45 |
| Shootings | Separate dataset, 2006-2025 | 23,988 | 0.27 |
| Gun violence | Shootings + shots fired, 2018-2025 | 26,519 | 0.30 |

Lambda is the mean incidents per block (n / 89,292). Crime types span a wide range: from murder (lambda = 0.09, extremely sparse) to grand larceny (lambda = 9.86, nearly 10 incidents per block on average across the full period).

---

## 3. All-Years Results

### 3.1 The 50-X Metric

| Crime Type | n | Obs 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|---:|
| Retail theft | 675,073 | 0.21% | 36.13% | **-35.92 pp** |
| Grand larceny | 880,025 | 5.04% | 37.75% | -32.71 pp |
| Street assault | 504,862 | 5.51% | 34.09% | -28.58 pp |
| Felony assault | 423,237 | 4.76% | 32.84% | -28.09 pp |
| Robbery | 346,591 | 5.60% | 31.46% | -25.86 pp |
| Theft from auto | 450,185 | 10.37% | 33.52% | -23.15 pp |
| Robbery (outdoor) | 223,405 | 6.06% | 27.90% | -21.84 pp |
| Burglary | 323,089 | 8.75% | 30.73% | -21.98 pp |
| Felony assault (outdoor) | 178,137 | 4.82% | 26.04% | -21.22 pp |
| Residential burglary | 208,114 | 7.41% | 27.52% | -20.12 pp |
| GLA | 201,642 | 10.69% | 27.29% | -16.60 pp |
| Commercial burglary | 84,192 | 3.27% | 19.11% | -15.84 pp |
| Vehicle accessory theft | 108,637 | 7.42% | 21.94% | -14.52 pp |
| Pickpocket (non-transit) | 40,519 | 0.55% | 13.79% | -13.24 pp |
| Gun violence | 26,519 | 2.39% | 10.85% | -8.46 pp |
| Shootings | 23,988 | 2.23% | 10.13% | -7.90 pp |
| Murder | 8,192 | 0.05% | 4.18% | -4.13 pp |
| Pickpocket (transit) | 6,251 | 0.06% | 3.26% | -3.20 pp |

The ranking by marginal concentration tells a different story than the raw observed values. Retail theft is the most concentrated crime type in NYC by a wide margin — only 0.21% of blocks account for 50% of retail theft, a marginal gap of nearly 36 percentage points below the null. This reflects the obvious geography: retail theft happens in stores, and stores occupy a tiny fraction of street blocks.

Grand larceny, street assault, felony assault, and robbery form a second tier with marginals of 26-33 percentage points. These are high-volume crime types where the spatial signal is massive and unambiguous.

At the bottom, murder and transit pickpocketing show marginals under 5 percentage points. Their raw concentration looks extreme (0.05% and 0.06% of blocks), but the null is also highly concentrated because so few incidents exist. Most of what looks like concentration is sparsity artifact.

### 3.2 Gini Coefficients

| Crime Type | Obs Gini | Null Gini | Marginal |
|:---|---:|---:|---:|
| Retail theft | 0.985 | 0.203 | **+0.781** |
| Grand larceny | 0.778 | 0.179 | +0.599 |
| Felony assault | 0.818 | 0.256 | +0.562 |
| Street assault | 0.800 | 0.235 | +0.565 |
| Robbery | 0.806 | 0.282 | +0.524 |
| Robbery (outdoor) | 0.801 | 0.347 | +0.453 |
| Felony assault (outdoor) | 0.832 | 0.386 | +0.446 |
| Burglary | 0.731 | 0.291 | +0.440 |
| Theft from auto | 0.682 | 0.248 | +0.434 |
| Residential burglary | 0.770 | 0.359 | +0.410 |
| Commercial burglary | 0.891 | 0.536 | +0.354 |
| GLA | 0.696 | 0.365 | +0.332 |
| Vehicle accessory theft | 0.776 | 0.482 | +0.294 |
| Pickpocket (non-transit) | 0.963 | 0.694 | +0.269 |
| Gun violence | 0.926 | 0.773 | +0.153 |
| Shootings | 0.930 | 0.790 | +0.140 |
| Murder | 0.988 | 0.916 | +0.072 |
| Pickpocket (transit) | 0.998 | 0.935 | +0.063 |

The Gini tells the same story from a complementary angle. Retail theft has the highest marginal Gini (+0.78): observed inequality is extreme (0.985) while the null is modest (0.203, because with lambda = 7.56, randomness spreads incidents broadly). The gap is almost entirely real spatial signal.

Murder has the highest *observed* Gini (0.988) but the lowest *marginal* (0.072), because the null Gini is already 0.916. Nearly all of murder's apparent inequality is mechanical sparsity.

### 3.3 Weisburd's Bandwidth

Weisburd (2015) proposed that 4-6% of places account for 50% of crime, with a review of 47 studies showing an IQR of 3.2-5.7%. How do NYC's 18 crime types stack up?

- **Inside the bandwidth** (3.2-5.7%): Felony assault (4.76%), street assault (5.51%), robbery (5.60%), grand larceny (5.04%)
- **Below the bandwidth** (< 3.2%): Murder (0.05%), retail theft (0.21%), pickpocket transit (0.06%), pickpocket non-transit (0.55%), commercial burglary (3.27%), shootings (2.23%), gun violence (2.39%)
- **Above the bandwidth** (> 5.7%): Robbery outdoor (6.06%), burglary (8.75%), residential burglary (7.41%), GLA (10.69%), vehicle accessory theft (7.42%), theft from auto (10.37%), felony assault outdoor (4.82% — just inside)

The bandwidth holds reasonably well for the major violent crime categories but breaks down at the extremes. Very sparse crimes fall well below (driven by sparsity artifact), while property crimes with diffuse spatial signatures (theft from auto, GLA) exceed it.

---

## 4. Single-Year Snapshot (2025)

| Crime Type | n (2025) | lambda | Obs 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|---:|---:|
| Retail theft | 52,223 | 0.585 | 0.13% | 15.04% | -14.91 pp |
| Grand larceny | 45,507 | 0.510 | 4.16% | 14.45% | -10.28 pp |
| Felony assault | 29,474 | 0.330 | 3.07% | 11.61% | -8.54 pp |
| Street assault | 27,256 | 0.305 | 3.41% | 11.04% | -7.64 pp |
| Burglary | 12,688 | 0.142 | 2.36% | 6.14% | -3.79 pp |
| Robbery | 15,024 | 0.168 | 2.70% | 7.07% | -4.37 pp |
| Robbery (outdoor) | 8,720 | 0.098 | 2.59% | 4.42% | -1.84 pp |
| Felony assault (outdoor) | 11,006 | 0.123 | 2.18% | 5.43% | -3.25 pp |
| Residential burglary | 6,616 | 0.074 | 2.02% | 3.44% | -1.42 pp |
| Grand larceny auto | 13,366 | 0.150 | 4.20% | 6.42% | -2.21 pp |
| Commercial burglary | 4,298 | 0.048 | 0.54% | 2.29% | -1.75 pp |
| Theft from auto | 15,897 | 0.178 | 4.56% | 7.41% | -2.85 pp |
| Vehicle accessory theft | 9,234 | 0.103 | 2.60% | 4.65% | -2.06 pp |
| Pickpocket (non-transit) | 2,342 | 0.026 | 0.31% | 1.28% | -0.97 pp |
| Gun violence | 2,484 | 0.028 | 0.82% | 1.35% | -0.53 pp |
| Shootings | 688 | 0.008 | 0.34% | 0.38% | -0.04 pp |
| Murder | 277 | 0.003 | 0.14% | 0.15% | -0.01 pp |
| Pickpocket (transit) | 216 | 0.002 | 0.03% | 0.12% | -0.09 pp |

At single-year resolution, the sparse-data problem bites hard. Murder (277 incidents on 89,292 blocks, lambda = 0.003) and shootings (688 incidents) show marginals near zero — observed concentration is statistically indistinguishable from random. Retail theft retains a large marginal (-14.9 pp) because even a single year produces 52K+ incidents concentrated in commercial blocks.

The general pattern: marginals shrink roughly proportionally with the reduction in lambda. Crime types that showed 25-35 pp marginals across all years drop to 5-10 pp in a single year. This is Chalfin et al.'s (2021) core point — temporal pooling inflates apparent concentration, and the null calibration reveals how much.

---

## 5. Borough-Level Marginal Concentration (2021-2025)

Breaking the analysis by borough provides 89,292 blocks distributed unevenly: Manhattan (8,082), Bronx (12,659), Staten Island (14,381), Brooklyn (20,795), Queens (33,339).

### 5.1 Selected Highlights

**Retail theft** — extreme everywhere, but Manhattan is extraordinary:

| Borough | n | Obs 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|---:|
| Manhattan | 124,858 | 0.63% | 40.10% | -39.47 pp |
| Brooklyn | 57,641 | 0.16% | 28.53% | -28.37 pp |
| Bronx | 32,211 | 0.17% | 27.95% | -27.78 pp |
| Queens | 56,937 | 0.09% | 23.96% | -23.87 pp |
| Staten Island | 8,865 | 0.07% | 15.19% | -15.12 pp |

Manhattan has lambda = 15.4 for retail theft — meaning the average block sees 15 retail theft incidents over 2021-2025 — yet 50% of all retail theft still concentrates on just 0.63% of blocks. The marginal gap of 39 percentage points is the largest single value in the entire analysis.

**Shootings** — the Bronx leads, outer boroughs fade to noise:

| Borough | n | Obs 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|---:|
| Bronx | 1,812 | 2.85% | 6.18% | -3.33 pp |
| Manhattan | 881 | 2.03% | 4.88% | -2.85 pp |
| Brooklyn | 1,837 | 1.94% | 4.04% | -2.10 pp |
| Queens | 775 | 0.79% | 1.14% | -0.34 pp |
| Staten Island | 117 | 0.29% | 0.40% | -0.12 pp |

Shooting concentration is a Bronx/Manhattan/Brooklyn phenomenon. In Queens and Staten Island, the marginal is negligible — apparent concentration is almost entirely sparsity artifact.

**Grand larceny** — Manhattan dominates:

| Borough | n | Obs 50-X | Null 50-X | Marginal |
|:---|---:|---:|---:|---:|
| Manhattan | 83,882 | 9.00% | 38.08% | -29.08 pp |
| Bronx | 40,666 | 8.88% | 30.17% | -21.29 pp |
| Queens | 48,378 | 5.87% | 23.29% | -17.42 pp |
| Brooklyn | 57,424 | 9.64% | 28.48% | -18.84 pp |
| Staten Island | 6,996 | 5.22% | 14.20% | -8.98 pp |

Manhattan's lambda of 10.4 for grand larceny is the highest borough-crime combination outside retail theft. Every borough shows substantial marginal concentration, but Manhattan's 29 pp gap is nearly double Staten Island's 9 pp.

**Pickpocket (transit)** — a Manhattan story:

| Borough | n | Marginal |
|:---|---:|---:|
| Manhattan | 741 | -3.94 pp |
| Queens | 288 | -0.41 pp |
| Bronx | 106 | -0.36 pp |
| Brooklyn | 185 | -0.35 pp |
| Staten Island | 0 | NA |

Transit pickpocketing is essentially a Manhattan phenomenon. Zero incidents in Staten Island (no subway coverage in most of the borough). Even the citywide marginal of -3.2 pp is driven almost entirely by Manhattan.

### 5.2 Cross-Borough Patterns

Two broad patterns emerge from the borough decomposition:

1. **Volume-driven consistency**: For high-volume crime types (felony assault, robbery, grand larceny), all five boroughs show substantial marginal concentration. The ranking varies — Manhattan and the Bronx tend to lead — but the signal is present everywhere.

2. **Sparsity-driven divergence**: For low-volume types (murder, shootings, pickpocket), marginal concentration concentrates in a few boroughs and vanishes in others. The citywide marginal is an average that masks complete heterogeneity — real clustering in some boroughs, pure noise in others.

---

## 6. The Punchline

Crime concentration in NYC is real and substantial — but far from uniform across crime types or geographies.

**The strongest spatial signals** belong to retail theft (marginal 50-X of -35.9 pp, marginal Gini of +0.78) and grand larceny (-32.7 pp, +0.60). These are crimes with specific land-use targets — stores for retail theft, commercial/tourist corridors for grand larceny — and the concentration reflects that geography.

**Major violent crimes** (felony assault, street assault, robbery) form a robust middle tier with marginals of 22-29 pp. These are the crime types where Weisburd's law holds most cleanly: 5-6% of blocks account for 50% of incidents, concentration is genuine, and hot spots are real operational targets.

**Sparse crime types** (murder, shootings, transit pickpocketing) show marginals under 8 pp. Their raw numbers look dramatically concentrated — 0.05% of blocks hold 50% of murders — but the Poisson null is also highly concentrated. The real spatial signal is modest citywide, and at single-year resolution it evaporates almost entirely.

**Property crimes** show the most spread. Theft from auto and GLA both exceed 10% of blocks for 50% of crime — above Weisburd's bandwidth. These crimes have diffuse spatial signatures because parked cars and motor vehicles are distributed more broadly than stores or nightlife corridors.

**The borough decomposition** reveals that citywide metrics conceal sharp geographic heterogeneity. Shooting concentration is real in the Bronx (marginal -3.3 pp) but noise in Queens (-0.3 pp). Retail theft is extraordinary everywhere but most extreme in Manhattan (-39.5 pp). Murder marginals are negligible in every borough.

**Methodologically**: the standard claim that "X% of places hold Y% of crime" systematically overstates concentration for rare crime types and understates the variation across crime categories. The null-adjusted marginal — not the raw metric — is what matters for both theory and practice.

---

## References

- Chalfin, A., Kaplan, J., & Cuellar, M. (2021). Measuring marginal crime concentration. *Journal of Research in Crime and Delinquency*, 58(4), 467-504.
- Bernasco, W., & Steenbeek, W. (2017). More places than crimes. *Journal of Quantitative Criminology*, 33, 451-467.
- Weisburd, D. (2015). The law of crime concentration and the criminology of place. *Criminology*, 53(2), 133-157.

---

*Script: `scripts/03-tier1_concentration.R`*
*Data: NYPD Complaint Data, Shootings, Shots Fired on 89,292 physical blocks (EPSG:2263)*
*Crime types: 18 specific offense categories (see Section 2)*
