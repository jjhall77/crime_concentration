# Crime Concentration as an Emergent Property of Cities

The criminology of place treats crime concentration at micro-places as a discovery about crime. But concentration may be less a finding about criminal behavior than a rediscovery of general mathematical and spatial properties of cities, viewed through a criminological lens. This writeup surveys the evidence from outside criminology --- power-law statistics, space syntax, urban scaling theory, economic geography, and spatial statistics --- that predicts concentration would emerge from the structure of cities alone, independent of any criminological mechanism.

---

## 1. Power Laws, Heavy Tails, and Equifinality

### The Ubiquity of Heavy-Tailed Distributions

Clauset, Shalizi, and Newman (2009) provided the definitive statistical framework for detecting power-law distributions across empirical data. Their key finding: power laws appear in an enormous range of natural and human phenomena --- earthquake magnitudes, city sizes, file sizes, word frequencies, war casualties. The J-curve that characterizes crime concentration is one instance of a distributional form that recurs throughout nature.

The critical insight for crime concentration comes from what Phillips (2022) formalized as scale independence and what geoscientists call *equifinality*: power-law distributions can be produced by at least five distinct classes of generative models. The same distributional outcome does not identify a unique process. A power-law concentration pattern is consistent with routine activities, social disorganization, network centrality, multiplicative accumulation, and pure stochastic processes simultaneously.

### Multiplicative Processes and Lognormals

Mitzenmacher (2004) showed that multiplicative processes --- where a quantity grows by random proportional increments --- naturally produce lognormal distributions, which are nearly indistinguishable from power laws in empirical data, especially in the tails. Crime accumulation at a block is plausibly multiplicative: each additional commercial establishment, transit connection, or routine activity pathway multiplies opportunity rather than adding to it linearly. The resulting distribution would appear concentrated regardless of any spatial clustering mechanism. As Mitzenmacher demonstrated, lognormal and power-law distributions connect naturally, so it is unsurprising that both have been proposed across many fields.

### Implication

Even when the concentration finding is real --- and it is --- the distributional form alone tells us very little about crime specifically. The heavy tail is overdetermined by mathematical processes that have nothing to do with offending.

### References

Clauset, A., Shalizi, C. R., & Newman, M. E. J. (2009). Power-law distributions in empirical data. *SIAM Review*, 51(4), 661--703.

Mitzenmacher, M. (2004). A brief history of generative models for power law and lognormal distributions. *Internet Mathematics*, 1(2), 226--251.

Phillips, J. D. (2022). The law of scale independence. *Annals of GIS*, 28(1), 15--29.

---

## 2. Space Syntax and Network Geometry

### Natural Movement Theory

Hillier, Penn, Hanson, Grajewski, and Xu (1993) developed the theory of natural movement: the configuration of the urban grid is itself a primary generator of aggregate pedestrian flow patterns. Some streets are topologically more "integrated" --- requiring fewer direction changes to reach all other streets in the network --- and these streets attract disproportionate movement purely as a function of network structure, before considering any land use, demographics, or policing.

### The Foreground Network and Crime

Hillier and Sahbaz (2008) showed through extensive London data that the relationship between street configuration and crime is not uniform across crime types. Street robbery maps onto the "foreground network" of high-integration streets, while residential burglary follows different spatial logic. More accessible streets, where urban movement and public awareness are highest, experience more crime (Summers & Johnson, 2017). This means a portion of what appears as crime concentration at micro-places is actually *network centrality concentration* --- a property of the street graph itself, not of the social processes occurring on it.

Davies and Johnson (2015) formalized this using betweenness centrality --- a graph-theoretic measure of how frequently a street segment lies on shortest paths through the network. Betweenness was a highly significant predictor of burglary risk at the street segment level, even after controlling for socio-demographic factors. The configuration of the street network shapes where crime occurs independent of who lives there.

### Space Syntax and the Open vs. Closed Debate

Hillier and Sahbaz (2008) addressed the long-standing tension between Jacobs' "eyes on the street" (open, permeable environments deter crime) and Newman's "defensible space" (closed, restricted-access environments deter crime). Their evidence suggests both are partially right: the relationship between permeability and crime is nonlinear, with crime risk peaking at intermediate levels of connectivity. The design implication is that street layout produces spatial variation in crime risk as a geometric property of the built environment.

### Implication for NYC

NYC's street grid has enormous variation in integration values --- the difference between a through-block in Midtown Manhattan and a dead-end residential street in eastern Queens. That topological variation alone would produce "concentration" of any activity correlated with pedestrian flow. Some fraction of the crime concentration we observe at physical blocks is a network property, not a criminological one.

