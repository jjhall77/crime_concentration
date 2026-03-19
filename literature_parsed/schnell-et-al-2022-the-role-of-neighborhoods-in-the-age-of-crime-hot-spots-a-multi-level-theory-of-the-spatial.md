###### 1140836CADXXX10.1177/00111287221140836Crime & DelinquencySchnell et al.

| | | |
|---|---|---|
| | | |


Article

# The Role of Neighborhoods in the Age of Crime Hot Spots: A Multi-Level Theory of the Spatial Distribution of Robbery in Chicago

Crime & Delinquency 2024, Vol. 70(11) 2855–2881

© The Author(s) 2022 Article reuse guidelines:

sagepub.com/journals-permissions DOI: 10.1177/00111287221140836 journals.sagepub.com/home/cad

https://doi.org/10.1177/00111287221140836

## Cory Schnell1 , Samuel E. DeWitt2, and M. Dylan Spencer3

#### Abstract

This study observes the spatial distribution of robbery using a multi-level framework to further understand the unique contribution of both microplaces and neighborhoods to the spatial variability of crime patterns. Mixedeffects regression models were estimated to determine if the influence of spatial interdependence measured with a spatial lag variable at street segments had a random effect between Chicago’s community areas. The variance parameters guided an exploratory spatial data analysis which revealed clusters of robbery patterns which were larger than crime hot spots and often nested within neighborhoods. We found there is an important distinction between places in Chicago where the spatial transmissibility of robberies is most acutely experienced across entire neighborhoods or within the immediate proximity of certain micro-places.

- 1University of South Carolina, Columbia, USA
- 2University of North Carolina—Charlotte, USA 3South Dakota State University, Brookings, USA


Corresponding Author: Cory Schnell, Department of Criminology and Criminal Justice, University of South Carolina, 1305 Greene Street, Columbia, SC 29208, USA. Email: schnellc@mailbox.sc.edu

Keywords crime and place, multi-level models, micro-places, neighborhoods, crime mapping

## Introduction

Neighborhoods and micro-places have emerged as the two predominant spatial units of analysis used to understand crime variation within cities. Multilevel conceptual models provide a malleable framework to support the integration of these disparate approaches for a more comprehensive ecological account of crime variation (Wilcox et al., 2003). These models often propose the use of neighborhood effects to represent the “environmental backcloth” or broader contextual factors which can influence criminal opportunity at micro-places (see Deryol et al., 2016). For example, the micro-level impact of crime attractor facilities like bars or liquor stores can have different effects on spatial crime patterns based upon the structural characteristics (e.g., concentrated disadvantage) of the neighborhood they are nested within (see Tillyer et al., 2021). Due to the focus of these studies on deductive theoretical integration (see Jones & Pridemore, 2019), they rarely devote much attention to the underlying spatial variability of crime across these units of analysis. Specifically, if there are unique patterns in the spatial distribution of crime at micro-places between neighborhoods (see O’Brien et al., 2022).

As a result, there is less descriptive research which estimates multi-level models to compare the unique influence of both micro-places and neighborhoods to understanding the spatial distribution of crime within cities (see Hipp et al., 2020; O’Brien & Winship, 2017; Steenbeek & Weisburd, 2016). These descriptive studies often partition or decompose hierarchical spatial variance finding micro-places provide the largest contribution to the overall variability of crime patterns with neighborhoods still capturing modest amounts of variation. Steenbeek and Weisburd (2016) observed that around two-thirds of the total spatial variability of crime incidents was accounted for by micro-places and the remaining one-third by different meso- and macrospatial units which generally approximate neighborhoods. Beyond assigning a percent contribution to each level of spatial aggregation, these descriptive studies do not provide an inductive theoretical understanding of how these units of analysis collectively influence the spatial distribution of crime patterns. In other words, what is the specific role of both micro-places and neighborhoods in conveying where crimes occur within cities? Our study addresses this issue by expanding upon these analyses to contribute a new theory of the multi-level spatial distribution of robbery between micro-places and neighborhoods.

First, we estimated mixed-effects negative binomial regression models to determine if the degree of spatial interdependence of robberies measured with micro-spatial lags varies between neighborhoods in Chicago. Spatial interdependence or the impact of contiguous locations on crime provides an underlying measurement of clustering. Second, we conduct exploratory spatial data analysis using the variance parameters from these mixed-effects models to examine if the spatial composition of robbery patterns at microplaces varies within and between neighborhoods. We then present crime maps that help to translate these findings into a more intuitive format and permit a new classification of spatial crime patterns. Our findings show considerable spatial variability between micro-places but also larger formations of robbery patterns which exceed what would be traditionally considered a crime hot spot. We explore the implications of these patterns and how they may allow researchers to further clarify the theoretical contribution of neighborhoods and reframe the utility of these units of analysis in the age of crime hot spots. In general, micro-places provide granular building blocks to capture spatial variability and neighborhoods a helpful domain to organize the higher-order arrangement of crime patterns. Both units of analysis are essential for telling the complete story of where crime happens within cities. These findings provide further empirical support for multi-level frameworks and demonstrate the consideration of only one of these units of analysis could offer a misleading portrait of spatial crime patterns.

## Multi-Level Description

A multi-level conceptual framework presents a logical solution to address concerns regarding the selection of spatial units of analysis in place-based criminology. The representation of different levels of spatial aggregation is a fundamental concern for the measurement of spatial units of analysis. Contemporary scholarship has emphasized the importance of specification of units of analysis in addition to the dangers of assuming an ideal level of geography (see Hipp, 2007; Openshaw, 1983; Weisburd et al., 2009). A multilevel framework offers a strategy to represent the unique features of both neighborhood and micro-levels of spatial aggregation without having to choose one over the other. Neighborhoods and micro-places can be considered two interconnected levels of spatial aggregation because each represents a unique perspective to interpret the concept of place within cities (Wilcox & Tillyer, 2018). Decades of scholarship suggest both units of analysis capture essential domains for the organization of social life in urban areas (e.g., Park & Burgess, 1925; Sampson, 2012; Sherman et al., 1989).

Micro-places represent behavioral settings that capture the daily rhythms of urban life and contain the specific activity hubs where residents interact with each other over time (Appleyard, 1981; Jacobs, 1961; Whyte, 1943). These locations are often measured using buildings, street segments, cityblocks, or other locations bounded to street grids (Eck & Weisburd, 1995). By contrast, neighborhoods are a broader construct which subdivides the traditional geographic and social boundaries between major areas of cities (Bursik & Grasmick, 1993; Park & Burgess, 1925; Sampson, 2012). Neighborhoods are still arguably the most common place-based unit of analysis used to understand crime variation within cities because of the enduring legacy of the Chicago School (see Reiss, 1986; Sampson et al.,

- 2002). Micro-places are nested within neighborhoods which suggests the former captures a local spatial influence and the latter more contextual influences (see Jones & Pridemore, 2019). Wilcox and Tillyer (2018) propose the “place in neighborhood” (PIN) approach and Kim and Hipp (2020b) the “egohood” approach which further integrate these 2units of analysis into one interconnected concept. Both approaches are examples of novel extensions of these units of analysis beyond their traditional domains and provide important efforts to continue to reformulate that relationship moving forward.


