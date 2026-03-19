# PLOS ONE

a1111111111 a1111111111 a1111111111 a1111111111 a1111111111

OPEN ACCESS

Citation: Alazawi MA, Jiang S, Messner SF (2022) Identifying a spatial scale for the analysis of residential burglary: An empirical framework based on point pattern analysis. PLoS ONE 17(2): e0264718. https://doi.org/10.1371/journal. pone.0264718

Editor: Tzai-Hung Wen, National Taiwan University, TAIWAN

Received: June 16, 2021 Accepted: February 15, 2022 Published: February 28, 2022

Copyright: © 2022 Alazawi et al. This is an open access article distributed under the terms of the Creative Commons Attribution License, which

permits unrestricted use, distribution, and reproduction in any medium, provided the original author and source are credited.

Data Availability Statement: All relevant data are within the manuscript and its Supporting Information files.

Funding: SJ: Center for Social and Demographic Analysis (CSDA), University at Albany; Center for Urban and Regional Analysis (CURA), The Ohio State University. The funders had no role in study design, data collection and analysis, decision to publish, or preparation of the manuscript.

Competing interests: The authors have declared that no competing interests exist.

RESEARCH ARTICLE

Identifying a spatial scale for the analysis of residential burglary: An empirical framework based on point pattern analysis

Mohammed A. Alazawi1‡*, Shiguo JiangID2‡*, Steven F. Messner3

1 Department of Information Science, University at Albany, State University of New York, Albany, NY, United States of America, 2 Department of Geography and Planning, University at Albany, State University of New York, Albany, NY, United States of America, 3 Department of Sociology, University at Albany, State University of New York, Albany, NY, United States of America

‡ MAA and SJ contributed equally to this work as co-first authors

* sjiang2@albany.edu (SJ); mmohammedali@albany.edu (MAA)

## Abstract

A key issue in the spatial and temporal analysis of residential burglary is the choice of scale: spatial patterns might differ appreciably for different time periods and vary across geographic units of analysis. Based on point pattern analysis of burglary incidents in Columbus, Ohio during a 9-year period, this study develops an empirical framework to identify a useful spatial scale and its dependence on temporal aggregation. Our analysis reveals that residential burglary in Columbus clusters at a characteristic scale of 2.2 km. An ANOVA test shows no significant impact of temporal aggregation on spatial scale of clustering. This study demonstrates the value of point pattern analysis in identifying a scale for the analysis of crime patterns. Furthermore, the characteristic scale of clustering determined using our method has great potential applications: (1) it can reflect the spatial environment of criminogenic processes and thus be used to define the spatial boundary for place-based policing;

(2) it can serve as a candidate for the bandwidth (search radius) for hot spot policing; (3) its independence of temporal aggregation implies that police officials need not be concerned about the shifting sizes of risk-areas depending on the time of the year.

### Introduction

In spatial analysis of crime such as residential burglary, a key issue is the choice of the spatial scale of analysis. In areal data analysis, the spatial scale of analysis refers to the unit of analysis. In the literature [see 1 for a brief review], studies have adopted different units/scales varying from the macro level (nation, state, county or city) to meso level (neighborhood, census tract), to the micro level (street addresses or street segments). The spatial patterns of crime may vary across geographic units of analysis [2–5], which is the well-known Modifiable Areal Unit Problem [MAUP; 6–8]. Therefore, it is difficult to compare or generalize across different studies due to the issues of the ecological fallacy and the atomistic fallacy [3]. For example, statistical inferences about the nature of larger geographic units (groups) are not necessarily applicable

to smaller geographic units due to the issue of the ecological fallacy [3,5,9]. Similarly, statistical inferences based on smaller geographic units cannot be directly applied to larger geographic units due to the issue of the atomistic fallacy [3,10,11].

Another issue is the choice of the most useful temporal scale. In its finest scale, crime incidents are recorded at the resolution of the minute. In practice, crime data are usually aggregated based on a certain time interval, mostly on a yearly basis to be consistent with the temporal scale of other covariates with available data such as socio-economic status (SES). Some studies have also aggregated multiple years of crime data to minimize yearly fluctuations [12,13]. However, the existence of seasonality [14–16], repeat and near-repeat victimization [17–19], and periodic change of guardianship for homes [20,21] can all affect the temporal patterns of residential burglary. The seasonality observed for property crimes and specifically for burglary has been confirmed by many other studies [15,22–25] and has mostly been explained with reference to routine activity theory. Andresen and Malleson [14] argued that, due to the seasonal patterns and related distinct spatial patterns, analysis based on yearly aggregated crime rates and census data may not be suitable for inference. Studies of repeat and nearrepeat victimization reveal that victimization recurs quickly to the same victim or to targets with similar characteristics or situation [19,26]. The time intervals between recurrence can be as short as one week but are mostly within 4–6 weeks [21,27,28]. Periodic change of guardianship for homes refers to the difference of guardianship for weekday/weekend and day/night wherein the least degree of guardianship usually occurs during the daytime of weekdays [20,29]. The interaction among seasonality, periodic change of guardianship, and repeat/near repeat victimization creates complex spatio-temporal patterns that may be masked by the yearly aggregated data.

Previous studies have made significant contributions in searching for a useful scale of analysis. Criminologists have examined crime concentration at various spatial levels (e.g., street segment, neighborhood, and district) and found that the majority of the variability can be attributed to street segments [30–32], confirming the importance of crime analysis at microscale [1,33–36]. Some scholars also investigated the in(stability) of residential burglary patterns on street segments and found that burglary point patterns exhibit a moderate to high degree of spatial stability over time [37]. Despite the current movement within criminology towards analyzing crime at finer spatial scales, some scholars have recently revealed otherwise different results. For example, Malleson et al. [38] found that the choice of scale varies with the types of crime, the number of events, and the degree of clustering, and Ramos et al. [39] revealed that finer is not necessarily better in the micro-analysis of crime, and that units coarser than street segments might be better.

In this study, we borrow ideas from ecological and biological research and use L function to identify the scale of analysis for crime patterns. In the biological literature, different forms of K function (L function) have been used to investigate the spatial organization (random, clustering, or regularity) of molecules [40,41], to identify the domain size (cluster size) of micro-organization [42–44] or degree of clustering [45], and the change of spatial point pattern over time [46]. This study uses residential burglary as an example and extends the ideas from the above biological research in pursuit of two closely related objectives:

- 1. to develop an empirical framework that can facilitate the selection of the spatial scale of analysis for residential burglary;
- 2. to examine the impact of temporal aggregation on the spatial scale identified in the first objective.


It is important to acknowledge at the onset that selecting the scale of analysis depends upon the objectives of the research. For example, research on the influence of welfare policies on crime rates in the U. S. has typically used the U. S. states as the units of analysis. This is justified on the grounds that state-level agencies determine and administer the welfare policies which apply to the respective residents [47,48]. Similarly, a macro-sociological theory such as Institutional Anomie Theory [49] has stimulated a good deal of research at the level of nation-states, which makes sense given that the core variables in the theory reflect features of societies, e.g., the interrelationships among social institutions and dominant cultural values. We also acknowledge the practical benefits of crime hot spot policing demonstrated in the literature [50–55].

In our study, the search for the spatial scale seeks to identify the geographic scale that captures faithfully the clustering of incidents in the data. This is thus an inductive, empirical approach to identify meaningful areal units. Our approach is predicated on the assumption that observed spatial clustering/spatial dependence of residential burglary is likely to indicate social processes that do in fact operate at the corresponding geographic scale. The results of our study shed light on the selection of appropriate units for areal studies, thus addressing the modifiable areal unit problem (MAUP).

### Data and methods Study area and data

