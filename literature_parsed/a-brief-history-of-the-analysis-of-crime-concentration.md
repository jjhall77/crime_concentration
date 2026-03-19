Euro. Jnl of Applied Mathematics (2010), vol. 21, pp. 349–370. c Cambridge University Press 2010 doi:10.1017/S0956792510000082

349

# A brief history of the analysis of crime concentration

## SHANE D. JOHNSON

Department of Security and Crime Science, UCL Jill Dando Institute, University College London, Second Floor Brook House, 2-16 Torrington Place, London WC1E 7HN, UK email: Shane.johnson@ucl.ac.uk

(Received 1 June 2009; revised 17 February 2010; accepted 23 February 2010; ﬁrst published online 15 April 2010)

Decades of research demonstrate that crime is concentrated at a range of spatial scales. Such ﬁndings have clear implications for crime forecasting and police resource allocation models. More recent work has also shown that crime clusters in space and time with a regularity that might improve methods of crime prediction. In this paper I review some of the available evidence and provide illustrations of the types of analysis – spatial and spatio-temporal – conducted hitherto. With a few exceptions, the application of formal Mathematics in the study of space–time patterns of crime has been rather limited, and so a central aim of the paper is to stimulate interest in this area of research.

1 Introduction

Many theories (Merton, 1938; Agnew, 1985) seek to derive an explanation of crime by focusing on those characteristics of the oﬀender – their social status, peer-group associations, biology and so on – that may be associated with criminality. Theories concerned with crime and place acknowledge the role of individual characteristics, but instead generally focus on the role of the environment; in terms of the generation of crime opportunity, the accessibility of those opportunities or in the provocation of criminal behaviour. Academic interest in the role of opportunity and crime occurrence dates back to the eighteenth century (Weisburd et al., 2008) but only relatively recently has this really been pursued systematically. For those interested in what has come to be known

- as environmental criminology (Brantingham & Brantingham, 1981) the preferred theories have an ecological focus which explicitly consider the oﬀender–environment interaction. Methods of analysis have (for example) included the study of the spatial distribution of crime and for such research the focus is generally on sequenced event decisions rather than oﬀender motivations. This paper considers how some of what we have learned may inform methods of forecasting when and where crimes are most likely to occur in the near future at the small area level.


The majority of research concerned with crime patterns has employed a top–down statistical approach to analysis and the application of formal mathematics has been rather limited, meaning that many possibilities exist. Consequently, the aims of the current paper are four-fold: (1) to review some of the research concerned with the spatial and spatiotemporal distribution of crime, and to present some novel analyses; (2) to brieﬂy review

Figure 1. Spatial distribution of domestic burglary for a four-year period in one police area in the UK (Left: Point pattern; Centre: Thematic map using census output area geography; Right: Kernel Density Estimation).

the most apposite theories concerned with spatial and space–time crime patterns; (3) to provide Mathematicians with an idea of the types of police data that may be available for analysis (their strengths and weaknesses); and (4) to illustrate some of the applied, as well as theoretical, purposes for which research of this kind has and might be used. Most of the illustrations provided throughout the paper are for the crime of residential burglary (as deﬁned by the UK Home Oﬃce). What follows begins with a series of illustrations of the ways in which crime has been shown to be concentrated.

2 Spatial concentration 2.1 Concentration at the area level

Research consistently demonstrates that crime is concentrated at a range of spatial scales (Shaw & McKay, 1969; Sherman et al., 1989; Pease, 1998; Ratcliﬀe, 2004; Weisburd et al., 2004). To illustrate, Figure 1 shows the spatial variation in the frequency of domestic burglary at the area level for one police area in a county in the UK for the four year period April 1998–March 2002. The left panel of Figure 1 shows the point pattern for the 12,806 burglary events (for more information about the data, see Johnson & Bowers, 2010). While useful, point patterns can be misleading. For example, multiple points may occur at the same locations thereby masking variation in point density. For this and other reasons, thematic maps – for which the frequency or rate of crime is computed for a series of geographical areas – are often generated. The map shown in the centre panel of Figure 1 was derived by intersecting the point pattern with the UK census output area (OA) geography. The number of homes per OA is around 129, and there are 896 OAs in the map shown. This type of thematic mapping – which in this case shows the count of crime per area – provides a visual impression of spatial variation in the problem and

Burglaries (%)

020406080100

Street segments

Census areas

Expected

0 20 40 60 80 100

Households (%)

Figure 2. Observed (solid lines) and expected (dotted lines) concentration of burglary at the street segment and census area levels.

indicates that the distribution of crime is non-homogeneous. This type of map may be useful for operational policing decision making (but see below), but does not provide a clear indication of the extent to which the crime problem is concentrated.

Figure 2 shows a Lorenz curve (e.g. Tseloni & Pease, 2005) derived using the same data. This was generated by producing an array of the OAs rank ordered by their crime rates (from highest to lowest), and then plotting the cumulative percentage of crimes experienced within the (1–896) areas against the cumulative percentage of homes households located within them. The dotted line indicates the fraction of crime that would be expected for a given percentage of homes if the risk of crime were evenly distributed. These were derived in the following way using Ordnance Survey address point data: N homes – where N is the number of crimes in the data considered – are selected as (virtual) victims from all those available using a uniform random number generator. This selection process is completed with replacement as some homes are expected to be victimised more than once (see below). After each iteration, a Lorenz curve is computed for the sample selected. Repeating this process many times (in this case, 99) represents a Monte Carlo (MC) re-sampling procedure which can be used to compute the mean expected values and to establish the statistical signiﬁcance of any diﬀerences observed. The statistical signiﬁcance of any diﬀerences between the observed and expected values may then be estimated using the following formula (North et al., 2002):

rank + 1 n + 1

, (1)

p =

where n is the number of simulations, and rank is the position of the observed value in a rank ordered array for that OA.

At the area level, the risk of burglary is clearly concentrated in space more than would be expected, assuming a random process (all ps < 0.01). For other types of crime that do not occur at residential addresses, such as street robbery or vehicle crime, the reliability of the geographic coordinates recorded may be questionable and substantial data cleaning is required prior to analysis. For example, in an earlier study (Johnson et al., 2006) we found that for the crime theft from motor vehicle, in one police force area only 55% of crimes had reliable geo-coordinates. In a second area the accuracy rate was 70%. Reasons for inaccuracy in the data include limitations in the geographical databases used to assign coordinates to events and the victim’s inability to provide complete address information regarding crime locations. When an accurate description of the oﬀence location is unavailable, an event is sometimes indexed to the midpoint of a street, with obvious implications for geo-coding accuracy and errors of inference. The estimation of expected values may also be problematic for other types of crime as accurate estimates of the population at risk (e.g. ambient populations for street robbery) may not be readily available.

Nevertheless, the general ﬁnding that crime is concentrated appears to be typical across (most) crime type(s), area and time period of study (Weisburd et al., 2008). It also appears from Figure 1 that areas of high (low) crime tend to be clustered in space, reﬂecting the ﬁrst law of geography (Tobler, 1970). To examine this, the Moran’s I statistic (Moran, 1950) – a simple test of spatial autocorrelation (shown in (2)) – was computed. This conﬁrmed that areas with high counts of crime tend to be co-located (Moran’s I = 0.47, p < 0.001; for rates instead of counts: Moran’s I = 0.43, p < 0.001). Simply put, crime clusters in areas, and areas of high crime also cluster:

