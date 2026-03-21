# Introduction

## The Pattern

A small share of places accounts for a large share of crime. This empirical regularity, documented across dozens of cities and formalized as the "law of crime concentration at places" (Weisburd, 2015), has become one of the most cited findings in modern criminology. The canonical estimate holds that approximately 4--6% of street segments generate roughly 50% of crime incidents, with a systematic review of 47 studies reporting a median of 4.5% and an interquartile range of 3.2--5.7% (Weisburd et al., 2024). The finding is striking for its consistency: the same approximate ratio appears in Seattle (Weisburd et al., 2004), Chicago (Schnell et al., 2017), The Hague (Steenbeek & Weisburd, 2016), Tel Aviv (Weisburd & Amram, 2014), six U.S. cities simultaneously (Walter et al., 2023), and eight cities compared on common metrics (Spencer & Schnell, 2022). Sherman et al.'s (1989) original Minneapolis study --- showing that 3% of addresses generated 50% of police calls --- proposed that places, like people, have "criminal careers" with onset, persistence, and desistance. Three decades later, the empirical case for spatial concentration has only grown stronger.

The finding matters for two reasons. First, it implies an enormous efficiency gain for place-based interventions. If most crime occurs at a tiny fraction of locations, then resources directed at those locations can, in principle, achieve outsized returns relative to offender-focused or community-wide strategies. Multiple meta-analyses have confirmed that hot spots policing produces statistically significant crime reductions with minimal spatial displacement and some diffusion of benefits to surrounding areas (Braga et al., 2019; Braga, 2001). Second, the consistency of the ratio across cities suggests that crime concentration may reflect a structural feature of urban environments rather than the idiosyncrasies of any particular city's demographics or policing practices. This is the sense in which Weisburd (2015) invoked the word "law" --- deliberately provocative, meant to signal an empirical regularity with the robustness to guide both theory and policy.

Yet the descriptive finding, however robust, is not self-explanatory. It tells us *that* crime clusters at micro-places, not *why*, and its apparent strength depends on methodological choices --- the spatial unit, the metric, the crime type, and the treatment of sparse data --- that the field has only recently begun to interrogate systematically. This paper contributes to that interrogation. Using 18 specific crime types measured across 89,292 physical street blocks in New York City, we apply the marginal concentration framework of Chalfin et al. (2021) to decompose observed concentration into a statistical artifact (what randomness alone would produce) and a genuine spatial signal. The results reveal that crime concentration is real but far from uniform: it is overwhelmingly a property-crime phenomenon, it varies dramatically across crime types, it intensifies over time for some offenses while remaining negligible for others, and it is systematically overstated for rare crimes by conventional metrics.

## Theoretical Foundations

The intellectual architecture supporting crime concentration at micro-places draws on three theoretical streams that converged over the second half of the twentieth century, each redirecting attention from offender motivation to situational opportunity.

The first is routine activities theory. Cohen and Felson (1979) reframed crime not as the product of pathological individuals but as a predictable consequence of everyday spatial and temporal routines. Crime requires the convergence in space and time of a motivated offender, a suitable target, and the absence of a capable guardian. When these three elements align repeatedly at a given location --- because of commuting patterns, commercial activity, land use, or the rhythm of daily life --- that location accumulates crime. The theory does not require that offenders be unusual or that places be deficient; it requires only that opportunity structures be unevenly distributed, which they inevitably are. Routine activities theory thus provides the causal logic for why crime would concentrate at specific places rather than distributing evenly across the urban landscape.

The second stream is crime pattern theory. Brantingham and Brantingham (1993) introduced the geometry of crime: nodes (activity anchors like homes, workplaces, and entertainment venues), paths (routes between them), and edges (boundaries between land uses). Crime occurs not randomly but at the intersections of offender and target activity spaces --- the places where routine movement patterns bring potential offenders into contact with opportunities. This framework predicts that crime will cluster at predictable spatial locations: transit hubs, commercial corridors, entertainment districts, and the edges between residential and commercial zones. Vandeviver et al. (2017) characterize these as the "opportunity theory" backbone of the micro-place perspective, and the empirical record strongly supports the prediction that land use and activity patterns shape where crime happens.