### References

Davies, T. & Johnson, S. D. (2015). Examining the relationship between road structure and burglary risk via quantitative network analysis. *Journal of Quantitative Criminology*, 31, 481--507.

Hillier, B., Penn, A., Hanson, J., Grajewski, T., & Xu, J. (1993). Natural movement: Or, configuration and attraction in urban pedestrian movement. *Environment and Planning B*, 20(1), 29--66.

Hillier, B. & Sahbaz, O. (2008). An evidence based approach to crime and urban design. Working paper, Bartlett School of Graduate Studies, UCL.

Summers, L. & Johnson, S. D. (2017). Does the configuration of the street network influence where outdoor serious violence takes place? *Journal of Quantitative Criminology*, 33, 397--420.

---

## 3. Urban Scaling Laws

### Superlinear Scaling of Social Outputs

Bettencourt, Lobo, Helbing, Kuhnert, and West (2007) demonstrated that many urban characteristics follow predictable power-law scaling with city population. Social outputs --- wages, patents, GDP, and explicitly crime --- scale superlinearly (exponent ~1.15), meaning doubling a city's population more than doubles its crime. Infrastructure scales sublinearly (~0.85). These are not correlations; they are scaling laws that hold across urban systems and nations.

Bettencourt (2013) provided the theoretical derivation: cities are social reactors where the density of social interactions per capita increases with city size. The superlinear exponent arises from the geometry of social networks embedded in physical space. The prediction is that *all* social outputs --- positive (innovation, wealth) and negative (crime, disease) --- concentrate in proportion to local interaction density.

### Scaling Within Cities

The between-city scaling result has a direct within-city corollary. If social interaction rates increase superlinearly with local density, then the densest, most connected micro-places within a city will generate disproportionate crime as a mathematical consequence of the scaling relationship --- alongside disproportionate innovation, wealth, and every other social output. Crime concentration at places becomes a corollary of a general law about how social interaction scales with spatial density.

### Scale-Adjusted Metrics

Bettencourt, Lobo, Strumsky, and West (2010) developed scale-adjusted metropolitan indicators (SAMIs) that remove the expected nonlinear population effect. Residuals from the scaling relationship --- how much a city deviates from its population-expected crime level --- provide a truer measure of local performance than per capita rates. They found that local deviations display long-term memory: cities that under- or over-perform their size expectation maintain that advantage or disadvantage for decades.

Oliveira (2021) extended this across 12 countries, showing that theft scales superlinearly with population while burglary scales roughly linearly --- crime-type-specific scaling that parallels the crime-type-specific concentration patterns in the micro-place literature.

### Implication

Eck et al.'s (2017) finding that crime concentrates at the same level as restaurants and fire calls is exactly what scaling theory would predict. The concentration of *any* social output at high-density, high-connectivity places is a general urban property, not a criminological discovery.

### References

Bettencourt, L. M. A. (2013). The origins of scaling in cities. *Science*, 340(6139), 1438--1441.

Bettencourt, L. M. A., Lobo, J., Helbing, D., Kuhnert, C., & West, G. B. (2007). Growth, innovation, scaling, and the pace of life in cities. *Proceedings of the National Academy of Sciences*, 104(17), 7301--7306.

Bettencourt, L. M. A., Lobo, J., Strumsky, D., & West, G. B. (2010). Urban scaling and its deviations: Revealing the structure of wealth, innovation and crime across cities. *PLoS ONE*, 5(11), e13541.

Oliveira, M. (2021). More crime in cities? On the scaling laws of crime and the inadequacy of per capita rankings. *Crime Science*, 10, 27.

---

## 4. Why Is There More Crime in Cities?

Glaeser and Sacerdote (1999) asked the question directly from an economics perspective. Crime rates are much higher in large cities than in small cities or rural areas. Their decomposition found that higher pecuniary benefits explain at most one-quarter of the urban crime premium; lower arrest probabilities and lower recognition probabilities explain at most one-fifth; and between one-third and one-half is explained by the presence of more female-headed households (a proxy for reduced informal social control). Even after accounting for all measured factors, a substantial residual urban crime effect remains --- consistent with the agglomeration and scaling mechanisms described above.

### Reference

Glaeser, E. L. & Sacerdote, B. (1999). Why is there more crime in cities? *Journal of Political Economy*, 107(S6), S225--S258.

---

## 5. The Modifiable Areal Unit Problem and the Ecological Fallacy

### MAUP