Wij(Xi − X)(Xj − X) i (Xi − X)2

N i j Wij · i j

, (2)

I =

where N is the number of spatial units (in this case OAs) indexed by i and j, X is the variable of interest, X¯ is the mean of X and wij is a matrix of spatial weights indexed by i and j

The implications of this type of regularity have been considered from theoretical and practical perspectives. The former are discussed below but in terms of police practice, if (and only if) area level crime patterns are time-stable (Weisburd & Eck, 2004) then the identiﬁcation of those areas that have experienced the most amount of crime in the past should inform the allocation of (limited) resources. In fact, research has demonstrated the crime reductive beneﬁts of so doing for a range of crime types (Sherman & Weisburd, 1995; Weisburd & Green, 1995; Braga & Bond, 2008). Thematic maps such as that shown in Figure 1 are commonly used by the police and others (Chainey & Ratcliﬀe, 2005) but are problematic for at least two reasons. First is the Modiﬁable Areal Unit Problem (Openshaw, 1984) whereby changing the boundary used to derive the maps may aﬀect observed patterns. Second, such maps invite the ecological fallacy (Robinson, 1950) of assuming that risk is evenly distributed within areas. The extent to which this assumption of homogeneity is likely to be reasonable will be inversely related to the size of the polygons considered.

For these reasons, Kernel Density Estimation (KDE) maps are preferred (Chainey & Ratcliﬀe, 2005). Rather than using existing administrative boundaries, maps are derived

using a lattice of regular sized cells and a smoothing function such as a quartic (see (3)). For such an approach, cells with the most crimes within a given radius of, and nearest to, their centroid have the highest density values. Where the cells within the lattice are relatively small, KDE maps provide a more accurate representation of the morphology of the problem. For the purposes of illustration, the right panel of Figure 1 shows an example of a KDE map derived using the same data as that for the thematic map:

3 πτ2

λτ(s) =

di τ

d2i τ2

1 −

2

, (3)

where, λτ(s) = risk intensity value for cell s τ = bandwidth; di = distance of each point (i) within the bandwidth from the centroid of the cell.

Comparison of the two maps demonstrates the problems associated with thematic maps discussed and also illustrates a further problem. That is, the size of the areas can distort the reader’s interpretation of the distribution of the problem (Monmonier, 1996). Large dark areas are eye-catching. Small dark areas are not. However, the latter may be the best places to target resources, depending on the crime reductive strategy employed.

The density function used for Figure 1 represents crime density per unit area. Dual density functions – which divide the density of crime by that for that of opportunity (e.g. density of households) – have only recently been applied in the analysis of crime (Johnson et al., 2008b). Such maps may have less application in the police context than they do for the understanding of crime risk for the simple reason that police resource allocation models are typically driven by volume per unit area rather than risk per crime opportunity.

Whether these types of map provide the most accurate predictions of the future locations of crime is an empirical question and is the subject of our ongoing research. Surprisingly, before we started work on this topic (Bowers et al., 2004), there were no published studies that examined the forecasting accuracy of crime hotspot maps. Nor was there a single paper of which we are aware in which the authors had selected the parameters of a KDE map for theoretical (or even empirical) reasons. I will return to this at the end of the paper.

2.2 Concentration at the street level

A number of studies (e.g. Beavon et al., 1994; Hillier, 2004; Weisburd et al., 2004; Groﬀ et al., 2008) have examined patterns of crime at the street block face or segment level. In the UK, the Ordnance Survey produce polyline data to describe the street network, for which the smallest unit of analysis is the street segment. For the area shown in Figure 1, there are 14,258 street segments for which the mean segment length is 70.3 m and the mean number of homes per segment is 11.5.

- Figure 2 shows Lorenz curves of the observed and expected concentration of burglary at

the street segment level for the same data discussed above. Clearly, some street segments experience more crime than would be expected, assuming uniform risks across homes.

- Figure 3 shows how burglary risk varies at the street segment level for one part of the area examined. The inclusion of the map is purely for illustration, but visual inspection


Figure 3. An example of crime risk at the street segment level (Ordnance Survey Crown Copyright. All Rights reserved).

of it suggests that for this area at least, while there is evident spatial clustering of highrisk street segments it is also the case that one street segment may experience a high rate of crime whilst those adjacent experience little or none. Statistical analyses reported elsewhere demonstrate a regularity to this pattern (Hillier, 2004; Johnson & Bowers, 2010) and suggest that the explanation for the distribution of crime cannot be found entirely in theories which consider sociological processes that operate at the area level. Other factors, which include the conﬁguration of the street network, are at play.

3 Spatial clustering at the point level

Research also suggests that crime is clustered at the point level. One simple approach to detecting such clustering is a nearest neighbour analysis (nNa: Getis, 1964). To do this, for every event the ﬁrst-order nearest neighbour is identiﬁed and the distance between the two computed. The average nearest neighbour distance across all events is then calculated and compared with what would be expected on a chance basis. A number of approaches could be taken to derive the expected value. However, the method typically used is to assume complete spatial randomness (CSR) such that each event could occur at any location within the smallest rectangle that surrounds the study area. The expected value and the

statistical signiﬁcance of that observed is then estimated using the following formulae:

- 1

- 2


nNa expected =

A N

, (4)

nNa standard error =

(4 − π).A 4πN2

, (5)

nNaexpected − nNaexpected S.E.nNa

Z =

, (6)

where A is the area of the minimum bounding rectangle and N is the number of incidents.

For the current data the observed mean nearest neighbour distance was 13.96 m. This can be compared with the expected value of 39.67, and a simple nNa index of clustering computed by dividing the observed value by that expected. A value of one so derived would indicate that the mean nearest neighbour distance observed was exactly equal to that expected, and hence that any spatial clustering observed could have resulted as the consequence of a chance process. For the current data, the observed index of 0.35 suggests that burglaries are clustered much more than a random point pattern. The diﬀerence between the observed and expected values is also statistically signiﬁcant (z = −142.9, p < 0.001). In addition to computing the ﬁrst-order nearest neighbour for each event, polyorder analysis provides a more detailed picture of the degree of clustering. For example, such analysis may indicate whether most crimes are only close to one other or if they are near to many.

One obvious criticism of the above approach is that the null hypothesis of CSR will rarely be reasonable as the opportunity structure for crime is rarely (if ever) likely to be uniform over space; burglary can only occur where houses exist. Consequently, the expected mean nearest neighbour distance is likely to be overestimated. Thus, some (or even all) of the spatial clustering observed could be explained by the spatial distribution of targets rather than being a function of (assumed and) more interesting target selection processes on the part of oﬀenders.

A simple alternative not subject to this criticism – but not applied hitherto – is to compute the expected distribution with reference to the actual distribution of opportunities; for burglary, the distribution of households. To do this, the same type of MC simulation

- as described above was used except that this time for all homes selected, nearest neighbour distances were computed, and the mean nearest neighbour distance calculated for all orders of interest.