Our study area is based on data for the city of Columbus, Ohio, which is the capital of Ohio and the county seat of Franklin County. From the U.S. Census TIGER website, we obtained the boundary file of Columbus, which is a little messy and has many isolated holes or dangling areas. To reduce the edge effect [56–58] due to complex boundaries, we determined the study area with a balance between selecting as large an expanse of the Columbus city as possible and as simple/compact a boundary as possible.

We obtained residential burglary data (TXT files) for the years 1994–2002 from the Columbus Division of Police. We cleaned and geocoded the data to points using ESRI ArcGIS with a 96% match rate, which far exceeded the minimum acceptable match rate (i.e., 85%) of geocoding proposed by Ratcliffe [59]. The mapped spatial point patterns of residential burglary during 1994–2002 are shown in Fig 1, where the number of offenses appears in each subplot after the year. The yearly number of offenses during 1994–2002 range from 8572 to 9796, with an average of 9023. Other ancillary data include: (1) the block data and parcel data of Franklin County, Ohio, all obtained from Franklin County Auditor; (2) the boundaries of census tracts and zip codes obtained from the 2000 U.S. Census-TIGER/Line Shapefiles; (3) the boundaries of the neighborhoods obtained from Google My Maps [60], (4) the boundaries of Columbus communities obtained from City of Columbus Department of Technology [61].

To investigate the impact of temporal aggregation on the spatial scale of the crime pattern, we classify residential burglary based on five temporal levels, with 1+4+12+2+7 = 26 temporal scales and 26 x 9 = 234 spatial point patterns for the nine years (Table 1). The descriptive statistics for all the 234 spatial point patterns are presented in the Supplementary Data (S1 Table).

### Point pattern analysis

We investigate how each residential burglary offense (point) is located in space compared to other residential burglary offenses (points) at various temporal scales. We conduct this analysis using Ripley’s K function [57,62; for simplicity, K function hereafter], a statistic based on the pairwise distances between events, i.e., burglary offences for this study. Based on the intensity and the distance distribution of the events, K function can detect if the point patterns are completely random, clustered, or regular (inhibition between events). Point pattern analysis

Fig 1. Residential burglary (represented with black +) overlaid with kernel density map indicating hotspots around downtown Columbus during 1994–2002. In each subplot, the year and the number of offenses are separated by “:”; For example, in the first subplot on the top left, “1994: 8863” indicates that there were 8863 residential burglary offences in year 1994. The unit of the density map is one residential burglary per km2.

https://doi.org/10.1371/journal.pone.0264718.g001

###### Table 1. Temporal scale of point pattern analysis.

|Level|Scale|Number of temporal scale per year|Number of years|Total number of point patterns|
|---|---|---|---|---|
|Annual|1994–2002|1|9|9|
|Season|Spring-Winter|4|9|36|
|Month|January-December|12|9|108|
|Workday|Weekday/Weekend|2|9|18|
|Day of week|Monday-Sunday|7|9|63|
|Grant total| |26|9|234|


https://doi.org/10.1371/journal.pone.0264718.t001

using K function has been widely used in statistics and geography and has gained increasing use in criminology in recent years [e.g., 63–65]. One specific feature of K function analysis that has been relatively neglected or underreported in previous studies is the scale of clusters, which can be used to guide the determination of scale for crime studies.

Homogeneous K function. Ripley’s K function [62] measures the within-pattern point interactions and can be used to create a summary graph of cumulative crimes indicating the cluster pattern at multiple scales. Specifically, K function can reveal the spatial scales (distances) where significant spatially clustered point patterns occur. The original Ripley’s K-function assumes stationary point processes with a constant intensity. Consider a stationary spatial point process U = {u1,...,un}. So, K value within a Euclidian radius distance of h for the observed number of points N over a study area A is estimated as:

eijIðdij hÞ l2

XN

##### XN

1 jAj

K^ðhÞ ¼

i¼1

j¼1;j6¼i

ð1Þ

where λ is the intensity of the point process that can be estimated by λ = N(A)/|A|, which is constant throughout the study area A, and |A| is the area of the study area A, N(A) is the number of events in study area A; dij is the distance between location of point i and location of point j that fall inside a circle of radius h, so, I (dij < h) is the indicator function where:

