# Temporal Aspects of Crime Spatial Concentration: A Literature Review

## 1. Long-Term Stability of Spatial Concentration

The foundational literature on crime concentration at micro-places is primarily concerned with year-over-year stability — whether the same street segments remain hot spots across extended time periods.

### Key Works

**Weisburd, D., Bushway, S., Lum, C., & Yang, S. (2004).** Trajectories of crime at places: A longitudinal study of street segments in the city of Seattle. *Criminology*, 42(2), 283–322.

- Used group-based trajectory models on 14 years of Seattle data. Found most street segments had stable trajectories, but a small subset accounted for most of the variance in citywide crime trends — the "chronic hot spots" finding.

**Weisburd, D., Groff, E.R., & Yang, S. (2012).** *The Criminology of Place: Street Segments and Our Understanding of the Crime Problem*. Oxford University Press.

- Book-length treatment of the Seattle street segment data, establishing the street segment as the key unit of analysis for place-based criminology.

**Weisburd, D. (2015).** The law of crime concentration and the criminology of place. *Criminology*, 53(2), 133–157.

- The Sutherland Address. Formalized the "law of crime concentration," arguing that crime concentrates within a narrow bandwidth of percentages across cities, and that this concentration is stable over time despite macro-level crime trends.

**Curman, A.S.N., Andresen, M.A., & Brantingham, P.J. (2015).** Crime and place: A longitudinal examination of street segment patterns in Vancouver, BC. *Journal of Quantitative Criminology*, 31(1), 127–147.

- Replicated the Weisburd et al. (2004) trajectory approach in Vancouver using both group-based trajectory models and k-means clustering. Found the majority of street blocks had stable crime trends, with a minority showing decreasing trends. Confirmed the qualitative findings from Seattle.

**Wheeler, A.P., Worden, R.E., & McLean, S.J. (2016).** Replicating group-based trajectory models of crime at micro-places in Albany, NY. *Journal of Quantitative Criminology*, 32(4), 589–612.

- Further replication in Albany, NY — a city of different character than Seattle or Vancouver. Found similar trajectory patterns, contributing to generalizability. Also raised methodological cautions about model selection and the sensitivity of results to analytic choices.

**Andresen, M.A., Curman, A.S., & Linning, S.J. (2017).** The trajectories of crime at places: Understanding the patterns of disaggregated crime types. *Journal of Quantitative Criminology*, 33(3), 427–449.

- Extended the trajectory approach to disaggregated crime types in Vancouver. Found that crime is highly concentrated regardless of crime type and most trajectories are stable, but notable differences across crime types exist that need to be considered for crime prevention.

**Braga, A.A., Papachristos, A.V., & Hureau, D.M. (2010).** The concentration and stability of gun violence at micro places in Boston, 1980–2008. *Journal of Quantitative Criminology*, 26, 33–53.

- Demonstrated that gun violence concentration at micro-places in Boston was remarkably stable over nearly three decades.

### Methodological Critiques of Group-Based Trajectory Modeling

**Skardhamar, T. (2010).** Distinguishing facts and artifacts in group-based modeling. *Criminology*, 48(1), 295–320.

- Simulation study generating longitudinal data with no true groups (only continuous heterogeneity and state dependence), then fitting SPGM/GBTM. Found that the method consistently recovered seemingly distinct trajectory groups. Standard diagnostics (AvePP > 0.7, OCC > 5) were satisfied in most simulations. Group-specific effects of a covariate with a true uniform effect appeared statistically different across groups. Concludes that GBTM cannot provide evidence for or against the existence of distinct subpopulations; groups should be treated as data reduction constructs, not real types.

**Erosheva, E.A., Matsueda, R.L., & Telesca, D. (2014).** Breaking bad: Two decades of life-course data analysis in criminology, developmental psychology, and beyond. *Annual Review of Statistics and Its Application*, 1, 301–332.

- Comprehensive review of GBTM and growth mixture models. Found that in 8 of 9 studies that plotted individual trajectories within groups, within-group variability was high relative to between-group differences, suggesting groups approximate a continuum rather than reflecting discrete types. The number of groups recovered is sensitive to study design (time span, observation frequency, outcome variable). Introduced unimodal curve registration (UCR) as an alternative that avoids categorical mixture representation. Recommended plotting individual trajectories within groups and treating groups as approximations rather than entities.