The left panel of Figure 4 shows the expected distribution – derived using 99 iterations of an MC simulation – for the ﬁrst-order nearest neighbour distance. The standard deviation of the distribution of 0.15 is the value estimated by the standard error shown in (2). In this case, the observed value is located in the extreme left tail of the expected distribution; values this extreme were never generated by any of the iterations of the MC simulation.

The right panel of Figure 4 shows the neighbour indices for orders 1–20, calculated using both the MC procedure and the formulae which assume CSR. The nearest neighbour indices computed using the former are substantially (1.5–1.95 times) larger than those

0.00.51.01.52.0

Density

12 14 16 18 20

Expected nearest neighbour distance

0.00.20.40.60.81.0

Observed/expected

MC simulation

### CSR

5 10 15 20

Nearest neighbour order

Figure 4. Nearest neighbour statistics (Left: Observed and expected distribution for the ﬁrst order; Right: Observed/expected for orders 1–20).

calculated using the latter, but they are also lower than the expected value of 1 (the null hypothesis of no clustering). In short, for the area considered burglary is clustered in space more than would be expected on the basis of the spatial distribution of opportunities and a random data generating process. This is true for all orders of nearest neighbour distances shown (all of which are statistically signiﬁcant at the 0.01 level), although the size of the eﬀect decays across orders. The results also demonstrate how unreasonable the assumption of CSR really can be.

3.1 Repeat victimisation of the same location

Research concerned with repeat victimisation (e.g. Polvi et al., 1991; Johnson et al., 1997; Pease, 1998; Farrell, 2005; Sagovsky & Johnson, 2007) of the same person or household indicates that crime clusters at this scale too. Figure 5 shows a Log–Log plot of the number of homes burgled N times for a sample of police recorded crime data for one UK County reported elsewhere (for more detail, see Johnson, 2008). For the four year interval considered, 10.5% (N = 5,431) of all burglaries (N = 50,691) were incidents of repeat victimisation. This can be compared with what would be expected assuming the data generating process was a simple Poisson process, the latter derived using formula or the MC approach described above. Doing so indicated that the observed frequency of repeat victimisations was 2.5 times the expected frequency of 2,113 assuming a simple Poisson process. I return to this later, but for now suﬃce it to say that the observed pattern exceeds what would be expected if all homes were at an equal risk, and events were independent (Trickett et al., 1992).

However, the observed frequency is likely to underestimate the true extent of concentration at this scale. First, not all crime is reported to the police. For crimes such as burglary, reporting rates (of around 81%) are higher than for many other crimes (e.g. for assault with no injury the ﬁgure is 36%: Nicholas et al., 2007) in part due to the

Figure 5. Log–Log plot of the frequency of homes burgled 1 to 7 times.

reporting requirements imposed by insurance companies. Nevertheless, research indicates that the likelihood of reporting is negatively associated with victimisation experience (Xie

- et al., 2006). Thus, repeat victimisation in particular is likely to be underrepresented in police data due to the under-reporting issue. A second issue is that for many police forces, addresses are recorded in free-text ﬁelds which allow the inconsistent (or incomplete) recording of the same address (Johnson et al., 1997) across oﬀences, with obvious implications for the identiﬁcation of repeat victimisation.

The extent of this problem can be illustrated with ﬁgures from the British Crime Survey. Now conducted on a rolling basis, around 40,000 interviews are conducted per annum in England and Wales to measure the victimisation experience (amongst other things) of the general public over the previous 12 months. Analyses of these data suggest that around 29% of all incidents of domestic burglary are incidents of repeat victimisation (Nicholas

- et al., 2007). Consequently, the patterns shown in the data presented here should be considered conservative, particularly for chronic victimisation.


4 Theoretical explanations for the spatial concentration of crime

That crime is concentrated has received substantial academic attention and numerous theoretical models have been proposed. Some theories focus largely on time-stable factors while others consider more dynamic inﬂuences of crime risk. Some focus on factors which operate at the level of the neighbourhood or area (Sampson & Raudenbush, 1999), whilst others consider inﬂuences at the more micro level of analysis such as the street and/or individual household (Jeﬀrey, 1971).

Theories with an ecological perspective include routine activity (Cohen & Felson, 1979) and crime pattern theory (Brantingham & Brantingham, 1993a). The former speciﬁes that direct contact predatory crimes can only occur when a motivated oﬀender and potential target converge in space and time in the absence of a capable guardian. Guardians may be police oﬃcers but they may be anyone (e.g. neighbours or pedestrians) or anything (e.g.

CCTV) that might deter criminal activity. A key element of routine activity theory is that illegitimate activity is generally parasitic in nature feeding oﬀ the rhythms of everyday life. As consequence, the frequency and nature of the convergence that facilitates crime occurrence is determined by the degree to which people’s (victim and oﬀender) routine activities overlap (or for burglary the extent to which they do not). Unlike theories which focus on the role of the oﬀender alone, according to routine activity theory, even if the population of oﬀenders were to remain stable, changes in crime (positive or negative) are expected to occur as a direct result of changes in the population – or routine activities of – suitable targets or capable guardians against crime.

Amongst other things, pattern theory (Brantingham & Brantingham, 1993b, 1995) makes explicit the spatial dimension of routine activity theory. Set notation is used to specify the role of oﬀender routine activity nodes (e.g. the home, places of work, etc.), paths (the routes between nodes), awareness spaces that evolve as consequence of routine activities and the edges that delineate those spaces of which oﬀenders are and are not aware. The topology of crime concentration is assumed to reﬂect the intersection of collective oﬀender awareness spaces and suitable crime opportunities; oﬀenders cannot commit crimes at locations of which they are unaware or against targets they do not have the necessary skills to attack.

Rational choice theory (Cornish & Clarke, 1986) considers more explicitly the oﬀender decision making process. Drawing on ideas from disciplines including economics, sociology and psychology, rational choice theory considers two levels of decision making: (1) whether the oﬀender should continue or desist from criminal activity; and (2) eventlevel decisions. When engaging in the latter the oﬀender is believed to engage in a simple form utility maximisation, weighing up the associated risks of a particular crime against potential beneﬁts1. Decision making is assumed to be bounded insofar as the oﬀender will routinely evaluate incomplete information about particular situations, and will process the information in idiosyncratic ways informed by past experience. Moreover, decision making may often be relatively heuristic rather than requiring signiﬁcant cognitive eﬀort. Crime scripts, which represent evolved cognitive templates of preferred strategies are thought to aid in the process (Brantingham & Brantingham, 1993; Cornish, 1994).

Together, the three theories suggest that where the routine activities of oﬀenders and victims overlap in space and time to provide suﬃcient (and suitable) crime opportunities in the absence of adequate guardianship, hotspots of crime will form. For theories of crime and place then, the goal is to identify that set of features of the environment – social or physical – that inﬂuence these conditions with some regularity. What the relevant unit of analysis is to seek these explanations – or how explanations at the diﬀerent levels should interact – is a matter of contemporary debate (see Weisburd et al., 2008).