(

1; If dij h 0; If dij > h

Iðdij hÞ ¼

ð2Þ

eij is an edge correction term to remove the bias introduced by the edge of study area A [57]. Point process under K-function is assumed as homogenous Poisson Process, also called complete spatial randomness (CSR), where intensity is homogeneous throughout a study area.

Inhomogeneous K function. Exploratory analyses of the first order intensity maps (see the maps in Fig 1 for some examples) indicate the presence of a large-scale (global) trend from the downtown area outwards. This large-scale trend is likely due to the spatial variation of the population at risk, i.e., the inhomogeneous distribution of residential properties [66]. This means that applying the original K-function could be misleading because the significant spatial dependence (clustering) could be a result of the first order intensity (due to inhomogeneous point process) rather than the second order spatial dependence that occurs within the point pattern. For example, the spatial point pattern of residential burglary could show a significant spatial dependence within certain spatial scales due to a small-scale variation of the intensity resulting from the variation of the spatial population of parcels rather than the real spatial interaction within the crime point pattern. Here, the population parcels could be the hidden covariate that resulted in the spatial trend of intensity in the residential burglary.

Therefore, when testing the null hypothesis of complete spatial randomness, it is necessary to consider the spatial trend effects shown in the corresponding intensity map of Fig 1 [67,68]. In other words, the point patterns of residential burglary in Columbus can be modeled by a nonstationary inhomogeneous Poisson process (IPP) with non-constant intensity [69,70]. To do so, we separate the spatial trend and re-weight the first order intensity by using inhomogeneous K-function [71]. Such separation is necessary to avoid the confounding between intensity and within-pattern interaction [72,73].

The inhomogeneous K-function (Kinhom) is an extension of Ripley’s homogeneous K-function to an inhomogeneous point process, where spatial dependence and associated spatial scales are examined with non-constant intensities throughout a study area. Under Kinhom function, the spatial varying intensities and the spatial trend are adjusted by an intensity function

l^ðuÞ. Consider a non-stationary spatial point process U = {u1,...,un} with an intensity function l^ðuÞ, the Kinhom is estimated as [71,74]:

eijIðdij hÞ l^ðuiÞl^ðujÞ

XN

##### XN

1 jAj

K^inhomðhÞ ¼

i¼1

j¼1;j6¼i

ð3Þ

where |A|, dij, I(dij < h), and eij are defined as before; l^ðuiÞ and l^ðujÞ are the intensity function λ(u) at point ui and uj, respectively, which are estimated using the method in next section. To stabilize the variance of K function and for visualization purpose, we use L function which is a centered linear transformation of K function [66,74–76]:

q

ffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffiffi K^inhomðhÞ=p

L^inhomðhÞ ¼

h ð4Þ

To determine the significance of the L function, we construct a simulation envelope using the Monte Carlo test [57,77,78], which only requires a relatively small number of simulations to achieve high accuracy [73]. In this study, we conduct 39 Monte Carlo simulations, resulting in a significance level of α = 2/(1+39) = 0.05 according to Baddeley et al. [73]. Again, the border correction method developed by Ripley [79] is used to remedy the possible edge effect bias (eij). The border correction strategy is preferable for large point data set to allow faster computation. In addition, compared to other edge effect strategies and methods, the border correction estimate is consistent and approximately unbiased [73].

Modeling the spatial trend. This intensity function l^ðuÞ can be estimated non-parametrically by using kernel smoothing estimators or nearest-neighbor estimators [71,80,81] or parametrically by applying a parametric model (e.g., a log-linear model). To investigate the general spatial patterns of residential burglary, we estimate the first order intensity of each point pattern using kernel smoothing with a bandwidth of 2000 m. Fig 1 shows the intensity maps for each year of 1994–2002. To avoid bias due to edge effect and to obtain better statistical performance, we use the edge correction method proposed by Diggle [80]. The estimated intensity map, with relatively large bandwidth (i.e., 2000 m here), reveals the general spatial trend of the point patterns [69,80].

To further characterize the first order intensity used for the within-pattern interaction analysis, a parametric model is preferred for two main reasons. First, the non-parametric estimation through kernel smoothing is using the same spatial point pattern data, which can lead to substantial bias in the estimate of the inhomogeneous K-function, which is more responsive to local fluctuations in the data [73]. Second, the non-parametric estimation has the assumption that the scale of the first order is larger than that of the second order [67].

For this study, the global trend for the point pattern of residential burglary can be estimated with a log-linear additive model [73]:

l^ðuÞ ¼ expfb0 þ b1x1ðuÞ þ b2x2ðuÞ þ ... þ bpxpðuÞg ð5Þ

where β0, β1, β2, ,βp are the parameters to be estimated; x1(u), x2(u), ,xp(u) are the covariates at location u. The spatial covariates used in Eq 5 should be the populations at risk, where we include two variables (Fig 2): residential area (RA) and parcel density (PD).

By definition, residential burglary should only happen in the residential area. However, due to mixed parcel/land use, there are a significant number of residential burglary incidents in areas classified as non-residential. To characterize this variation, we include residential area as a dummy variable in all our candidate models. The spatial covariates are converted to raster images to link with the point pattern through the model in the R environment. The residential

Fig 2. Spatial covariates for modeling the spatial trend. a–residential area, b–parcel density (unit: One parcel per km2). https://doi.org/10.1371/journal.pone.0264718.g002

areas are represented as a dummy variable: 1 for residential areas and 0 for non- residential areas. The raster image of parcel density is estimated using kernel density estimation.

The models are validated using the relative intensity, r(u), which measures the agreement between the true intensity λ(u) and the estimated intensity l^ðuÞ [73]. The relative intensity is defined as rðuÞ ¼ lðuÞ=l^ðuÞ. The closer r(u) to 1, the better the model. In practice, r(u) is estimated by kernel smoothing [73]:

X

1 eðuÞ

1 l^ðuiÞ

^rðuÞ ¼

kðu uiÞ ð6Þ

i

where k is a smoothing kernel and e(u) is the edge correction factor.

Spatial scale of interaction. The K function reflects the number of events separated by certain distance h. The L function is the standardized K function, indicating the standardized strength of interaction. Fig 3 shows an example of an estimated L function (thick black line) and simulation envelope (gray shaded area).

For a clustered point pattern, the inhomogeneous L function starts inside the simulation envelope and increases with distance h. At a certain distance, inhomogeneous L function rises consistently above the simulation envelope. After a certain distance, the inhomogeneous L function decreases until below the simulation envelope (Fig 3). Here we define three scales of interaction.

- • Minimum Scale of Interaction (h0): the distance where the L function starts to increase above the simulation envelope as indicated by the blue dashed line in Fig 3 where h0 = 520 meters.
- • Range of Interaction (hr): the distance where the L function decreases below the upper envelope as indicated by the blue solid line in Fig 3 where hr = 3247 meters. hr H, where H is the maximum distance between events in the study area.
- • Characteristic Scale of Clustering (hc): the weighted average scale of interaction defined as,


Fig 3. An example inhomogeneous L function, assuming inhomogeneous Poisson process (IPP). The black line (including the thick segment in the middle) is the estimated L function from the data; the red dashed line is the theoretical L function (null model) for IPP; the shaded area indicates the simulation envelope constructed with 39 Monte Carlo simulations of the fitted IPP model. The blue dashed line indicates the minimum scale of interaction (h0); the blue solid line indicates the range of interaction (hr).

https://doi.org/10.1371/journal.pone.0264718.g003

X

Lihi X

hn hi hr

hc ¼

Li

hn hi hr

ð7Þ

where Li is the estimated L value for hi, h0 hi hr, i.e., hc is estimated based on the thick black line between the blue dashed line and blue solid line.

Under some conditions, particularly for the point patterns at annual aggregation, the L function stays above the envelope all through the h values. In such case, hr is calculated as the maximum distance (H) between events in the study area.

### Dependence of spatial scale on temporal aggregation

To examine the impact of temporal aggregation on the spatial scale of clustering, we analyze spatial point patterns with various temporal aggregations. In other words, we subset the point pattern data by different temporal scales, and then conduct point pattern analysis using Ripley’s K function to detect the spatial scales of clustering. As discussed in Table 1 above, we

Fig 4. Estimated relative intensity. https://doi.org/10.1371/journal.pone.0264718.g004

analyze 234 spatial point patterns with various temporal aggregations, resulting in 234 sets of L functions and spatial scales of interaction. We use a one-way ANOVA test to compare the difference and significance of the characteristic scale of clustering among the 234-point patterns.

Most of the analyses in this paper are carried out using R [82]. Specifically, the point pattern analysis (K function and L function) is implemented using functions from the spatstat package [73].

### Results Spatial trend of residential burglary

The estimated spatial trend model is: l^ðuÞ ¼ expf  2:83 þ 2:63RAðuÞ þ 0:34PDðuÞg, where

RA is the residential area and PD is the parcel density as shown in Fig 2. All the parameters, β0, β1, β2, are significant at the level α = 0.001. The map and histogram of estimated relative intensity are shown in Fig 4.

The range of the relative intensity is concentrated around 0.7–1. Fig 5 shows the fitted intensity map for all residential burglaries during 1994–2002. The map indicates that the spatial trend of residential burglary is well captured by the spatial covariates. The estimated parameters of the model indicate that the intensity of residential burglary is e2.63 14 times higher in residential areas than non-residential areas (i.e., mixed use parcel/areas). For each additional parcel per km2, the residential burglary incidents increase by (e0.34−1)×100% 40.5%.

### Spatial scale of clustering

For all the 234 point patterns, the inhomogeneous L functions stay above the simulation envelopes for at least a certain distance. In other words, all the point patterns are significantly clustered. For each of the 234 point patterns, we extracted the minimum scale of interaction (h0), the range of interaction (hr), and the inhomogeneous L function values (Li) associated with distances hi (h0 hi hr). For the example L function shown in Fig 3, the extracted Li and hi are shown in S2 Table of the Supplementary Data. Using Eq 7, we calculated the characteristic scale of clustering (hc) (Table 2), which varies across the temporal scales with a grand mean of

Fig 5. Fitted intensity map for mapped point pattern (all residential burglary during 1994–2002). Unit: One residential burglary incident per km2.

- https://doi.org/10.1371/journal.pone.0264718.g005


2243 meters. As shown by the histogram (Fig 6), the distribution of hc across values most concentrated between 1500 m and 3000 m.

### Dependence of spatial scale on temporal aggregation

The ANOVA test among the spatial patterns of residential burglary based on the temporal scale indicates that changing temporal scale has no significant impacts on the spatial scale of interaction (hc) (Table 3). In other words, the spatial scales of interaction are relatively stable across various temporal scales.

### Summary and discussion Spatial trend of residential burglary and population at risk

Our spatial trend model captured most of the first order intensity of residential burglary and thus served the purpose of separating the global trend and local within pattern variation of residential burglary. As noted, this separation is essential to investigate spatial dependence. For

|Sun|1925|2004|2091|1873|2130|2461|2062|1304|2175|
|---|---|---|---|---|---|---|---|---|---|
|Sat|2724|2340|2682|3007|1557|2399|2851|2861|1304|
|Fri|2204|1908|2481|2596|2892|2958|1423|3024|2599|
|Thu|2282|1812|2748|1539|2286|1546|2197|2503|1321|
|Wed|2159|2034|2849|2952|2210|1869|1951|2829|2086|
|Tue|2770|1892|2348|2151|2787|2550|1545|2893|2051|
|Mon|2411|2932|2951|1705|2448|2840|2734|2621|3015|
|Weekend|2552|2504|2712|2801|2392|2388|2875|2530|2004|
|Weekday|2266|2356|2468|2189|2325|2434|1967|2319|2128|
|Dec|3013|1518|2763|1976|2751|1468|2585|1064|2474|
|Nov|2869|2870|2692|2824|3164|1693|1574|1657|2255|
|Oct|2288|1784|2291|1640|1670|1915|2374|3088|1261|
|Sep|2149|1882|2763|1627|1741|2965|1585|2756|1328|
|Aug|2869|1574|1786|1326|2621|2725|1942|2642|1912|
|Jul|1914|2492|2751|2423|2321|3082|2446|2231|1579|
|Jun|1554|2956|3008|1928|1861|1753|1596|2560|1695|
|May|1852|3083|2178|2895|1769|1567|2507|3208|1514|
|April|984|1691|2275|1124|2488|1297|3056|2237|2494|
|March|2387|2270|2389|2445|2685|1168|692|1979|2198|
|Feb|3101|2008|1401|2916|1824|2845|614|1227|1456|
|Jan|2326|1678|1628|3167|1958|2925|927|1576|2545|
|Winter|2959|1835|2707|2653|2626|2921|1456|1638|2524|
|Fall|2582|2648|2725|1789|2914|2093|2254|2880|1662|
|Summer|2357|2207|2779|2575|2619|2818|2159|2903|2158|
|Spring|1385|2607|2716|2735|2496|1488|2844|2870|2796|
|Annual|1987|2102|2160|1992|2007|2106|2037|1965|1943|
|Year|1994|1995|1996|1997|1998|1999|2000|2001|2002|


|1304|2461|2003|294|
|---|---|---|---|
|1304|3007|2414|566|
|1423|3024|2454|498|
|1321|2748|2026|462|
|1869|2952|2327|402|
|1545|2893|2332|433|
|1705|3015|2629|385|
|2004|2875|2529|245|
|1967|2468|2273|148|
|1064|3013|2179|654|
|1574|3164|2400|582|
|1261|3088|2035|508|
|1328|2965|2088|566|
|1326|2869|2155|533|
|1579|3082|2360|412|
|1554|3008|2101|547|
|1514|3208|2286|622|
|984|3056|1960|675|
|692|2685|2024|622|
|614|3101|1932|812|
|927|3167|2081|678|
|1456|2959|2369|537|
|1662|2914|2394|438|
|2158|2903|2509|279|
|1385|2870|2438|546|
|1943|2160|2033|70|
|min|max|mean|sd|


sd70546279438537678812622675412533566508582654148245385433402462498566294

19941987138523572598418521554191428692149228828693013226625522411277021592282220427241925

19952102260722072669130832956249215741882178428701518235625042932189220341812190823402004

19962160271627792727521783008275117862763229126922763246827122951234828492748248126822091

19971992273525751712428951928242313261627164028241976218928011705215129521539259630071873

19982007249626192948817691861232126211741167031642751232523922448278722102286289215572130

19992106148828182029715671753308227252965191516931468243423882840255018691546295823992461

20002037284421592205625071596244619421585237415742585196728752734154519512197142328512062

20011965287029032823732082560223126422756308816571064231925302621289328292503302428611304

20021943279621581649415141695157919121328126122552474212820043015205120861321259913042175

min19431385215816621456927614692984157913261328126115741064196720041705154518691321142313041304

max216028702903291429593167310126853056308228692965308831643013246828753015289329522748302430072461

mean203324382509239423692081193220241960236021552088203524002179227325292629233223272026245424142003

YearAnnualSpringSummerFalrilMayJunJulAugSepOctNovDecWeekdayWeekendMonTueWedThuFriSatSun

DescriptiveStatistics

hTable2.Thecharacteristicscaleofclustering()forthe234-spatialpointpatterns.c

hhhhNote:Thegranddescriptivestatisticsareasfollows:min()=614;max()=3208;mean()=2243;sd()=546.cccc

https://doi.org/10.1371/journal.pone.0264718.t002

Fig 6. The distribution of the characteristic scale of clustering (hc) across the 234-point patterns. The red vertical line highlights the grand mean of hc (2243 m).

- https://doi.org/10.1371/journal.pone.0264718.g006


Columbus Ohio, compared to mixed parcel/land use, the residential area has a much higher risk of residential burglary as expected. Parcel density, as an indicator of the population at risk, captures the spatial patterns of residential burglary very well.

### Spatial scale of clustering

The characteristic scale of clustering (hc = 2243 m) is the radius of the geographic unit where the spatial variation of the residential burglary is captured. For a given residential burglary

###### Table 3. ANOVA test for the characteristic scale of clustering among the spatial point patterns based on temporalaggregations.

| |Df|Sum Sq|Mean Sq|F value|Pr (>F)|
|---|---|---|---|---|---|
|Characteristic scale of clustering|25|9048921|361957|1.239|0.209|
|Residuals|208|60781093|292217| | |


- https://doi.org/10.1371/journal.pone.0264718.t003


- Table 4. Descriptive statistics of the equivalent radius for zip code, community, neighborhood, census tract, and the characteristic scale of clustering (hc) in the study area.


|Geographic Unit|No. of Units|Radius|Radius|Radius|Radius|Radius|
|---|---|---|---|---|---|---|
|Geographic Unit|No. of Units|Min|Max|Median|Mean|SD|
|Zip code|21|1029|4472|2007|2290|1000|
|Community|35|336|3698|1730|1776|1074|
|Neighborhood|163|338|2734|859|911|376|
|Census tract|179|136|2142|748|829|354|
|hc|234|614|3208|2286|2243|547|


Represents the number of spatial scales, i.e., 234 spatial point patterns. The equivalent radius is calculated as

p

ffiffiffiffiffiffiffiffiffiffiffiffiffiffi area=p

, i.e., the radius of the equivalent circles.

- https://doi.org/10.1371/journal.pone.0264718.t004


event, the chance of finding another residential burglary event within 2243 meters is higher than beyond 2243 meters. We compared the characteristic scale of clustering with the equivalent radius of four geographic units in the study area: census tracts, neighborhoods, communities, and zip codes (Table 4). The average sizes of the equivalent radius for census tracts and neighborhoods are 829 meters and 911 meters, respectively, which are less than half the characteristic scale of clustering (2243 meters). The average of the equivalent radius for zip codes (2290 meters) is the closest to the characteristic scale of clustering. However, the spread distribution shows that the radius of the zip code is positively skewed with the maximum of 4472 meters, resulting in several units that are much larger than the average of the characteristic scale of clustering (Fig 7(E)). This can result in overestimating the geographic area of the processes of residential burglary and the cluster of residential burglary, as will be discussed later in this section.

Fig 7. The boundaries and radius distribution for four area units: zip codes (a and e), communities (b and f), neighborhoods (c and g), and census tracts (d and h). For the boundaries of communities and zip codes, we included only the units that most of their areas fall within the study area and excluded those that most boundaries extend beyond the study area.

https://doi.org/10.1371/journal.pone.0264718.g007

Fig 8. The configuration of communities and neighborhoods in the study area. https://doi.org/10.1371/journal.pone.0264718.g008

The characteristic scale of clustering reflects, to a large extent, the size and distribution of commonly understood communities in the study area (Table 4, and Fig 7(F)), which are composed of several neighborhoods and used by the city of Columbus for planning and reporting purposes (Fig 8). The community units have the mean and medium equivalent radius of 1776 meters and 1730 meters, respectively, with the maximum radius of 3698 meters, which is the closest to the maximum characteristic scale of clustering (3208 meters). As shown in (Fig 7 (F)), the radius for 83% of the community units are equal to or less than the average characteristic scale of clustering, and the radius for the rest of the units fall within the range of the characteristic scale of clustering, suggesting the community unit is the most suitable unit of analysis among the other geographic units.

Our empirical, inductive approach yields useful information to help guide conventional analyses of crime rates in urban communities. For areal data analysis, crime data are commonly aggregated into areal units so that crime rates for these units can be correlated with social-economic factors. One important consideration for the selection of the size of such areal units is that they conform to the area defined by the characteristic scale of clustering.

- 1. If analysts choose an areal unit larger than ph2c, they would be aggregating significant clusters with non-clustered areas, i.e., smoothing residential burglary rates, leading to the loss of information.
- 2. If they choose an areal unit smaller than ph2c, there is chance of dividing a significant cluster into multiple area units.


Given that the clusters do not necessarily coincide with areal units, there is always the chance of dividing significant clusters into multiple areal units even when choosing one with size equal to ph2c. This is not particularly problematic because each areal unit tends to be homogeneous, without the loss of information. In other words, analysts are on solid ground when implementing an areal unit that comes as close to our criterion given the available data. For the residential burglary of Columbus, ph2c ¼ 15:8 km2, which is about the mean size of communities in the study area. These results suggest that the community is a geographic unit that is particularly well suited for the spatial analysis of residential burglary in Columbus.

### Impact of temporal scale on the spatial scale of interaction

We found no significant impact of temporal aggregation on the spatial scale of interaction. Changing the temporal aggregation level could result in a changing frequency of crime or a different spatial pattern in terms of location. However, the results indicate that the spatial scale and geographic level of significant–clustered pattern (the size of that spatial pattern) does not depend on the temporal scale. This stability across various temporal scales suggests strong social or spatial processes that operate within that range of spatial scales. It is important to mention that the large variation in the number of crime incidents across the 234-point patterns (mean = 1735, standard deviation = 1919, see S1 Table in the Supplementary Data for details) does not necessarily impact the values of the characteristic scale of clustering (hc).

Our results regarding the independence of the spatial scale with respect to the temporal scale are consistent with previous spatio-temporal studies where spatial dependence is more significant and has a larger influence on crime patterns than spatio-temporal interaction [83,84]. It also implies that police officials need not be concerned about shifting sizes of riskareas with the time of the year.

### Further implications

Our paper addresses the well-known Modifiable Areal Unit Problem (MAUP), whereby different boundaries and spatial scales result in different visual representations and hot spots of crime [85]. As shown in previous studies [86], burglary is related to both neighborhood-level and target-level attributes. The MAUP is a potential concern for researchers who are interested in causal studies of crime (e.g., residential burglary here) and the effects of explanatory variables [87]. Thus, this paper provides a preliminary attempt and framework that can help researchers deal with the issue of geographic aggregation level.

Another implication is related to the issue of using fixed pre-existing geographic units with non-overlapping boundaries as the units of analysis. Lee and colleagues [88,89] argued that such geographic units (e.g., census tracts) do not reflect the actual area for the

community concept (e.g., neighborhood) or the spatial environment of criminogenic processes. They therefore proposed a tract-free approach across egocentric local environments of varying size (radius). Hipp and colleagues [12,90] similarly argued that neighborhoods defined based on nonoverlapping boundaries (such as block groups or tracts) are fundamentally flawed in investigating the spatial processes of crime. They proposed a new definition of neighborhoods labelled “egohoods”, which are conceptualized as waves washing across the surface of cities using overlapping boundaries. The new measures proposed by Lee, Hipp and colleagues [12,88–90] used (weighted) averages of data within circles of various radii centered on the target block. The characteristic scale of clustering hc derived using our method might serve as a promising candidate for the radius put forth by Lee, Hipp and colleagues.

Moreover, our approach provides important information to those who conduct hot spot analyses, especially those involving bandwidth selection such as in kernel density estimation, where the characteristic scale of clustering can be used to facilitate the determination of the bandwidth. Our study can be combined with hot spot analyses to help effective policing: Our method reveals the characteristic scale of clusters, while the hot spot analyses reveal the location of clusters. The characteristic scale of clustering (hc) also complements the hot spot policing strategy by serving as a radius search for residential burglary hot spots. For the case of residential burglary in Columbus, Ohio, our results can guide police agencies in their efforts to control and prevent residential burglary by extending their interventions to 2.2 km from the highly focused spots of residential burglary.

Our study also supports previous research in geographic profiling that has documented processes underlying target selection for residential burglary. Summers et al. [91] found that burglars have a consistent pattern of semi-radial movement in different directions from their home. The characteristic scale of clustering in our study may represent such a radius of the circle wherein burglars commute to commit burglaries. Our results for the characteristic scale of clustering (2.2 km) in residential burglary is comparable to the travel distances of burglars revealed in previous studies, such as 2.6 km in Rhodes & Conley [92], 2.8 km in White [93], 2.6-3km in Wiles & Costello [94]. Similarly, in a study of burglary in the Hague, the Netherlands, Bernasco [95] found that the majority (about 90%) of the solitary burglars travel a distance of 1–4 km to commit crime, with an estimated mean of 2.6 km.

Our analytic framework can be used to address MAUP by a wide range of applications that use areal units for spatial analysis, such as disease outbreak, public health issues, and health inequalities [96,97], environmental risk analysis [98], social and population analysis [99], spatial politics analysis [100]. Moreover, the framework can be used to address the Modifiable Temporal Unit Problem (MTUP) that is associated with MAUP [101,102].

### Limitations and future study

Our spatial trend model (Eq 5) mainly relies on the population at risk (parcels) and the polygons that determine the residential areas (dummy variable). This model can be improved to capture more accurately the first order effects (intensity of residential burglary) by including more covariates that contribute to the large-scale variation of residential burglary.

Although our findings provide valuable insight about the spatial pattern of residential burglary and the selection of an appropriate spatial scale of analysis, the theoretical rationale and social spatial processes that generate such spatial patterns are not clear. In addition, the appropriate scale presented here applies to residential burglary in Columbus, Ohio. It may vary across different offenses and differ for different cities. Thus, one potential and useful extension of this study is to apply the basic analytic framework to different types of crime across different

cities. This comparison can help develop a theoretical framework that can explain the variation or uniformity of spatial patterns for different types of crime. In the case where the appropriate scale resulting from point pattern analysis does not overlay well with census units, area based interpolation can be applied to generate areal data at the appropriate scale [103–105].

It is also important to investigate the possible presence of micro space-time interaction that can change the location of clusters over time. This stability or instability of cluster locations reveal how long the crime clusters persist at the determined spatial scale of analysis, which has important implications for deploying resources from the police force.

### Conclusion

In this study, we applied spatial point pattern analysis to characterize the within pattern interaction of residential burglary incidents and its dependence on temporal variability. The inhomogeneous L functions was used to determine the characteristic scale of clustering, which can serve to identify a reasonable spatial scale of analysis. Residential burglary mostly clusters at a spatial scale of 15.8 km2, which is about the size of communities in our study area. This finding suggests that the community is well suited for spatial analysis of residential burglary in Columbus, Ohio. We found no significant variation of the spatial scales of clustering for spatial patterns aggregated at different temporal scales. Thus, it is reasonable to use a yearly temporal aggregation level for spatial analyses of residential burglary.

Overall, we call attention to two main implications from this study. First, it has policy implications given that the characteristic scale of clustering can be used to define the spatial boundary for place-based policing. Second, it can lay the foundation for theoretical explanations of the social processes that operate within the characteristic scale of clustering. In areal data analysis of crime risk, we suggest that crime data and socioeconomic factors be aggregated at a spatial scale that comes close to our criterion given the available data.

### Supporting information

- S1 Table. Counts (number of incidents) and distances (km) between residential burglary incidents for all the 234 point patterns. (DOCX)
- S2 Table. Li and hi for Fig 3: h0 hi hr, h0 = 519.5, hr = 3247.2. (DOCX)


S1 Data. (ZIP)

### Acknowledgments

We gratefully acknowledge the Columbus Division of Police, Lauren J. Krivo, Desheng Liu for crime data and Chao Ma for help with data preprocessing.

### Author Contributions

Conceptualization: Mohammed A. Alazawi, Shiguo Jiang, Steven F. Messner. Data curation: Shiguo Jiang. Formal analysis: Mohammed A. Alazawi, Shiguo Jiang. Funding acquisition: Shiguo Jiang.

Investigation: Shiguo Jiang. Methodology: Mohammed A. Alazawi, Shiguo Jiang. Software: Mohammed A. Alazawi. Supervision: Shiguo Jiang. Writing – original draft: Mohammed A. Alazawi, Shiguo Jiang, Steven F. Messner. Writing – review & editing: Mohammed A. Alazawi, Shiguo Jiang, Steven F. Messner.

### References

- 1. Weisburd D. The law of crime concentration and the criminology of place. Criminology. 2015; 53: 133–

157. https://doi.org/10.1111/1745-9125.12070

- 2. Ackerman WV, Murray AT. Assessing spatial patterns of crime in Lima, Ohio. Cities. 2004; 21: 423–

437. https://doi.org/10.1016/j.cities.2004.07.008

- 3. Andresen MA, Malleson N. Spatial heterogeneity in crime analysis. In: Leitner M, Leitner M, editors. Crime Modeling and Mapping Using Geospatial Technologies. Dordrecht; 2013. pp. 3–23. https://doi. org/10.1007/978-94-007-4997-9_1
- 4. Boessen A, Hipp JR. Close-ups and the scale of ecology: land uses and the geography of social context and crime. Criminology. 2015; 53: 399–426.
- 5. Brantingham PJ, Dyreson DA, Brantingham PL. Crime seen through a cone of resolution. Am Behav Sci. 1976; 20: 261–273.
- 6. Gehlke CE, Biehl K. Certain effects of grouping upon the size of the correlation coefficient in census tract material. J Am Stat Assoc. 1934; 29: 169–170.
- 7. Openshaw S. The Modifiable Areal Unit Problem. Norwich, England: Geo Books; 1984.
- 8. Ratcliffe J. Crime mapping: Spatial and temporal challenges. In: Piquero AR, Weisburd D, editors. Handbook of Quantitative Criminology. New York, NY: Springer New York; 2010. pp. 5–24. https:// doi.org/10.1007/978-0-387-77650-7_2
- 9. Robinson WS. Ecological correlations and the behavior of individuals. Am Sociol Rev. 1950; 15: 351–

357. https://doi.org/10.2307/2087176

- 10. Diez-Roux AV. Bringing context back into epidemiology: Variables and fallacies in multilevel analysis. Am J Public Health. 1998; 88: 216–222. https://doi.org/10.2105/ajph.88.2.216 PMID: 9491010
- 11. Susser M. Causal Thinking in the Health Sciences. New York: Oxford University Press; 1973.
- 12. Hipp JR, Boessen A. Egohoods as waves washing across the city: A new measure of “neighborhoods.” Criminology. 2013; 51: 287–327. https://doi.org/10.1111/1745-9125.12006
- 13. He L, Paez R, Liu D, Jiang S. Temporal stability of model parameters in crime rate analysis: An empirical examination. Appl Geogr. 2015; 58: 141–152.
- 14. Andresen MA, Malleson N. Crime seasonality and its variations across space. Appl Geogr. 2013; 43: 25–35. https://doi.org/10.1016/j.apgeog.2013.06.007
- 15. Linning SJ, Andresen MA, Brantingham PJ. Crime seasonality: Examining the temporal fluctuations of property crime in cities with varying climates. Int J Offender Ther Comp Criminol. 2017; 61: 1866–

1891. https://doi.org/10.1177/0306624X16632259 PMID: 26987973

- 16. McDowall D, Loftin C, Pate M. Seasonal cycles in crime, and their variability. J Quant Criminol. 2012; 28: 389–410. https://doi.org/10.1007/s10940-011-9145-7
- 17. Short MB, D’Orsogna MR, Brantingham PJ, Tita GE. Measuring and modeling repeat and near-repeat burglary effects. J Quant Criminol. 2009; 25: 325–339. https://doi.org/10.1007/s10940-009-9068-8
- 18. Townsley M, Homel R, Chaseling J. Repeat burglary victimisation: Spatial and temporal patterns. Aust N Z J Criminol. 2000; 33: 37–63. https://doi.org/10.1177/000486580003300104
- 19. Townsley M, Homel R, Chaseling J. Infectious burglaries: A test of the near repeat hypothesis. Br J Criminol. 2003; 43: 615–633.
- 20. D’Alessio SJ, Eitle D, Stolzenberg L. Unemployment, guardianship, and weekday residential burglary. Justice Q. 2012; 29: 919–932. https://doi.org/10.1080/07418825.2011.605073
- 21. Sagovsky A, Johnson SD. When does repeat burglary victimisation occur? Aust N Z J Criminol. 2007; 40: 1–26. https://doi.org/10.1375/acri.40.1.1


- 22. Chimbos PD. A study of breaking and entering offences in “Northern City”, Ontario. Can J Criminol Correct. 1973; 15: 316–325.
- 23. Cohn EG, Rotton J. Weather, seasonal trends and property crimes in Minneapolis, 1987–1988. J Environ Psychol. 2000; 20: 257–272. https://doi.org/10.1006/jevp.1999.0157
- 24. Farrell G, Pease K. Crime seasonality: Domestic disputes and residential burglary in Merseyside 1988–90. Br J Criminol. 1994; 34: 487–498.
- 25. Hipp JR, Curran PJ, Bollen KA, Bauer DJ. Crimes of opportunity or crimes of emotion? Testing two explanations of seasonal change in crime. Soc Forces. 2004; 82: 1333–1372.
- 26. Pease K. Repeat Victimisation: Taking Stock. London: Home Office Police Research Group; 1998. Available: http://books.google.com/books?id=QxLZAAAAIAAJ.
- 27. Polvi N, Looman T, Humphries C, Pease K. The time course of repeat burglary victimization. Br J Criminol. 1991; 31: 411–414.
- 28. Wang Z, Liu X. Analysis of burglary hot spots and near-repeat victimization in a large Chinese city. ISPRS Int J Geo-Inf. 2017; 6: 148. https://doi.org/10.3390/ijgi6050148
- 29. Wickes R, Zahnow R, Shaefer L, Sparkes-Carroll M. Neighborhood guardianship and property crime victimization. Crime Delinquency. 2017; 63: 519–544. https://doi.org/10.1177/0011128716655817
- 30. Steenbeek W, Weisburd D. Where the action is in crime? An examination of variability of crime across different spatial units in the hague, 2001–2009. J Quant Criminol. 2016; 32: 449–469. https://doi.org/ 10.1007/s10940-015-9276-3
- 31. Schnell C, Braga AA, Piza EL. The influence of community areas, neighborhood clusters, and street segments on the spatial variability of violent crime in chicago. J Quant Criminol. 2017; 33: 469–496. https://doi.org/10.1007/s10940-016-9313-x
- 32. O’Brien DT. The action is everywhere, but greater at more localized spatial scales: Comparing concentrations of crime across addresses, streets, and neighborhoods. J Res Crime Delinquency. 2019; 56: 339–377. https://doi.org/10.1177/0022427818806040
- 33. Groff E, Weisburd D, Morris NA. Where the action is at places: examining spatio-temporal patterns of juvenile crime at places using trajectory analysis and GIS. Putting crime in its place. Springer;

2009. pp. 61–86. https://doi.org/10.1007/978-0-387-09688-9_3

- 34. Oberwittler D, Wikstro¨m P-OH. Why small is better: advancing the study of the role of behavioral contexts in crime causation. In: Weisburd D, Bernasco W, Bruinsma GJN, editors. Putting Crime in Its Place. New York, NY: Springer New York; 2009. pp. 35–59. https://doi.org/10.1007/978-0-38709688-9_2
- 35. Weisburd D, Groff E, Yang S-M. The criminology of place: street segments and our understanding of the crime problem. Oxford; New York: Oxford University Press; 2012. https://doi.org/10.1126/ science.1227919 PMID: 23180859
- 36. Gerell M. Smallest is better? The spatial distribution of arson and the Modifiable Areal Unit Problem. J Quant Criminol. 2017; 33: 293–318. https://doi.org/10.1007/s10940-016-9297-6
- 37. Vandeviver C, Steenbeek W. The (in)stability of residential burglary patterns on street segments: The case of Antwerp, Belgium 2005–2016. J Quant Criminol. 2019; 35: 111–133. https://doi.org/10.1007/ s10940-017-9371-8
- 38. Malleson N, Steenbeek W, Andresen MA. Identifying the appropriate spatial resolution for the analysis of crime patterns. Koukoulas S, editor. PLOS ONE. 2019; 14: e0218324. https://doi.org/10.1371/ journal.pone.0218324 PMID: 31242224
- 39. Ramos RG, Silva BFA, Clarke KC, Prates M. Too fine to be good? Issues of granularity, uniformity and error in spatial crime analysis. J Quant Criminol. 2020 [cited 21 Jan 2021]. https://doi.org/10.1007/ s10940-020-09474-6
- 40. Lagache T, Lang G, Sauvonnet N, Olivo-Marin J-C. Analysis of the Spatial Organization of Molecules with Robust Statistics. Rappoport JZ, editor. PLoS ONE. 2013; 8: e80914. https://doi.org/10.1371/ journal.pone.0080914 PMID: 24349021
- 41. Amgad M, Itoh A, Tsui MMK. Extending Ripley’s K-Function to quantify aggregation in 2-D grayscale images. Vorberg IM, editor. PLOS ONE. 2015; 10: e0144404. https://doi.org/10.1371/journal.pone. 0144404 PMID: 26636680
- 42. Prior IA, Muncke C, Parton RG, Hancock JF. Direct visualization of Ras proteins in spatially distinct cell surface microdomains. J Cell Biol. 2003; 160: 165–170. https://doi.org/10.1083/jcb.200209091 PMID: 12527752
- 43. Parton R. Lipid rafts and plasma membrane microorganization: insights from Ras. Trends Cell Biol. 2004; 14: 141–147. https://doi.org/10.1016/j.tcb.2004.02.001 PMID: 15003623


- 44. Kiskowski MA, Hancock JF, Kenworthy AK. On the use of Ripley’s K-function and its derivatives to analyze domain size. Biophys J. 2009; 97: 1095–1103. https://doi.org/10.1016/j.bpj.2009.05.039 PMID: 19686657
- 45. Hess ST, Kumar M, Verma A, Farrington J, Kenworthy A, Zimmerberg J. Quantitative electron microscopy and fluorescence spectroscopy of the membrane distribution of influenza hemagglutinin. J Cell Biol. 2005; 169: 965–976. https://doi.org/10.1083/jcb.200412058 PMID: 15967815
- 46. Peterson CJ, Squiers ER. An unexpected change in spatial pattern across 10 years in an aspen-white pine forest. J Ecol. 1995; 83: 847–855. https://doi.org/10.2307/2261421
- 47. Brown J. Social support and crime: A state-level analysis of social support policies. J Sociol Soc Welf. 2016; 43: 135–156.
- 48. Liebertz S, Bunch J. Examining the externalities of welfare reform: TANF and crime. Justice Q. 2018; 35: 477–504. https://doi.org/10.1080/07418825.2017.1323113
- 49. Messner SF, Rosenfeld R. Crime and the American Dream. Belmont, California: Wadsworth; 1994.
- 50. Sherman LW, Weisburd D. General deterrent effects of police patrol in crime “hot spots”: A randomized, controlled trial. Justice Q. 1995; 12: 625–648.
- 51. Braga AA, Papachristos A, Hureau D. Hot spots policing effects on crime. Campbell Syst Rev. 2012; 8: 1–96. https://doi.org/10.4073/csr.2012.8
- 52. Braga AA, Turchan B, Papachristos AV, Hureau DM. Hot spots policing of small geographic areas effects on crime. Campbell Syst Rev. 2019; 15: e1046. https://doi.org/10.1002/cl2.1046
- 53. Braga AA. Hot spots policing: Theoretical perspectives, scientific evidence, and proper implementation. In: Teasdale B, Bradley MS, editors. Preventing Crime and Violence. Cham: Springer; 2017. pp. 269–279. https://doi.org/10.1007/978-3-319-44124-5_23
- 54. Weisburd D, Braga AA, Groff ER, Wooditch A. Can hot spots policing reduce crime in urban areas? An agent-based simulation. Criminology. 2017; 55: 137–173.
- 55. Weisburd D. Hot spots of crime and place-based prevention. Criminol Public Policy. 2018; 17: 5–25. https://doi.org/10.1111/1745-9133.12350
- 56. Haase P. Spatial pattern analysis in ecology based on Ripley’s K-function: Introduction and methods of edge correction. J Veg Sci. 1995; 6: 575–582.
- 57. Ripley BD. Modelling spatial patterns (with discussion). J R Stat Soc Ser B Methodol. 1977; 39: 172– 212.
- 58. Ripley BD, Ranneby B. Edge effects in spatial stochastic processes. Statistics in Theory and Practice: Essays in Honour of Bertil Mate´rn. Swedish University of Agricultural Sciences, Section of Forest Biometry; 1982. pp. 247–262. Available: https://illiad-albany-edu.libproxy.albany.edu/illiad/illiad.dll? Action=10&Form=75&Value=919147.
- 59. Ratcliffe JH. Geocoding crime and a first estimate of a minimum acceptable hit rate. Int J Geogr Inf Sci. 2004; 18: 61–72. https://doi.org/10.1080/13658810310001596076
- 60. Valmor88. Neighborhoods of Columbus. From Google My Maps: https://www.google.com/maps/d/ viewer?mid=1ZyLio1JNf9oil4nNLbVudqEyWeA. Accessed 7 September 2021. 2015. Available: https://www.google.com/maps/d/viewer?mid=1ZyLio1JNf9oil4nNLbVudqEyWeA.
- 61. City of Columbus Department of Technology. Columbus Communities, Open Data: https://opendata. columbus.gov/datasets/columbus-communities, Accessed 7 September 2021. 2019.
- 62. Ripley BD. The second-order analysis of stationary point processes. J Appl Probab. 1976; 13: 255–

266. https://doi.org/10.1017/S0021900200094328

- 63. Kalantari M, Yaghmaei B, Ghezelbash S. Spatio-temporal analysis of crime by developing a method to detect critical distances for the Knox test. Int J Geogr Inf Sci. 2016; 30: 2302–2320. https://doi.org/10. 1080/13658816.2016.1174867
- 64. Wooditch A, Weisburd D. Using space-time analysis to evaluate criminal justice programs: An application to stop-question-frisk practices. J Quant Criminol. 2016; 32: 191–213. https://doi.org/10.1007/ s10940-015-9259-4
- 65. Ye X, Xu X, Lee J, Zhu X, Wu L. Space–time interaction of residential burglaries in Wuhan, China. Appl Geogr. 2015; 60: 210–216. https://doi.org/10.1016/j.apgeog.2014.11.022
- 66. Bailey TC, Gatrell AC. Interactive Spatial Data Analysis. Longman Scientific & Technical Essex; 1995.
- 67. Diggle PJ, Go´mez-Rubio V, Brown PE, Chetwynd AG, Gooding S. Second-order analysis of inhomogeneous spatial point processes using case-control data. Biometrics. 2007; 63: 550–557. https://doi. org/10.1111/j.1541-0420.2006.00683.x PMID: 17688507
- 68. Illian J, Penttinen A, Stoyan H, Stoyan D. Statistical Analysis and Modelling of Spatial Point Patterns. 1314: John Wiley & Sons; 2008.


- 69. Cressie N. Statistics for Spatial Data. John Wiley & Sons; 2015.
- 70. Diggle PJ, Barnett V, Turkman KF. Point process modelling in environmental epidemiology. In: Barnett V, Turkman KF, editors. Statistics for the Environment. New York: John Wiley & Sons; 1993. pp. 89–

110. https://doi.org/10.1006/geno.1993.1392 PMID: 8244387

- 71. Baddeley AJ, Møller J, Waagepetersen R. Non- and semi-parametric estimation of interaction in inhomogeneous point patterns. Stat Neerlandica. 2000; 54: 329–350. https://doi.org/10.1111/1467-9574. 00144
- 72. Bartlett M. 207. note: A note on spatial pattern. Biometrics. 1964; 20: 891–892.
- 73. Baddeley A, Rubak E, Turner R. Spatial Point Patterns: Methodology and Applications with R. CRC Press; 2015.
- 74. Liu D, Kelly M, Gong P, Guo Q. Characterizing spatial–temporal tree mortality patterns associated with a new forest disease. For Ecol Manag. 2007; 253: 220–231. https://doi.org/10.1016/j.foreco. 2007.07.020
- 75. Besag JE. Contribution to the discussion on Dr. Ripley’s paper. J R Stat Soc Ser B. 1977; 39: 193– 195.
- 76. Kenkel NC. Pattern of self-thinning in jack pine: Testing the random mortality hypothesis. Ecology. 1988; 69: 1017–1024. https://doi.org/10.2307/1941257
- 77. Besag J, Clifford P. Generalized Monte Carlo significance tests. Biometrika. 1989; 76: 633–642. https://doi.org/10.2307/2336623
- 78. Besag J, Diggle PJ. Simple Monte Carlo tests for spatial pattern. Appl Stat. 1977; 26: 327–333. https:// doi.org/10.2307/2346974
- 79. Ripley BD. Statistical Inference for Spatial Processes. Cambridge: Cambridge University Press;

1988. https://doi.org/10.1017/CBO9780511624131

- 80. Diggle PJ. A kernel method for smoothing point process data. J R Stat Soc Ser C Appl Stat. 1985; 34: 138–147. https://doi.org/10.2307/2347366
- 81. Silverman BW. Density Estimation for Statistics and Data Analysis. CRC Press; 1986.
- 82. R Core Team. R: A language and environment for statistical computing. Vienna, Austria: R Foundation for Statistical Computing; 2021. Available: https://www.R-project.org.
- 83. Law J, Quick M, Chan P. Bayesian spatio-temporal modeling for analysing local patterns of crime over time at the small-area level. J Quant Criminol. 2014; 30: 57–78. https://doi.org/10.1007/s10940-0139194-1
- 84. Law J, Quick M, Chan PW. Analyzing hotspots of crime using a Bayesian spatiotemporal modeling approach: A case study of violent crime in the greater Toronto area. Geogr Anal. 2015; 47: 1–19. https://doi.org/10.1111/gean.12047
- 85. Chainey S, Ratcliffe J. GIS and Crime Mapping. John Wiley & Sons; 2013.
- 86. Vandeviver C, Bernasco W. “Location, location, location”: Effects of neighborhood and house attributes on burglars’ target selection. J Quant Criminol. 2019 [cited 15 Jan 2020]. https://doi.org/10. 1007/s10940-019-09431-y
- 87. Hipp JR. Block, tract, and levels of aggregation: Neighborhood structure and crime and disorder as a case in point. Am Sociol Rev. 2007; 72: 659–680.
- 88. Lee BA, Reardon SF, Firebaugh G, Farrell CR, Matthews SA, O’Sullivan D. Beyond the Census Tract: Patterns and Determinants of Racial Segregation at Multiple Geographic Scales. Am Sociol Rev. 2008; 73: 766–791. https://doi.org/10.1177/000312240807300504 PMID: 25324575
- 89. Lee BA, Farrell CR, Reardon SF, Matthews SA. From Census Tracts to Local Environments: An Egocentric Approach to Neighborhood Racial Change. Spat Demogr. 2019; 7: 1–26. https://doi.org/10. 1007/s40980-018-0044-5 PMID: 31223641
- 90. Hipp JR, Bates CJ. Egohoods: Capturing Change in Spatial Crime Patterns. In: Bruinsma GJN, Johnson SD, editors. The Oxford Handbook of Environmental Criminology. New York, NY: Oxford University Press; 2018. pp. 424–452.
- 91. Summers L, Johnson SD, Rengert GF. The use of maps in offender interviewing. In: Bernasco W, editor. Offenders on Offending: Learning about Crime from Criminals. Willan; 2010. pp. 246–272.
- 92. Rhodes WM, Conley C. Crime and mobility: An empirical study. In: Brantingham PJ, Brantingham PL, Brantingham PJ, Brantingham PL, editors. Environmental Criminology. London; 1981. pp. 167–188.
- 93. White RC. The relation of felonies to environmental factors in indianapolis. Soc Forces. 1932; 10: 498–509. https://doi.org/10.2307/2569897
- 94. Wiles P, Costello A. The “Road to Nowhere”: The Evidence for Travelling Criminals. Home Office London; 2000.


- 95. Bernasco W. Co-offending and the choice of target areas in burglary. J Investig Psychol Offender Profiling. 2006; 3: 139–155. https://doi.org/10.1002/jip.49
- 96. Dorling D, Mitchell R, Orford S, Shaw M, Tunstall H. Health Inequalities. In: Kitchin R, Thrift N, editors. International Encyclopedia of Human Geography. Oxford: Elsevier; 2009. pp. 46–50.
- 97. Keeler C, Emch M. Geographic Information Systems (GIS) in Public Health. In: Quah SR, editor. International Encyclopedia of Public Health. Oxford: Academic Press; 2016.
- 98. Su M, Lin M-C, Wen T. Spatial mapping and environmental risk identification. Encyclopedia of Environmental Health. Burlington: Elsevier; 2011. pp. 228–235.
- 99. Xie Z, Ziegler H. Mapping urban population at housing unit level with integrated geospatial technology. In: Liang S, editor. Comprehensive Remote Sensing. Oxford: Elsevier; 2018. pp. 67–75.
- 100. Hui I, Cho WKT. Spatial dimensions of American politics. Compr Geogr Inf Syst. 2017.
- 101. C¸ o¨ltekin A, De Sabbata S, Willi C, Vontobel I, Pfister S, Kuhn M, et al. Modifiable temporal unit problem. ICC2011 Workshop. Paris, FR: University of Zurich; 2011.
- 102. Cheng T, Adepeju M. Modifiable temporal unit problem (MTUP) and its effect on space-time cluster detection. Preis T, editor. PLoS ONE. 2014; 9: e100465. https://doi.org/10.1371/journal.pone. 0100465 PMID: 24971885
- 103. Goodchild MF, Anselin L, Deichmann U. A framework for the areal interpolation of socioeconomic data. Environ Plan A. 1993; 25: 383–397.
- 104. Schroeder JP. Target-density weighting interpolation and uncertainty evaluation for temporal analysis of census data. Geogr Anal. 2007; 39: 311–335. https://doi.org/10.1111/j.1538-4632.2007.00706.x
- 105. Mennis J. Dasymetric mapping for estimating population in small areas. Geogr Compass. 2009; 3: 727–745. https://doi.org/10.1111/j.1749-8198.2009.00220.x