**Bauer, D.J. & Curran, P.J. (2003).** Distributional assumptions of growth mixture models: Implications for overextraction of latent trajectory classes. *Psychological Methods*, 8(3), 338–363.

- Showed via simulation that mild nonnormality in outcomes can cause mixture models to extract spurious groups even when only one true group exists. Group-specific covariate effects can be seriously distorted. Concludes that identifying multiple classes as optimal does not indicate population heterogeneity any more than a significant correlation indicates causation.

### Spatial Point Pattern Test

**Andresen, M.A. (2009).** Testing for similarity in area-based spatial patterns: A nonparametric Monte Carlo approach. *Applied Geography*, 29(3), 333–345.

- Developed the spatial point pattern test (SPPT) — a nonparametric method for formally comparing two spatial crime distributions. Produces a global Similarity Index (S) ranging from 0 to 1 and mappable local output showing where patterns diverge.

**Andresen, M.A. (2016).** An area-based nonparametric spatial point pattern test: The test, its applications, and the future. *Methodological Innovations*, 9, Article 12.

- Updated and extended discussion of the SPPT, reviewing its applications across multiple domains.

**Wheeler, A.P., Steenbeek, W., & Andresen, M.A. (2018).** Testing for similarity in area-based spatial patterns: Alternative methods to Andresen's spatial point pattern test. *Transactions in GIS*, 22(3), 760–774.

- Discussed limitations of the SPPT and provided alternative calculation methods. Showed that with large point patterns, many areas will be identified as statistically different even when differences are substantively trivial.

### Stability Testing

**Andresen, M.A., & Malleson, N. (2011).** Testing the stability of crime patterns: Implications for theory and policy. *Journal of Research in Crime and Delinquency*, 48(1), 58–82.

- Used the SPPT to test year-over-year stability of spatial crime patterns in Vancouver across multiple spatial scales. Found that a small percentage of street segments accounted for a substantial portion of crime and this pattern remained stable over time.

### Measurement Critiques

**Hipp, J.R., & Kim, Y.A. (2017).** Measuring crime concentration across cities of varying sizes: Complications based on the spatial and temporal scale employed. *Journal of Quantitative Criminology*, 33(3), 595–632.

- Raised important methodological concerns about how measurement choices — particularly spatial and temporal scale — affect apparent crime concentration levels.

### Special Issue

The **2017 special issue of the *Journal of Quantitative Criminology*** (Vol. 33, No. 3), edited by Braga and Andresen, is the single best collection on testing the law of crime concentration, with papers testing it across different contexts, crime types, and methodological approaches.

---

## 2. Within-Year Temporal Dependence of Spatial Concentration

A smaller but important literature examines whether the *spatial pattern* of crime shifts within the year — by season, day of week, or hour of day. This is distinct from the trajectory literature, which focuses on long-run stability.

### Seasonal Spatial Redistribution

**Andresen, M.A., & Malleson, N. (2013).** Crime seasonality and its variations across space. *Applied Geography*, 43, 25–35.

- The most directly relevant paper for within-year spatiotemporal questions. Used the SPPT to compare spatial crime patterns across seasons in Vancouver. Found that for several crime types (assault, theft, theft from vehicle), the spatial pattern genuinely shifted between seasons — summer crime concentrated at beaches, parks, and the annual fair. Made the important argument that aggregating to annual counts obscures meaningful within-year spatial redistribution, and that inference based on annual crime rates may be based on "spurious results" because one is averaging across spatially distinct seasonal patterns.

**Linning, S.J., Andresen, M.A., & Brantingham, P.J. (2017).** Crime seasonality: Examining the temporal fluctuations of property crime in cities with varying climates. *International Journal of Offender Therapy and Comparative Criminology*, 61(16), 1866–1891.

- Compared property crime seasonality in Vancouver and Ottawa (cities with different climates). Found that cities with greater weather variation throughout the year have more distinct summer increases in property offenses, and that different climate variables affect different crime types — advocating for disaggregate analysis.

### Intra-Week and Hourly Spatial Shifts

**Andresen, M.A., & Malleson, N. (2015).** Intra-week spatial-temporal patterns of crime. *Crime Science*, 4, Article 12.