To illustrate, consider that whilst area-level explanations might provide a plausible explanation for why crime concentrates at the census OA level, it is diﬃcult to see how they could explain the variation in risk observed within areas as hinted at in Figure 3 and shown systematically elsewhere (Beavon et al., 1994; Hillier, 2004; Johnson & Bowers,

1 Beneﬁts need not be ﬁnancial. They may be psychological in the sense that committing a crime may provide excitement, or the respect of an oﬀender’s peer-group. Other possibilities exist but the idea is that the oﬀender’s goal is utility maximisation.

2010). This disconnect between area-level explanations and empirical ﬁndings also applies to repeat victimisation, a point to which I will return below. Crime pattern theory (Brantingham & Brantingham, 1993b) represents one attempt to integrate the diﬀerent levels of explanation by explicitly considering how the urban backcloth –which includes spatial variation in the conﬁguration of the street network, social and other factors – shapes oﬀender awareness of crime opportunities.

A conclusion that might be drawn from many macrolevel, mesolevel and even microlevel level explanations of crime is that, whilst temporal variation in crime concentration is to be expected, the factors which inﬂuence crime placement will be relatively time-stable. And, consequently, that patterns of victimisation can be explained in terms of population heterogeneity: some people, houses and areas are simply more attractive crime targets than others and hence a range of diﬀerent oﬀenders will target them.

5 Temporal clustering

Patterns of crime tend also to cluster in time (Ratcliﬀe, 2002). Clear seasonal trends have been observed for some types of crime (Farrell & Pease, 1994) but not others (Hird, 2007). Where they occur, seasonal trends likely reﬂect changes in routine activity patterns. For example, in places where tourism is a major industry, the routine activity of places will be quite diﬀerent during high and low season.

Perhaps discussed less frequently (but implicitly assumed), it is also clear that for time series data (collected at the macrolevel at least) counts of crime are serially correlated; counts of crime are more similar for adjacent time periods than for those further apart. For example, analysis of the weekly counts of crime for the data discussed in the section on repeat victimisation – and shown in the left panel of Figure 6 – indicate that the ﬁrstorder serial auto-correlation coeﬃcient of 0.56 is statistically signiﬁcant (p < 0.001). So too is the second order partial auto-correlation coeﬃcient (which partitions any second-order correlation that may be explained by the ﬁrst-order process) of 0.291 (p < 0.001). This suggests that crime levels – at the macroscale at least – cannot be explained by timeinvariant processes alone. At this level of resolution, possible explanations are numerous and range from the mundane, such as the inﬂuence of changes in police recording practices, to those more interesting such as the impact of crime reduction strategies or systematic changes in the opportunity for crime to occur, such as the impact on vehicle related crime of the introduction of car immobilisers (Farrell et al., 2008). However, while such ﬁndings are useful for testing macrolevel theories of crime, they are unlikely to inform methods of crime forecasting at the small area level, other than to indicate that the risk of crime may generally be changing in one direction or the other. Such analysis could be repeated at the small area level, but as the size of the space–time units of analysis (e.g. weekly crime counts for neighbourhoods) decrease, the combination of small observed frequencies and the volatility in the data would limit the reliability of the analysis.

Considering time in a diﬀerent way that may more usefully inform the task of forecasting

- at the small area level, for repeat burglary victimisation, the elapsed time between events is typically short, with most events occurring within 1–2 weeks of an antecedent. The right panel of Figure 6 shows the time course of repeat victimisation for the data analysed above. To ensure that the temporal signature observed was not simply a statistical artefact,


Burglaries

0100200300400

0 50 100 150 200

Week

Number of repeats

50100150200

0 20 40 60 80 100

Weeks between events

Figure 6. Weekly time series data for burglary (left panel: vertical lines indicate the ﬁrst week of January for each year) and the time course of repeat victimisation (right panel).

a moving time frame is used for all events so that a historic interval of 12 months is available for every incident analysed2.

The time course of repeat victimisation is a distinct signature and intuitively it is diﬃcult to see how this could be generated by theories which focus on relatively timestable inﬂuences of crime risk, such as population heterogeneity. The obvious alternative– and that suggested by the signature – is that the risk of burglary at a particular location is elevated or boosted following a ﬁrst oﬀence (Pease, 1998), most likely reﬂecting a revealed preference of oﬀenders to return to successfully burgled locations. Reasons for so doing would include the fact that their knowledge of previously victimised homes will be better than for those that remain unknown, and because they may not have been able to take everything during the ﬁrst oﬀence or they suspect that stolen items will have been replaced by the time they revisit (Pease, 1998). In contrast to the boost hypothesis, theories of risk heterogeneity do not assume that repeat victimisation of the same property will be the work of the same oﬀender, rather that some homes will simply be repeatedly targeted by diﬀerent oﬀenders. The apparent problem with theories of risk heterogeneity is that on the face of it, they would not predict a distinct time course for repeat victimisation.

However, it is possible that this diﬃculty is illusory and may be explained by an artefact of conducting analyses using data that have been aggregated across a large area. In the current example the data shown are for an entire UK county. This is potentially problematic as the analysis of data aggregated across heterogeneous populations is known to produce unexpected results not unlike those described (Vaupel & Yashin, 1985; Morgan, 2001; Johnson, 2008). The problem for causal inference is that the researcher may commit the ecological fallacy of assuming that the aggregate patterns reﬂect those for individual properties or areas when in fact they are the artefact of aggregating data.

2 For a twelve month interval there are more one-week intervals than there are two-week intervals, and so on.

To illustrate, consider an area in which there are two classes of home; those with a stable high risk of victimisation and those with a stable low risk. Even on a chance basis, some homes from each group would experience repeated victimisations. If the patterns of repeat victimisation were generated by a random process (insofar as the risk of victimisation were only a function of the time-stable probability for each home), and analyses were performed independently for each class of home, the probability of a repeat victimisation occurring for any interval of interest (1 to n) would be stable within groups (assuming a moving time window is used to identify repeats, see above). However, if the data for the two groups were analysed together, a curve may be generated. The high risk homes would be victimised with a higher frequency and would be more likely to be re-victimised. Per unit of elapsed time following an index event, the risk of re-victimisation for homes of this kind would be highest.

Determining whether or not the observed time course of repeat victimisation – which has proved ubiquitous across published studies (Pease, 1998; Farrell, 2005) – can be explained in this way is important as it should inform both theory and police practice. To examine this hypothesis, in a recent study (Johnson, 2008) the patterns generated by a series models of risk heterogeneity were examined using microsimulation. Rather than testing a purely theoretical model, real world data were used to calibrate the model. These included: (1) Ordnance Survey address point data to generate a population at risk;

- (2) police recorded crime data for the crime of burglary, to estimate the risk of burglary

at the small area level, in this case using the census OA geography for the county; and

- (3) UK census data. Having generated a basic representation of the population at risk, simple versions of


the model were tested in the following way. Simulations were run for intervals of four virtual years. On each virtual day, homes were selected as victims using a uniform random number generator. For a baseline Poisson model, all homes had the same probability of being selected as victims each day, whereas for a simple model of risk heterogeneity, the likelihood of selection for each home was a function of the time-stable risk associated with the area within which it was located. For a series of further models, additional heterogeneity was introduced by increasing (decreasing) the risk to a fraction of homes within each virtual OA using one or more scaling factors. These were selected on the basis of styalised facts derived from data such as British Crime Survey (BCS). For example, it is evident from the BCS that homes with more than two security features are at 1/10 the risk of those with less, and that around 28% of homes have two or more security features.