Steenbeek and Weisburd (2016) conducted an influential study on hierarchical variance decomposition which estimated a four-level linear mixed model on 9years of all crime incident report data from The Hague, Netherlands. The first level measured time which the model allowed to vary as a random slope over the second level measured as street segments (i.e., micro-places), nested in neighborhoods (i.e., meso-neighborhoods), which were nested in districts (i.e., macro-neighborhoods). This allowed the authors to partition the variance attributed to the spatial units at each level and provide a concise estimate of the contribution the total spatial variability of crime patterns. They found 58% to 69% of the total spatial variability was attributed to the micromeasure of place, 5% to 7% to the meso-measure, and 24% to 38% to the macro-measure. Schnell et al. (2017) replicated that modeling strategy with violent crime in Chicago and observed similar findings. O’Brien and Winship (2017) contrasted two micro-units and a neighborhood finding much more variation observed at street addresses relative to street segments and neighborhoods. Finally, Hipp et al. (2020) compared the influence of spatial to temporal variability within weeks noting that, outside of micro-places, time accounts for more variability than either meso or macro units of analysis. Despite the importance of these studies, these analyses do not permit further narrative inference beyond framing the contribution of each spatial level as “where the action is” in spatial variability (see Steenbeek & Weisburd, 2016).

That most spatial variability occurs between micro-places is not surprising because of the large number of these locations and the sparse distribution of crime events (see Bernasco & Steenbeek, 2017). The concentration of crime at micro-places is expected considering there are often far more micro-places within cities than incidents of crime per year. For example, Chicago experiences around 500 homicides per year distributed across almost 50,000 street segments. Previous research suggests there is much between-unit variability in crime patterns at micro-places (Weisburd et al., 2012). In other words, a crime hot spot could be found next to several micro-places in a city which have no crime at all. These findings have fueled further study of micro-places which resulted in hot spots becoming the primary tool to summarize the spatial distribution of crime (Sherman et al., 1989; Weisburd, 2015; Weisburd et al., 2012).

The role of neighborhoods in this age of hot spots remains unclear. Without being able to conceptualize a hierarchical spatial distribution of crime, theoretical integrations are unable to fully address the phenomena they are created to explain. The use of a multi-level framework to explain the spatial distribution of crime infers there is unique variability between units of analysis worth investigating in the first place. This provides a roadblock for the advancement of multi-level frameworks and a challenge to best conveying the full story of where crime happens within cities which is the core motivation of this research. This study addresses this issue by developing an inductive theory of the multi-level spatial distribution of crime. This approach contrasts to previous deductive theoretical integrations which are focused on theory testing at these units of analysis. Our inductive account offers a grounded theoretical assessment based upon observations of spatial variability between micro-places and neighborhoods.

## Data and Methods Robbery and Chicago

This study examines robbery incidents reported to the Chicago Police Department from 2016 to 2018. These data were collected through the City of Chicago’s open data portal (see data.cityofchicago.org). We selected robbery to focus on a disaggregate category of violent crime which has a welldefined theoretical connection to place and robust literature within place-based criminology to further situate our findings (see Braga et al., 2011; Haberman et al., 2018; Wright & Decker, 1997). Despite the inherent limitations of these data (see Black, 1970), incident reports still provide a useful overview of where crimes occur within jurisdictions and have been instrumental in the development of “the criminology of place” (Weisburd, 2015). From 2016 to

2018, a total of 33,518 robbery incidents were reported in Chicago. There were 11,960 in 2016, 11,877 in 2017, and 9,681 in 2018. Street robberies represented 71.2% (5,456 of 33,518) of the total robberies while commercial robberies were only 16.3% (12,866 of 33,518) and other robberies captured 12.5% (4,186 of 33,518). We assessed this 3-year temporal period (see Bernasco & Block, 2011) to minimize the influence of outlier years and observe broader spatial patterns.

Two levels of spatial aggregation were selected because of their importance in understanding Chicago’s geography and their prior contributions to criminological research conducted within the city (see Sampson, 2012). The first unit of analysis is community areas which represent the general ecological concept of neighborhoods. Chicago is composed of 76 community areas which were originally delineated by Chicago School researchers and the city’s Department of Public Health in the 1920s (Chicago Fact Book Consortium, 1990). Community areas are still widely used today by municipal administrative agencies and residents to understand the local geography of Chicago (Sampson, 2012).1 Chicago has a total geographic expanse of nearly 230mi2. The geographic sizes of community areas range from between

- 0.61 and 13.3mi2 (mean=3.00sq. miles) and average around 36,000 residents (U.S. Census Bureau, 2010). The second unit of analysis is street segments or street block faces which are defined as “the two block faces on both sides of a street between two intersections” (Weisburd et al., 2004, p. 290). Street segments represent a salient micro-spatial domain for understanding the variation of crime events in cities (Eck & Weisburd, 1995; Weisburd, 2015; Weisburd et al., 2012). The use of place-based units of analysis that adhere to street networks provides a more holistic representation of how people navigate urban areas (Grannis, 1998).


There are 50,897 total street segments in Chicago (mean length=426.52 feet, s.d. =233.49ft). We excluded 2,587 street segments associated with interstates and highways. Robberies are rarely recorded at these locations as they are primarily used for automotive transportation instead of more diverse land use functions where individuals are likely to be the victims of a robbery. All the Chicago Police Department’s incident reports correspond to street addresses rather than the intersection of two or more streets (see Schnell et al., 2017). Therefore, we did not have to consider developing street intersections as an additional micro-place unit of analysis (e.g., Braga et al., 2011) or exclude these incidents (e.g., Weisburd et al., 2004). Incident locations were then geocoded using their XY coordinates and aggregated to create a street segment count. Using ArcGIS 10.8 software, we successfully geocoded street addresses for 99.8% (33,463 of 33,518) of the robbery incidents to their associated street segments in Chicago (see Andresen et al., 2020). The final

dataset included 33,463 robbery incidents distributed across 48,310 street segments which are nested within 76 community areas.

### Research Design

Our analyses proceeded in two stages. The first stage addresses the research question: does the micro-spatial interdependence of robberies vary between neighborhoods? Micro-spatial interdependence is measured as a spatial lag at street segments and neighborhood-context is represented through the hierarchical nesting of street segments within community areas.2 Mixed-effects negative binomial regression models are estimated to examine the relationship. This provides an alternative to the hierarchical variance decomposition strategy by focusing on the random slope estimates for a spatial lag measure which, in turn, helps facilitate more direct inference about the spatial distribution of crime patterns. In addition, this modeling strategy is similar to studies which examine cross-level interactions (see Tillyer et al., 2021) because we aim to observe differences in micro-level effects between different neighborhood-contexts. Our approach combines the descriptive focus of research on hierarchical variance decomposition with a modeling strategy that is commonly adopted for research focused on theoretical integration. Overall, we investigate the broader contextual descriptions of spatial dependencies—that is, do micro-places in certain neighborhoods exhibit lessened or magnified spatial dependencies for robbery compared to micro-places in other neighborhoods?