The third is situational crime prevention. Clarke (1995) demonstrated that modifying the immediate circumstances of crime --- through target hardening, surveillance, access control, and environmental design --- could reduce offending at specific places without simply displacing it elsewhere. Clarke's work gave practical substance to the theoretical claim that places matter: if changing a place changes its crime level, then the place itself is causally relevant, not merely a passive backdrop for offender behavior. The diffusion-of-benefits finding --- that situational prevention at treated locations often reduces crime at nearby untreated locations as well --- further undermined the displacement objection and strengthened the case for place-based intervention.

These three theoretical currents --- routine activities, crime pattern theory, and situational prevention --- share a common departure from the neighborhood-level tradition that had dominated spatial criminology since the Chicago School. Shaw and McKay (1942) had established that crime rates varied systematically across urban areas, linked to poverty, residential instability, and ethnic heterogeneity. But the unit of analysis in that tradition was the community or the neighborhood --- too coarse, the micro-place theorists argued, to capture the dramatic within-neighborhood variation that the data revealed. A single neighborhood could contain blocks with dozens of annual incidents alongside blocks with none. The insight that drove the micro-place turn was that the neighborhood average conceals this heterogeneity, and that the heterogeneity itself --- the variation *within* neighborhoods --- is where the explanatory action lies. Jacobs (1961) had intuited this decades earlier, arguing that the physical design of specific streets and buildings shapes informal social control at a granularity far below the neighborhood. The empirical work that followed Sherman (1989) confirmed the intuition with data.

Farrell (2015) proposed a broader unification, arguing that concentration across offenders (a small share of individuals commits most crime), victims (repeat victimization), places (hot spots), and products (hot products) are all manifestations of a single underlying phenomenon. In this framing, crime concentration at places is not a standalone empirical curiosity but one face of a more general law governing how crime distributes across all units of analysis. Whether this generalization holds precisely enough to warrant the term "law" remains debated, but it situates the micro-place finding within a broader theoretical landscape.

## The Evidence Base

The empirical case for crime concentration has been built through three waves of research.

The first wave established the finding. Sherman et al. (1989) showed the striking concentration of police calls at addresses and intersections in Minneapolis. Weisburd et al. (2004) extended the analysis longitudinally, using group-based trajectory modeling to classify Seattle street segments into distinct crime-level trajectories over 14 years. The central result was stability: 84% of segments maintained consistent crime levels, with the aggregate crime drop driven by a small group of declining micro-places rather than a generalized citywide reduction. This established crime concentration not merely as a cross-sectional pattern but as a durable structural feature of urban landscapes.