A number of the risk heterogeneity models tested generated patterns of concentration at the individual household level that resembled those shown in Figure 5. None generated the distinct time course described above. In contrast, a simple Poisson model in which the risk to victimized homes was temporarily elevated (up to a limit) was able to generate the time course, but not the pattern of spatial concentration generated by the risk heterogeneity models. Combining both risk heterogeneity, as measured at the small area level, and a boosting parameter generated both the spatial concentration observed in the data and the time course of repeat victimisation. Thus, it would seem that neither the risk heterogeneity or boost hypothesis in isolation can explain the observed patterns; both have a part to play. Determining the precise contribution of each and if and how this varies over space and time would be a useful next step.

Considering the temporary elevation in risk that victimised homes appear to experience this could be generated by a number of processes. While the most parsimonious is that repeat victimisation is the work of returning oﬀenders, other possibilities exist. Thus, diﬀerent research methods are necessary to examine the theory properly. Data from two other types of study are particularly persuasive. First, interviews with burglars (Wright & Decker, 1994) indicate that many oﬀenders return to previously targeted homes for reasons that are consistent with rational choice theory:

‘I always go back [to the same places] because, once you’ve been there, you know just about when you been there before, and when you can go back. And every time I hit a house, it’s always the same day [of the week] I done been before cause I know there ain’t nobody there’

(oﬀender 51, Wright & Decker (1994), p. 69)

Second, the analysis of burglaries detected by the police provide support for the boost hypothesis (Kleemans, 2001). In particular, recent work shows that for samples of detected repeat burglaries in both the Netherlands (Bernasco, 2008) and the UK (Johnson et al., 2009), around 98% of repeat burglaries that occur within one week are the work of returning oﬀenders, whereas for those that occur after three months, less than one-third are committed by the same oﬀender(s).

Of course, these types of study are subject to sampling bias. For example, oﬀenders interviewed by researchers are generally recruited from prisons or through contact with the police. Thus, even if they were randomly selected from available samples, while they may be representative of the population of oﬀenders detected by the police, they may not be representative of the general population of oﬀenders. This problem is particularly acute given that detection rates for recorded crimes such as burglary are typically low (generally between 5%–25%, e.g. Mitchell & Babb, 2007). Moreover, those who participate in interviews are volunteers and so may diﬀer from the population of detected oﬀenders. For these reasons, it is important to triangulate results from studies that employ diﬀerent methods, such as simulation.

6 Space–time clustering: oﬀender as forager?

On the basis of the data, targeting homes previously victimised quickly appears to be a strategy adopted by (at least) some oﬀenders. From a theoretical perspective, we have proposed that such ﬁndings may indicate that some oﬀenders engage in foraging activity much like that observed across species (Johnson & Bowers, 2004; Johnson et al., 2008a, 2009). To elaborate, the precepts of optimal foraging theory are that the aims of foraging – itself a resource intense activity – are to maximise resources acquired, whilst minimising search time and the risk of exposure. Targeting previously victimised households for which the outcome and associated risks were acceptable may reﬂect a simple foraging strategy; the oﬀender would be targeting those homes about which something is already known, and additional search time would be unnecessary.

Consequently, in more recent work, the possibility that repeat victimisation represents a special case of a more pattern general pattern of foraging activity has been explored. To elaborate, consider that the forager (animal or human) operates under spatial and

temporal constraints. Potential targets are likely to be clustered in space. Within clusters there will be variation in target attractiveness but targets nearest to each other are likely to be most similar, the association between propinquity and similarity reﬂecting the ﬁrst law of geography (Tobler, 1970). Finding locations that fulﬁl the forager’s requirements will involve search strategies and movement decisions. For the rational forager (Cornish & Clarke, 1986), such decisions must be informed by what is learned during foraging.

Having targeted a particular home for the ﬁrst time, a burglar acquires knowledge to inform future targeting decisions. This may concern the internal layout of a burgled property, the ease of access and escape, the goods to be found were the oﬀender to return, the risks of identiﬁcation and so on. This knowledge is likely to reduce uncertainty about nearby homes. Just as ﬂowers in a cluster are likely to share nutritional value (Pyke, 1984), homes proximate to each other are likely to share architectural features, levels of natural surveillance and occupant aﬄuence and routine activities. A forager seeking a strategy aﬀording an acceptable balance of rewards and risks might favour homes about which most is known. This may involve returning to previously burgled homes, and also those nearby.

Consistently targeting the same areas is likely to be sub-optimal because there will be a limited population of targets and resources will eventually be depleted if the oﬀender does not move. There may also be an increased risk of identiﬁcation over time. Rather than targeting locations randomly, an optimal forager would be expected to conserve the time and energy expended in searching for the next target, and make targeting decisions with available information regarding risks and rewards. For these reasons, over time oﬀenders would be expected to vary the areas targeted, but with a gravitational inﬂuence of the oﬀender’s routine activity nodes.

To examine this hypothesis, a number of diﬀerent approaches to analysis have been employed. In the early work (Townsley et al., 2003; Johnson & Bowers, 2004a, 2004b; Bowers & Johnson, 2005; Johnson et al., 2007a), studies were conducted to determine whether it is the case that the risk of burglary clusters in space and time. To examine this hypothesis, techniques originally developed to detect disease contagion were adapted for the study of crime. The method which has been used most frequently is the Knox approach (Knox, 1964; Besag & Diggle, 1977). For this method, each crime is compared with every other and the distance and time between them computed. A contingency table is then populated to summarise how many pairs of crimes occurred within 1 to d metres and 1 to t days of each other,.....(n −1)d and nd metres and (n − 1)t and nt days of each other. The dimensions of the contingency table are arbitrary but typically speciﬁed so as to provide insight into the hypothesis of interest. A Monte Carlo simulation is used to determine the expected distribution and associated p-values, assuming the timing and location of events are independent. Having computed the expected frequencies for each cell of the contingency table, a Knox ratio may be derived by dividing the observed cell frequency by the mean of that expected (Johnson et al., 2007a). A value of 1 would indicate that the observed frequency was exactly equal to that expected (the null hypothesis).

If crime clusters in space and time there should be an over-representation of event pairs that occur near to each other in space and time. To provide an illustration, Table 1 shows the results for a sample of the burglary data shown in Figure 1. In line with the forager hypothesis, more pairs of events occurred near to each other in space and time than

Table 1. Knox analysis (ratios in bold are statistically signiﬁcant, p < 0.01).

Days between event pairs 1–14 15–28 29–42 43–56 57–70 71–84 85–98 98–112

Distance between event pairs