The potential variation of the impact of micro-spatial interdependence between neighborhoods is anticipated because of the uneven spatial distribution of crime within cities. Crime patterns in cities are disproportionately influenced by a small number of crime hot spots which account for a large amount of crime while most locations experience little to no crime (see Weisburd et al., 2012). Therefore, models which do not account for the uneven spatial distribution could provide a misleading representation of the impact of spatial interdependence. Spatial interdependence is one of the most consequential findings within place-based criminology and suggests the broader area in which a unit of analysis is surrounded influences local observations (see Bernasco & Elffers, 2010). The finding of positive spatial autocorrelation indicates places are often found close to other places with similar crime patterns. Using a strategy to address cross-unit dependence of crime patterns in adjacent places is almost an afterthought for contemporary placebased analyses since it is such a foundational consideration (see Anselin et al., 2000; Bernasco & Block, 2011; Morenoff et al., 2001). The goal of our modeling strategy is to provide a deeper descriptive account of the spatial variability of robbery patterns as opposed to specifying an explanatory model

- Table 1. Descriptive Statistics for Model. Variable Mean SD Min. Max.


Robberies 2016–2018 0.683 1.661 0 50 Spatial Lag −0.025 1.615 −2.407 29.312 Segment Length (Log) 5.902 0.605 1.933 8.29 Robberies 2013–2015 0.630 1.511 0 56

to test place-based theories. As such, a parsimonious model of the spatial distribution is estimated with only three independent variables included in the final models.3

The main independent variable is a threshold distance-defined spatial lag

as measured by the Getis-Ord Gi* statistic using ArcGIS 10.8 (Ord & Getis, 1995). To create this continuous variable, a fixed 660-foot buffer, which rep-

resents one standard city-block in Chicago, is created around each street segment and the value is calculated based upon the number of street segments and robberies from 2016 to 2018 within this buffer. Higher Gi* values represent street segments surrounded by more locations with robberies and lower scores represent the inverse. The Gi* statistic is a hot spot analysis measure commonly used for the identifying local spatial clustering, (Grekousis, 2020) which was selected to provide a connection to the second stage of analyses on crime mapping. In general, this measure captures both the spatial concentration of robberies and the statistical concentration of the number of robberies occurring at these street segments. Two additional control variables are included to account for the size of each street segment and any temporal dependence within street segments that experienced robberies in an earlier period. These variables were included because the concepts of spatial exposure and temporal dependence are other robust atheoretical constructs which can help provide a more balanced description-only account of spatial variability. The length of the street segment is a continuous variable originally measured in feet with a natural log transformation applied to account for a small percentage of exceptionally large street segments. The temporal lag variable measures the count of robberies at the street segment from 2013 to

- 2015 or 3years prior to the measurement of the dependent variable. Table 1 presents descriptive statistics for each variable.


Around 5% or 2,395 of the total 48,310 street segments fell on the boundary of two or more community areas which resulted in these locations being unable to be nested and uniquely identified to one location (see Steenbeek & Weisburd, 2016). These street segments were excluded from the main analysis to isolate the impact of any potential nesting or “edge effect” issues

(Schnell et al., 2017). There is a robust literature centered on analyzing edge effects because these locations are theorized to present unique areas for the confluence of criminal opportunities (Brantingham & Brantingham, 1993; Kim & Hipp, 2018; Song et al., 2013). Appendix A presents findings from a sensitivity analysis where we included these segments to determine the impact of their exclusion on our main results4 Mixed-effects negative binomial regression models are estimated in Stata 17.0 using the “meglm” function. A negative binomial specification is used due to overdispersion in our data and the overdispersion parameter is calculated conditional on the random effects. Three versions of the model were estimated to determine optimal fit.5 The first model specified just a random intercept. The second and third models included a random slope for the spatial lag variable with a structured (Cov=0) or an unstructured covariance (Cov≠0).6

The second stage of analyses addresses the research question: how do micro-places and neighborhoods assist description of the spatial distribution of crime? Exploratory spatial data analysis (ESDA) is conducted to further observe and classify the spatial patterns of robberies at street segments within and between community areas. Crime maps are featured to help visualize the higher-order spatial clustering of robberies between street segments. Crime maps are the oldest (i.e., Balbi & Guerry, 1829) and still one of the most useful qualitative tools in place-based criminology for descriptive research on the spatial distribution of crime. The observation of the spatial variability between micro-places and neighborhoods can provide a pathway to more deeply understanding the relationship between these units of analysis. Place-based studies often use maps as a supplemental analysis, but our research design features maps as the culmination of our analyses due to our objectives.

Descriptive statistics help summarize the composition of community areas using the total number of street segments with robberies in these locations (see O’Brien, 2019). The variance parameters (i.e., random intercept and random slope effects) from the models in the first stage of our analysis are used to create groupings of community areas. This helps provide a means for differentiating patterns of spatial interdependence between neighborhoods. Observing meaningful random effects for the spatial lag in the first stage of the analysis can provide a starting point to guide ESDA. Random effects for a spatial lag variable between community areas indicates potential differences in the baseline risk of robbery at nested micro-places and may also suggest that there are significant between-neighborhood differences in the spatial interdependence of robberies across street segments.

The Gi* values allow for the identification of statistically significant clusters of robbery street segments. These values are featured in our crime maps to illustrate the locations where robberies clustered in Chicago. These

clusters denote locations where the impact of spatial interdependence is the most pronounced. The distinction of clustered compared to diffused spatial patterns of robberies at segments provides the foundation of our ESDA. The presence of small clusters or diffused patterns suggests the salience of microplaces while much larger clusters or sprawling patterns could demonstrate the influence of broader spatial forces (i.e., neighborhood-level dynamics) which shape the spatial distribution in a certain area. In general, this stage of the analyses aims to observe if neighborhoods offer helpful boundaries to display the clustering of crime patterns.

## Results

- Table 2 displays the results of three mixed effects negative binomial regression models. The third model includes both random effects (i.e., a random intercept and a random slope) and an unstructured covariance and, according to likelihood ratio tests and AIC/BIC values, this model provides the best fit to the data. The coefficients for each of the independent variables are statistically significant and relatively consistent across the models. The model results also indicate noteworthy between-neighborhood variation in both intercepts (0.113, p<.001) and the slope for the spatial lag covariate (0.097, p<.001). Furthermore, there is a tendency for these estimates to co-vary systematically as indicated by the unstructured covariance estimate (−0.101, p<.001). This indicates the random effects are negatively correlated, such that a neighborhood with an above-average intercept (i.e., a positive random intercept effect) is expected to have a below-average slope (i.e., a negative random slope effect).


The range of these estimates exhibits substantial heterogeneity in both the baseline risks and the relationship between nearby street segment robbery counts with a street segment’s own expected count of robberies. In fact, an average street segment in Chicago can have over four times as high an expected baseline robbery count (0.621 vs. 0.139) or nearly four times as high a predicted robbery count (1.110 vs. 0.294) from a one-unit difference in spatial lag, depending upon its broader neighborhood context.7 This level of heterogeneity in both intercepts and slopes confirms our prior expectations regarding the interplay between micro- and macro-spatial contexts in cities. Stated differently, although local conditions undoubtedly have a substantial impact on crime patterns, neighborhood context remains a powerful influence, shaping both the baseline risk and how nearby robberies transmit risk across adjacent street segments.8