Openshaw (1984) formalized the Modifiable Areal Unit Problem: statistical properties of spatial data change depending on how boundaries are drawn. For crime concentration, the 4--6% finding is partly an artifact of choosing street segments as the unit. Use census blocks and you get a different number; use addresses and a different one still; use intersections and yet another. The "law" holds at the street segment level, but the specific bandwidth is unit-dependent.

### The Ecological Fallacy

Robinson (1950) demonstrated that correlations computed at the aggregate (ecological) level can differ dramatically from correlations at the individual level --- and can even reverse sign. For crime concentration, the implication is that area-level concentration patterns cannot be straightforwardly interpreted as individual-level behavioral processes. The concentration of crime at a street segment does not mean the people on that segment are more criminal; it may mean the segment has properties (network centrality, commercial density, transit access) that attract crime from elsewhere. Aggregation effects can create, destroy, or reverse apparent spatial patterns.

### Scale Independence

Phillips (2022) formalized the law of scale independence (LSI): for any phenomenon spanning a sufficiently large range of scales, there exists a scale separation distance at which the scales are independent with respect to system dynamics and explanation. Processes operating at the street-segment level need not reduce to neighborhood-level processes or vice versa. The micro-place concentration finding may be genuinely scale-specific --- operating through mechanisms that are invisible at larger scales and irrelevant at smaller ones.

### References

Openshaw, S. (1984). *The modifiable areal unit problem*. Concepts and Techniques in Modern Geography, 38. Norwich: Geo Books.

Phillips, J. D. (2022). The law of scale independence. *Annals of GIS*, 28(1), 15--29.

Robinson, W. S. (1950). Ecological correlations and the behavior of individuals. *American Sociological Review*, 15(3), 351--357.

---

## 6. Agglomeration Economics

Krugman's (1991) new economic geography showed that spatial concentration of economic activity is a self-reinforcing equilibrium driven by increasing returns, transport costs, and market size. Commercial activity clusters because firms benefit from proximity to other firms and customers, creating positive feedback loops. Since crime opportunity is tightly coupled to commercial activity --- targets, foot traffic, absence of guardians during off-hours --- crime concentration at micro-places may be substantially downstream of economic agglomeration, which itself is a well-understood mathematical process involving bifurcation dynamics, not anything specific to criminal behavior.

### Reference

Krugman, P. (1991). *Geography and Trade*. Cambridge, MA: MIT Press.

---

## 7. Synthesis: Concentration as Overdetermined

Crime concentration at micro-places is overdetermined. It would emerge from:

**(a) The occupancy problem** --- when crimes are rare relative to places, standard metrics mechanically produce concentrated distributions (Chalfin et al., 2021; Bernasco & Steenbeek, 2017).

**(b) Network topology** --- street segments with higher integration and betweenness centrality attract disproportionate pedestrian flow and, consequently, crime, purely as a function of the street graph (Hillier et al., 1993; Davies & Johnson, 2015; Summers & Johnson, 2017).

**(c) Superlinear scaling** --- all social outputs concentrate at high-density, high-connectivity places as a mathematical consequence of how social interaction scales with spatial density (Bettencourt et al., 2007; Bettencourt, 2013).

**(d) Multiplicative processes** --- any quantity that accumulates through proportional growth produces heavy-tailed distributions indistinguishable from crime concentration patterns (Mitzenmacher, 2004; Clauset et al., 2009).

**(e) Economic agglomeration** --- commercial activity self-reinforces at specific locations through increasing returns, and crime opportunity follows (Krugman, 1991; Glaeser & Sacerdote, 1999).

**(f) Equifinality** --- the same distributional outcome can be produced by multiple distinct processes, so the concentration pattern alone cannot identify a causal mechanism (Phillips, 2022).

The marginal concentration framework (Chalfin et al., 2021) strips away (a), but (b) through (f) remain as non-criminological explanations that the field has not systematically engaged with. The "law" of crime concentration may be less a discovery about crime than a rediscovery of general mathematical and spatial properties of cities.

### For the NYC Analysis

This framing is directly relevant to the physical block data. NYC's grid varies enormously in network integration, commercial density, transit access, and pedestrian flow --- all of which predict concentration independent of any criminological theory. The marginal concentration results (stripping away sparse-data artifact) are a necessary first step, but they do not address network, scaling, or agglomeration explanations. Future work could decompose observed concentration into:

1. **Sparse-data component** (already estimated via Chalfin counterfactual)
2. **Network component** (betweenness centrality of physical blocks)
3. **Scaling component** (local density / interaction intensity)
4. **Agglomeration component** (commercial land use, transit proximity)
5. **Residual criminological component** (what remains after the above)

Only the residual would be uniquely "about crime."