Same 3.17 1.48 1.32 1.36 1.00 0.81 1.19 1.32 1–100 m 1.39 1.16 1.07 0.97 0.97 1.00 1.09 0.96 101–200 m 1.20 1.08 1.06 1.02 1.04 0.99 0.98 1.02 201–300 m 1.13 1.10 1.05 1.00 1.02 0.98 1.04 1.00 301–400 m 1.12 1.07 1.01 1.00 0.97 1.00 1.00 1.02 401–500 m 1.06 1.08 1.04 1.02 0.99 1.01 0.98 0.99 501–600 m 1.02 0.99 1.01 1.04 1.01 1.00 1.02 1.01 601–700 m 1.00 1.01 0.96 1.01 1.03 1.02 1.02 1.00 701–800 m 1.01 0.99 0.98 0.98 0.98 1.01 1.01 1.05 801–900 m 0.99 0.97 1.01 0.96 0.99 1.02 1.00 0.98 900 m to 1 km 0.98 0.96 0.96 1.01 0.99 1.02 0.97 1.01

would be expected if it were the case that their timing and location could be explained in terms of risk heterogeneity alone. The eﬀect appears to decay in space in time and this pattern reﬂects that of all studies so far published, including a cross-national comparison of patterns of burglary across ﬁve diﬀerent countries (Johnson, et al., 2007a). Similar patterns have been observed for vehicle crime in the UK (Johnson et al., 2009), gun crime in the US (Ratcliﬀe & Rengert, 2008), and insurgent attacks in Iraq (Townsley et al., 2008; Johnson & Braithwaite, 2009).

Of course, the patterns shown in Table 1 could be generated by a range of processes. To examine the forager hypothesis, researchers have examined patterns in crimes detected by the police. Such analysis shows that for detected burglaries in the Netherlands (Bernasco,

- 2008) 89% of burglaries that occur within 7 days and 100 m are the work of the same oﬀender(s), whereas for events that occurred within 100 m and more than three months apart, only 3% were the work of the same oﬀender(s). Almost identical results have been reported for detected burglaries and vehicle crime in the UK (Johnson et al., 2009).

One concern with such results is that they may simply reﬂect a bias in the types of crimes detected by the police. For a variety of reasons (Bernasco, 2008; Johnson et al.,

- 2009), the possibility exists that detectives are more likely to link and consequently detect two or more crimes committed by the same oﬀender if they occur close in time and space. Thus, the above ﬁndings may reﬂect police detection strategies rather than oﬀender targeting decisions. To test this hypothesis, Johnson et al. (2009) examined patterns in crimes detected by the police across two crime types (burglary and theft from motor vehicle) for which it had been shown that the timing and location of the two types of event were independent of each other in space and time. That is, for the area studied, when a burglary oﬀence occurred at one location an incident of theft from motor vehicle crime was no more likely to occur nearby in the next few days than it was in the next 9–10 months. For such a data set, evidence in favour of the detection bias hypothesis would be provided if it were found that pairs of events, one of each type, were more likely


to be cleared to the same oﬀender(s) if they occurred near to each other in space and time. In support of the oﬀender as forager hypothesis, no such pattern was found. Further evidence in support of the forager hypothesis comes from recent interviews with oﬀenders, some of whom articulated strategies in line with those discussed (Summers et al., 2010).

7 Burglary forecasting

The ﬁndings discussed have potential implications for burglary forecasting, but to diﬀering extents depending upon the forecast window of interest. Where forecasts are generated for long intervals of time (e.g. 1 year), the most appropriate approach to analysis would be to quantify the time-stable variation in risk across spatial units, discounting any shortterm or random ﬂuctuation. Simply computing KDE maps using data aggregated for a long interval of time is one approach, but as has been discussed elsewhere this may be susceptible to error if there are uncharacteristic ﬂuctuations in crime risk at some locations for even a few intervals of time (Johnson et al., 2008b). One simple solution to correct for this is to compute a time series of KDE maps for an area and to then compute a mean intensity value for each cell of the lattice using the logged values for the series (Johnson et al., 2008b). Other approaches exist but have not been explored hitherto.

Where the aim of forecasting is to predict where crime is likely to occur in the near future, in addition to identifying those locations that tend to appeal to oﬀenders generally, the aim is to attempt model any regularities in active oﬀender targeting strategies that might inform what will happen next. Methods of crime hot-spotting such as KDE do not do this.

The ﬁnding that oﬀenders appear to swiftly return to recently victimised locations and those nearby is something that we have incorporated into simple forecasting methods (Bowers et al., 2004; Johnson et al., 2007b, 2008a). The exact formula used may be speciﬁed in a variety of ways but one general form which is used to compute risk intensity values for a lattice of regular sized cells, is shown as (7):

λτ(s) =

ci τ∩ei υ

1 (1 + ci) ∗

1 (1 + ei)

, (7)

where, λτ(s) = risk intensity value for cell s τ = spatial bandwidth; υ = temporal bandwidth; ci = number of cells between each point (i) within the bandwidth and the cell; ei = weeks elapsed for each point (i) within the temporal bandwidth.

As with KDE, a spatial decay function is used. Unlike KDE, this is used for theoretical reasons, rather than to simply enhance the visual elegance of the map produced or to address the MAUP. Moreover, for this model the timing of events is considered; recent events are assigned more importance than those that occurred in the distant past. By including parameters concerned with the timing and location of events, the equation is intended to model the contagion-like process predicted by the oﬀender as forager hypothesis and the patterns observed in crime event data. Additionally, the spatial bandwidth selected for the model is informed by theory, being the distance over which the Knox analysis suggests the risk of victimisation shows a contagious-like eﬀect (Bowers et al., 2004). For KDE, the bandwidth selected is typically arbitrary.

Figure 7. Predictive accuracy of prospective mapping and KDE for one seven-day forecast (adapted from Johnson et al., 2008a).

An alternative approach to forecasting would be to generate KDE maps using data for only very recent periods (e.g. the last two weeks). This is what many police forces in fact do. However, given the evident ﬂuidity of crime patterns, this may lead to resources being directed to the right locations but at the wrong times. Moreover, the advantage of equations of the form shown in (7) – or variations of it (Mohler et al., 2010) – is that they model both recent activity as well as spatial variation in long-term risk heterogeneity.

Across a series of studies we have compared the predictive accuracy of diﬀerent types of hotspot mapping with the method described by (7), a technique referred to as prospective mapping to diﬀerentiate it from the more retrospective methods typically used. The basic approach to evaluation is to produce a forecast for each model using data for the same period of time and to then determine what fraction of events that occur over the next (say) seven days take place in the locations predicted to be the most at risk by each method. This fraction could then be divided by the size of the search area speciﬁed by the method used but for simplicity and to make the comparisons fair, the approach we have taken is to consider the fraction of crimes identiﬁed for areas of the same size (across methods) or for areas of a range of diﬀerent sizes. To illustrate, Figure 7 shows the results of one such comparison for KDE and prospective mapping (for more detail, see Johnson et al., 2008a). The grey lines indicate chance expectation generated by 99 runs of a Monte Carlo simulation (dashed line: mean expected accuracy; solid line 95th percentile). Comparisons for a series of forecasts indicate that the diﬀerences between the two methods are statistically signiﬁcant. This ﬁnding has been replicated in other work using data for diﬀerent geographic areas and intervals of time (Johnson et al., 2007b).