Figure 1 displays the spatial distribution of random effect estimates dividing community areas into three general groups. These groups provided a

Table 2. Mixed Effect Negative Binomial Regression Results—Comparison of Model Results for Different Random Effect Parameterizations.

Random Slope (Cov≠0) Coefficients

Random Intercept

Random Slope (Cov=0)

Spatial Lag and Robbery

Intercept −4.445 (0.156) −4.112 (0.146) −4.210 (0.148) Lagged Robbery 0.587 (0.050) 0.569 (0.048) 0.568 (0.048) Log Seg Length 0.467 (0.025) 0.456 (0.027) 0.459 (0.027) Spatial Lag 0.020 (0.008) 0.331 (0.071) 0.246 (0.046)

Error Components Intercept 0.347 (0.137) 0.041 (0.014) 0.113 (0.039) Slope — 0.234 (0.109) 0.097 (0.036) Intercept, Slope — — −0.101 (0.033) Log Likelihood −32198.134 −32042.492 −31999.777 AIC 64,408.27 64,098.98 64,015.55 BIC 64,460.67 64,160.13 64,085.43

- Level-1 Units 45,915 45,915 45,915
- Level-2 Units 76 76 76


| |
|---|


Figure 1. Spatial distribution of random effects for intercepts, slopes, and final groups between community areas.

summary of this distribution based upon how these variance parameters compared relative to the other community areas.9 The first group (n=14) are the gray community areas on the map with large negative random effects estimates for the intercept (i.e., Quartile 1) and large positive random effects

estimates for the slopes (i.e., Quartile 4). These community areas are primarily found on the border of Chicago and experienced few robberies. These community areas exhibit a unique contextual influence whereby the baseline risk of robbery for an individual street segment is lower than a comparable segment in an average community area, but the spatial transmission of risk due to robberies in nearby street segments is higher. The second group (n=38) are the white community areas on the maps without exceptionally large random effect estimates for intercepts and slopes (i.e., Quartiles 2 & 3).10 These locations are found throughout Chicago and do not demonstrate any unique micro- or neighborhood- contextual effects compared to the other locations. These community areas are best represented by the baseline model estimates for the intercept and slope parameters. The third group (n=24) are the red community areas on the maps with large positive random intercept effects (i.e., Quartile 4) and large negative random effects for the slopes (i.e., Quartile

- 1). Variance parameters suggest the effect attributed to spatial lag or microspatial interdependence is lessened in these community areas while at the same time, the baseline risk of robbery is higher than the average community area. Despite the general groups of community areas created from the mixedeffects models there are still many differences even within these classifications of the spatial distribution of robberies.


Our ESDA provides additional narrative support for the findings from the mixed-effects models. We conducted a global test for spatial autocorrelation using the General G-Statistic which examined the city-wide spatial distribution of robberies (Grekousis, 2020). This analysis confirms there is statistically significant clustering (z=51.85, p<.001) of these incidents within one city-block compared to complete spatial randomness of robberies at street segments across Chicago. These segments represent 9.1% of the total street segments in Chicago and around 40% of the total robberies. These street segments were found throughout Chicago with only 25.0% of community areas (19 of 76) having no robbery clusters. The boundaries of community areas provide a helpful tool to further describe the clustering of robberies across street segments. There is noticeable variability in the spatial distribution of robbery clusters between community areas.

Since there is no consensus on the size of a crime hot spot, we develop an explicit classification scheme. We observed two general categories of spatial patterns for clustered street segments: hot spots and formations. Hot spots are small clusters comprising a few street segments with robberies which do not extend beyond a one or two block radius. By contrast, formations are larger clusters of segments with robberies that extend beyond a two-block radius and thus challenges the traditional definition of what could be considered a micro-place.

| |
|---|


- Figure 2. The spatial distribution of clustered robbery street segments in Group 2 community areas.


One overarching pattern across the defined groups of community areas is the difference between locations with few street segments in robbery clusters (i.e., Group 1) and locations where many street segments are in clusters (i.e., Group 3). Community areas in Group 1 had generally lower counts of robberies which are more widely dispersed throughout street segments in the neighborhood. These locations averaged 8.2% of total street segments with a robbery (SD 5.3%) and only two community areas had any clustered segments. The large, negative estimates for random intercept effects at these locations suggest the counts of robberies across the street segments is lower but there is an elevated risk of robberies transmitted to street segments immediately around where robberies occur (i.e., large, positive random slope effect).