- Pushed to intra-week temporal resolution. Found that for most crime types (except robbery and sexual assault), the spatial pattern at street segments changed significantly between different days of the week. Weekend crime literally occurred in different places than weekday crime.

**Herrmann, C.R. (2015).** The dynamics of robbery and violence hot spots. *Crime Science*, 4, Article 33.

- Working in the Bronx with NYPD data, showed robbery hot spots shifted dramatically by hour of day and school-day vs. non-school-day. Daytime robbery clustered near schools and subway stations around 3pm; nighttime robbery clustered near bars and transit after 1am. Made the strong claim that almost no hot spots are both spatially and temporally stationary.

**Herrmann, C.R. (2013).** Street-level spatiotemporal crime analysis: Examples from Bronx County, NY (2006–2010). In M. Leitner (Ed.), *Crime Modeling and Mapping Using Geospatial Technologies*. Springer.

- Chapter illustrating how spatiotemporal analysis at street-level scales reveals patterns invisible in purely spatial analysis.

### Ambient Population and Time-Varying Denominators

**Malleson, N., & Andresen, M.A. (2015).** Spatio-temporal crime hotspots and the ambient population. *Crime Science*, 4, Article 10.

- Argued that hotspot identification is fundamentally misleading without time-varying population denominators. Places like retail districts are only "hot" when foot traffic is high. Used social media data to estimate ambient population and showed hotspot identification changes when accounting for the population actually present.

### Special Issue on Spatiotemporal Dynamics

**Newton, A., & Felson, M. (2015).** Editorial: Crime patterns in time and space: The dynamics of crime opportunities in urban areas. *Crime Science*, 4, Article 11.

- Editorial for the 2015 *Crime Science* special issue on "Spatiotemporal Patterns of Crime." Reviewed findings showing that crime hotspots shift quickly in response to the structure of daily life — robbery locations shift from afternoon to early morning, crime near bars is significant on weekends but negligible on weekdays, etc.

### Seasonal Waveform Classification

**Tompson, L., Bannister, J., & Bowers, K. (2023).** Seasonal characteristics of crime: An empirical investigation of the temporal fluctuation of the different types of crime in London. *Computational Urban Science*, 3, Article 94.

- Proposed a methodological framework combining Poisson state-space models with cluster analysis to classify crime types by the similarity of their seasonal waveforms. Found that the amplitude of seasonal fluctuation explained 95% of similarity in crime waveforms across 12 London crime types.

---

## 3. The Gap: Temporally Contingent Spatial Concentration

The existing literature documents that (a) spatial concentration is stable over long periods (the trajectory work), and (b) spatial patterns shift by season, day of week, and hour of day (the spatiotemporal work). However, **no study has directly formalized the concept of temporally contingent spatial concentration** — i.e., that certain places are crime hot spots *only conditional on* specific temporal activity patterns.

### The Exemplar Case

Consider pickpocketing near Rockefeller Center in November/December. This is a crime type that is simultaneously place-bound and season-bound: the spatial concentration only exists during a specific temporal window driven by a specific activity generator (holiday crowds). The location is not a year-round pickpocket hot spot; the temporal window is not a citywide pickpocket peak in the same places. The concentration is the *interaction* of place and time, mediated by a specific routine activity pattern.

### What Exists

The closest theoretical framing is Brantingham & Brantingham's crime generators/attractors concept combined with routine activities theory. Andresen & Malleson (2013) come closest empirically by showing that summer crime shifts to beaches and fairs. Herrmann (2015) shows within-day spatial shifts driven by school schedules and nightlife. Malleson & Andresen (2015) demonstrate that the population-at-risk is itself temporally dynamic.

### What's Missing

Nobody has operationalized the idea that a targeting algorithm needs to account for **seasonal activation** of particular places — that some blocks are only crime generators during specific time windows within the year, and that a static annual targeting model will either miss them or dilute their signal. This has direct implications for:

- **Hot spot prediction**: Annual models will underweight seasonally active places and overweight year-round hot spots.
- **Resource allocation**: Patrol or intervention dosage should vary not just spatially but by temporal activation window.
- **Experimental design**: An RCT at the block level needs to account for the possibility that treatment effects are temporally heterogeneous because the crime-generating mechanism is itself temporal.

This represents a genuine gap in the crime-and-place literature with practical implications for place-based crime prevention strategies and targeting algorithms.