Modiﬁcations of the prospective approach which incorporate data on the density and location of households and street segments have been shown to improve forecast accuracy still further (Johnson et al., 2008a). An obvious advantage of taking a more theoretical approach to crime forecasting than has previously been the case is that it provides the opportunity to develop the method further. If, for example, the forager hypothesis has

validity, then more sophisticated models may be developed to take account of how the geometry and connectedness of the street network might inﬂuence foraging decisions, rather than assuming that risk will spread uniformly over space (Johnson & Bowers, 2007). The contribution of time-stable and more dynamic processes may also be more explicitly speciﬁed, calibrated and modelled (see Johnson et al., 2008a, 2009; Mohler et al., 2010).

8 Conclusion

The ﬁrst aim of this paper was to discuss and illustrate research concerned with the spatial and temporal distribution of crime. The studies reviewed, and the new analyses presented, were also intended to highlight the types of data that might be available for analysis and the strengths and biases associated with each of them. It should be evident from what has been reviewed that crime clusters in both dimensions and does so with a regularity that should inform both criminological understanding and police practice. In addition to crime forecasting for police resource allocation models, understanding the data generating processes underlying crime patterns should inform methods for evaluating the impact of crime reduction interventions (Johnson, 2009), for which a literature exists in its own right. With a few exceptions (Short et al., 2009; Mohler et al., 2010; Pitcher, 2010), the application of formal Mathematics in the study of space–time crime patterns has been rather limited, and so a second central aim of this paper was to try to stimulate interest in this area of research as the author believes that Mathematicians have much to oﬀer.

References

Agnew, R. (1985) A revised strain theory of delinquency. Soc. Forces 64, 151–167. Beavon, D. J., Brantingham, P. & Brantingham, P. (1994) The inﬂuence of street networks on the

patterning of property oﬀenses. In: R. Clarke (editor), Crime Prevention Studies Vol II, Willow Tree Press, New York.

Bernasco, W. (2008) Them again? Same oﬀender involvement in repeat and near repeat burglaries. Eur. J. Criminol. 5, 411–431.

Besag, J. & Diggle, P. (1977) Simple Monte Carlo tests for spatial pattern. Appl. Stat. 26, 327–333. Bowers, K. J. & Johnson, S. D. (2005) Domestic burglary repeats and space-time clusters: The

dimensions of risk. Eur. J. Criminol. 105, 67–92. Bowers, K. J., Johnson, S. D. & Pease, K. (2004) Prospective hot-spotting: The future of crime mapping? Br. J. Criminol. 105, 641–658. Braga, A. & Bond, B. (2008). Policing crime and disorder hot spots: A randomized controlled trial. Criminology 46, 577–607. Brantingham, P. & Brantingham, P. (1981) Environmental Criminology, Sage, Beverly Hills.

- Brantingham, P. & Brantingham, P. (1993a) Environment, routine and situation: Toward a pattern theory of crime. In R. V. Clarke & M. Felson (editors), Routine Activity and Rational Choice, Transaction Publishers, New Brunswick, pp. 259–294.
- Brantingham, P. & Brantingham, P. (1993b) Nodes, paths and edges: Considerations on the complexity of crime and the physical environment. J. Environ. Psychol. 13, 3–28.


Brantingham, P. & Brantingham, P. (1995) Criminality of place: Crime generetors and crime attractors. Eur. J. Criminal Policy Res. 105, 5–26. Chainey, S. & Ratcliffe, J. H. (2005) GIS and Crime Mapping, Wiley, London.

Cohen, L. & Felson, M. (1979) Social change and crime rate trends: A routine activity approach. Am. Sociol. Rev. 105, 588–608. Cornish, D. (1994) The procedural analysis of oﬀending and its relevance for situational prevention. Crime Prevention Studies Volume 3, Criminal Justice Press, New York. Cornish, D. & Clarke, R. V. (1986) The Reasoning Criminal: Rational Choice Perspectives on Oﬀending, Springer-Verlag, New York. Farrell, G. (2005) Progress and prospects in the prevention of repeat victimization. In: N. Tilley

(editor), Handbook of Crime Prevention and Community Safety, Willan, Cullompton, pp. 145–172. Farrell, G. & Pease, K. (1994) Crime seasonality: Domestic disputes and residential burglary in

Merseyside 1988–90. Br. J. Criminol. 34, 487–498. Farrell, G., Tilley, N., Tseloni, M. & Mailley, J. (2008) The crime drop and the security hypothesis. Br. Soc. Criminol. Newslett. 62, 17–21. Getis, A. (1964) Temporal land-use pattern analysis with the use of nearest neighbour and quadrate methods. Ann. Assoc. Am. Geogr. 54(3), 391–399.

Groff, E., Weisburd, D. & Morris, A. (2008) Where the action is at places: Examining spatiotemporal patterns of juvenile crime at places using trajectory analysis. In: D. Weisburd, W. Bernasco & B. G. J (editors), Putting Crime in its Place, Springer, New York.

Hillier, B. (2004) Can streets be made safe? Urban Des. Int. 9, 31–45. Hird, C. A. (2007) Seasonaility in recorded crime: Preliminary ﬁndings, Home Oﬃce, London. Jeffrey, C. R. (1971) Crime Prevention Through Environmental Design, Sage, Beverly Hills.

- Johnson, S. D. (2008) Repeat burglary victimization: A tale of two theories. J. Exp. Criminol. 4, 215–240.
- Johnson, S. D. (2009) Potential uses of computational methods in th evaluation of crime reduction activity. In: J. Knuttson & N. Tilley (editors), Crime Prevention Studies vol 24, Willan, Cullompton.


Johnson, S. D., Bernasco, W., Bowers, K. J., Elffers, H., Ratcliffe, J., Rengert, G., et al. (2007a) Near repeats: A cross national assessment of residential burglary. J. Quant. Criminol. 105, 201–219.

Johnson, S. D., Birks, D. J., McLaughlin, L., Bowers, K. J. & Pease, K. (2007b) Prospective Mapping in Operational Context. Home Oﬃce, London.

- Johnson, S. D. & Bowers, K. J. (2004a) The burglary as clue to the future: The beginnings of prospective hot-spotting. Eur. J. Criminol. 105, 237–255.
- Johnson, S. D. & Bowers, K. J. (2004b) The stability of space-time clusters of burglary. Br. J. Criminol. 105, 55–65.


Johnson, S. D. & Bowers, K. J. (2007) Burglary prediction: The roles of theory ﬂow and friction. In: G. Farrell, K. J. Bowers, S. D. Johnson & M. Townsley (editors), Imagination for Crime Prevention: Essays in Honour of Ken Pease, Willan, Cullompton.

Johnson, S. D. & Bowers, K. J. (2010) Permeability and Burglary Risk: Are Cul-de-sacs safer? J. Quant. Criminol., in press

Johnson, S. D., Bowers, K. J., Birks, D. & Pease, K. (2008a) Predictive mapping of crime by ProMap: Accuracy, units of analysis and the environmental backcloth. In: D. Weisburd, W. Bernasco & G. Bruinsma (editors), Putting Crime in its Place: Units of Analysis in Spatial Crime Research. Springer, New York.

Johnson, S. D., Bowers, K. J. & Hirschfield, A. F. (1997) New insights in to the spatial and temporal distribution of repeat victimization. Br. J. Criminol. 37, 224–241.