Figure 2 displays two examples of Group 2 community areas and the spatial distribution of robbery clusters. These maps demonstrate how not all locations found within clusters have robberies (i.e., black segments) and not all street segments with robberies form clusters. Instead, the spatial proximity of certain street segments to other locations with robberies can include them within these clusters. Albany Park (CA #1) is characterized by one distinct formation of a robbery cluster spanning multiple street segments in

| |
|---|


- Figure 3. The spatial distribution of clustered robbery street segments in Group 3 community areas.


the center of the community area with one small hot spot on the southern border. All the clustered robbery segments only represent 9.5% (50 of 528) of the total street segments and these locations are concentrated, suggesting the place-based characteristics which influence robbery are specific to this location and do not reflect a broader pattern across the community area. West Pullman (CA #2) displays a few small hot spots spread throughout the community area. The spatial pattern of robbery street segments in this community area resembles the prototypical examples of crime hot spots. Only

- 2.2% (19 of 872) of the total street segments had robbery clusters although 28.0% had a robbery occur (244 of 872). This suggests there are several other segments with robberies spread in between the hot spots that are not close enough or had too few robberies to form a statistically significant cluster.


Figure 3 illustrates several examples of Group 3 community areas from the westside of Chicago. Most of these community areas have large formations of street segments with robberies. For example, Austin (CA #3) had 54.4% of its total street segments experience a robbery and 32.2% of the total segments are in clusters. This extent of clustering is anticipated because of

the increase in number of street segments with robberies but still noteworthy because most of the community areas in Group 3 had fewer than half of their street segments experience a robbery from 2016 to 2018. This suggests there is unique clustering within these community areas because of more than just the raw increase in street segments with robberies and the raw count of these incidents. For Austin, many clustered street segments are within a large formation on the southern part of the neighborhood and there are a few hot spots on the northern part. This indicates the general spatial risk for robbery is not concentrated in one location but diffused throughout large areas of the neighborhood. Humboldt Park (CA #4) has a large formation at its center and a few hot spots of robbery clusters outside of this location. West Garfield Park (CA #5) has the largest percentage of total street segments with robberies (56.9%) and clusters (70.5%) of any community area in Chicago, making it appear as though the entire neighborhood is crime prone. East Garfield Park (CA #6) and North Lawndale (CA #7) have multiple hot spots and formations spread throughout the entire community areas. As a result, exceptionally few street segments are not near a robbery cluster. Together, these community areas capture three of the five locations with the highest percentage of street segments with robberies and within robbery clusters. The saturation of robberies in these community areas challenges the utility of micro-places to summarize the spatial distribution of robbery. While there still is street segment to street segment variability in robbery patterns, for the broader story of where crime is happening in these locations, the neighborhood unit of analysis plays an essential role.

## Discussion

Overall, this study helps recontextualize the role of both micro-places and neighborhoods in describing the spatial distribution of crime within cities. Our findings support previous research suggesting there is considerable variability between which street segments experienced robbery incidents (see Groff et al., 2010). Despite this variability and the small number of street segments that had robberies (also see Braga et al., 2011), there were still noteworthy spatial patterns which emerged throughout Chicago. We found substantial clustering of street segments with robberies and observed two general categories of clusters we identified as hot spots and formations. The analyses for our first research question confirm there is important variation found in the spatial interdependence of robberies at street segments between community areas. These findings indicate there is between-neighborhood variability in both the underlying risk of robbery for individual street

segments and the spatial interdependence of robbery in nearby segments as measured by the Gi* statistic. To further unpack this result and answer our second research question, we used ESDA. This analysis revealed three general groups of community areas which provide different contexts for understanding the distribution of robbery based upon their random intercept and slope parameters. Several community areas had very few street segments with robberies (i.e., Group 1) and these locations were often not clustered but spatially diffused throughout the community area. The remaining community areas had varying numbers of street segments with robberies in addition to hot spots and formations of these locations.

Our findings suggest neither the micro-place nor neighborhood alone can tell the complete story of where crime happens in a city. Instead, a combination of both spatial units of analysis as co-equal places renders the most comprehensive portrait. Previous research on variance decomposition offers a potentially misleading representation by attributing the contribution of each to specific numbers. The findings from our study build upon previous research concerning variance decomposition (see Schnell et al., 2017) to offer a complementary theoretical account which further clarifies the unique contribution of micro-places and neighborhoods through an in-depth exploration of random effect parameters. The influence of each varies depending upon the specific environment with the neighborhood more influential for certain locations, the micro-place to other locations, and finally a mix of both units of analysis for most locations.

For the community areas with few robberies (i.e., Group 1), these findings suggest more micro-level risk unique to each location which could be diffused to some immediate areas despite a broader neighborhood-level protective effect. In community areas with more street segments with robberies (i.e., Group 3) there is a different interplay because the neighborhood random effects reflect a higher base rate of robberies (i.e., positive random intercept effects), but diminished spatial contagion evidenced by large negative random slope effects. In addition, these are community areas where the saturation of robbery clusters has passed beyond a “tipping point” to go from just a hot spot cluster to a more widespread pattern of locations which can no longer be summarized as just a micro-level problem. In other words, these places are not hot spots, they are just simply “hot neighborhoods.” The community areas in-between with near-average random effects and moderate numbers of robberies (i.e., Group 2) indicate a micro-level impact of spatial interdependence because there is no pronounced neighborhood effect. These are community areas with a few hot spots of robberies or a moderate formation but no overarching saturation of robberies.

The use of a multi-level framework presents a valuable synthesis which can account for the evolving conceptualization of place which embraces networks (see Sampson, 2012), novel measures (Kim & Hipp, 2020b), and micro-places (see Weisburd et al., 2012). The measurement of spatial interdependence at micro-places presents a “bottom-up” approach which offers a more flexible strategy that can account for varying distances and relationships of spatial proximity between units of analysis (see Hipp & Boessen, 2013). This can facilitate the more holistic use of micro-places as the foundational building blocks in a more sophisticated hierarchical structure that may best represent the relationship between crime and place. The use of neighborhoods allows for the representation of unique contextual effects which offers a “top-down” approach that relies on a more traditional organization of areas with defined physical boundaries. These long-standing physical designations of neighborhoods are still influential in how residents of cities conceptualize place. While the bottom-up approach can produce better fitting models (see Kim & Hipp, 2020), their detachment from top-down physical boundaries, which are intertwined with municipal agencies’ understanding of cities such as police departments, present challenges for the adoption of policy.

The concept of crime hot spots is spatially imprecise—these locations could be one building, several blocks, etc.—but generally represents the sub-neighborhood concentration of high crime micro-places (Sherman et al., 1989). Our observation of moderate sized formations (see Figure 2), while slightly larger than the traditional depiction of a hot spot, are still aligned with the concept but open a debate about how large a hot spot should be considered. This is the primary issue which emerges with our observation of large formations of robbery clusters between street segments. The traditional arguments of micro-spatial risk accounting for these places (see Eck & Weisburd, 1995) is much less satisfying because these locations cover such large areas. This suggests crime prevention strategies in certain areas with widespread crime problems should consider more than just hot spot-based interventions and target larger structural issues in these neighborhoods. Advances in place-based policing focused on micro-places over the past 30years have had a massive impact but for continued progress, policymakers need to fully embrace the limitations of these strategies and not abandon broader structural reforms targeted to places (see Sampson, 2012). Like the integration of theoretical concepts in place-based criminology, crime prevention strategies associated with both perspectives should consider further integration based upon the underlying hierarchical spatial distribution of crime.

There are limitations to our study which were not addressed by the sensitivity analyses. Several alternate units of analysis in Chicago could have been examined to represent micro-places and neighborhoods. Neighborhood clusters are smaller than community areas, composed of groups of census tracts, and used extensively in contemporary research on crime in Chicago (see Kirk & Papachristos, 2011; Morenoff et al., 2001; Sampson et al., 1997). In addition, street blocks are larger than street segments and have been previously applied to the study of robbery in the city before (Bernasco & Block, 2011). The use of different units of analysis could also spur a reconsideration of boundary segments and a more nuanced assessment of potential edge effects. Future research should explore if random effect parameters exhibit different patterns when using other combinations of micro- and macro-units of analysis. Furthermore, our observations are restricted to the spatial distribution of robbery over one temporal period. Because robbery is a violent crime and more uncommon than certain property crimes such as theft, the fewer street segments which experience this crime could have impacted our findings. Our models are purely descriptive—we include only a few variables and focus strictly on a contemporaneous spatial lag. Finally, our findings are restricted to one city. While there is a rich tradition of place-based criminological research featuring Chicago that offers an unparalleled body of literature to build upon, there is also a necessity for place-based criminological research to study a broader assortment of cities.

Our study contributes a new theory to a growing foundation of research that indicates multi-level conceptual frameworks can facilitate a more comprehensive ecological account of crime variation within cities (Deryol et al.,

- 2016; Jones & Pridemore, 2019; Miethe & Meier, 1994; Rice & Smith, 2002; Steenbeek & Weisburd, 2016; Weisburd et al., 2012; Wilcox et al.,


- 2003). Specifically, our findings build upon descriptive research on variance decomposition to offer an inductive portrait of the role both micro-places and neighborhoods provide in understanding where crimes happen within cities. We found the local influence of micro-spatial interdependence varies across Chicago based upon neighborhood context. There is a distinction between places in Chicago where the spatial transmissibility of robberies is most acutely experienced across entire neighborhoods or within the immediate proximity of certain micro-places. Our findings suggest a multi-level conceptual framework can help recast neighborhoods during the era of crime hot spots as a level of spatial aggregation to observe unique clustering of crime patterns at micro-places. Neighborhoods provide a crucial meso- or macro- unit of analysis which complement micro-places by providing the structure for the broader contextual subdivision of cities. The presence of


formations of robbery patterns which exceed the size of the traditional conceptualization of crime hot spots provides a new contribution. In turn, this overarching structure showcases important differences in the spatial distribution of crime throughout the city and that these locations can have a unique impact on the micro-places nested within them. Both micro-places and neighborhoods are essential for telling the complete story of where crime happens within cities.

## Appendices

### Appendix A: Robustness Checks for Boundary Segments and Spatial Lag Block Radii

Several sensitivity analyses were conducted to address key specification decisions from our modeling strategy. The first set of analyses examined the role of boundary segments between community areas. We randomly assigned these boundary street segments to one of the potential community areas they could be nested within. Then, we tested the alternate identifications from these assignments. The models were re-estimated with these additional street segments, and we found negligible differences to the models without boundary segments (see Appendix Table 1A). The second analysis used different distance measures for the spatial lag of two and three city-blocks (see Appendix Table 2A). The coefficients across models are quite similar, except for the spatial lag variable. Additionally, the random effects tend to decrease in size as the block radius for the spatial lag parameter increases, this being particularly true for the random slope effects.

This finding indicates that our conclusions about the spatial distribution of random intercept and slope effects may be sensitive to assumptions about the most appropriate spatial lag structure. However, this difference is not surprising because the larger the distance threshold becomes, the closer the spatial lag becomes to approximating the area represented by the community area. For example, a three-block buffer far exceeds the size of the average census tract in Chicago. This can start to blur the distinction between the micro- and macro-units of analysis—better approximating the latter while obscuring the former. As such, we believe our choice to use a one-block buffer is appropriate in the context of this analysis given that larger buffers come dangerously close to approximating the size of our level-2unit of analysis. Across all other sensitivity analyses we can conclude these specification decisions had little to no impact on our findings.

- Table 1A. Mixed Effect Negative Binomial Regression Results (Including Boundary Street Segments).

Model parameters

Random intercept

Random slope (Cov=0)

Random slope (Cov≠0)

Coefficients Intercept −4.322 (0.155) −3.992 (0.143) −4.086 (0.146) Lagged Robbery Count 0.581 (0.049) 0.561 (0.047) 0.560 (0.047) Logged Segment Length 0.449 (0.025) 0.437 (0.026) 0.440 (0.026) Spatial Autocorrelation 0.020 (0.007) 0.325 (0.071) 0.244 (0.044) Error Components Intercept 0.358 (0.141) 0.047 (0.016) 0.121 (0.041) Slope — 0.227 (0.111) 0.096 (0.035) Intercept, Slope — — −0.104 (0.034) Log Likelihood −34161.065 −33986.301 −33939.47 AIC 68,334.13 67,986.60 67,894.94 BIC 68,386.84 68,048.10 67,965.22 Level-1 Units 48,310 48,310 48,310 Level-2 Units 76 76 76

- Table 2A. Spatial Lag Specification Results Comparison. Model Parameters 1-Block Radius 2-Block Radius 3-Block Radius


Coefficients Intercept −4.210 (0.148) −4.223 (0.148) −4.224 (0.148) Lagged Robbery Count 0.568 (0.048) 0.558 (0.048) 0.561 (0.048) Logged Segment Length 0.459 (0.027) 0.471 (0.027) 0.470 (0.026) Spatial Autocorrelation 0.246 (0.046) 0.192 (0.031) 0.139 (0.021) Error Components Intercept 0.113 (0.039) 0.051 (0.023) 0.048 (0.023) Slope 0.097 (0.036) 0.042 (0.016) 0.019 (0.007) Intercept, Slope −0.101 (0.033) −0.042 (0.014) −0.027 (0.010) Log Likelihood −31999.777 −31991.321 −32008.573 AIC 64,015.55 63,998.64 64,033.15 BIC 64,085.43 64,068.52 64,103.02

- Level-1 Units 45,915 45,915 45,915
- Level-2 Units 76 76 76 Note. All models specify a random intercept, slope, and unstructured covariance.


### Appendix B: Additional Modeling Information

The models take the following general form: log Y Getis Length PreRob

( ) ( ) ( )

ij j j ij

0 1

2 3 )

, ( ,

ij ij

Of primary interest to this study are the random effects (µj and υj ) and the covariance between them, ( , ) . The first term, µj, is a random effect for the neighborhood-level intercept and represents departures from the baseline expected robbery count holding other covariates fixed. The second term, υj , is a random effect for the neighborhood-level slope between the spatial lag measure (Gi* statistic) and the robbery count and represents departures from the expected slope for the average neighborhood.

Finally, the covariance term, ( , ) , represents two potential assumptions about the relationship between the random intercept and slope terms. The simplest assumption is that there is no relationship between the random effects— ( , ) 0 —this is referred to as a structured covariance. Alternatively, we may also assume that there does exist a systematic relationship between the random effects— ( , ) 0 —this prompts the model to provide an estimate for the covariance structure—this is referred to as an unstructured covariance. If a structured covariance provides a better fit to the data this implies that random intercept estimates are uncorrelated (e.g., that a community area with a greater than average baseline expected robbery count is no more or less likely to exhibit a non-zero random slope effect). By contrast, if an unstructured covariance provides a better fit to the data, this suggests the random effects are systematically related (e.g., a community area with a greater than average expected robbery count is likely to also observe a non-zero random slope effect). Best fit models are identified using likelihood ratio tests in addition to evaluating AIC and BIC values across models.

#### Declaration of Conflicting Interests

The author(s) declared no potential conflicts of interest with respect to the research, authorship, and/or publication of this article.

#### Funding

The author(s) received no financial support for the research, authorship, and/or publication of this article.

#### ORCID iDs

Cory Schnell https://orcid.org/0000-0002-4034-0953 M. Dylan Spencer https://orcid.org/0000-0001-9805-0986

#### Notes

- 1. These “macro” representations of neighborhoods were selected because previous research including Schnell et al. (2017) in Chicago found these larger aggregations of neighborhoods capture more spatial variability than “meso” measures such as neighborhood clusters. These units of analysis are large but considering the context of Chicago being the third most populous city in the U.S. this puts their size in more perspective. Furthermore, a meso-spatial unit of analysis is approximated by the creation of the spatial lag variable at the center of our analyses which is why they were not considered here.
- 2. Our measure of a spatial lag is specifically referring to a spatial lag for the dependent variable, therefore this creates a new independent variable (Bernasco & Elffers, 2010). Spatial lag regression models are a general class of models where lags can be created for any variable. For example, if our models were testing criminal opportunity theories and wanted to examine the impact of bus stops, we could use a variable that captures if there is a bus stop on a street segment and if the street segment is near a location with a bus stop as a spatially lagged measure. This proximity can be calculated with a varying range of distance buffers (i.e., one block away, two blocks away, etc.).
- 3. Bernasco and Block (2011) argued spatial lags for dependent variables are less helpful in explaining the distribution of robberies because the spatial proximity to other robberies does not influence offender’s decision-making processes. They emphasized robbers select locations based upon criminal opportunity which can spuriously manifest itself as the proximity to other robberies. While we believe the further elaboration of the causal pathway is critical for explanatory research, our study is explicitly descriptive by-design. We are only interested in modeling a baseline representation of interdependence to facilitate our exploration of the spatial distribution of robberies instead of untangling an explanation for interdependence.
- 4. The results from this sensitivity analysis are comparable to those from our main analysis (see Appendix A). We were comfortable excluding these locations from the main analysis because of this finding and a few other concerns. There is no ideal strategy to include these locations. We believe the random assignment of segments to community areas is a satisfactory solution to including these locations, but it does not truly resolve the edge effect issue. Due to the inherent complexity of this issue (i.e., where do these truly locations belong?) which could support a whole other study, we feel our decision to exclude them from the main analysis and include for a sensitivity analysis is the best pathway to approach this matter for the sake of the space limitations for this study. This denotes their importance and provides an assessment of this decisions impact. Therefore, all interpretations of our findings should be considered with the caveat we excluded


- these locations. We are grateful a reviewer raised this point and hope future research can provide a much more nuanced consideration of this matter.
- 5. A common critique of spatial lag regression models pertains to the endogeneity of these equations because the dependent variable appears on both sides of the equation. However, these models are very common in spatial analyses of crime (see Fingleton & Le Gallo, 2008; Jendryke & McClure, 2019; Lambert et al., 2010; Light & Harris, 2012). While endogeneity is a valid concern, this critique is less problematic for the current analysis because we do not aim to resolve the “chicken and egg” conundrum the use of a contemporaneous spatial lag variable creates (e.g., neighbors influence local or vice versa). Instead, we focus on developing a more comprehensive descriptive understanding of spatial interdependence and do not presuppose a direction of the effect (Bernasco & Elffers, 2010).
- 6. Appendix B provides further technical discussion of the models.
- 7. Values are calculated holding logged street segment length and lagged robbery counts at the sample mean (see Table 1) and compare expected robbery counts for a one-unit shift in the spatial lag (from 0 to 1) based upon minimum and maximum values of the random effects for the intercept and slope, respectively.
- 8. Appendix A includes additional information on other sensitivity analyses conducted for these models.
- 9. We divided the estimates from the n=76 community areas into adjusted quartiles. The key distinction amongst estimates was between positive and negative values which we used to create two sub-groups instead of evenly splitting the distribution between half the locations. These sub-groups were further divided at each median to create four total groups. These figures identified the highest and lowest values which would correspond to the first and fourth adjusted quartiles in the maps. These groupings were very similar to alternate specifications using true quartiles and natural breaks approaches. The modest number of total community areas discouraged us from using more complex approaches or subgroupings. Our goal was to simply differentiate between low and high values of the distribution while maintaining a clear distinction between positive and negative random effect estimates.
- 10. Per Figure 2, there are only four community areas did not completely align within these categories. These locations were often very close to each quartile threshold which made us comfortable resolving these differences to include them into the final groups instead of creating a new group. The community area was included in the group which had the smallest deviation from the quartile threshold.


#### References

Andresen, M. A., Malleson, N., Steenbeek, W., Townsley, M., & Vandeviver, C. (2020). Minimum geocoding match rates: An International study of the impact of data and areal unit sizes. International Journal of Geographical Information Science, 34, 1306–1322.

Anselin, L., Cohen, J., Cook, D., Gorr, W., & Tita, G. (2000). Spatial analyses of crime. Criminal Justice, 4, 213–262.

Appleyard, D. (1981). Livable streets. University of California Press. Balbi, A., & Guerry, A. M. (1829). Statistique comparèe de L’ètata de L’instruction et

du nombre des crimes dans les divers arrondissements des acadèmies et des cours royales de France. Everat.

Bernasco, W., & Block, R. (2011). Robberies in Chicago: A Block-level analysis of the influence of crime generators, crime attractors, and offender anchor points. Journal of Research in Crime and Delinquency, 48, 33–57.

Bernasco, W., & Elffers, H. (2010). Statistical analysis of spatial crime data. In A. R. Piquero & D. Weisburd (Eds.), Handbook of quantitative criminology (pp. 699–724). Springer.

Bernasco, W., & Steenbeek, W. (2017). More places than crimes: Implications for evaluating the law of crime concentration at Place. Journal of Quantitative Criminology, 33, 451–467.

Black, D. J. (1970). Production of crime rates. American Sociological Review, 35, 733–748.

Braga, A. A., Hureau, D. M., & Papachristos, A. V. (2011). The Relevance of micro places to citywide robbery trends: A longitudinal analysis of robbery incidents at street corners and Block faces in Boston. Journal of Research in Crime and Delinquency, 48, 7–32.

Brantingham, P. L., & Brantingham, P. J. (1993). Nodes, paths and edges: Considerations on the complexity of crime and the physical environment. Journal of Environmental Psychology, 13, 3–28.

Bursik, R. J., & Grasmick, H. G. (1993). Neighborhoods and crime: The dimensions of effective community control. Lexington Books. Chicago Fact Book Consortium. (1990). Local community fact book: Chicago metropolitan area. Academy Chicago Publishers.

Deryol, R., Wilcox, P., Logan, M., & Wooldredge, J. (2016). Crime places in context. An illustration of the multi-level nature of Hot Spot Development. Journal of Quantitative Criminology, 32, 305–325.

Eck, J. E., & Weisburd, D. (1995). Crime and Place: Crime Prevention Studies ( Vol. 4). Criminal Justice Press.

Fingleton, B., & Le Gallo, J. (2008). Estimating spatial models with endogenous variables, a spatial lag and spatially dependent disturbances: Finite sample properties. Papers in Regional Science: The Journal of the Regional Science Association International, 87, 319–339.

Grannis, R. (1998). The importance of Trivial streets: Residential streets and residential segregation. American Journal of Sociology, 103, 1530–1564. Grekousis, G. (2020). Spatial Analysis Methods and practice. Describe-exploreexplain through GIS. Cambridge University Press.

Groff, E. R., Weisburd, D., & Yang, S. M. (2010). Is it important to examine crime trends at a Local “Micro” Level?: A longitudinal analysis of Street to Street variability in crime trajectories. Journal of Quantitative Criminology, 26, 7–32. Haberman, C. P., Sorg, E. T., & Ratcliffe, J. H. (2018). The seasons they are a changin’: Testing for seasonal effects of potentially criminogenic places on street robbery. Journal of Research in Crime and Delinquency, 55(3).

Hipp, J., & Boessen, A. (2013). Egohoods as waves washing across the city: A new measure of “neighborhoods”. Criminology, 51, 287–327.

Hipp, J. R. (2007). Block, tract, and levels of aggregation: Neighborhood Structure and crime and disorder as a case in point. American Sociological Review, 72, 659–680.

Hipp, J. R., Kim, Y. A., & Wo, J. C. (2020). Micro-Scale, Meso-Scale, Macro-Scale, and temporal scale: Comparing the relative importance for robbery risk in New York City. Justice Quarterly, 38, 1–25.

Jacobs, J. (1961). The death and life of Great American Cities. Vintage Books. Jendryke, M., & McClure, S. C. (2019). Mapping crime—Hate crimes and hate

groups in the USA: A Spatial analysis with gridded data. Applied Geography, 111, 102072.

Jones, R. W., & Pridemore, W. A. (2019). Toward an integrated multilevel theory of crime at Place: Routine activities, social disorganization, and the Law of Crime Concentration. Journal of Quantitative Criminology, 35, 543–572.

Kim, Y. A., & Hipp, J. R. (2018). Physical boundaries and city boundaries: Consequences for crime patterns on street segments? Crime and Delinquency, 64, 227–254.

- Kim, Y.-A., & Hipp, J. R. (2020a). Pathways: Examining Street network configurations, structural characteristics and spatial crime patterns in Street segments. Journal of Quantitative Criminology, 36, 725–752.
- Kim, Y.-A., & Hipp, J. R. (2020b). Street Egohood: An alternative perspective of measuring neighborhood and spatial patterns of crime. Journal of Quantitative Criminology, 36, 29–66.


Kirk, D. S., & Papachristos, A. V. (2011). Cultural mechanisms and the persistence of neighborhood violence. American Journal of Sociology, 116, 1190–1233.

Lambert, D. M., Brown, J. P., & Florax, R. J. G. (2010). A Two-Step estimator for a spatial lag model of counts: Theory, small sample performance and an application. Regional Science and Urban Economics, 40, 241–252.

Light, M. T., & Harris, C. T. (2012). Race, space, and violence: Exploring Spatial Dependence in structural covariates of white and Black Violent Crime in US Counties. Journal of Quantitative Criminology, 28, 559–586.

Miethe, T. D., & Meier, R. F. (1994). Crime and its social context: Toward an integrated theory of offenders, victims, and situations. State University of New York Press.

Morenoff, J. D., Sampson, R. J., & Raudenbush, S. W. (2001). Neighborhood inequality, collective efficacy, and the spatial dynamics of Urban Violence. Criminology, 39, 517–558.

Openshaw, S. (1983). The modifiable areal unit problem. Geobooks. Ord, J. K., & Getis, A. (1995). Local spatial autocorrelation statistics: Distributional

issues and an application. Geographical Analysis, 27, 286–306.

O’Brien, D. T. (2019). The action is everywhere, but greater at more localized spatial scales: Comparing concentrations of crime across addresses, streets, and neighborhoods. Journal of Research in Crime and Delinquency, 56, 339–377.

O’Brien, D. T., Ciomek, A., & Tucker, R. (2022). How and why is crime more concentrated in some neighborhoods than others? A New Dimension to Community Crime. Journal of Quantitative Criminology, 38, 295–321. https://doi. org/10.1007/s10940-021-09495-9

O’Brien, D. T., & Winship, C. (2017). The gains of greater granularity: The presence and persistence of problem properties in urban neighborhoods. Journal of Quantitative Criminology, 33, 649–674.

Park, R. E., & Burgess, E. W. (1925). The city. University of Chicago Press. Reiss, A. J. (1986). Why are communities important in understanding crime? Crime

and Justice, 8, 1–33.

Rice, K. J., & Smith, W. R. (2002). Socioecological models of automotive theft: Integrating routine activity and social disorganization approaches. Journal of Research in Crime and Delinquency, 39, 304–336.

Sampson, R. J. (2012). Great American city: Chicago and the enduring neighborhood effect. The University of Chicago Press.

Sampson, R. J., Morenoff, J. D., & Gannon-Rowley, T. (2002). Assessing “Neighborhood Effects” Social Processes and New Directions in Research. Annual Review of Sociology, 28, 443–478.

Sampson, R. J., Raudenbush, S. W., & Earls, F. (1997). Neighborhoods and Violent Crime: A multi-level study of collective efficacy. Science, 277, 918–924.

Schnell, C., Braga, A. A., & Piza, E. L. (2017). The influence of community areas, neighborhood clusters, and street segments on the spatial variability of violent crime in Chicago. Journal of Quantitative Criminology, 33, 469–496.

Sherman, L. W., Gartin, P. R., & Buerger, M. E. (1989). Hot Spots of predatory crime: Routine activities and the Criminology of Place. Criminology, 27, 27–56.

Song, J., Spicer, V., & Brantingham, P. (2013). The edge effect: Exploring high crime zones near residential neighborhoods. [Conference session]. 2013 IEEE International Conference on Intelligence and Security Informatics, Seattle, WA, pp.245–250. doi: 10.1109/ISI.2013.6578828

Steenbeek, W., & Weisburd, D. (2016). Where the action is in crime? An examination of variability of crime across different spatial units in the Hague, 2001–2009. Journal of Quantitative Criminology, 32, 449–469.

Tillyer, M. S., Wilcox, P., & Walter, R. J. (2021). Crime generators in context: Examining ‘Place in neighborhood’ propositions. Journal of Quantitative Criminology, 37, 517–546.

U.S. Census Bureau. (2010). American fact finder. http://quickfacts.census.gov/qfd/ states/17/1714000.html Weisburd, D. (2015). The law of crime concentration and the criminology of Place. Criminology, 53, 133–157. Weisburd, D., Bernasco, W., & Bruinsma, G. (2009). Putting crime in its place: Units of analysis in geographic criminology. Springer.

Weisburd, D., Bushway, S., Lum, C., & Yang, S. M. (2004). Trajectories of crime at places: A Longitudinal Study of street segments in the City of Seattle. Criminology, 42, 283–322.

Weisburd, D., Groff, E. R., & Yang, S. (2012). The criminology of place: Street segments and our understanding of the crime problem. Oxford University Press. Whyte, W. F. (1943). Street corner society: The social structure of an Italian slum.

The University of Chicago Press.

Wilcox, P., & Tillyer, M. S. (2018). Place and neighborhood contexts. In J. E. Eck & D. Weisburd (Eds.), Connecting crime to place: New directions in theory and policy (pp. 121–142). Transaction Publishers.

Wilcox, P., Land, K. C., & Hunt, S. C. (2003). Criminal circumstance: A dynamic multicontextual criminal opportunity theory. Walter de Gruyster. Wright, R. T., & Decker, S. H. (1997). Armed robbers in action: Stickups and street culture. University Press of New England.

#### Author Biographies

Cory Schnell is an assistant professor in the Department of Criminology and Criminal Justice at the University of South Carolina. He received his Ph.D. from Rutgers University. His research interests include place-based criminology, policing, and quantitative methods.

Samuel E. DeWitt is an assistant professor in the Department of Criminal Justice and Criminology at the University of North Carolina at Charlotte. He received his Ph.D. from Rutgers University. His research interests include quantitative methods and offender decision-making.

M. Dylan Spencer is an assistant professor in the Department of Sociology and Rural Studies at South Dakota State University. He received his Ph.D. from the University of South Carolina. His research interests include place-based criminology, wildlife crime, and quantitative methods.