The second wave replicated and extended the finding. The 2017 special issue of the *Journal of Quantitative Criminology* --- featuring studies of Chicago (Schnell et al., 2017), Boston (O'Brien & Winship, 2017), St. Louis (Levin et al., 2017), 42 Southern California cities (Hipp & Kim, 2017), Cincinnati (Haberman et al., 2017), Vancouver (Andresen et al., 2017), and The Hague (Bernasco & Steenbeek, 2017) --- simultaneously confirmed the core pattern and raised complications. The finding replicated across diverse urban contexts, but with important qualifications. Hipp and Kim (2017) showed that concentration varied more across cities than the narrow bandwidth suggested, particularly when measured with the inverted 5-X metric. Levin et al. (2017) introduced a crucial distinction between spatial inequality (the overall level of concentration, which is stable) and spatial mobility (which specific segments are hot, which shifts). Bernasco and Steenbeek (2017) demonstrated that standard Gini coefficients are biased upward when places outnumber crimes --- the near-universal condition for serious crime types. The replication wave confirmed the finding while revealing that its apparent precision was partly a product of methodological choices.

The third wave, still underway, moves toward mechanism and integration. Schnell et al. (2024) argue that neighborhoods are not passive containers but actively shape how crime clusters at micro-places, finding distinct spatial transmission patterns that vary across Chicago community areas. O'Brien and Ciomek (2023) show that disorder-to-violence aggravation operates most strongly at the address level but is amplified by neighborhood context. O'Brien et al. (2022) demonstrate that concentration itself is a neighborhood-level characteristic --- two neighborhoods with identical crime rates can have very different concentration profiles. These studies dissolve the old dichotomy between micro-places and neighborhoods, showing that both levels matter and interact in ways that aggregate concentration metrics obscure. On the environmental side, Diaz et al. (2025) conduct one of the few quasi-experimental tests of a specific mechanism, examining whether street markets provide Jacobs' (1961) "eyes on the street" --- and finding, counterintuitively, that large markets increase rather than deter theft. Tillyer et al. (2025) demonstrate that residential investment reduces crime at the street-segment level, particularly in disadvantaged neighborhoods, suggesting a non-enforcement pathway to reducing concentration.

The evidence base is thus rich but asymmetric. The descriptive pattern is well established; the causal mechanisms are not. The field knows *that* crime concentrates at micro-places with remarkable consistency across cities. It does not yet know, with comparable rigor, *why* specific places attract and sustain crime while their neighbors do not.

## The Measurement Problem

How much of what the field "knows" about crime concentration is an artifact of how crime is recorded, geocoded, and counted? The answer, emerging from a series of methodological critiques, is: more than the canonical framing acknowledges.

The most consequential critique is the sparse-data problem. Chalfin et al. (2021) demonstrated that standard concentration metrics --- the 50-X statistic, the Gini coefficient, the cumulative proportion curve --- systematically overestimate spatial concentration when the number of places exceeds the number of crimes, which is the default condition for all but the most common offense categories. Consider a city with 100,000 street segments and 300 annual homicides: even under perfectly random spatial allocation, most segments will have zero homicides, a few will have one, and the resulting distribution will *look* concentrated. The apparent concentration is a mathematical inevitability, not evidence of a spatial process. Chalfin et al. proposed a randomization-based counterfactual --- the concentration that would be expected if crimes were distributed uniformly at random --- and defined *marginal* crime concentration as the difference between the observed value and this null expectation. The marginal captures the genuine spatial signal after removing the artifact. For common crimes (thousands of incidents annually), the correction is small and the observed concentration is largely real. For rare crimes (homicides, shootings), the correction can be enormous, revealing that most of the apparent concentration is statistical noise.

Bernasco and Steenbeek (2017) arrived at a complementary conclusion through a different route. Their generalized Lorenz curves correct for the mechanical concentration produced when places outnumber events, showing that standard metrics are biased upward precisely in the conditions where they are most commonly applied. Mohler et al. (2019) demonstrated the same bias using Poisson-Gamma estimation, offering a parametric alternative to the randomization approach. The common thread is clear: the field's signature finding --- that a small percentage of places generates a large percentage of crime --- is overstated for rare crime types by an amount that depends on the ratio of places to incidents.

The metric itself is also contested. Andresen and Weisburd (2025) compared seven commonly used concentration measures and argued that the 50-X metric (what percentage of places accounts for 50% of crime) is the most parsimonious and policy-relevant. They showed that some of the apparent disagreement about the law's bandwidth is attributable to metric choice: the inverted 5-X metric (what percentage of crime occurs in the top 5% of places), favored by Hipp and Kim (2017), produces artificially wide bandwidths that make concentration look inconsistent across cities. Converting all estimates to a common metric restores the narrow range. The debate about "how concentrated is crime?" is thus partly a debate about how to measure concentration, and the answer depends on the question being asked.

A broader challenge comes from Eck et al. (2017), who showed that crime concentrates at roughly the same level as many other spatial phenomena --- restaurant locations, traffic accidents, fire calls, and various non-criminal events. If concentration is not distinctive to crime but is instead a generic property of spatial distributions, then the policy implications change. The rationale for concentrating policing resources at hot spots depends partly on the claim that crime concentration is exceptional --- that the spatial signal is strong enough to warrant targeted intervention. If the same degree of concentration characterizes benign activities, the efficiency argument weakens, and the equity concerns surrounding hot spots policing intensify.

Finally, there are the data themselves. Police-recorded crime data reflects organizational routines, reporting behaviors, and geocoding conventions, not a neutral window onto criminal events. Taylor et al. (2024) demonstrated that 311 calls --- increasingly used as disorder proxies --- lack discriminant validity: theoretically unrelated categories (information requests) predicted physical conditions just as well as relevant categories (litter complaints), suggesting that 311 patterns reflect a general propensity to call rather than on-the-ground conditions. Andresen (2006) raised the denominator problem: concentrated relative to what? A nightlife district may look concentrated per unit of area but unremarkable per visitor. These are not peripheral technical concerns; they bear directly on the substantive interpretation of the law of crime concentration.

## Gaps in the Literature

Despite three decades of research and dozens of studies, several important gaps remain.

**Crime-type specificity.** Most studies either aggregate crime into a single index or examine one type in isolation --- typically robbery, violent crime, or total calls for service. Weisburd et al. (2024) note that specific crime types show tighter concentration than aggregates, but the evidence is thin. No published study has systematically compared marginal concentration across a broad crime typology at micro-units within a single city, holding geography constant while varying the offense. This matters because the theoretical mechanisms behind concentration are crime-type-specific: the opportunity structures that generate retail theft (stores) differ fundamentally from those that generate shootings (street networks, social conflicts) or residential burglary (housing stock). If the law of crime concentration holds uniformly across types, it points to a structural feature of urban space. If it varies sharply by type, the "law" is better understood as a family of type-specific patterns with distinct generators.

**The null calibration across types.** The Chalfin et al. (2021) framework has been applied in isolated studies but not deployed systematically across a full crime typology. This means the field lacks a clear picture of how the sparse-data bias varies across the volume spectrum --- from grand larceny (hundreds of thousands of incidents) to homicide (hundreds). The correction is presumably small for common crimes and large for rare ones, but the empirical profile across the full typology has not been documented.

**Temporal dynamics of concentration.** The stability claim --- that crime concentration is durable over years and decades --- is based primarily on aggregate metrics. Levin et al. (2017) showed that the *level* of concentration is stable even as the *specific locations* shift. But few studies have examined whether marginal concentration itself changes over time: whether crime is becoming more or less spatially concentrated after controlling for volume changes. Prieto Curiel et al. (2021) explored weekly temporal concentration in Mexico City, but the question of long-run trends in place-based concentration has received little attention.

**Seasonal and sub-annual dynamics.** The concentration literature is overwhelmingly cross-sectional or uses annual time windows. Whether concentration exhibits seasonal patterns --- summer peaks for violent crime, holiday-season peaks for theft --- is largely unexplored at the micro-place level with null-adjusted metrics. Haberman et al. (2017) showed that concentration holds across temporal scales (hour, day, season), but without the null calibration, it is unclear how much of that persistence is real versus artifact.

**Borough and sub-city heterogeneity.** Citywide concentration metrics average over geographically heterogeneous areas. O'Brien et al. (2022) showed that concentration varies across Boston neighborhoods, suggesting that the citywide metric is a potentially misleading summary. Whether this holds in larger, more diverse cities --- and whether the pattern of sub-city variation is consistent across crime types --- has not been tested.

## The Present Study

This paper addresses these gaps by conducting, to our knowledge, the most comprehensive null-adjusted crime concentration analysis to date. Using New York City as the study site --- with its 89,292 physical street blocks, diverse urban fabric, and rich administrative data --- we make four contributions.

First, we compute marginal concentration for 18 specific crime types spanning the full volume spectrum, from grand larceny (880,000 incidents) to transit pickpocketing (6,200 incidents). By applying the analytical Poisson null of Chalfin et al. (2021) uniformly across types, we produce the first systematic crime-type-specific profile of genuine spatial concentration at micro-units.

Second, we examine temporal trends in marginal concentration, tracking annual changes in four crime types over a 20-year window (2006--2025). This moves the stability question from "does concentration persist?" to "does concentration intensify, attenuate, or remain constant over time?" --- a more precise and policy-relevant formulation.

Third, we test for seasonality in micro-place concentration for sparse crime types, using pooled month-of-year profiles and quarterly time series to determine whether the spatial signal varies with seasonal rhythms even after null adjustment.

Fourth, we decompose marginal concentration by borough for three property crime types, testing whether the citywide metric conceals systematic sub-city heterogeneity in the strength of the spatial signal.

The paper proceeds as follows. Section 2 describes the data, spatial framework, and analytical methods. Section 3 presents the all-years concentration results for 18 crime types. Section 4 examines temporal dynamics, seasonal patterns, and borough-level variation. Section 5 discusses the implications for the law of crime concentration and the broader criminology of place. Section 6 concludes.

---

## References

Andresen, M. A. (2006). Crime measures and the spatial analysis of criminal activity. *British Journal of Criminology*, 46(2), 258--285.

Andresen, M. A., Linning, S. J., & Malleson, N. (2017). Crime at places and spatial concentrations: Exploring the spatial stability of property crime in Vancouver BC, 2003--2013. *Journal of Quantitative Criminology*, 33, 255--275.

Andresen, M. A., & Weisburd, D. (2025). Ockham's razor and the measurement of crime concentrations. *Journal of Quantitative Criminology*.

Bernasco, W., & Steenbeek, W. (2017). More places than crimes: Implications for evaluating the law of crime concentration at place. *Journal of Quantitative Criminology*, 33, 451--467.

Braga, A. A. (2001). The effects of hot spots policing on crime. *Annals of the American Academy of Political and Social Science*, 578, 104--125.

Braga, A. A., Turchan, B., & Papachristos, A. V. (2019). Hot spots policing of small geographic areas effects on crime. *Campbell Systematic Reviews*, 15(3).

Brantingham, P. L., & Brantingham, P. J. (1993). Nodes, paths, and edges: Considerations on the complexity of crime and the physical environment. *Journal of Environmental Psychology*, 13(1), 3--28.

Chalfin, A., Kaplan, J., & Cuellar, M. (2021). Measuring marginal crime concentration. *Journal of Research in Crime and Delinquency*, 58(4), 467--504.

Clarke, R. V. (1995). Situational crime prevention. In M. Tonry & D. P. Farrington (Eds.), *Building a Safer Society: Strategic Approaches to Crime Prevention* (pp. 91--150). University of Chicago Press.

Cohen, L. E., & Felson, M. (1979). Social change and crime rate trends: A routine activity approach. *American Sociological Review*, 44(4), 588--608.

Diaz, C., Fossati, S., & Trajtenberg, N. (2025). "Eyes on the street" and itinerant markets: A quasi-experimental test. *Journal of Quantitative Criminology*.

Eck, J. E., Lee, Y., O, S., & Martinez, N. (2017). Compared to what? Estimating the relative concentration of crime at places using systematic and other reviews. *Crime Science*, 6, 8.

Farrell, G. (2015). Crime concentration theory. *Crime Prevention and Community Safety*, 17, 233--248.

Haberman, C. P., Sorg, E. T., & Ratcliffe, J. H. (2017). Assessing the validity of the law of crime concentration across different temporal scales. *Journal of Quantitative Criminology*, 33, 547--567.

Hipp, J. R., & Kim, Y.-A. (2017). Measuring crime concentration across cities of varying sizes: Complications based on the spatial and temporal scale employed. *Journal of Quantitative Criminology*, 33, 595--632.

Jacobs, J. (1961). *The Death and Life of Great American Cities*. Random House.

Levin, A., Rosenfeld, R., & Deckard, M. (2017). The law of crime concentration: An application and recommendations for future research. *Journal of Quantitative Criminology*, 33, 635--659.

Mohler, G. O., Brantingham, P. J., Carter, J., & Short, M. B. (2019). Reducing bias in estimates for the law of crime concentration. *Journal of Quantitative Criminology*, 35, 747--765.

O'Brien, D. T., & Ciomek, A. (2023). Persistence and aggravation of violent crime at addresses, streets, and neighborhoods. *Journal of Research in Crime and Delinquency*, 60(6), 820--855.

O'Brien, D. T., Ciomek, A., & Tucker, R. (2022). Crime concentration variation across neighborhoods. *Journal of Quantitative Criminology*, 38, 775--800.

O'Brien, D. T., & Winship, C. (2017). The gains of greater granularity: The presence and persistence of problem properties in urban neighborhoods. *Journal of Quantitative Criminology*, 33, 649--675.

Prieto Curiel, R., Herrmann, H., & Bishop, S. R. (2021). Weekly crime concentration. *Journal of Quantitative Criminology*, 37, 319--344.

Schnell, C., Braga, A. A., & Piza, E. L. (2017). The influence of community areas, neighborhood clusters, and street segments on the spatial variability of violent crime in Chicago. *Journal of Quantitative Criminology*, 33, 469--496.

Schnell, C., DeWitt, S. E., & Spencer, M. D. (2024). The role of neighborhoods in the age of crime hot spots. *Crime & Delinquency*, 70(11), 2812--2841.

Shaw, C. R., & McKay, H. D. (1942). *Juvenile Delinquency and Urban Areas*. University of Chicago Press.

Sherman, L. W., Gartin, P. R., & Buerger, M. E. (1989). Hot spots of predatory crime: Routine activities and the criminology of place. *Criminology*, 27(1), 27--56.

Spencer, M. D., & Schnell, C. (2022). Reinvestigating cities and the spatial distribution of robbery. *Journal of Criminal Justice*, 82, 101966.

Steenbeek, W., & Weisburd, D. (2016). Where the action is in crime? An examination of variability of crime across different spatial units in The Hague, 2001--2009. *Journal of Quantitative Criminology*, 32(3), 449--469.

Taylor, R. B., Lockwood, B., & Wyant, B. R. (2024). Can streetblock 311 physical incivility call count shifts predict later assessed streetblock conditions? *Journal of Crime and Justice*, 47(1), 1--20.

Tillyer, M. S., Acolin, A., & Walter, R. J. (2025). Investment and crime on residential street segments. *Cities*, 156.

Vandeviver, C., Bernasco, W., & Wouters, M. (2017). The impact of opportunity theory on spatial crime research. In G. Bruinsma & S. Johnson (Eds.), *The Oxford Handbook of Environmental Criminology* (pp. 97--116). Oxford University Press.

Walter, R. J., Tillyer, M. S., & Acolin, A. (2023). Spatiotemporal crime patterns across six U.S. cities. *Journal of Quantitative Criminology*, 39, 921--950.

Weisburd, D. (2015). The law of crime concentration and the criminology of place. *Criminology*, 53(2), 133--157.

Weisburd, D., & Amram, S. (2014). The law of concentrations of crime at place: The case of Tel Aviv-Jaffa. *Police Practice and Research*, 15(2), 101--114.

Weisburd, D., Bushway, S., Lum, C., & Yang, S.-M. (2004). Trajectories of crime at places: A longitudinal study. *Criminology*, 42(2), 283--321.

Weisburd, D., Zastrowa, T., Kuen, K., & Andresen, M. A. (2024). Crime concentrations at micro places: A review of the evidence. *Aggression and Violent Behavior*, 78, 101940.