Johnson, S. D. & Braithwaite, A. (2009) Spatio-Temporal Modelling of Insurgency in Iraq. In: J. D. Freilich & G. R. Newman (editors), Reducing Terrorism Through Situational Crime Prevention. Willan, Cullompton.

Johnson, S. D., Lab, S. & Bowers, K. J. (2008b) Stable and ﬂuid hotspots of crime: Diﬀerentiation and identiﬁcation. Built Environ. 34, 32–45. Johnson, S. D., Summers, L., & Pease, K. (2006) Vehicle Crime: Communicating Spatial and Temporal Patterns, Home Oﬃce Report, March 2006.

Johnson, S. D., Summers, L. & Pease, K. (2009) Oﬀenders as forager: A direct test of the boost account of victimization. J. Quant. Criminol. 25, 181–200.

Kleemans, E. R. (2001) Repeat burglary victimization: Results of empirical research in the Netherlands. In: G. A. Farrell (editor), Crime Prevention Studies 12, Willan, Cullompton, pp. 53–68. Knox, G. (1964) Epidemiology of childhood Leukaemia in Northumberland and Durham. Br. J.

Preventitive Soc. Med. 105, 17–24. Merton, R. (1938) Social structure and anomie. Am. Sociol. Rev. 3, 672–682. Mitchell, H. & Babb, P. (2007) Crimes Detected in England and Wales 2006/07. Home Oﬃce

Statistical Bulletin 15/07. Home Oﬃce, London.

Mohler, G., Short, M. B., Brantingham, P. J., Schoenberg, F. P. & Tita, G. (2010) Self-exciting point processes explain spatial-temporal patterns in crime. Submitted for Review, accessed 17 February from, URL: http://www.math.ucla.edu/ mbshort/papers/crime3.pdf.

Monmonier, M. (1996) How to Lie With Maps. University of Chicago Press, Chicago. Moran, P. (1950) Notes on continuous stochastic phenomena. Biometrika 37, 17–33. Morgan, F. (2001) Repeat burglary in a Perth suburb: Indicator of short-term or long-term risk? In:

G. F. Pease (editor), Repeat Victimization: Crime Prevention Studies volume 12, Criminal Justice Press, Monsey NY.

Nicholas, S., Kershaw, C. & Walker, A. (2007) Home Oﬃce Statistical Bulletin: Crime in England and Wales 2006/07, Home Oﬃce, London. North, B. V., Curtis, D. & Sham, P. C. (2002) A note on the calculation of empirical p values fom

Monte Carlo procedures. Am. J. Hum. Gen. 71, 439–441. Openshaw, S. (1984) The Modiﬁable Areal Unit Problem, Geo Books, Norwich. Pease, K. (1998) Repeat Victimization: Taking Stock. Home Oﬃce Police Research Group, Crime

Detection and Prevention Series, Paper 90, Home Oﬃce, London. Pitcher, A. B. (2010) Adding police to a mathematical model of burglary. Eur. J. Appl. Math. 21, 401–419. Polvi, N., Looman, T., Humphries, C. & Pease, K. (1991) The time course of repeat burglary

victimisation. Br. J. Criminol. 31, 411–414. Pyke, G. (1984) Optimal foraging theory: A critical review. Annu. Rev. Ecol. Syst. 15, 523–575. Ratcliffe, J. (2002) Aoristic signatures and the temporal analysis of high volume crime patterns.

J. Quant. Criminol. 18, 23–43. Ratcliffe, J. (2004) The hotspot matrix: A framework for the spatio-temporal targeting of crime reduction. Police Pract. Res. 5, 5–23. Ratcliffe, J. H. & Rengert, G. (2008) Near-repeat patterns in Philadelphia shootings. Security J. 21, 58–76. Robinson, W. (1950) Ecological correlations and the behavior of individuals. Am. Sociol. Rev. 15, 351–357. Sagovsky, A. & Johnson, S. D. (2007) When does repeat victimisation occur? Aust. New Zealand J. Criminol. 40, 1–26. Sampson, R. J. & Raudenbush, S. W. (1999) Systematic observation of public spaces: A new look at disorder in urban neighbourhoods. Am. J. Sociol. 105, 603–651. Shaw, C. & McKay, H. (1969) Juvenile Delinquency and Urban Areas, University of Chicago Press, Chicago. Sherman, L., Gartin, P. & Buerger, M. (1989) Hot spots of predatory crime: Routine activities and the criminology of place. Criminology 27, 27–55. Sherman, L. W. & Weisburd, D. (1995) General deterrent eﬀects of police patrol in crime “hot spots”: A randomized controlled trial. Justice Q. 12, 625–648. Short, M. B., D’Orsogna, M. R., Brantingham, J. & Tita, G. E (2009) Measuring and modeling repeat and near-repeat burglary eﬀects. J. Quant. Criminol. 25, 325–339. Summers, L., Johnson, S. D. & Rengert, G. (2010) The use of maps in oﬀender interviewing. In: W. Bernasco (editor), Oﬀenders on Oﬀending, Willan. Cullompton.

Tobler, W. (1970) A computer movie simulating urban growth in the Detroit Region. Econ. Geography 46, 234–240. Townsley, M., Homel, R. & Chaseling, J. (2003) Infectious burglaries: A test of the near repeat hypothesis. Br. J. Criminol. 43, 615–633. Townsley, M., Johnson, S. D. & Ratcliffe, J. H. (2008) Space-time dynamics of insurgent activity in Iraq. Security J. 21, 139–146. Trickett, A., Osborn, D., Symour, J. & Pease, K. (1992) What is diﬀerent about high crime areas? Br. J. Criminol. 32, 81–89. Tseloni, M. & Pease, K. (2005) Population inequality: The case of repeat crime victimization. Int. Rev. Victimol. 12, 75–90. Vaupel, J. W. & Yashin, A. I. (1985) Heterogeneity’s ruses: Some surprising eﬀects of selection on population dynamics. Am. Stat. 39, 176–185.

Weisburd, D., Bruinsma, G. J. & Bernasco, W. (2008) Units of analysis in geographic Criminology: historical developement, critical issues and open questions. In: D. Weisburd, W. Bernasco & G. J. Bruinsma (editors), Putting Crime in its Place: Units of Analysis in Geographic Criminology, Springer, New York. pp. 3–34.

Weisburd, D., Bushway, S., Lum, C. & Yang, S. (2004) Trajectories of crime at places: A longitudinal study of street segments in the city of Seattle. Criminology 42, 283–321. Weisburd, D. & Eck, J. (2004) What can police do to reduce crime, disorder and fear? Ann. Am. Acad. Political Soc. Sci. 593, 42–65. Weisburd, D. & Green, L. (1995) Policing drug hotspots: The Jersey city DMA experiment. Justice Q. 12, 711–735. Wright, R. T. & Decker, S. (1994) Burglars in the Job: Streetlife and Residential Break-ins, Northeastern University Press, Boston. Xie, M., Pogarsky, G., Lynch, J. P. & McDowall, D. (2006) Prior police contact and subsequent victim reporting: Results from the NCVS. Justice Q. 23, 481–501.

