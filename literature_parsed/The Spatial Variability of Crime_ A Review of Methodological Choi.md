University of South Carolina 

University of South Carolina 

Scholar Commons 

Scholar Commons 

Theses and Dissertations 

Fall 2021 

# The Spatial Variability of Crime: A Review of Methodological  Choice, Proposed Models, and Methods for Illustrating the  Phenomenon 

The Spatial Variability of Crime: A Review of Methodological  Choice, Proposed Models, and Methods for Illustrating the  Phenomenon 

- Matthew D. Spencer 


Follow this and additional works at: https://scholarcommons.sc.edu/etd 

 Part of the Criminology and Criminal Justice Commons 

## Recommended Citation 

Recommended Citation 

Spencer, M. D.(2021). The Spatial Variability of Crime: A Review of Methodological Choice, Proposed  Models, and Methods for Illustrating the Phenomenon. (Doctoral dissertation). Retrieved from  https://scholarcommons.sc.edu/etd/6839 

This Open Access Dissertation is brought to you by Scholar Commons. It has been accepted for inclusion in  Theses and Dissertations by an authorized administrator of Scholar Commons. For more information, please  contact digres@mailbox.sc.edu. 

THE SPATIAL VARIABILITY OF CRIME: A REVIEW OF METHODOLOGICAL CHOICE, PROPOSED MODELS, AND METHODS FOR ILLUSTRATING THE PHENOMENON

by  Matthew D. Spencer  Bachelor of Science   Virginia Polytechnic Institute and State University, 2014  Master of Arts  Radford University, 2018 

Submitted in Partial Fulfillment of the Requirements  For the Degree of Doctor of Philosophy in  Criminology and Criminal Justice  College of Arts and Sciences  University of South Carolina  2022  Accepted by:  Cory Schnell, Major Professor  Robert Kaminski, Major Professor   Ashley Mancik, Committee Member   Andrew Lemieux, Committee Member  

Tracey L. Weldon, Interim Vice Provost and Dean of the Graduate School

© Copyright by Matthew D. Spencer, 2022  All Rights Reserved.

ii

DEDICATION

I dedicate this work to my beautiful daughters, Paisley Grace and Presley Emerson.  You have taught me more than any book or classroom ever could. 

iii

ACKNOWLEDGEMENTS

  Nothing is accomplished alone. I have many people to thank for helping me reach  this moment. First, I want to thank Cory Schnell for taking on the huge responsibility of  being my co-chair and mentoring me from my first moments on campus. You are as cool  as McConaughey. To my dissertation committee, Bob Kaminski, Ashley Mancik, and  Andrew Lemieux, thank you for keeping an open mind and allowing me the freedom to  explore my true interests. To everyone in the Department of Criminology and Criminal  Justice, thank you for the invaluable support while studying at the University of South  Carolina. I also want to thank Rachel Boba Santos, Egan Green, and Riane Bolin for their  support as it has been beyond what I ever expected to need. If it were not for them, I  likely would not have ended up here.     Finally, my sincerest gratitude goes to my beloved wife, Allie. In the short time  we spent in South Carolina, we have shared the darkest and brightest moments  imaginable. Through those times, we have only grown closer, and I am greatly  appreciative of everything you have provided me. 

iv

ABSTRACT

  The spatial analysis of crime has occurred for nearly two centuries. Within  criminology, research interests that have developed from the use of spatial methodologies  seek to identify the spatial variability and concentration of crime. The first focus utilizes  spatial statistics and mapping to describe and illustrate spatial variability. The second  focus uses statistical techniques to describe levels of concentration such as the percentage  of crime attributed to a unit. Due to the larger breadth of work and multiple analytical  components the former will be the focus of this research.  

This multi-study dissertation explores the methods currently used to study the  spatial variability of crime, presents a novel method to do so within and between U.S.  cities, and demonstrates innovative ways to illustrate it. The first study is a systematic  review of the literature on the spatial variability of crime during the last decade (20102019). Using protocols based on a systematic literature review this study reviews the  relevant literature and reports on the methods and findings of selected research. Trends  were identified that show a lack of cohesiveness across the studies regarding choice of  methodology and unit selection. However, an emphasis on using micro-units was  observed across the studies. The second study explores the spatial variability of crime  within and between U.S. cities. Variance partitioning of multi-level models were  estimated to observe the crime variance attributed to each unit of analysis. The majority  of the spatial variability of crime can be attributed to micro-units. However, larger spatial 

v

units provide greater context within cities and particularly between cities as spatial  variability was observed to vary among the examined cities. The third study highlights  the importance of crime mapping and explores methods to map the spatial variability of  crime. Innovative techniques such as dynamic maps are used to illustrate the adaptability  of crime mapping and suggestions are made for their continued use. Overall, this  dissertation contributes to the crime and place literature by examining past  methodologies, presenting new ones, and incorporating mapping into research on the  spatial variability of crime.  

vi

TABLE OF CONTENTS

Dedication .......................................................................................................................... iii  Acknowledgements ............................................................................................................ iv  Abstract ................................................................................................................................v  List of Tables ................................................................................................................... viii  List of Figures .................................................................................................................... ix  Chapter 1: Introduction ........................................................................................................1  Chapter 2: Literature Review .............................................................................................11  Chapter 3: How Do We Measure the Spatial Variability of Crime?    A Systematic Review ...............................................................................................36  Chapter 4: A New Test of the Law of Crime Concentration: Examining the Spatial    Variability of Robbery Within and Between Eight U.S. Cities ...............................58  Chapter 5: Best Practices for Illustrating the Spatial Variability of Crime:    Re-imagining the Crime Map ...................................................................................99  Chapter 6: Conclusion......................................................................................................125  References ........................................................................................................................129  Appendix A: Eligibility Check Sheet ..............................................................................142  Appendix B: Coding Protocol ..........................................................................................143

vii

LIST OF TABLES

Table 3.1 Key characteristics .............................................................................................45  Table 3.2 Spatial units by level ..........................................................................................47  Table 3.3 Methodological analysis by type .......................................................................48  Table 4.1 City characteristics .............................................................................................70  Table 4.2 Robbery characteristics ......................................................................................72  Table 4.3 Percent of spatial units accounting for 50% of robbery.....................................79  Table 4.4 Gini coefficients by unit of robbery ...................................................................80  Table 4.5 Negative binomial estimates for variance components .....................................86  Table 4.6 Variance proportions for each city.....................................................................87 

viii

LIST OF FIGURES

Figure 2.1 Example Lorenz curve ......................................................................................24  Figure 3.1 Flowchart of search and screening processes ...................................................44  Figure 4.1 Spatial units for Austin and Denver .................................................................71  Figure 4.2 Choropleth maps of robbery for Atlanta and Gainesville ................................81  Figure 4.3 Choropleth map of robbery counts for Atlanta .................................................82  Figure 4.4 Lorenz curves for each city ..............................................................................83  Figure 5.1 Choropleth maps of robbery incidents by census block in Atlanta ................112  Figure 5.2 Choropleth maps of robbery incidents by census tract in Atlanta ..................113  Figure 5.3 Image of dynamic map with increased detail .................................................114  Figure 5.4 Image of dynamic map with increased detail and reference information ......114  Figure 5.5 Image of dynamic map with multiple layers ..................................................116  Figure 5.6 Image of dynamic map with highlighted area ................................................117  Figure 5.7 Image of Shiny dashboard ..............................................................................117 

ix

CHAPTER 1 

INTRODUCTION 

Interest in exploring the relationship of the spatial variation of crime is not a novel  concept. From the 19th century to present, research findings have consistently found that  crime is unevenly distributed across cities (Guerry, 1833; Sampson, 2012; Shaw et al.,  1929; Weisburd et al., 2012). Crime and place research is an encompassing term that  describes the sub-field of criminological research focusing on the variation of crime  across geographic areas. This sub-field is a departure from traditional criminological  research that primarily focuses on explaining criminal behavior. Since the Chicago  School, scholars have observed how crime varies across urban landscapes and how it  concentrates at a few places relative to a much larger geographic backdrop (see Eck &  Weisburd, 1995; Shaw & McKay, 1942; Sherman et al., 1989; Weisburd, 2015). Over the  last two decades and combined with new computational abilities to do so, analyzing  crime through a geographic lens has gotten much more advanced. Technological  advancements are continually creating new opportunities for spatially analyzing crime.  Broadly, there are two research foci within modern crime and place research. These are  the statistical concentration of crime and the spatial variability of crime (also referred to  as distribution).  

While much empirical support exists for both research interests, as of late,  scholarly interest has been directed towards empirically testing the law of crime

concentration (see Weisburd, 2015). Research involving micro-places is also abundant as  crime is often most concentrated to these areas. Often overlooked though are studies  analyzing crime across multiple spatial levels and those that focus on how crime varies  within cities or between-city comparisons. The methods applied to study crime  concentration are typically limited to statistical descriptions such as the Lorenz curve and  Gini coefficient. Research analyzing the spatial variability of crime has a much wider  range of methodological choices that are dependent on multiple factors such as unit  choice and spatial weighting.  Because no clear framework exists regarding studying the  spatial variability of crime this dissertation sets out to use the topic as the basis for its  three studies.  

The remainder of this introductory chapter provides an explanation for why crime  and place research matters and the differences between crime concentration and the  spatial variability of crime. The motivations for this dissertation will also be discussed.  The final section briefly outlines the three studies comprising this work.  

Place Matters

Historical interest in crime and place research is evident, however, it is not until  the last few decades that considerable attention on the topic has occurred. Much of the  latest interest has grown from advancements in technology and theory. Research during  the Chicago School observed crime at the neighborhood level due to convenience and  was largely limited to descriptive exploration (Shaw & McKay, 1942). The complexities  of conducting spatial analyses pre-computers limited much of what could be explored  during the Chicago School. Of more recent times, the hot spot, is a type of spatial concept 

possible for study only due to the existence of computer technology. Calculating largescale hot spot analyses by-hand is not feasible. The recent trend to analyze crime at the  street segment, a micro-place, is also only possible using computer technology. The  technological advancements over the last 40 years have greatly contributed to the  flourishing body of crime and place work.  

Theoretical advancements have also increased interest in crime and place research  and two perspectives guide much of it. The dominant perspective is the opportunitybased theoretical spectrum which includes the routine activities, crime pattern, and  rational choice theories (Brantingham et al., 2017; Cornish & Clarke, 2017; Felson &  Eckert, 2019; Quick et al., 2018; Weisburd et al., 2012, 2016). As a precursor to their  crime pattern theory, the Brantinghams (1981) aptly stated that of the four dimensions of  every crime, a spatial dimension is one. The other theoretical perspective used in crime  and place research is based on the social disorganization theory (Sampson, 2012). This  theory has roots from the Chicago School with recent updates to include sociological  characteristics that go beyond “place” such as the concept of collective efficacy. While  immensely popular, the social disorganization theory is less often used compared to the  opportunity theories. There have been growing calls to integrate theories such as routine  activities and social disorganization to provide better understandings of how crime occurs  across space (see Jones & Pridemore, 2019). While each of the theoretical perspectives  play an important role in framing research, they do little to inform the methodologies  necessary to spatially study crime (see Hipp & Williams, 2020; Taylor, 2015). Future  research will undoubtedly be required to address this issue, but it is not of concern here.  

 In addition to theoretical differences, the approach to measuring crime based on a  spatial context can vary drastically depending on the methods used. Research on where  crime occurs have revealed uneven distributions (i.e., non-uniform variability) and  largely consistent statistical concentrations (see Andresen, 2011; Kim & Hipp, 2018;  Sampson, 2012; Shaw et al., 1929; Weisburd et al., 2012). The latter findings began with  the work of Pierce et al. (1988) and Sherman et al. (1989) which discovered that roughly  3% of street addresses accounted for 50% of calls for service. These levels of  concentrated were later formulated into the “law of crime concentration” by Weisburd 

(2015). The law of crime concentration is broadly based on the 80/20 Pareto principle  (Pareto, 1909) but also the more detailed levels such as 3-6% of places accounting for  50% of all crime. Research has consistently supported the law of crime concentration and  the statical crime ratios have translated from one city to another (Gill et al., 2017).  However, the uneven distribution of crime or what can loosely be referred to as the  spatial variability of crime is less understood or at least no clear consensus exists on how  to best measure it.  

To clearly outline going forward the following definition of spatial variability will  be used, spatial variability is the measure of crime across a hierarchically ordered  geographic space for which values of crime change given their aggregation to a unit.  This concept differs from spatial concentration in two major ways. First, spatial  concentration is a descriptive measure of how much crime occurs and where relative to  the entirety of the examined space. Second, spatial concentration is described statistically  rather than spatially. Lorenz curves and Gini coefficients are commonly used to describe  levels of crime concentration (see Hipp & Kim, 2017; Mohler et al., 2019). Maps on the 

other hand, are a common illustrative tool for communicating spatial variability as they  can show hot spots or crime densities.  

The nuanced difference between crime concentration and spatial variability is  important for advancing crime and place research. Plainly articulating these differences  can help guide future scholars and inform them of the methodologies available to them.  Because much of the spatial methods used in crime and place research originated from  geography criminologists interested in the topic may have difficulty understanding the  concepts and results. Providing a clearer understanding of the commonly used  methodologies, highlighting new ones, and supporting the use of maps may increase  further interest in the area. Growing interest on the topic is also likely to increase future  innovation, methodological and theoretical.  

Motivations 

  Advancing the understanding of how crime is connected to place through the  education and refinement of the concept of spatial variability is the primary motivation  for this dissertation. A topic of concern within the crime and place research is the  selection of a spatial scale. A common practice is to analyze crime within a single  geographic area (i.e., a city) using one or possibly two spatial levels and corresponding  units. A typical unit of analysis for much of the recent research has been to analyze crime  at the micro-level using units such as street segments (see Malleson et al., 2019;  Weisburd et al., 2016). A gap exists though as to what unit(s) should be analyzed, how to  analyze them, and how to best communicate the results. Addressing these areas of 

concern using the concept of spatial variability are what guide each research study in this  dissertation. The following section will briefly overview each study.  

The Studies 

Following an abstract format, this dissertation has three research studies, each  with a focus on the spatial variability of crime. As mentioned above, crime concentration,  while a spatial concept, is not a central focus. Instead, each of this dissertation’s studies  focus on the methodologies used to measure the spatial variability of crime. The spatial  methods used to measure crime variability widely vary with new ones appearing in crime  and place literature consistently.  

The principal goal of this dissertation is to increase the understanding of the  spatial variability of crime and the methodologies used to measure and illustrate it. To do  so, a systematic review, a multi-level analysis, and a mapping study are conducted. Each  study broadly contributes to the crime and place literature while extending the current  knowledge on spatial variability. Particularly, the importance of examining crime across  multiple spatial levels is highlighted. Until recently, much of the crime and place research  has focused on a single spatial level (e.g., micro, meso, or macro) with a few exceptions  examining crime across multiple spatial levels (see Hipp et al., 2020; Hipp & Williams,  2020; Quick, 2019; Schnell et al., 2017; Steenbeek & Weisburd, 2016). This dissertation  argues that to better appreciate and illustrate the spatial variability of crime multiple  levels of aggregated crime across space must be jointly analyzed. Doing so will also  address concerns related to ecological fallacies and the modifiable areal unit problem (see  Andresen, 2011; Openshaw, 1984, Robinson, 1950).  

  Due to recent trends in crime and place research that heavily emphasize spatial  concentration there is a knowledge gap concerning spatial variability. These two research  interests are diverging into their own perspectives with rapid advancements taking place  for each. This dissertation is presented with the timely opportunity to explore much of the  recent empirical work and present new methods for spatially analyzing crime variability.  A few issues are prominent from the lack of a consensus regarding the spatial variability  of crime. First, to the author’s knowledge, no consensus exists on what methodologies are  used or should be used to study the phenomenon. Second, crime and place researchers too  often choose to examine crime aggregated at a single spatial level versus using a more  appropriate multi-level approach. Lastly, innovations in crime mapping appeared to have  stalled despite significant advancements outside the field of criminology. These issues are  the basis of the three research studies that make up this dissertation. Each research study  is briefly discussed below. 

Research Study One 

  The first study in this dissertation is guided by the research question, what  methodologies are used to examine the spatial variability of crime and what are their  outcomes? Commonly, cluster-based tests such as Moran’s I and local indicators of  spatial autocorrelation (e.g., local Moran’s I, Getis-Ord Gi and Gi*) are used to examine  spatial variability. However, other possibilities exist, and the application of those tests  can differ. For example, typical methodologies used in recent crime and place research  often test for spatial autocorrelation at the micro-level using crime estimates aggregated  to a micro-unit such as street segments (Kim & Hipp, 2018; Weisburd et al., 2012). Other  research focuses on spatial variability at the meso-level where neighborhoods or other 

similarly sized areas are of interest (Bursik, 1988; Jones & Pridemore, 2019; Sampson,  2012). An abundance of other nuanced information is also important for formulating an  in-depth understanding of the methodologies used for this type of research. 

The uniqueness of selected methodologies and other relevant information are  captured using a systematic review. Extensive protocols for the systematic review are  based on the Campbell Collaboration. This research question is answered by examining  many factors from relevant research that measures the spatial variability of crime. To  help guide the research only studies from the past decade (2010-2019) are analyzed. This  period, which is conveniently and deliberately chosen, includes David Weisburd’s  seminal piece on the “law of crime concentration” (Weisburd, 2015). Weisburd’s (2015)  introduction of this “law” marks a renewed interest in crime and place research,  particularly one that emphasizes the analysis of micro-units. In addition, new  advancements in computer and GIS technologies have allowed for continual  improvements of how crime is analyzed spatially. Ultimately, the goal of this study is to  identify trends for the methodologies used to the measure the spatial variability of crime.  

Research Study Two 

The second research question is, how much of the total spatial variability of  robbery incidents can be attributed to census blocks, census tracts, and city-wide for  eight U.S. cities and do these estimates differ between cities? An abundance of research  has observed that the greatest amount of spatial variability occurs at the micro-level (Kim  & Hipp, 2018; Malleson et al., 2019; Weisburd et al., 2016) with modest variation  occurring at larger spatial levels (Baumer et al., 2012; Hipp & Williams, 2020; Schnell et 

al., 2017). Crime and place research often highlight the importance of spatial levels while  rarely addressing the multi-level interactions between the levels. More so, research is  often restricted to within-city analyses even those that use multi-level approaches (see  Hipp et al., 2020; Quick, 2019; Weisburd, 2015).  

Using a similar approach as Schnell et al. (2017) and Steenbeek and Weisburd 

(2016), with the addition of between-city comparisons, this study explores how the  estimates of spatial variability for robbery differ within- and between-cities across two  spatial levels. Like recent studies, the importance of micro-places is highlighted as they  provide a better understanding of crime variability and concentration given their presence  in larger geographic spaces. Much attention is paid to the importance of city-level  differences and how the variability of robbery may not be uniform for U.S. cities.  

Multiple analyses were conducted to answer this research question. Descriptive  analyses such tests of statistical concentration were used to examine the spatial  distribution of robbery for each of the cities. The spatial variability attributed to blocks  and tracts within each city was calculated using variance partitioning with multi-level  negative binomial models. These models allow for between-city comparisons. Sensitivity  analyses were also conducted to test various methods for estimating the variance of  robbery incidents.  

Research Study Three 

The third study is guided by the research question, how are maps currently being  used and what are best practices to illustrate the spatial variability of crime? Two  research goals also frame this study. One, discuss and present best practices for 

communicating the spatial variability of crime through mapping. Two, promote the  continued use of maps in criminological research by highlighting innovative mapping  techniques. Cartography in research is not an unusual concept, nor is crime mapping for  that matter (Chainey, 2021; Chainey & Ratcliffe, 2005; Monmonier, 2018). However,  recent trends seem to indicate that academics are less concerned with the continuous  advancements being made in cartography (O’Sullivan & Unwin, 2010). It is common to  see no maps or maps only used to communicate geographic boundaries rather than more  innovative uses such as dynamic maps which include interactive maps. Journal  restrictions are partly to blame for the simplicity in map design (O’Sullivan & Unwin,  2010). Additionally, a push towards advanced quantitative measures rather than visual  techniques such as maps also may be a contributing factor for their reduced use.  

  In this research study, an argument is presented that, combined with the recent  attention on spatial methods, maps still play a key role in communicating results.  Particularly, in studies of spatial variability, a multi-level concept, maps can help  communicate the importance of each spatial level given their larger geographic context.  Maps to be included within journals (paper or online) and as external appendices to  articles were created. A variety of methods are discussed on creating interactive maps and  multiple examples are showcased to encourage academic interest for their continued use.  Each map is also in-part, a method of effectively communicating estimates of the spatial  variability of crime. 

CHAPTER 2 

LITERATURE REVIEW

Unlike traditional dissertation literature reviews that heavily focus on theory, this  chapter discusses the advantages of including a spatial component for crime research. An  in-depth review of methodologies used in crime and place research also follows. A note  on theory is necessary before continuing, though. The theories used in crime and place  research are certainly important, but the methodological choices made in research are  rarely theoretically informed. Explicitly, the opportunity theories and social  disorganization theory only familiarize the researcher to the importance of place versus  how to measure that importance. Therefore, the subsequent sections of this chapter only  discuss the methodological choices necessary when conducting crime and place research.  The “selecting a unit of analysis” section discusses the importance of analyzing crime at  different spatial levels and units. Next, crime maps are discussed in the “mapping crime”  section where the history, data, and new design techniques are highlighted. The final  section, “spatially analyzing crime” reviews the differences between crime concentration  and the spatial variability of crime. Spatial tests for autocorrelation, among others, are  also discussed with contextual examples from relevant literature.  

 Human behavior, including criminal behavior, occurs somewhere. Somewhere  can be a measurable location that is increasingly being captured within crime data in the 

form of XY coordinates or some other similar variant. Extensive research has discovered  that crime is not a random occurrence or equally distributed across space (Chainey, 2021;  Weisburd et al., 2016). In fact, crime is highly concentrated. Research has also observed  that the variability of crime is dependent on the geographic unit being examined (Schnell  et al., 2017; Steenbeek & Weisburd, 2016). For instance, when examined at multiple  spatial levels, the smaller or more micro-level, will account for the most variance of total  crime when compared to larger spatial levels. Representations of micro-units can include  single addresses, street segments, and census blocks among others. Micro-level spatial  units likely account for the majority of crime variance given they are where the “action”  of the crime occurs. For example, a single street segment with numerous bars also has  numerous late-night physical assaults. When aggregated to a larger spatial level such as  neighborhoods, the micro-level processes occurring can be “drowned” out or perhaps  over-amplified by nearby high-crime streets as well. Viewing crime beyond a single  microcosm is important for many reasons that are detailed in the subsequent sections.  

Selecting A Unit of Analysis 

The challenge of selecting a unit of analysis is not unique to crime and place  research. Geographers have long been plagued by the choice of which spatial level and  unit are the most appropriate for their research question(s) (Wong, 2009). The type of  data available can help direct the decision, but many times it is not clear what the most  suitable decision is. Historically, units of analysis were chosen based on convenience.  Neighborhoods were often used as a spatial unit during the Chicago School because they  were readily available boundaries for access (Shaw & McKay, 1942). Before the 

computer and spatially tailored software, the complication or impossibility of conducting  spatial analysis by hand also shaped unit choice.  

  Perhaps the most important issue of selecting a unit of analysis is the dealing with  aggregation bias (Woolredge, 2002). Aggregation bias is more comprehensive term that  includes the ecological fallacy (Robinson, 1950) and the modifiable areal unit problem  (MAUP hereafter; Openshaw, 1984). Both are examples of using aggregated data to  make inferences about individuals or areas smaller in size than what was measured or  used for analysis. An example of an ecological fallacy would be to label all individuals in  a high-crime neighborhood as criminals. The geographic fallacy of MAUP is more  nuanced in that researchers must be aware of the endless and seemingly arbitrary  demarcations of geographic boundaries commonly used that can affect statistical  outcomes (Openshaw, 1984; Wong, 2009). For example, census tracts are often used as a  proxy for neighborhoods. Yet, they certainly do not align with the traditional sense of  many neighborhoods, nor do they change at a pace (the U.S. census is conducted every  10 years) that keeps up with rapid development which can greatly impact neighborhoods.  

  Aggregation bias also occurs when only examining crime at a single spatial level.  Andresen (2011) addressed this issue when he compared crime rates for census tracts and  dissemination areas. Each spatial unit was used to aggregate crime data by attributing a  count of crime per unit. Tests for spatial clustering were conducted for each unit to  examine any differences. Though the results between the two units were mostly similar,  the observed differences highlight how two geographic boundaries using the same data  can have different outcomes. If only a single spatial unit had been examined, any 

conclusions drawn could have glossed over hidden spatial heterogeneity at more  localized levels.  

  The choice to spatially analyze crime data using a single unit of analysis is  commonly made, mostly due to data availability. The effect of doing so becomes  pronounced when only examining crime at meso or macro levels. Doing so invites the  possibility of exaggerating the variability and concentration of crime while ignoring local  processes which are more fitting to the behaviors of individuals. To provide context,  imagine a high crime neighborhood. Only analyzing crime using this geographic unit will  likely produce overestimation of how “dangerous” or crime-ridden the neighborhood is.  In reality, the neighborhood contains many street segments that have no crime with a few  that are responsible for most of it. In fact, a few street addresses that are clustered  together and have high crime can make it seem like the entire neighborhood is full of  crime. 

  The possibility of overestimating crime in the opposite direction (micro to macro)  can also occur. When using hot spots to examine high crime locations in a city, single  crime incidents are interpolated into a non-structured shape that can “grow” dependent  certain factors. For instance, specific distance bands or spatial weights can be applied that  will create outcomes with markedly different hot spots. In some cases, a few crime  incidents can cluster together creating a hot spot that will “spillover” into neighboring  areas where no crime occurred.  

With the above-mentioned issues concerning selecting a unit of analysis it is  tempting to ask what the “best” spatial level or unit is. Malleson et al. (2019), attempted 

to find the most appropriate spatial scale regarding crime patterns. Their findings suggest  that one singular unit likely does not exist, and the choice unit will depend on the type of  crime being analyzed. The researchers also suggest that increasing the use of smaller  spatial units such as street segments to analyze crime is favorable. Doing so provides  better estimates of spatial heterogeneity that occur within the larger areas containing the  streets such as neighborhoods. In this approach, crime concentration can be observed at  very local levels while also understanding the spatial variability of crime within larger  spatial units.  

Data availability combined with the research question at hand are the predominant  drivers behind selecting a unit of analysis. However, when possible, the best approach is  to analyze crime data across multiple spatial levels (see Andresen, 2011). Doing so  reduces issues related to aggregation bias and provide better representations of how crime  varies across a larger geographic area. The nested properties of geographic boundaries  commonly used for crime and place research are also prime candidates for multi-level  analysis (i.e., census blocks nest in block groups, which nest in tracts). Even when units,  such as street segments, do not nest perfectly within others, many techniques exist such  as “clipping functions” which only capture data within the selected boundaries. A  growing amount of research is beginning to recognize the importance of spatially  analyzing crime across multiple levels rather than relying on a single unit or arguing the  importance of one unit over another. To fully understand how crime is concentrated and  varies across larger geographic areas such as cities, utilizing the strengths of multiple  spatial levels and units is recommended. Doing so will help shape future discourse on the  topic by guiding relevant theory and policy.  

The incorporation of theory has also influenced the selection of a unit of analysis.  But, as mentioned above, the current crime and place theories commonly used do not  inform specific methodological choice. Instead, the theories simply imply which spatial  level could be analyzed. The choice of a spatial unit is not clear either. From a macro to  micro scale, the crime and place theories range from routine activities (macro), crime  pattern theory (meso), social disorganization (meso), and rational choice (micro). Though  each theory tends to focus on understanding crime as a product of the socio-physical  world across varying geographic scales they are not always appropriately applied. Taylor 

(2015) notes that a common misapplication occurs with the use of routine activities for  multiple levels of spatial scale. Making this mistake can lead to the misidentification of  results and lead to incorrect inferences. As of late, a noticeable shift from larger spatial  units to micro-units has occurred in much of the crime and place research (Hipp &  Williams, 2020; Weisburd et al., 2012). While micro-units are often more appropriate for  several reasons, the decision to move from larger to smaller units is not always explained  or deduced from theory. 

Mapping Crime 

The uniqueness of spatial variability is that it can be illustrated using maps. The  use of maps for studying crime predates the establishment of the field of criminology (see  Balbi & Guerry, 1829; Guerry, 1833; Quetelet, 1831 [1984]). When designed well, maps  can easily and effectively communicate crime data. Conversely, like other visualization  types, maps can be deceiving about the information they display (O’Sullivan & Unwin,  2010; Monmonier, 2018). Careful consideration is required about how maps are designed 

and the data that are being used to create the map. A variety of techniques are available  for researchers to create maps, some of which are discussed here.  

Creating Maps 

Historically, creating maps was a time-intensive process completed by hand on  paper. Today, computers allow access to user-friendly software designed exclusively for  creating maps which can take very little time or mapping knowledge. With new  innovations for making maps come new problems and historical ones with new  considerations. While cartographic theory extensively outlines the history, use, and  design of maps the following sections will be restricted to how maps and crime and place  research connect.  

Data 

Spatial representations of geographic places are part of the vector data model.  Vector data are made up of points, lines, and polygons. Each of these data types are  important for crime and place research and examples are provided for each. Point data is  the most common type as it is simply observed crime incidents that have some pair of  coordinates. Point data are the basis of many spatial statistics and how crime and place  research aggregates to certain spatial units. Line data are ordered sequences of points that  are connected. Street segments are an example of line data. Polygons, or area data, are  points that are connected by lines to form polygons. Census blocks, tracts, and  neighborhoods are polygon data. Another spatial object is raster data which are made up  of cells with associated values. Raster data are not commonly used in crime and place  research.  

  For crime to be mapped it must contain a pair of coordinates. Coordinates can  then be placed into a geographic information system (much like a typical database but  with the coordinate information) and mapped against some backdrop. The backdrop can  be a city for example. Contained within the city, lines and polygons can also be mapped.  For example, streets, rivers, parks, police beats, etc., can all be mapped for additional  context. The combination of the spatial object types can be beneficial for the user or  detrimental dependent on design features. Additionally, consideration must be taken  regarding the quality of the data used for the map. Particularly, the crime data.   

  A few well-known limitations exist about crime data. First, official crime data are  only those incidents which were reported, captured, and recorded by law enforcement.  Second, for privacy concerns, crime data are often “shifted” away from the original  location they were recorded (Chainey & Ratcliffe, 2005). For example, if a crime  occurred at location ‘A’ and was recorded at that location, a shifting process will be  applied to move the point 50 feet in a random direction to protect the privacy of potential  victims. Often these shifting processes are not made public as they could potentially be  reversed back into the original positions. Nonetheless, this is a well-known tradeoff for  obtaining public crime data.  Lastly, in addition to the deliberately shifted data, the  original process for recording an incident is not always uniform. For example, if a crime  occurs at an intersection or unknown location, the responding officer may attribute a  nearby location to the incident versus recording the actual location.  

The accuracy of crime data has long been questioned with recent research  suggesting errors in the data may impact micro-level spatial analyses more so than meso-  or macro-level ones (Buil-Gil et al., 2021). Micro-level crime and place research is the 

most vulnerable because the crime data are often not aggregated to larger areas which can  reduce estimation biases based on data errors. At the micro-level, small errors, or  deliberate ones such as shifted data are likely to greatly influence any estimate of crime at  that scale due to their much smaller size. While some of these issues are ongoing, each  highlight the importance of proper data cleaning before any spatial analysis or mapping is  attempted.  

Projections. When mapping any data, understanding how projections work is  crucial. Not choosing the appropriate projection can greatly distort a map leading to user  disinformation and incorrect inferences about the data (Peterson, 2021). Simply,  projections allow for spatial data such as crime incidents to be integrated with other  geographic information and then mapped. Coordinate systems are the basis of all  projections, and they can be split into two types: geographic and projected. A geographic  coordinate system is a three-dimensional arrangement for the surface of the Earth using  lines of latitude and longitude. A projected coordinate system is how the 3D Earth is  transformed into a 2D surface that can be mapped on. There are many types of  projections but rarely are they discussed in the crime and place literature. One reason is  the scale of analysis for many studies is very local (city level) relative to the geographic  area covered by projections and they need not be considered. However, for larger-scale  studies data can become distorted if the proper projections are not used. Peterson (2021)  notes that while most researchers could not be bothered with projections, studies across  large geographic areas will undoubtedly run into projections issues. While the current  state of crime and place research is primarily limited to single cities, future research may 

expand to larger geographic areas where a greater understanding of projections will be  required.  

Design 

Maps are visual representations of information. The design of maps can  significantly dictate what the map consumer interprets as important or not. There are  many factors to consider when designing maps that are beyond the purview of this  dissertation (see Brewer, 2016, Chainey & Ratcliffe, 2005; Monmonier, 2018; Peterson,  2021). For this discussion, two design aspects are highlighted. These are map color and  dynamic capabilities. These two were chosen for further discussion because one is a  historical design element, and the other is a novel approach for creating maps.  

  To communicate differences of information compiled in a map, color has  historically been a go-to design feature. The grey scale shaded regions of France in the  crime maps by Balbi and Guerry (1829) are one such example. The computer-generated  color-coded hot spot maps of today are another. Color, which is comprised of hue, value,  and chroma can be a powerful tool of communication (see Brewer, 2016 for an in-depth  explanation on color). Color can have different meanings to different people and can be  incorrectly applied more easily than it can be correctly. When combined with non-equal  geographic sizes, color can become very misleading. For example, two neighboring areas  that are shaded similar colors but of vastly different sizes can become confusing as to  their importance. Additionally, color scales with too much variance are difficult for the  user to discern. Though many color design options are available to the map creator, it is 

often recommended to go simple and stick with little color variation (O’Sullivan &  Unwin, 2010).  

  The second design element highlighted for this review is a product of more recent  mapping capabilities. Dynamic maps are a comprehensive term for maps that are  interactive rather than static. These types of maps can include zoom features, the ability  to turn layers on and off, and linking and brushing among others. Dynamic maps can be  hosted through the web or included within documents using specific programming  language (see Lovelace et al., 2019). The benefit of these types of maps are the ability for  the user to directly interact with the data. For example, a linking and brushing feature  allows the user to select certain regions on the map which will then correspond to an  accompanying statistical graph such as a scatterplot (O’sullivan & Unwin, 2010). The  capabilities of dynamic maps are continuously advancing as computer technology, data  availability, and the general interest of visual data increases. Though dynamic maps are  currently used to illustrate crime data, rarely are they created for academic purposes.  Journal limitations are a primary reason for the bland looking maps commonly witnessed  in the crime and place research. However, as noted by O’Sullivan and Unwin (2010) a  lack of academic interest for the growing mapping capabilities may also be to blame.  Whatever the reason, a missed opportunity for representing crime data in an innovative  manner is occurring and needs to be addressed.  

Analyzing Crime Using a Geographic Lens 

Many techniques are available for analyzing crime using a geographic lens. The  techniques can be separated into two types of measures: crime concentration and spatial 

variability. Both measures have flourished recently as GIS functionality has increased  and become more accessible along with the development of new spatial statistics (e.g.,  see Anselin, 1988, 1995; Cressie, 1993; Getis & Ord, 1992; Ord & Getis, 1995).  However, as in the case of crime concentration, not all methods are new, but rather, new  takes on old methods (see Gini, 1912; Lorenz, 1905). Nonetheless, much of the recent  crime and place research can be placed into one or both methodological categories.  

Crime Concentration 

In introducing the law of crime concentration, Weisburd (2015), highlighted a few  notable observations that are often found in crime and place research. The first being that  smaller spatial units are necessary to uncover accurate measures of crime concentration.  Secondly, when using a micro-level spatial scale, concentrations of crime will be evident  for a small proportion of the total defined area. The locations with high concentrations of  crime will account for much of the total observed crime and the relationship will be  temporally stable (see Weisburd et al, 2012). Particularly, the use of street segments in  research reveals that only a very small percentage of the segments will contain crime  occurrences as crime is a rare phenomenon and not equally distributed across space. An  area, or street segment for this example, may be surrounded by other street segments that  contain no crime at all.  

  Much of the foundation for the law of crime concentration came from the seminal  research of crime across Seattle, WA, by Weisburd and colleagues (2012). In their study,  they examined the longitudinal stability of crime at the street segment. They found that  crime is very stable across time (between 1989 and 2004) and is concentrated at a small 

percentage of street segments. For each year examined in the study, approximately 4.7%  to 6.1% of street segments accounted for 50% of the crime. This is a similar finding  based on earlier research from Sherman et al. (1989) and Sherman and Weisburd (1995)  which discussed the concept of crime hot spots and the relative concentration of crime to  a few places. While the ratio of crime to place varies by study, generally, 80% of crime  can be allocated to 20% of locations across a city. The 80/20 crime rule is the basis of the  law of crime concentration and mimics the Pareto principle (Pareto 1909; Rosser et al.,  2017). An increasing number of studies have also found evidence that supports the law of  crime concentration of which too many exist to list here (see Andresen & Malleson,  2011; Gill et al., 2017; O’Brien, 2019).  

Lorenz Curves and the Gini Index 

  The primary method of measuring crime concentration is to use descriptive  techniques. A common practice is to determine the percentage of spatial units that  account for 50% and 80% of crime for the study area (see Steenbeek and Weisburd,  2016). A more advanced, yet still relatively simple technique combines the illustrative  property of the Lorenz curve while also statistically communicating a numerical  summary of inequality via the Gini index. The Lorenz curve and Gini index were  developed in the field of economics for studying income inequality (Gini, 1912; Lorenz,  1909). The Lorenz curve is a graphical display that illustrates inequality from a  theoretical reference line. The Gini index or coefficient is a numerical summary of the  Lorenz curve varying from 0 to 1. Figure 1.1 shows an example of a Lorenz curve  (colored red) against a reference line (colored black). The Gini index is calculated as the 

proportion of space between the reference line and the Lorenz curve compared to the total  space below the reference line.  

Figure 2.1. Example Lorenz Curve.    When used to study crime, a zero on the Gini index indicates no concentration  and a one indicates perfect concentration of crime. The Lorenz curve and Gini index also  provide a good confirmation of the law of crime concentration as the extend its  descriptive properties (Eck et al., 2017). In crime and place research the two measures  provide visual and quantitative descriptions of the concentration of crime. However, they  do not show where the concentration are such as hot spots can on a map. Nor do they  help explain the variability of crime across multiple spatial levels.     The use of the Lorenz curve and Gini index also have a few other limitations that  limit its ability as a standalone assessment in crime and place research. Mohler et al. 

(2019) discussed how both estimators can be severely biased when a small N is used.  This can be a common occurrence in crime and place research as crime is often  aggregated, thus, lowering the sample size. Bernasco and Steenbeek (2017) also 

identified a weakness when using the perfect equality reference line of the Lorenz curve  as a true comparison to observed crime concentration. In certain situations, places  outnumber observed crime. This issue can arise when examining single crime types  against micro-places such as street segments. Using the Lorenz curve and Gini index with  imbalanced data can lead to biased estimates. The authors addressed this issue by  developing a generalized version of the two techniques that replaces the line of perfect  equality with a computed line of maximal equality based on the data analyzed.  

Spatial Variability 

Unlike measures of crime concentration, analyzing how crime varies across space  allows researchers to understand where crime is occurring and at what amounts per  spatial level. A common approach is to use crime maps as visual illustrations of crime  variability (see separate discussion in the ‘Mapping Crime’ section) combined with  measures of spatial autocorrelation. Where measures of crime concentration are  descriptive statistics, spatial variability estimates are statistical outcomes (i.e., crime  locations) based on placed-based characteristics such as criminal opportunities. How  these observed crime incidents are located throughout space can be measured and  mapped using a variety of techniques. Some of the most common techniques are  discussed below.   

Hot Spots 

  Hot spots are areal clusters of crime relative to the observed crime distribution for  the examined area (see Chainey, 2021; Sherman et al., 1989; Sherman & Weisburd,  1995). The use of hot spots has a long history in the crime and place research (see Braga 

et al., 2014; Chainey & Ratcliffe, 2005; Harries, 1999; Kochel & Weisburd, 2019).  Depending on the technique used to calculate them and the spatial level examined, hot  spots can dramatically differ. A crude technique uses point data (i.e., observed crime  incidents) that are aggregated and graduated on a map to account for numerous crime  incidents at a single location such as a bar or nightclub (Chainey & Ratcliffe, 2005).  Regardless of the technique used, hot spots are simplistic representations of how crime  can be place-dependent and vary unequally across space rather than be concentrated in  areas. More advanced methods for creating hot spots are discussed in the following three  sections. 

Nearest Neighbor Analysis 

Also called average nearest neighbor, nearest neighbor analysis is a distancebased statistic used to determine the spatial dependence of a point pattern (Grekousis,  2020). A point pattern can be random, dispersed, or clustered. The null hypothesis for the  test statistic is that the observed pattern exhibits complete spatial randomness. By  comparing the observed spatial patterning to a theoretical one, expected complete  randomness, the test statistic provides a nearest neighbor ratio. A p-value is also  calculated to determine the significance of the ratio. However, this measure is highly  sensitive to the study area’s size and does not indicate where clustering is occurring.  Nearest neighbor analysis only gives a global indication of the presence of clustering, but  not where it takes place.   

Ripley’s K Function 

Like the nearest neighbor analysis, Ripley’s K function is a test of point patterns  using a distance measure (Ripley, 1976). For this test, the number of events within a userdefined radius is calculated. The distance defined radius is placed around each point and  for each set distance. The total count of “captured” events is then compared to what is  expected given that no spatial patterning is evident (Grekousis, 2020). Multiple variations  of  this  test  statistic  exist,  but  in  principle,  each  is  using  radial  distance  measures  to  determine whether spatial patterning exists beyond what is expected for the data.  

  A problem with this method is the likelihood of having edge effects distort the  detection of spatial patterning. When crime data from a single city are analyzed, a common  issue affecting the analysis is the data being “cut off” by administrative borders (Kim &  Hipp. 2018). For example, if a major crime area on the border of the city and a nearby  unincorporated  area  exists,  only  the  city  data  will  be  analyzed.  The  demarcation  of  administrative  or  political  boundaries  does  not  prohibit  crime  from  occurring  in  one  location versus another. Therefore, edge effects can have a significant impact on spatial  analysis. Other physical boundaries such as rivers, parks, and major transportation routes  can create edge effects (Kim & Hipp, 2018).  

Kernel Density Function 

The kernel density function is a test statistic that provides the most familiar-looking  hot spot maps. Areas with varying densities of point data and graduated colors are used to  map  hot  spots.  Where  the  nearest  neighbor  analysis  and  Ripley’s  K  function  provide  estimates,  the  kernel  density  function  illustrates  generally  where  and  how  strong  the 

observed spatial patterns are. However, the strength of the observed spatial patterning is  not determined by statistical significance. 

  To calculate the kernel density function, a grid of cells is generated over the point  data. Each cell is then analyzed whereby a “kernel” moves across each cell given a setdistance and calculates weights for each point encountered (Chainey & Ratcliffe, 2005). A  kernel refers to a three-dimensional window function that moves across each cell giving  higher weights to closer points (Johnson, 2017). A commonly used kernel type is Gaussian  influenced but different spatial statistics programs use different kernel functions such as  Poisson (Grekousis, 2020). After the weighted distances are calculated each grid cell is  given a measure based on its summed weights. The result of the analysis is a smoothed  density estimation illustrating instances of higher or lower point occurrence around each  cell. While this method of analysis is very common in crime and place research, a few  caveats  limit  its  functionality  compared  to  more  localized  methods  (Grekousis,  2020;  Johnson, 2017). 

  Like other global measures used to detect spatial patterning, the kernel density  function is limited by cell size and the chosen kernel function (Johnson, 2017). Small  variations in the cell size can change the outcome of the analysis. Particularly, the use of  large bandwidths for the kernel function to examine each cell are more appropriate for  revealing  large-scale  pattering  (Fotheringham  et  al.,  2000).  Because  the  use  of  kernel  density function is common in crime and place research, general guidelines for bandwidth  selection exist to help the researcher determine which is best for use  (see Chainey  &  Ratcliffe, 2005). Another issue that exists with the use of this measure is the application of  “smoothing” which is also influenced by the selected bandwidth. Chainey and Ratcliffe 

(2005) note that the smoothing process can extend over areas where no crime occurred, but  due to the estimated density function, it appears crime is more widespread than in reality.  Hence, the crime hot spots can exaggerate the distribution of crime. While there is a lot of  flexibility in the use of the kernel density function, a more accurate representation and one  that provides evidence of statistical significance are indicators of spatial autocorrelation.    

Spatial Autocorrelation 

At its most basic form spatial autocorrelation suggests a nonzero covariance  between the values on a random variable for neighboring locations:  

Cov(yi,yj) = E(yiyj) – E(yi)E(yj) ≠ 0 for i≠j          (1) 

where i,j represent locations (Anselin & Bera, 1998; Darmofal, 2015). The null  hypothesis for a test of spatial autocorrelation indicates a random distribution of the  values on the random variable, i.e., that the locations of i and j do not provide evidence of  spatial proximity or dependence (Darmofal, 2015).  

Spatial randomness is the inverse of spatial autocorrelation. When spatial  autocorrelation is present it can be classified into two categories: positive or negative  (Harris, 2016). Positive spatial autocorrelation occurs when locations that are similar are  close to each other such as two adjacent neighborhoods with high crime rates. Negative  spatial autocorrelation is when a pattern of dissimilar (high and low) locations occurs  more frequently than true spatial randomness (Fortin & Dale, 2009). A map representing  negative spatial autocorrelation would look like a checkerboard (Harris, 2016). However,  checkerboard patterns are not visually obvious and are often not discernable from spatial 

randomness. More developed measures of detecting spatial autocorrelation are necessary  for analysis and are discussed in the following sections.  

Global Patterns. Global patterns of spatial autocorrelation are estimates of  spatial clustering across large geographic units. They illustrate how the data exhibits  spatial dependence in its entirety. The identification of clusters does not occur with the  use of global spatial statistics, but rather local measures. Global patterns can be analyzed  as dichotomous or continuous variables (Darmofal, 2015). An example of a dichotomous  variable is whether crime occurred at a certain threshold per community or not. A join  count analysis is applicable in this scenario where binary weights are utilized to create the  weights matrix. The other method, which will be discussed in detail, is the analysis of  continuous-like data such as crime counts. While they are truly not continuous, crime  counts are often treated as such. To analyze crime incident data an understanding of the  spatial weights matrix and the two more commonly used global measures of spatial  autocorrelation is necessary. 

The Spatial Weights Matrix. In spatial autocorrelation statistics, weight matrices  apply to many of the commonly used measures. A weight matrix summarizes the spatial  data and any relationships that exist among a variable at one areal unit against its  neighbor(s) (Chi & Zhu, 2020; Dubin, 2009). Two types of spatial structures can be used  to create a spatial weights matrix. These are contiguity and or distance-based structures  (Chi & Zhu, 2020). A contiguity-based structure implies that each areal unit “touches”  another, therefore, they are neighbors. Commonly used contiguity structures include the  “rook’s case” and “queen’s case”. In a rook case structure, neighbors are defined as  spatial units that share a common edge (Darmofal, 2015). A queen case structure defines 

neighbors as any spatial unit sharing a common edge or vertex much like in a game of  chess. Anselin (1988) notes that in a queen case structure all spatial units contiguous to i  are neighbors of i. 

The following is a spatial weights matrix where matrix W contains elements wij

��� ��� ⋯ ��� ��� ��� ⋯ ��� ⋮ ⋮ ⋱ ⋮ ��� ��� ⋯ ���

�  = �

� (2) 

For neighbor cases in a spatial matrix, a ‘1’ is used for coding based on observation i and  its neighbor j. A common practice is to row standardize the weights which allows for  easy use in many of the spatial statistic models (Chi & Zhu, 2020). Row standardization  involves summing the total weights per row and dividing across neighbors. The  interpretation of spatial proximity for a unit is easier when row standardization is used.  Other options that can be applied to spatial weight matrices are fixed or variable weights.  Distance measures and functions of the examined variable can also affect how these  matrices are created (Chi & Zhu, 2020).  

  Many configurations exist for how spatial weights matrices are created and used.  Perhaps, the most important use is for exploratory spatial data analysis and fitting spatial  regression models (Dubin, 2009). Like many spatial statistics, there is difficulty in  selecting the best method for a given research questions. In some instances, theory can  help inform the researcher but as previously discussed, crime and place theories do not  provide such justification. However, selecting which matrix to use can rely on the  research question itself. Chi & Zhu (2020) suggest selecting a matrix that allows for high  spatial autocorrelation for exploratory purposes. This method is used in conjunction with 

Moran’s I. When using a spatial weights matrix, a common challenge encountered is  imprecise data which can lead to “islands” in the data where no neighbor exists. Using  distance-based measures can also include too many or too few neighbors. The best  practice is to see what best fits the data combined with guidance from prior research or  theory. 

  Global Moran’s I. The Moran’s I statistics is a measure used for detecting global  spatial dependence and whether the dependence is statistically significant (Moran, 1950).  Moran’s I statistics is defined as 

���������������������

� = � �

����������          (3) 

������

where �� and �� are the values on the random variable at locations i and j, �� is the mean  of the variable of interest, and ��� is the spatial weight of the link between i and j. When  the values for locations i and j are more similar or dissimilar, Moran’s I is a larger  positive or negative value. Weaker neighbor relationships are closer to ‘0’. The  theoretical bound for Moran’s I is between -1 and 1, with positive correlation between 0  and 1, and negative between -1 and 0. Stronger correlations are closer to the extremes of  the bound.  

  The use of Moran’s I is very common with larger areal data and when global  trends are detected. When examining an entire city’s crime data, Moran’s I can detect  spatial clustering and whether the clustering is significant beyond what is expected:  spatial randomness (Darmofal, 2015). However, to determine where clusters exist and to  detect finer precision regarding spatial heterogeneity, local indicators of spatial 

autocorrelation are required. Lastly, a null finding using Moran’s I does not imply the  absence of spatial dependence at the local level, thus providing more evidence for the use  of local measures (Waller, 2009; Ward & Gleditsch, 2019).  

Geary’s c. Another measure of spatial autocorrelation is Geary’s c statistic  (Geary, 1954). Like Moran’s I, Geary’s c is used to detect global spatial dependence. The  interpretation of the statistic differs though as values closer to 1 imply spatial  randomness, greater than 1 imply negative autocorrelation, and values closer to 0 imply  spatially positively correlated data (Chi & Zhu, 2020). Because Moran’s I is considered  more powerful and less affected by outliers (Geary’s c gives more weight to extreme  values), Geary’s c is less commonly used.   

Local Patterns. Studying the spatial variability of crime will often involve the  use of micro-units to detect local spatial patterns (Weisburd et al., 2012). Global  measures of spatial autocorrelation can be viewed as a provisional starting point for crime  variability research as they do not detect where spatial clusters are located. Localized  spatial clusters can be hidden by global models as broad spatial patterns can “wipe” out  smaller patterns (Anselin, 1995). Having a single statistic for an entire study area can lead  researchers to violate MAUP or committing an ecological fallacy as they may infer from  larger spatial units to smaller units incorrectly (Wong, 2009).  

  Like global measures, local measures of spatial autocorrelation are designed for  the use of point data. However, as in the case of street segments, point data can be  aggregated to areal or line data (Weisburd et al., 2012). It is common in micro-place  research to use street segments as a measure of local spatial similarity. While other 

micro-place types exist, they are commonly limited by small N sizes which can make for  model misspecification regarding the detection of spatial autocorrelation (Andresen et al.,  2020). The two most popular methods for detecting local spatial dependence are  discussed below.  

Local Moran’s I. Developed by Anselin (1995) as a localized version of Moran’s  I¸ local indicators for spatial autocorrelation (LISA, hereafter) are used for disaggregating  global patterns of spatial autocorrelation. The Local Moran’s I statistic is defined as  

�� = ���������������������

������           (4) where the notation matches the global statistic in (3). For each attribute, Ii measures the  extent of significant spatial clustering of high and low values, and detects spatial outliers  (Darmofal, 2015; Grekousis, 2020). The sum of Ii for all observations is proportional to  Moran’s I (Anselin, 1995). Compared to its global analogous, Ii identifies significant  clusters of high-high and low-low values indicating positive spatial autocorrelation.  Significant clusters of differing values indicate negative spatial autocorrelation.  

  A helpful way to visual and recommended as an intermediary step between global  and local tests is the Moran scatterplot. A Moran scatterplot is a quadrat plot where the  observed values on the random variable are along the x-axis and the weighted average for  each observation’s neighboring values are along the y-axis (Darmofal, 2015). Local  regression (ex. Lowess) can be used to identify possible structural breaks in the data.  Additionally, as the possibility of clustering or outliers due to randomness exists,  permutation tests are applied (Grekousis, 2020). A typical permutation test is a Monte  Carlo simulation (e.g., see Andresen et al., 2020).

*. Another LISA test commonly applied when studying the spatial  variability of crime is the G statistic and its variants. The Gi and Gi

  Gi and Gi

* tests are the two most  often used in crime and place research, particularly, for hot spot analysis (Chainey &  Ratcliffe, 2005). The more frequently used test, Gi

*, is discussed here and is defined as 

� ����� � ���

��∗��,��� =

� �� � ���

(5) 

where ��∗��,��� is the local statistic at location I, which has grid coordinates (u,v) and for  which a binary weights matrix is used, set to ��� = 1 if locations i and j are within a  certain distance, d, of each other or else ��� = 0. (Ord & Getis, 1995). Differing from the  Local Moran’s I, the Gi

* statistic is interpreted as positive values indicating high-high  relationships and negative values indicating low-low relationships. Both relationships are  indications of positive spatial autocorrelation. Negatively autocorrelated cases are  difficult to detect with this statistic (Darmofal, 2015).  

* statistic is sensitive to the distance threshold used which in  turn affects the spatial weights matrix. Unlike other LISAs, the Gi

  The result of the Gi

* statistic incorporates i  in its own neighborhood set (Grekousis, 2020). Like other distance-based measures  though, theory and optimization techniques can be used to justify the chosen distance for  calculation. One example is the variogram which helps calculate the best distance  threshold to use during analysis (Harris, 2016). 

CHAPTER 3 

HOW DO WE MEASURE THE SPATIAL VARIABILITY OF CRIME? A  SYSTEMATIC REVIEW1

1 Spencer, M. D., A. M. Lemieux, and A. Mancik. To be submitted to Journal of Research in Crime and  Delinquency. 

Abstract 

Objective  In the last decade (2010-2019) crime and place research has flourished. The spatial  variability of crime has attracted recent interest due to its nested properties of spatial  homogeneity. To analyze these properties, diverse methods and units of analysis have  been utilized, often with little a priori guidance. This study systematically reviewed the  relevant literature and reports on the research methods and findings of the spatial  variability of crime.    Data/Methods  

Systematic review protocols based on the Campbell Collaboration were followed and  machine learning software was used to identify studies for inclusion. Methodological  trends used to measure the spatial variability of crime were identified.  

Results   We identified 11 studies that studied the spatial variability of crime. Our review reveals a  lack of cohesiveness across studies regarding the methods and units of analysis used.  Despite the range of methodological choices applied to study the phenomenon, all studies  reiterated the importance of micro-units.   Conclusions  

Analyzing variance across multiple units and spatial scales is becoming more common.  However, defining the concept and choosing methods to study the spatial variability of  crime is a work-in-progress. Further research is needed to develop this area of research.   

Introduction 

Rather than theoretical advancement, crime and place research has often focused  on advancing the methodologies used to measure where crime occurs (see Hipp, 2016 for  an exception). These advancements come in two flavors: statistical measures of crime  concentration, and spatial measures of crime variability. The latter presents a more  diverse range of spatial applications whereas the former is a descriptive approach such as  described by the law of crime concentration (see Weisburd, 2015). It is often assumed  that crime is dependent on place and by some measure it varies given certain place  characteristics (Brantingham & Brantingham, 1981; Cohen & Felson, 1979). Little  thought is given though to how estimates of crime vary due to methodological choices  such as unit selection and tests for spatial variability.  

Most studies find support for the law of crime concentration (Andresen et al.,  2017; Haberman et al., 2017; Sherman et al., 1989; Weisburd, 2015) and more broadly  the connection between crime and place (Weisburd et al, 2016). Little is succinctly  understood about the salience of crime variability, particularly if estimates translate  between cities. For example, crime concentration using the 80/20 ratio and the  observation that 50% of crime can be attributed to 3-6% of places roughly translates from  one study location to another (see Weisburd et al., 2012). However, depending on the  spatial units examined and tests used, crime variability estimates may not be a universally  transferable statistic. Because a comprehensive review or unified definition across studies  researching the spatial variability of crime does not exist, a systematic review seems  appropriate. The primary focus of this systematic review will be on the methodologies  used for examining the spatial variability of crime including the selection of units of 

analysis. To help frame the study a definition of spatial variability is provided as the  measure of crime across hierarchically ordered geographic space for which values of  crime change given their aggregation to a unit.  

Background: The Spatial Variability of Crime 

The process of spatially analyzing crime has developed greatly over the last few  decades. Within this timeframe research has progressed from predominantly analyzing  hot spots to the concentration of crime and now the spatial variability of crime (Sherman  et al., 1989; Weisburd, 2015). Much of these topics are well defined by the techniques  used to study them with the exception being the latter. For example, when studying hot  spots or the concentration of crime there are methodologies readily apparent that are  foundational to these topics. The same is not true for studying the spatial variability of  crime, a phenomenon without a concrete definition even. Instead, due partially to the  developing nature of the topic, a diverse array of methodologies exists with minimal  clarity on which to use. Further a key component of analyzing the spatial variability of  crime is the selection of units. This is an issue that has plagued geographical researchers  for decades (Openshaw, 1984; Wong, 2009).  

Much of the history of crime and place research has been characterized by  neighborhood-level units or micro-units, typically street segments as of recent (Weisburd  et al., 2009; Weisburd, 2015). Analyzing multiple units within a single study is not a new  concept (see Baumer et al., 2012; Hipp & Williams, 2021). Yet, until recently much of  the crime and place research has not done so. More so, the hierarchical organization of  spatial units has often been ignored (i.e., not addressing the modifiable areal unit  problem) or analyzed separately (i.e., crime concentration research). Driven by the 

popularity of Weisburd’s (2015) Law of Crime Concentration, research analyzing the  spatial variability of crime has begun to gain traction. At present, no systematic gathering  of information on these studies exists. Particularly, it is unclear what methodologies are  commonly being used to study crime variability and across what units. To the author’s  knowledge, there is at present no clarity of these findings from these studies nor how they  compare to estimates of crime concentration. Though, given the complexities of  performing a meta-analysis on the outcomes of selected studies none was performed.  Only ancillary comparisons are made of their findings.  

Methods 

This systematic review will use the Campbell Collaboration as a guide for its  methodology. See Appendix A and B for the proposed eligibility check sheet coding  protocol.   Criteria for Inclusion of Studies 

Five criteria were used to determine relevant studies. First, using the previously  stated definition of spatial variability, only studies where crime was the dependent  variable and those that examined the phenomena were eligible for review. However,  spatial variability does not need to be the primary focus as examinations of spatial  concentration are also common and performed in parallel. Second, for a study to be  included, a spatial methodology must have been applied. That is, the study was  contingent on crime data being geo-referenced, thus making traditionally non-spatial  methodologies spatially contextual. For example, studies were not limited to methods  deemed strictly spatial such as spatial regression or indicators of spatial autocorrelation.  Third, the units of analysis were not limited. Therefore, research utilizing any 

combination of within and between city comparisons across micro, meso, and macrolevels were included. Some examples are provided for context regarding possible spatial  unit choices. Examples of micro-level units are census blocks, street segments, and single  addresses. Meso-level units are typically representative of neighborhoods and can include  block groups, census tracts, community areas, and police beats. Macro-level units are  commonly representative of entire cities but can include other large geographic spaces  such as counties or states. Among each level is the possibility for researcher defined areas  such as grid cells. Any geographic not previously listed did not exclude any study from  analysis. Fourth, for this review, crime was an inclusive term defined as a measure of  official reported crime incidents, calls for service, and arrests. Fifth, and lastly, the  location of or the reporting law enforcement agency were not exclusionary factors.  Search Strategies    Encompassing search strategies were performed to capture literature that meets  the eligibility criteria. First, a keyword search2 was performed using 12 online abstract  databases.3 Additionally, governmental, and nonprofit organization web pages4 and the  online abstracts of articles presented at professional criminology and criminal justice and  geography conferences were searched.5 Second, a forward search was performed for 

2 The following search terms were used: spatial variability AND crime, crime AND place, “placed-based”  AND crime, environmental criminology, geocoding AND crime, geography AND crime, “spatio-temporal”  AND crime, “hot spots” AND crime, crime distribution, crime mapping.  3 The following 12 databases were searched: Academic Search Complete, Criminal Justice Abstracts,  National Criminal Justice Reference Services (NCJRS), Sociological Abstracts, Web of Science Core  Collection, Social Science Full Text, Google Scholar, Academic Search Complete, JSTOR, Applied Social  Sciences Index and Abstracts, Dissertation Abstracts, C2 SPECTR (The Campbell Collaboration Social,  Psychological, Educational and Criminological Trials Register).  4 The web pages include the Center for Problem-Oriented Policing, Netherlands Institute for the Study of  Crime and Law Enforcement, University College of London, U.S. Office of Community Oriented Policing  Services, Police Foundation, Police Executive Research Forum, and U.K. Home Office.  5 These conferences include the annual meetings of the American Society of Criminology, Academy of  Criminal Justice Sciences, and the American Association of Geographers. 

research that has cited the seminal crime and place work of Weisburd (2015). Third, hand  searches were performed of leading journals in the field of criminology and criminal  justice and geography.6 Google’s h5-index was used to determine what these journals  were. All searches were restricted to the time frame of 2010-2019. This time frame was  selected because it spans roughly equal time before and after Weisburd’s (2015) work  and presentation on the law of crime concentration. The law of crime concentration  served as a major rejuvenation of research focused on place, particularly research  focusing on micro-units of analysis (see Eck et al., 2017). It is also during this time frame  that crime and place research greatly expanded in scope and methodological  sophistication.   

  After completing the initial searches, a total of 535 studies were identified as  potentially eligible studies. That is, these 535 studies were deemed to be relevant but not  thoroughly screened for inclusion as part of this study’s analysis. To aid the process of  screening abstracts an open-source machine learning software called ASReview was used  (see van de Schoot et al., 2021). This software was developed to expedite the amount of  time spent screening abstracts. Through a process of varying machine learning algorithms  that can be expressed (the Naïve Bayes algorithm was used for this study), the researcher  is able to continuously train the software by categorizing studies as relevant or irrelevant.  Before the screening, a researcher-defined stopping point was created to determine when 

6 These journals are as follows: Criminology, Criminology & Public Policy, Justice Quarterly, Journal of  Research in Crime and Delinquency, Journal of Experimental Criminology, Journal of Criminal Justice,  British Journal of Criminology, Journal of Quantitative Criminology, Crime & Delinquency, and Criminal  Justice and Behavior. These journals are listed in the top 10 according to Google’s h5-index from 20152019 Criminology, Criminal Law & Policing. Progress in Human Geography, Applied Geography, and the  Journal of Economic Geography were also searched. These are the top 3 according to Google’s h5-index  for Geography and Cartography. 

the screening process would cease.7 The stopping point was defined as ��� where, after  ~54 (10%) consecutive studies were categorized as irrelevant the screening process  halted. This threshold was chosen because it matches the approximate error rate of  humans reviewing abstracts for a systematic review (see Wang et al., 2020). Using this  process, a total of 15 relevant studies were identified. The 15 studies were then fully  screened and further reduced to 11 eligible studies. The four studies that were dropped,  while methodologically interesting, did not explicitly test the spatial variability of crime  as defined by this study.8 Figure 3.1 illustrates the flowchart of the search and screening  processes. Approximately 32% (172 of 535) of the eligible abstracts were reviewed using  ASReview before the screening was halted. The remaining 68% (363 of 535) of abstracts  were not reviewed as deemed unnecessary based on the defined stopping point.  

7 At present, no definitive stopping point using this software or others like it has been studied. Three  options exist: predetermined (screen only a set % of all studies); data-driven (stop after X irrelevant studies  consecutively); and time-based (stop after a set time). Visit https://asreview.nl/blog/asreview-class101/#stop-screening for more information on using the software.  8 Despite being closely related to the topic these four studies were ultimately not selected for inclusion as  they did not satisfy the current definition of spatial variability offered by this study. In the future,  refinement of the concept may lead to these studies being considered fully relevant. Nonetheless, each of  these four studies provided relevant information and offered unique methodological perspectives. The  studies are (Boessen & Hipp, 2015; Hipp et al., 2017; Lee et al., 2014; Malleson et al., 2019) 

Figure 3.1 Flowchart of search and screening processes.  

Findings 

Key features of each included study were examined. These include: the spatial  methodology used, spatial unit of analysis, type of crime examined, and relevant findings  regarding levels of spatial variability. Other features examined include authorship,  location examined, crime incident sample size, years examined, and journal among  others.  

Table 3.1 presents the basic characteristics of the 11 eligible studies. Over twothirds (63.7%) of the studies examined locations in the United States or Canada. Of the  locations examined in North America, two cities were the subject of two studies each:  Boston, MA and Vancouver, BC. Two studies examined locations in Europe and two in  Brazil. Within each study, the cities, or metropolitan areas examined had populations  >300,000. A few areas of examination (Campinas and Recife, Brazil and Chicago, IL)  had over 1,000,000 residents. Regarding crime, most studies (63.6%) analyzed multiple  crime types, often including only violent crimes. Of the studies which analyzed a single 

crime type, each type is violent (e.g., residential burglary, homicide, robbery, and arson).  Almost all studies (45.5% each category) had sample sizes < 10,000 or between 10,000  and 999,999. One study analyzed more than 1,000,000 crime incidents.9 A single study  analyzed crime using data from one year and the majority analyzed data spanning  multiple years averaging five years. Most studies used multi-level models (54.5%) with  the remaining using point-pattern tests or spatial regression. Concerning the  concentration of crime, approximately half did and did not analyze levels of  concentration such as how many units account for some ratio of crime.  

Table 3.1 Key characteristics analyzed, N = 11  Characteristic    N  Percentage  Country  United States  4  36.4    Canada  3  27.3    Brazil  2  18.2    Netherlands  1  9.0    Sweden  1  9.0  Crime   Single Type  4  36.4    Multiple Types  7  63.6  Sample Size  <10,000  5  45.5    10,001-999,999  5  45.5    >1,000,000  1  9.0  Years  1-3  4  36.4    4-9  6  54.5    >10  1  9.1  Methodology  Point-Pattern Test  4  36.4    Spatial Regression  1  9.1    Multi-level Model  6  54.5  Concentration Analyzed  5  45.5    Not analyzed  6  54.5 

Also assessed (not included in tables) were the authors, journal, year published,  and use of publicly accessible data. Across the 11 studies, there are 18 authors and half  were at the time of publication U.S. based. The rest of the authors were from Australia 

9 O’brien and Winship (2017) analyzed 311 reports and 911 dispatches. The samples for each type were  369,172 and 1,673,908 respectively.  

(1), Brazil (4), Canada (1), the Netherlands (1), Sweden (1), and the U.K. (1). Among the  authors, two were involved in multiple studies: Daniel T. O’Brien (2x; twice as first  author, once as sole) and Martin A. Andresen (4x; once as first author). Eight of the  studies were published in journals from the field of criminology, two in geography, and  one in the broad domain of social science. Of those published in criminological outlets,  four were published in the Journal of Quantitative Criminology and two in the Journal of  Research in Crime and Delinquency. No other publications came from the same journals.  Three of the four studies published in Journal of Quantitative Criminology were in the  same volume and the other in the prior volume.10 Of the 11 studies, all but one (published  in 2011) were published after 2015 with four in 2017 and four in 2019. The use of openly  accessible data was also quite common with 45.5% of studies doing so.  

Of particular importance to this systematic review is the scope of spatial units of  analysis across research on the topic. Table 3.2 presents the micro- and meso-level units  examined in each study.11 No study examined units beyond what is geographically  considered meso-level. It was common for multiple units at each level to be analyzed.  The most common unit analyzed was street segments (n = 8) and the least common was  grid cells and units that are not easily transferable to U.S. census units (see de Melo et al.,  2015; Gerell, 2017). Tracts (n = 6) were another commonly examined unit. There is a  large difference between the number of micro- and meso-units analyzed across the  studies. Of the 14 types of micro-units examined, 11 included more than 10,000 units. Of 

10 Volume 33 of the Journal of Quantitative Criminology had four issues with many studies covering crime  and place focused topics. Issue 3 of volume 33 was a special issue titled “The Law of Crime Concentration  at Places”. 

11 Across the studies, units with the same name but different meanings were used (i.e., dissemination areas).  In each case, the study clearly compared these units to recognizable units in the United States. These comparisons guided the categorization as micro- or meso-level units.  

the 19 types of meso-units examined, 13 included less than 200 units. All studies assessed  the spatial variability of crime using two units of analysis, nine used three units, and two  used four units. While four units were used in the models by Schnell et al. (2017) and  Steenbeek and Weisburd (2016) only three levels represented spatial units; the other level  represented a time component. 

Table 3.2 Spatial units by study 

Units (N)  Study  Micro  Meso  Andresen & Malleson 

Street segments (11,730);  Dissemination areas  (1,011) 

Tracts (110) 

(2011) 

de Melo et al. (2015)  Street segments (49,173)  Ponderation areas (36);  Tracts (1,749)  Gerell (2017)  Thiessen polygons (952)  Sub-districts (136); Small 

area statistics areas (391)  Hodkinson & Andresen 

Street segments (18,445)  Neighborhoods (22);  Tracts (117);  Dissemination areas (991) 

(2019) 

O’Brien (2019)  Addresses (98,355); Street  segments (13,048) 

Tracts (178)  O’Brien & Winship (2017)  Addresses (123,265); 

Tracts (178)  Pereira et al. (2017)  Street segments (31,777)  Tracts (1,854)  Quick (2019)  Dissemination areas (656)  Police patrol zones (18); 

Street segments (13,767) 

Electoral wards (25);  Neighborhoods (97) 

Schnell et al. (2017)  Street segments (41,926)  Community areas (76); 

Neighborhoods (342)  Smith & Sandoval (2019)  250-meter grid cells 

500-meter grid cells (777)  Steenbeek & Weisburd 

(2,922) 

Street segments (15,527)  Districts (44);  Neighborhoods (114) 

(2016) 

The primary type of methodology applied by each study is of central concern to  this review. The analyses across the studies are presented in Table 3.3 by study. Among 

the studies which utilized multi-level models there is some diversity of the chosen model.  A Bayesian approach, count model, and a nested Gini coefficient model were used  once.12 Three other studies used linear mixed models with one being a quasi-replication  of another (see Schnell et al., 2017; Steenbeek & Weisburd, 2016). Of the studies which  analyzed the spatial variability of crime using a point-pattern test, all four used  Andresen’s S-index (see Andresen, 2009). Of note, in each of the studies using this  method, the creator of the statistic was an author. Lastly, of a more traditionally spatial  method, a single study used a spatial regression model; specifically, spatial lag and  geographically weighted regression models.  

Table 3.3 Methodological Analysis by Type 

Multi-Level Model  Gerell (2017)  Two-level linear mixed  O’Brien (2019)  Three-level nested Gini coefficients O’Brien & Winship (2017)  Three-level Poisson  Quick (2019)  Two-level Bayesian cross-classified  Schnell et al. (2017)  Four-level linear mixed  Steenbeek & Weisburd (2016)  Four-level linear mixed

Point-Pattern Test 

Andresen & Malleson (2011)  Andresen’s S-index  de Melo et al. (2015)  Andresen’s S-index  Hodgkinson & Andresen (2019)  Andresen’s S-index  Pereira et al. (2017)  Andresen’s S-index 

Spatial Regression  Smith & Sandoval (2019)  Spatial lag and geographically weighted 

12 The Gini coefficient is a measure of inequality (Gini, 1912) and commonly used as a descriptive measure  of crime concentration (Bernasco & Steenbeek, 2017; Hipp & Kim, 2017; Mohler et al., 2017). Alone, the Gini coefficient would not satisfy the requirement of testing for spatial variability. However, O’Brien 

(2019) applied a nested use of the coefficient that aims to capture concentrations of crime across multiple  geographic scales. 

Lastly, of ancillary importance to this review were the findings of each study. Due  to the complexities of comparing variance estimates originating from different  methodological choices and across varying geographic units of analysis for each study,  only the general findings are discussed. Across all studies, the largest share of the spatial  variability of crime can be attributed to micro-units of analysis (most often street  segments) regardless of how many other units were examined. The units within higherorder geographic scales, often representing neighborhoods, explained the other largest  shares of variance.  

A few caveats exist though regarding the latter statement and how important these  larger units were for explaining variability. In the case of Smith and Sandoval (2019),  raster grids were used as units. Like the other studies which used administratively defined  units, the smallest unit offered the greatest accuracy for examining local spatial  variability. However, their larger unit provided more robust estimates for their models.  Gerell (2017) observed that little difference existed between large and medium-sized  units, but the smallest units were the most important. O’Brien and Winship (2017) found  that 95-99% of the variance was attributed to the micro-unit (addresses).  

The results from the three previously described studies contrast with the findings  from Schnell et al. (2017) and Steenbeek and Weisburd (2016) which found more support  for the importance of meso-units. For example, Schnell et al. (2017) observed that on  average 59% of the variance of violent crime was attributed to the micro-unit while larger  units were responsible for the remaining 41%. These estimates are similar to Steenbeek  and Weisburd’s (2016) findings (average of 62% for micro-units and 38% for higherorder units). Despite the nuanced differences of methodological choice which influenced 

how variance was reported for each unit, smaller units (often street segments) were the  greatest indicator for levels of crime variability.

The importance of micro-units is an un-surprising finding given micro-units have  been widely discussed and advocated for use in recent years (see Bernasco & Steenbeek,  2017; Oberwittler & Wikström, 2009). Yet, careful consideration must be taken when  interpreting results using micro-units as they often far exceed the number of crimes being  analyzed, resulting in artificial inflation of concentration and variability. This realization  suggests that the statistical methods rather than units of analysis used may be a more  fertile ground regarding their impact on research findings.   

Discussion and Conclusions 

The importance of analyzing geographic data across multiple scales and units  gained traction when Openshaw (1984) coined the term modifiable areal unit problem  (MAUP). This term addresses the issue of research foci being too narrow or broad; one,  that disregards spatial trends above and below the unit being examined. While crime and  place research has flourished since the hot spots research of the 1990s to crime  concentration research of the mid-2010s, much does not specifically address the issue of  MAUP. As examined by the research included in this systematic review, the concept of  spatial variability is designed to address MAUP. That is, crime varies by units nested  within other units and analyzing the phenomenon requires multi-level methodologies.  This largely follows the definition outlined at the beginning of this systematic review.  However, as evident by the plethora of methodologies and units examined from the  identified studies, that definition may be too narrow or ill-defined. Specifically, the  definition does not expand on what types of spatial and statistical relationships are of key 

interest among the data being analyzed. For example, it is difficult to differentiate  whether the studies that used tests of concentration (e.g., the nested Gini coefficient)  across multiple spatial levels should be categorized as tests of concentration or spatial  variability. The primary differentiating factor in this case is the nested analysis. Future  work in this area will certainly benefit from refining the definition of spatial variability of  crime.     There is also the issue of overlap between research examining crime  concentration versus more spatially centric studies. In both cases, research is interested in  understanding where crime occurs and at what levels. However, as previously discussed  measures of crime concentration are statistical descriptions rather than true tests of spatial  unevenness. There is room for overlap though, as evident from the studies included in  this review. Some studies even use tests designed for examining crime concentration but  across multiple levels (see O’Brien, 2019; O’Brien et al., 2021).     Based on the few studies selected as satisfactorily examining the spatial  variability of crime, it is evident this branch of research is in the development phases.  This systematic review is the first comprehensive bridge between these studies with a  central focus on their methodological choices. The present study aims to serve as a guide  to the choices being made for future research on this burgeoning topic. While many of the  findings from the research on the spatial variability of crime mimic those on the  concentration of crime, there are ample opportunities to parse the nuance of  methodological choice. Additionally, research on this topic has the potential to invoke  new theoretical progress that is hierarchically structured and methodically informed.  

  Central findings from this systematic review are that across the reviewed research  a wide array of sample sizes, units, and methodologies are used. There is also a lack of  research when compared to studies on the concentration of crime where a recent  systematic review identified 44 studies from 1970-2015 (see Lee et al., 2017). Like  research on crime concentration micro-places play an important role in our understanding  of where crime occurs relative to other units. Of concern and as a recommendation for  future research, replication is needed. Because many options exist on how to measure the  spatial variability of crime and new ones being proposed, it appears replication is of little  interest. Instead, pressure from pursuing the next innovative methodology may lure  researchers away from replication. This is a harmful prospect as the concept of spatial  variability is in development and without methodological guidance. Foundations are  crucial for any topic of research for future research to build upon. Instead, as evident  from this systematic review, that has not occurred yet or may not occur in the future.   

References 

Andresen, M. A. (2009). Testing for similarity in area-based spatial patterns: A  nonparametric Monte Carlo approach. Applied Geography, 29, 333-345.  

Andresen, M. A., Curman, A. S., & Linning, S. J. (2017). The trajectories of crime at  places: Understanding the patterns of disaggregated crime types. Journal of  Quantitative Criminology, 33, 427-449. 

Andresen, M. A., & Malleson, N. (2011). Testing the stability of crime patterns:  Implications for theory and policy. Journal of Research in Crime and  Delinquency, 48, 58-82.  

Baumer, E. P., Wolff, K. T., & Arnio, A. N. (2012). A multicity neighborhood analysis of  foreclosure and crime. Social Science Quarterly, 93, 577-601.  

Bernasco, W., & Steenbeek, W. (2017). More places than crimes: Implications for  evaluating the law of crime concentration at place. Journal of Quantitative  Criminology, 33, 451-467. 

Boessen, A., & Hipp, J. R. (2015). Close-ups and the scale of ecology: Land uses and the 

geography of social context and crime. Criminology, 53, 399-426.   Brantingham, P. J., & Brantingham, P. L. (1981). Environmental criminology. Sage.   Cohen, L. E., & Felson, M. (1979). Social change and crime rate trends: A routine 

activity approach. American Sociological Review, 44, 588-605. 

de Melo, S. N., Matias, L. F., & Andresen, M. A. (2015). Crime concentrations and  similarities in spatial crime patterns in a Brazilian context. Applied Geography,  62, 314-324.  

Eck, J. E., Lee, Y., O, S., & Martinez, N. (2017). Compared to what? Estimating the  relative concentration of crime at places using systematic and other reviews.  Crime Science, 6, 1-17.  

Gerell, M. (2017). Smallest is better? The spatial distribution of arson and the modifiable 

areal unit problem. Journal of Quantitative Criminology, 33, 293-318.   Gini, C. (1912). Variabilità e mutabilità. vamu.  Haberman, C. P., Sorg, E. T., & Ratcliffe, J. H. (2017). Assessing the validity of the law 

of crime concentration across different temporal scales. Journal of Quantitative  Criminology, 33, 547-567.  

Hipp, J. R. (2016). General theory of spatial crime patterns. Criminology, 54, 653-679.  

Hipp, J. R., & Kim, Y. A. (2017). Measuring crime concentration across cities of varying  sizes: Complications based on the spatial and temporal scale employed. Journal of  Quantitative Criminology, 33, 595-632. 

Hipp, J. R., & Williams, S. A. (2021). Accounting for meso- or micro-level effects when  estimating models using city-level crime data: Introducing a novel imputation  technique. Journal of Quantitative Criminology, 37, 915-951. 

Hipp, J. R., Wo, J. C., & Kim, Y. A. (2017). Studying neighborhood crime across  different macro spatial scales: The case of robbery in 4 cities. Social Science  Research, 68, 15-29.  

Hodgkinson, T., & Andresen, M. A. (2019). Changing spatial patterns of residential  burglary and the crime drop: The need for spatial data signatures. Journal of  Criminal Justice, 61, 90-100. 

Lee, H., Vaughn, M. S., & Lim, H. (2014). The impact of neighborhood crime levels on  police use of force: An examination at micro and meso levels. Journal of  Criminal Justice, 42, 491-499.  

Lee, Y., Eck, J. E., O, S., & Martinez, N. N. (2017). How concentrated is crime at places?  A systematic review from 1970 to 2015. Crime Science, 6, 1-16.  

Malleson, N., Steenbeek, W., & Andresen, M. A. (2019). Identifying the appropriate  spatial resolution for the analysis of crime patterns. PLoS One, 14, e0218324. 

Mohler, G., Short, M. B., & Brantingham, J. P. (2017). The concentration-dynamics  tradeoff in crime hot spotting. In D. Weisburd & J. E. Eck (Eds.)., Unraveling the  crime-place connection. New directions in theory and policy (pp. 19-40).  Routledge.

Oberwittler, D., & Wikström, P. O. H. (2009). Why small is better: Advancing the study  of the role of behavioral contexts in crime causation. In D. Weisburd, W.  Bernasco, & G. J. N. Bruinsma (Eds.), Putting crime in its place (pp. 35-59).  Springer. 

O’Brien, D. T. (2019). The action is everywhere, but greater at more localized spatial  scales: Comparing concentrations of crime across addresses, streets, and  neighborhoods. Journal of Research in Crime and Delinquency, 56, 339-377.  

O’Brien, D. T., Ciomek, A., & Tucker, A. (2021). How and why is crime more  concentrated in some neighborhoods than others?: A new dimension to  community crime. Journal of Quantitative Criminology.  https://doi.org/10.1007/s10940-021-09495-9

O’Brien, D. T., & Winship, C. (2017). The gains of greater granularity: The presence and  persistence of problem properties in urban neighborhoods. Journal of Quantitative  Criminology, 33, 649-674.  

Openshaw, S. (1984). The modifiable areal unit problem. Geo Books.  Pereira, D. V. S., Mota, C. M. M., & Andresen, M. A. (2017). The homicide drop in 

Recife, Brazil: A study of crime concentrations and spatial patterns. Homicide  Studies, 21, 21-38. 

Quick, M. (2019). Multiscale spatiotemporal patterns of crime: A Bayesian crossclassified multilevel modeling approach. Journal of Geographical Systems, 21,  339-365. 

Schnell, C., Braga, A. A., & Piza, E. L. (2017). The influence of community areas,  neighborhood clusters, and street segments on the spatial variability of violent  crime in Chicago. Journal of Quantitative Criminology, 33, 469-496.  Sherman, L. W., Gartin, P., & Buerger, M. E. (1989). Hot spots of predatory crime: 

Routine activities and the criminology of place. Criminology, 27, 27-55. 

Smith, T. A., & Sandoval, J. S. O. (2019). Examining the local spatial variability of  robberies using a multi-scale methodology. Social Sciences, 8, 1-25.  

Steenbeek, W., & Weisburd, D. (2016). Where the action is in crime? An examination of  variability of crime across different spatial units in The Hague, 2001-2009.  Journal of Quantitative Criminology, 32, 449-469.  

van de Schoot, R., de Bruin, J., Schram, R., Zahedi, P., de Boer, J., Weijdema, F.,  Kramer, B., Huijts, M., Hoogerwerf, M., Ferdinands, G., Harkema, A.,  Willemsen, J., Ma, Y., Fang, Q., Hindriks, S., Tummers, L., & Oberksi, D. L. 

(2021). An open source machine learning framework for efficient and transparent  systematic reviews. Nature Machine Intelligence, 3, 125-133.  

Weisburd, D. (2015). The law of crime concentration and the criminology of place.  Criminology, 53, 133-157.  Weisburd, D., Bernasco, W., & Bruinsma, G. (2009). Putting crime in its place: units of  analysis in geographic criminology. Springer.   Weisburd, D., Groff, E. R., & Yang, S.M. (2012). The criminology of place: Street  segments and our understanding of the crime problem. Oxford University Press. 

 Wang, Z., Nayfeh, T., Tetzlaff, J., O’Blenis, P., & Murad, M. H. (2020). Error rates of  human reviewers during abstract screening in systematic reviews. PLoS ONE, 15,  e0227742.  

Wong, D. (2009). The modifiable areal unit problem (MAUP). In A. S. Fotheringham &  P. A. Rogerson (Eds.), The SAGE handbook of spatial analysis (pp. 105-124).  Sage. 

CHAPTER 4  A NEW TEST OF THE LAW OF CRIME CONCENTRATION:  EXAMINING THE SPATIAL VARIABILITY OF ROBBERY WITHIN AND BETWEEN EIGHT U.S. CITIES13

13 Spencer, M. D., and C. Schnell. Submitted to Journal of Quantitative Criminology, 12/29/2021. 

Abstract 

Objective   The law of crime concentration suggests the spatial distribution of crime at micro-places  is consistent between cities. While previous research has assessed the law’s proposed  distributional bandwidth of incidents, we conduct a new test which systematically  examines the spatial variability of crime patterns within and between cities.   Data/Methods   This study observes robbery incidents reported to police departments across eight U.S.  cities from 2015-2019. Incidents are geocoded to census blocks which are hierarchically  nested within census tracts and cities. We calculate the spatial variability attributed to  blocks and tracts using variance partitioning with multi-level negative binomial models  and compare estimates between cities.   Results   Our findings support the law of crime concentration by observing minimal spatial  variability between cities. Census blocks accounted for around 72-92% of the total spatial  variability and census tracts just 8-28%. These variability estimates suggest city’s do not  have a large effect on shaping the spatial distribution of crime patterns. Conclusions   Despite the disparate physical and social characteristics of cities, the spatial distribution  of crime is remarkably similar between most locations. Micro-places account for the  largest amount of spatial variability. Future research should continue to explore the  broader contexts in which these locations are found to have the most complete  understanding of the relationship between crime and place.

Introduction 

The history of crime and place research is generally characterized by a transition  in focus from large to small spatial units of analysis (Weisburd et al., 2009). The earliest  research examined spatial units such as countries and cities before shifting to  neighborhoods and micro-places over long periods of time (Park & Burgess, 1925;  Quetlet, 1831; Weisburd et al., 2012). Contemporary research on micro-places has  garnered attention due to the disproportionate concentration of crime found at a small  number of these hot spot locations (e.g., Sherman et al., 1989). Examples of micro-level  units of analysis are street segments, street blocks, and other places found within  neighborhoods (Eck & Weisburd, 1995). More recent studies have indicated micro-places  provide a larger contribution to the overall spatial variability of crime patterns compared  to neighborhoods (Steenbeek & Weisburd, 2016). These studies used a hierarchical  framework which examined crime across at least two nested spatial units to understand  how crime varies at different spatial scales within cities (see Hipp et al., 2020; Hipp &  Williams, 2021; O’Brien, 2019; O’Brien & Winship, 2017; Quick, 2019; Schnell et al.,  2017). These studies suggest researchers continue to scale-down from macro- or meso-  units to understand more about where the “action” of crime occurs which is between  micro-places in cities (see Steenbeek and Weisburd, 2016).  

Weisburd (2015) proposed the law of crime concentration after observing  remarkable consistency between cities regarding the distribution of crime at microplaces. Despite the wide range of differences in the social and physical characteristics of  cities, the distribution of crime between micro-places is almost identical. Between 4-6%  of micro-places in large cities and 2-4% in small cities account for 50% of crime 

incidents. These findings suggest there is little influence of cities upon the distribution of  crime at micro-places. In other words, there is not much difference between Charlotte,  NC, and Cleveland, OH in where crimes occur or the spatial relationship between which  locations have crime within these cities. Much research on micro-places is often bounded  to observations of crime data from a single city (see Weisburd et al., 2012). There are  only a few examples of research focused on micro-places which expands the spatial  scope beyond a single city to consider differences between cities (see Hipp & Kim, 2017;  Hipp & Williams, 2021). Most tests of the law of crime concentration only explore the  distribution from a new, unstudied city (e.g., Gill et al., 2017) or examine measurements  across varying temporal periods (e.g., Haberman et al., 2017). In addition, these studies  do not provide a rigorous examination of the spatial distribution of crime incidents  instead focusing on the statistical distribution or a bandwidth to summarize the  distribution.     Our study provides a new test of the law of crime concentration which reexamines  the proposal that the spatial distribution of crime is consistent between cities. Our  analytic framework builds upon previous hierarchical studies to examine the spatial  variability of crime within and between cities. We present a systematic sampling strategy  to identify eight cities for the comparison of robbery patterns. Together, we use the  hierarchical nesting of micro-places within neighborhoods and spatial weights to offer a  more robust spatial consideration of the law of crime concentration. Previous tests of the  law of crime concentration imply the role of cities in shaping the spatial distribution is  minimal but these analyses do not provide a direct test of this proposition. This study  directly addresses the question: do cities provides a unique contribution to understanding 

the spatial variability of crime? If there is some spatial variability accounted for by cities,  this would suggest continued inquiry into the explanations for this variability. What about  cities helps shape their unique spatial distribution of crime patterns? This would also lead  to further reconsideration of place-based crime preventions strategies which are more  tailored to the characteristics of specific cities instead of more generalized approaches.  The next section provides a more detailed literature review before we discuss the research  methodology for this study.  

Examining Crime Variability Across Multiple Spatial Units 

Crime and place research has increasingly investigated spatial variability across  multiple place-based units of analysis within cities (Deryol & Payne, 2021; Duru & Kim,  2021; Lee et al., 2017; Umar et al., 2021). This is important because the modifiable aerial  unit problem (MAUP) is a key consideration for any spatial analysis. The MAUP forces  researchers to consider the benefits and costs to prioritizing any single spatial unit of  analysis over the wide range of alternatives (Openshaw, 1984). Examining multiple  spatial levels is important because meso- and macro-units can provide important context  to localized processes (Baumer et al., 2012; Hipp & Williams, 2021; Jones & Pridemore,  2019; Lyons et al., 2013). This research has consistently found that most of the spatial  variability of crime occurs at the micro-level. However, the influence that meso- and  macro- level units have on crime variability is still noteworthy. By studying  neighborhoods researchers could miss out on micro-variability within these units or by  studying micro-places researchers ignore the higher-order clustering of patterns within  neighborhoods. Andresen (2011) explored local crime clusters across census tracts and  dissemination areas which are equivalent to census blocks in Vancouver, Canada. A local 

analysis of spatial autocorrelation conducted on aggregated counts of crime incidents at  both units revealed similar measures of variance. However, the observed differences  between the levels are an important feature of the unit choice. If only a single spatial unit  had been analyzed, the conclusions drawn would have disregarded hidden spatial  heterogeneity at different spatial levels.  

Two recent studies helped create a template for hierarchical frameworks to  analyze spatial variability of crime between different units of analysis. Steenbeek and  Weisburd (2016) estimated linear mixed models on crime incident data nested across  street segments (i.e., micro), neighborhoods (i.e., meso), and districts (i.e., macro) in The  Hague, Netherlands. These analyses permitted the calculation of easily interpretable  variance partition components (VPC) which assign a unique contribution of the total  spatial variability to each spatial unit of analysis. A temporal component was also  included as a fixed effect nested within micro-places providing the first hierarchical level.  To calculate the variance attributed to each spatial unit, the variance depended on time, as  it was allowed to vary randomly per spatial level. Supporting prior research, the authors  found the most total variability occurring at the micro-level with approximately 58-69%  attributed to street segments depending on the year. The remaining 31-42% of variability  was attributed across both meso- and macro- units of analysis. This study was replicated  using Chicago robbery data whereas Schnell et al. (2017) similarly observed a range of  56-65% attributed to street segments. Notable, is the large share of variability attributed  to the neighborhood was found at macro- instead of meso- units (districts and community  areas, respectively).  

Linear mixed models are not the only method of analysis used in recent studies.  O’Brien (2019) relied on Gini coefficients by calculating a global and nested  distributional coefficient. For example, the nested coefficients were calculated per unit  and then used to evaluate concentrations at the lower unit. When fewer events occurred  relative to the number of units, a generalized Gini coefficient was calculated (see  Bernasco & Steenbeek, 2017). Using these methods, O’Brien (2019) observed  concentrations of crime were highest at street segments and lowest at census tracts. In a  different study, logistic regression models were used by Hipp et al. (2020) to compare the  relative robbery risk across three spatial scales and a temporal scale. Results from their  full model indicated that, like prior research, street segments (micro-level) contribute the  greatest measure of unique variance when compared to other spatial levels. However,  when the variance estimates for the meso- and macro-level measures are combined, the  proportion of explained variance is comparable to the micro-level measures which  highlights the importance of larger spatial scales. Another recent study incorporated a  Bayesian modeling technique that also observed the largest variance attributed to the  smallest unit of analysis included within the multilevel models (Quick, 2019). In his  study, cross-classified Bayesian multilevel models were calculated for lower and higherlevel units that were non-nesting at the higher-level. When combined, the three higherlevel units analyzed explained 15% of the total variation of violent crime with  neighborhoods accounting for the majority of the variance.  

The law of crime concentration is constructed around Weisburd’s (2015)  observations on the distribution of crime across eight cities. The law was influenced by  Sherman and colleagues (1989) seminal findings on crime spots in Minneapolis and the 

Pareto Principle or the 80/20 rule from outside of criminology (Pareto, 1909). These  cities were located across most regions of the United States, and one was in Israel with  populations from around 70,000 (i.e., Redlands, CA) to over 8,000,000 residents (i.e.,  New York, NY). In turn, these cities had disparate social and physical characteristics. For  example, the poverty rate in Cincinnati, OH was more than two times higher than in  Seattle, WA and Tel-Aviv, Israel has 4.2% Black residents while Brooklyn Park, MN has  24.0%. The physical characteristics differed regarding the square milage of the cities and  length of street segments. In addition, the number of crime incidents and crime rates  varied drastically between cities. Despite these differences, across all cities 2-6% of street  segments accounted for 50% of crime incidents. The bandwidths are even closer when  separating between small (i.e., 2-4%) and large (i.e., 4-6) cities. While research has  supported the law of crime concentration (see Eck et al., 2017; Gill et al., 2017;  Haberman et al., 2017), other researchers have advocated for more standardized measures  of crime concentration such as Gini coefficients or Lorenz curves (see Bernasco &  Steenbeek, 2017). These measurements of spatial concentration only tell a small part of  the story of where crime occurs within cities. These are measurements of statistical  distributions and do not account of the spatial relationship or the actual location where  these incidents are found within cities.  

Previous scholarship has argued for the importance of understanding local  processes while recognizing the broader geographic context they are found within. One  of the lasting impacts of the Chicago School was the focus on cities as a critical spatial  unit of analysis and seeking to understand the organization of places within cities (Park &  Burgess, 1925). Cities often provide the overarching boundary for most research on 

neighborhoods and micro-places. However, city-wide characteristics are often ignored, or  studies are just conducted in a few cities in the United States (e.g., Chicago). These  characteristics could matter for several reasons. The role of city-specific characteristics is  potentially influential because these units of analysis can inherently shape everything  found within them (see Kim & Hipp, 2018). Specifically, political differences and  histories between cities have influenced drastically different policies, police practices,  urban layouts, and demographic distributions that could consequently influence crime  patterns in different ways (Hipp & Williams, 2021). Through this downward influence,  city-wide characteristics could affect processes at smaller geographic levels, providing  for unique differences between cities regarding the spatial distribution of crime. This  questions the generalizability of results which might not expand beyond the boundary of  the city examined.

Cities are salient ecological spaces that vary widely and assuming crime is  spatially distributed with comparable patterns between them could be problematic. It is  possible that differences do exist and estimates of crime variability per units of analysis  are not similar for all cities. To the authors’ knowledge, we present the first study to  systematically select cities and standardized crime variability measures for comparisons  at multiple levels within cities. We provide further investigation of the finding that microplaces account for the most spatial variability and continue to unpack the role of cities in  the accounting for differences in the spatial distribution of crime patterns.  

Data And Methods Present Study 

This study uses techniques for partitioning multi-level variance to examine the  spatial variability of robbery incidents at multiple spatial levels within and between eight  U.S. cities. This analytic framework expands upon recent studies which have conducted  variance partitioning for within city analyses (see Steenbeek & Weisburd, 2016). Our  research design is informed by the methodology of systematic reviews and meta-analyses  which provide a transparent search process and comparison of results between studies  (e.g., Braga & Weisburd, 2020). Robbery incidents are analyzed at both micro-places and  neighborhoods within cities. The standardization of results allows for the comparison  between each city of estimates. Therefore, the range between estimates from each  location can be attributed to between city variation (see Weisburd, 2015). Crime maps  and descriptive statistics are used to supplement these findings to provide further  understanding of the unique contribution of cities to the spatial distribution of crime  incidents. Multi-level negative binomial models are estimated to determine the variability  attributed to the micro- and meso- spatial units within each city. The overarching goal of  this study is providing a test of the proposition of the law of crime concentration that the  spatial distribution of incidents does not vary between cities.   Units of Analysis 

Three spatial units of analysis are observed: census blocks (i.e., micro), census  tracts (i.e., meso), and city boundaries (i.e., macro). The use of census geographic  boundaries is commonplace among crime and place research (see Weisburd et al., 2012  for discussion). These units of analysis were selected because they are already by-design 

nested. Census blocks are generally representative of street blocks which grounds these  units within the street grid which is common for representations of micro-places (Eck &  Weisburd, 1995; Grannis, 1998). These units are designed to be nested within census  tracts which are often used as proxies for neighborhoods. Both units are also standardized  across distinct cities in the U.S. which helps facilitate between city comparisons (see  Peterson & Krivo, 2010). These micro- and meso- units have been extensively explored  throughout the last fifty years (Lee et al., 2017; Walker & Drawve, 2018).14 A base map  for each spatial level per city was created by obtaining the appropriate boundary data  from the tidycensus and tigris packages in R provided by the U.S. Census Bureau. 

This study uses a systematic approach to identify a sample of cities to analyze.  This provides a contrast to Weisburd’s (2015) analysis which created a convenience  sample for his proposal of the law of crime concentration. The increased availability of  public data provides various options of cities which could be considered for inclusion in  our analysis. The construction of our sample was guided by several criteria. First, the  sample was restricted to U.S. cities with populations greater than 100,000 residents (U.S.  Census Bureau, 2019). While Weisburd (2015) does examine two cities with populations 

14 Census blocks are used instead of street segments which are one of the most examined measures of  micro-places today for two main reasons. First, the creation of accurate street segment maps for multiple  cities is not feasible due to time constraints. The process of accessing streets shapefiles for cities is not  difficult but the transformation of these streets’ files into accurate street segment files is challenging. While  the process is straightforward, the manner of cleaning a street segment shapefile for any abnormalities  resulting from the over-estimation of the number of street segments is labor intensive (see Schnell et al.,  2017, footnote 6). Second, there are advantages to the use of census blocks because they permit more  accuracy for the geocoding process which was a key consideration to minimize any errors during this  process across these different cities. These polygon features enhance the accuracy to which crimes can be  geocoded because all crimes captured within the polygon will be included rather than attributing crimes to  the nearest street segment when there is ambiguity. There is also the issue of crimes geocoded to  intersections or major roadways. Often, these crimes cannot be directly attributed to a street segment and  must manually be placed by the researcher or removed from analysis. Using census blocks minimizes this concern since polygon features are much larger than the average street segment, thus, it is easier capturing  all crimes falling within the polygon.  

under 100,000, we decided to restrict our eligibility. Larger cities have more crime  incidents which minimizes concerns about statistical power and provides more potential  crime incidents to study which helps the observation of variance. Second, only cities that  provided all crime incidents reported to the police publicly through an online portal were  considered (see footnote).15 Several pre-existing sources were referenced to determine  which cities had public data and a hand-search of each of the remaining cities was  conducted.16

Third, the available crime incident report data had to span five years. The use of  multiple years helps minimizes the influence of any potential outlier years. We selected  from 2015-2019 which covers the last five full years before the COVID-19 pandemic  (i.e., March 2020). Fourth, the crime incident data had to include XY coordinates to  minimize geocoding concerns across these disparate jurisdictions. Using these selection  criteria, 15 eligible locations were identified, and eight cities were randomly selected.  The inclusion of each additional city is labor intensive, and we decided mirroring the  number included by Weisburd (2015) was appropriate for this test. The selected cities  include Atlanta, GA, Austin, TX, Cincinnati, OH, Denver, CO, Gainesville, FL, Los  Angeles, CA, Orlando, FL, and Philadelphia, PA. The crime data were then downloaded  via each city’s open data portal. Table 4.1 shows the characteristics of each city regarding 

15 Atlanta (https://www.atlantapd.org/i-want-to/crime-data-downloads); Austin  (https://data.austintexas.gov); Cincinnati (https://data.cincinnati-oh.gov); Denver  (https://www.denvergov.org/opendata); Gainesville (https://data.cityofgainesville.org); Los Angeles  (https://data.lacity.org); Orlando (https://data.cityoforlando.net); Philadelphia  (https://www.opendataphilly.org)

16 Using keywords, “open portal”, and “crime data”, sources identified were  https://www.policedatainitiative.org and https://www.data.gov. Other research on this topic provided a  helpful tool for the recollection of which cities had public data. For example, Schnell et al. (2017) used data  from Chicago’s data portal. Larger cities are commonly more adept at making their crime data open and  accessible to the public. Searching all cities over 100,000 in population for appropriate data proved too  time consuming to do strictly by hand.  

population estimates, spatial units, and the size of each city. The sample represents a  geographically diverse collection of cities with much variation in population and the  overall size of the city. To illustrate the nesting of each spatial unit, Figure 4.1 contains  maps of Austin and Denver.  

Table 4.1 City characteristics    (a) 2019 

(b) N spatial units  (c) City  Area 

Population  estimates 

    Blocks  Tracts  mi2 Atlanta, GA  506,811  6,735  139  136.74  Austin, TX  978,908  10,732  213  326.51  Cincinnati, OH  303,940  4,606  114  79.42  Denver, CO  727,211  11,011  144  154.93  Gainesville, FL  133,997  2,494  41  64.22  Los Angeles, CA  3,979,576  30,565  1,001  478.17  Orlando, FL  287,442  4,768  75  118.82  Philadelphia, PA  1,584,064  18,872  384  142.58 

Crime Incidents 

Due to the unique reporting procedures of each city’s police departments, there  were substantial differences when comparing crime data. For example, incident reports of  domestic violence, sexual battery, and sexual assault among other crimes were excluded  from the public data in Orlando. Only UCR Part I crimes were accessible from Atlanta.  Most of the cities followed NIBRS-based reporting procedures while others followed  UCR procedures. Nevertheless, across all cities the reporting of robbery incidents was  consistent. Due to this uniformity, our study focuses exclusively on the spatial  distribution of robbery incidents.

71

Figure 4.1 Spatial units used in the study for Austin (left) and Denver (right): blocks (thin solid lines) nested in tracts (dashed borders)  nested in the city (solid thick border) 

Robbery incidents have high-reporting rates relative to other crimes and these  violence crimes occur often enough to provide enough incidents for observation  (Andresen & Linning, 2012). In addition, there is a large collection of studies on crime  and place which examine robbery and provide helpful reference points for this research  (Bernasco & Block, 2011; Block & Block, 1995; Braga et al., 2011; Hipp et al., 2020).  Table 4.2 provides an overview of the total robbery counts over the observation period  and geocoding results for each city. Each city meets standard acceptable thresholds for  geocoding rates (see Andresen et al., 2020). To create count variables of robbery  incidents for each city, robbery incidents were spatially joined to census blocks. The  number of robbery incidents per census tract were aggregated from the number of census  blocks within those units.  

Table 4.2 Robbery characteristics by city, 2015-2019    (a) Reported 

(b) Total  Robbery  Incidents After  Geocoding 

(c) Geocoding  Rates 

Robbery Incidents 

Atlanta  8,440  8,433  99%  Austin  2,587  2,587  100%  Cincinnati  3,582  3,539  99%  Denver  7,170  7,141  96%  Gainesville  891  884  99%  Los Angeles  50,735  50,446  99%  Orlando  2,897  2,795  96%  Philadelphia  34,128  33,887  99% 

Analytic Strategy 

This study involves two stages of analysis. The first stage involved calculating  descriptive summary statistics of crime concentration at each spatial level per city using  the threshold of 50% as discussed by Weisburd’s (2015) law of crime concentration. 

Additionally, Lorenz curves and Gini coefficients are used to provide more  comprehensive representations (Gini, 1912; Lorenz, 1905). The use of these descriptive  measures is commonplace when examining spatial concentration of crime (Bernasco &  Steenbeek, 2017; Hipp & Kim, 2017; Mohler et al., 2017). However, these measures only  provide helpful contrasts between spatial units and do not provide any indication of the  direct, nested spatial variability between units. For a more illustrative presentation of  crime concentration, choropleth maps are used to show the spatial concentration of  robbery.     In the second stage of analysis, we conducted variance partitioning to determine  the unique contribution of the micro- and meso- units of analysis to the spatial variability  of robbery patterns. Afterwards, we compare these results between cities. We initially  considered the use of a linear mixed model to calculate city-level estimates of spatial  variability. To build upon these hierarchical analyses (see Steenbeek & Weisburd, 2016),  the original plan for this research was to generally replicate their models using a fixed  effect to estimate longitudinal time trends at level-1 of the four-level model. The  remaining levels of the model, in order, were the census blocks (level-2), census tracts  (level-3), and cities (level-4). However, before any analyses were conducted the low  number of level 4 groups (i.e., eight cities) were anticipated to present statistical  challenges leading to low confidence in any findings and likely convergence issues (see  Hox, 1998; Nezlek & Gelman, 2006; Richter, 2006). As anticipated during our  preliminary analyses, the original model used in this study was not appropriate. Different  iterations of the model would not fully converge and using multiple optimizers from the 

R package Lmer were tested to no avail.17 Other methods such as using a generalizedlinear model also had convergence issues. To continue addressing the potential  differences between cities, it was decided to separate each model per city and aggregate  all crime incidents across time to improve crime counts per unit. 

The calculation of variance partition coefficients for multi-level models with  count data is guided by Leckie et al.’s (2019) discussion (also see Austin et al., 2017;  Goldstein et al., 2002). Calculating the variance partitioned coefficients (VPC) allows for  the proportion of the response variance (i.e., robbery incidents), to be estimated. Thus,  the VPC identifies the importance clusters have on the response. In our case, the  importance of census blocks, and tracts beyond the modelled outcomes. Calculating the  VPC for multilevel count models is less straightforward. However, Leckie et al. (2019)  have outlined such a method building upon Austin et al. (2017) who used simulation  testing for VPCs of Poisson models. Leckie et al. (2019) have extended the equations to  also fit negative binomial models as many count models, particularly, multilevel models  are characterized by overdispersion. This study utilized a technique for our primary  analysis that directly replicated the VPC mathematics from Leckie et al. (2019). These  formulae were used because they are relatively straightforward and provided easy to  understand estimates that can be used to compare between cities. The entire process of  data collection, cleaning, and modeling was the same for each city in this study.  

To begin, for each city, a two-level Poisson model was fitted with the total  robbery incidents from 2015-2019 as the response variable. Counts of robbery were  calculated at each level of the model with census blocks as the level-1 explanatory 

17 These included ‘nlminb’, ‘Nelder_Mead’, ‘bobyqa’, and ‘L-BFGS-B’. 

variable and census tracts as the level-2 variable. Let ��� denote the robbery incident  count for block i in tract j. To account for potential overdispersion, two-level negative  binomial models were also fitted and compared to the Poisson model. The negative  binomial model can be written as: 

���|��� ∼ ������������ ������� = �� + �� + ��� �� ∼ ��0,����

1 �

, �� where ��� denotes the overdispersion random effect. The overdispersion random effect is  exponentiated and assumed to have a gamma distribution with scale parameters for �.  The larger the value for �, the greater overdispersion that is present compared to the  Poisson model. Preference for the Poisson model is given when � = 0. To simplify the  included mathematical notation only the equation for the VPC is provided. For the  conditional and marginal statistical equations refer to Leckie et al. (2019). The following  VPC equation allows for level-specific components and captures within- and betweencluster variance in ���. The VPC equation used can be written as: 

�������� ∼ ������

�������{�������� − 1} �������{�������� − 1} + ���� + ���������������� where the numerator and likewise equation in the denominator is a measure of the level-2  variance. The other share of the denominator is a measure of the level-1 variance. To  account for overdispersion, the VPC is now a decreasing function of � such that as  overdispersion increases there is more unmodelled variation at level-1, thus the VPC  decreases. While � alone does not indicate true significance for preference over the 

����� =

Poisson model, the VPC estimates in conjunction allow for a better comparison.  Particularly, when aided by prior research and theory.  

We first examine constant-only models. As a comparison model, we included an  independent variable which provides a spatial weight for the level of robbery in  surrounding areas of both census blocks and tracts. Spatial weights using a queenscontiguity matrix were created for census blocks and tracts using the counts of neighbors’  robberies per unit. The motivation for creating the weights in this manner was that for  spatial units that have more neighbors, if those neighbors have high robbery counts, there  is likely a spatial relationship due to proximity influencing localized crime rates. While  hierarchical studies build upon other descriptive analyses from crime and place research,  they are not explicitly spatial. The designation of hierarchical nesting implies a spatial  relationship of level-1 units within level-2 units since they are treated as connected. This  approach does not account for the influence of the immediate surrounding areas to both  census blocks and tracts which is much more aligned with the measurement of the  concept of spatial interdependence (Bernasco & Elfers, 2010). Combined with the  hierarchical nesting a spatial weight variable provides a more realized representation of  spatial relationships.  

Due to the focus on examining the descriptive spatial variability of robbery across  different levels of geography, no other covariates were not added to the models. The  interest of this study is not to explain the variability of robbery by time-constant or timevarying predictors but providing a baseline representation of variability (see Steenbeek &  Weisburd, 2016). These descriptive representations are helpful to inform research about  the levels of aggregation to explore for the explanation of patterns. These are cross-

sectional models which do not examine the impact of time. Again, this decision was to  simplify model estimates and provide adequate variance at level-1 for larger cities such  as Los Angeles which has over 30,000 blocks. All statistical analyses were conducted  using the R statistical programming language. Packages such as Lme4 and glmmTMB  were used to estimate the multi-level models. As no package exists to succinctly calculate  the VPC, the equation was programmed and calculated for each city (see Leckie et al.,  2019). 

Results  Descriptive Statistics 

Table 4.3 presents the summary descriptive statistics for the distribution of  robbery across cities. Between cities there is a wide range of the total number of census  blocks which experienced a robbery during the observation period (see column a). Austin  had only 8.6% of the blocks with a robbery while Philadelphia had 52.1%. Most census  tracts experienced a robbery with 6 of 8 cities reporting over 90% of the locations had a  robbery. There was noteworthy concentration of robbery incidents at a small number of  blocks with 7 of 8 cities having 5% or fewer of locations account for 50% of incidents  (see column b). The distribution is less concentrated when considering the raw number of  locations which did experience a robbery incident (see column c). These estimates in  column (c) present a more conservative calculation of concentration (see Levin et al.  2017). The block figures are much more comparable to each other and census tracts with  this adjustment to the denominator for calculations. These statistics provide support to the  law of crime concentration by noting a relatively consistent concentration of robbery  across all cities. Conversely, these findings indicate important differences in the number 

of locations which experience crime events. Most micro-places in cities do not  experience crime incidents (i.e., datasets are zero-inflated). The number which do, appear  influenced by the total number of crimes and the physical layout of the location which  determines the total number of micro-units. While there is much consistency between  cities the location of Philadelphia appears an outlier with more locations having robberies  although the concentration of incidents appears comparable when accounting for the  number of locations with incidents.  

Next, we explore the spatial distribution of robbery across the two units of  analysis within cities between 2015-2019. Figure 4.2 compares the distribution of  robbery clusters between Atlanta and Gainesville using choropleth maps.18 Between both  cities census tracts, robbery is concentrated towards the center of each city rather than the  municipal edges. Atlanta has areas of higher concentration in southernmost tracts  compared to northernmost tracts. For both cities the areas of high robbery concentration  by census block appear dispersed and less uniform. Across both cities, clusters of high  robbery blocks are present in multiple areas. Due to the large number of the micro-units  of analysis for each city, viewing concentration at the block-level is difficult. To further  illustrate the concentration of robbery at the census block, Figure 4.3 displays a more  precise view of these spatial units within southeast Atlanta. This figure illustrates that  robbery is heavily concentrated in this section of the city. For this area, blocks with high  levels of robbery are directly adjacent to blocks with little to no robbery. This map further 

18 The Fisher-Jenks method was utilized for the maps presented in Figure 2. This method is an iterative  optimization often used to display “natural breaks” of geographic data (Fisher, 1958).  

confirms that areas can be relatively safe and robbery-free while being located next to  more robbery-prone areas (see Weisburd et al. 2012).  

Table 4.3 Percent of spatial units accounting for 50% of robbery for all cities, 20152019 

(c) Percentage of  spatial units with  robbery that account  for 50% of all  robbery    Blocks  Tracts  Blocks  Tracts  Blocks  Tracts  Atlanta  36.1  93.5  5.5  23.0  15.3  24.6  Austin  8.6  75.1  1.2  9.9  14.4  13.1  Cincinnati  25.0  93.9  4.2  18.4  16.9  19.6  Denver  21.2  100.0  3.1  19.4  14.5  19.4  Gainesville  12.9  75.6  2.7  14.6  20.9  19.4  Los Angeles  30.1  98.7  3.3  15.1  10.9  15.3  Orlando  15.8  90.7  2.2  10.7  14.2  11.8  Philadelphia  52.1  99.5  9.7  24.2  18.6  24.3 

(a) Percentage of  spatial units that  have any robbery 

(b) Percentage of  spatial units  accounting for 50%  of robbery 

The Lorenz curves in Figure 4.4 illustrate the robbery concentration per unit in  each of the eight cities. For all cities, robbery was most concentrated at the block-level.  To aid interpretation of robbery concentration, Table 4.4 contains the Gini coefficients by  unit for each city. The generalized Gini coefficients are also shown in columns (c) and (d)  of Table 4.4 (see Bernasco & Steenbeek, 2017). Generalized Gini coefficients are a  method for capturing a more accurate level of crime concentration as in many cases  places outnumber observed crime. In cases this imbalance occurs, biased estimates are  can impact interpretations of the distribution of incidents. Presently, the Gini coefficients 

using both methods did not differ for tract-level estimates because almost all locations  experienced robberies. The coefficients using the standard Gini range from 0.714-0.955.  As expected, small differences do exist among the block-level estimates because for 5 of  8 cities the number of blocks analyzed exceeds the number of robbery incidents observed.  In each case, the Gini coefficient decreased using the generalized method (ranging from  0.714-0.877). The differences range from 0.07-0.237 with Gainesville having the largest  reduction. This is an expected result as Gainesville had the fewest incidents of robbery 

(884) compared to blocks (2,494), an almost three-fold increase of units compared to  crime. No difference was observed for Atlanta, Los Angeles, or Philadelphia as each city  had more robbery incidents than blocks.  

Table 4.4 Gini coefficients by unit of robbery, 2015-2019    Gini Coefficients  Generalized Gini 

Coefficients    (a) Block-level 

(b) Tractlevel  coefficients 

(c) Block-level  coefficients 

(d) Tractlevel  coefficients 

coefficients 

Atlanta  0.819  0.443  0.819  0.443  Austin  0.955  0.695  0.718  0.695  Cincinnati  0.866  0.512  0.796  0.512  Denver  0.890  0.470  0.800  0.470  Gainesville  0.922  0.617  0.716  0.617  Los Angeles  0.877  0.542  0.877  0.542  Orlando  0.923  0.634  0.845  0.634  Philadelphia  0.714  0.425  0.714  0.425 

81 

Figure 4.2 Choropleth maps of robbery counts per units (blocks on left; tracts on right) for Atlanta and Gainesville.  

82 

Figure 4.3 Choropleth map of robbery counts per block for SE Atlanta

Figure 4.4 Lorenz curves for each city of robbery per unit from 2015-2019. 

The Gini coefficients for tracts among all cities range from 0.425-0.695. Like  Schnell et al. (2017) and Steenbeek and Weisburd (2016) the coefficients for micro-units  did not fall below 0.7. One noteworthy difference, the coefficients for 4 of the 8 cities are  substantially higher than those observed in prior research for comparable units. For  example, the tract-level coefficient for Austin (0.695) almost rises to levels of  concentration observed at the micro-place. Other cities though have estimates in-line with  prior research (< 0.5) for meso-level units. Nonetheless, it is notable there is a degree of  difference for robbery concentration between all cities across these units.   Variance Estimates 

We first estimated multi-level Poisson models with robbery aggregated to the  census blocks nested within census tracts for each city (see Leckie et al., 2019). Due to  the anticipated overdispersion of robbery counts we estimated multi-level negative  binomial models to account for this distributional feature of the data. The � values for the  negative binomial models were � > 0, which paired with other model fit tests indicated  the presence of overdispersion in the Poisson models. Table 4.5 reports the negative  binomial estimates for each city across 2015-2019. Of particular interest are the Level-2  and Level-1 VPC marginal estimates.  

To facilitate interpretation, the VPC for each city for all three models were  transformed into percent estimates. These estimates are presented in Table 4.6 and  represent the proportion of robbery attributed to each unit compared to the total variance  of robbery. The Model 1 estimates differ greatly compared to the other two models due to  this overdispersion and attributing greater variability to the census tracts. Using the  estimates from Model 2 and Model 3, across all cities, a clear pattern of robbery 

variability emerges. Like levels of concentration, robbery incidents vary the most at the  census block-level. Across all cities, the variability of robbery ranges from 71.8% -92.2%  using Model 2. A smaller proportion of robbery varies at the tract-level, with a range of  7.8% -28.2% for Model 2. These ranges for both units across all cities are comparable to  the estimates from Model 3 which included spatial weights. In addition, separate negative  binomial models for each city were calculated by year which are available upon request.  These estimates attribute more variability to blocks with approximately 83% -99% of  total spatial variability and tracts 2% -16% of variability. No single year per city  presented an outlier instead estimates for each city were relatively stable.  

The VPCs expand upon the results of our descriptive analyses in demonstrating  the importance of micro-units (Weisburd, 2015). The results also highlight the continued  importance of higher-order spatial units such as the census tract when estimating  proportions of robbery variability. Like other research that has explored spatial  variability, our work further supports findings of nested crime variability with microunits accounting for most of the total variability, with neighborhoods accounting for a  small but essential share of the variability (Quick, 2019; Schnell et al., 2017; Steenbeek  & Weisburd, 2016). Our results are the first to systematically examine between-city  differences of the spatial variability of robbery. Differences of VPC estimates between  the cities exist but are quite modest. This is despite the vast differences between the cities  such as geographic size, number of robbery incidents, and the number of spatial units. 

Table 4.5 Negative binominal estimates for variance components fitted to the 2015-2019 robbery data for all cities    Atlanta  Austin  Cincinnati  Denver  Gainesville  Los 

Orlando  Philadelphia 

Angeles 

86 

Parameter Estimates  β0 - Intercept  -0.096  -2.459  -0.701  -0.852  -1.677  0.036  -1.122  0.206  σu2 - Tract  variance 

0.787  2.346  1.211  0.847  1.121  2.047  1.175  0.782 

2.915  7.199  2.974  4.172  6.971  3.992  6.258  1.127  Marginal Estimates 

α -  Overdispersion 

Marginal  Expectation 

1.346  0.276  0.909  0.651  0.328  2.047  0.586  1.816 

Marginal  Variance 

15.118  6.739  11.117  5.350  2.844  79.498  8.304  13.844

Level-2  Component 

2.169  0.721  1.950  0.566  0.222  12.163  0.768  3.908 

Level-1  Component 

12.950  6.018  9.167  4.784  2.622  67.335  7.536  9.936 

Level-2 VPC  0.143  0.107  0.175  0.106  0.078  0.153  0.092  0.282  Level-1 VPC  0.857  0.893  0.825  0.894  0.922  0.847  0.908  0.718 

Fit Statistics  Deviance  17529  8485  8564  18121  2785  75473  6588  59194 

Table 4.6 Variance proportions for each city across each model    Model 1: Poisson   Model 2: Negative 

Model 3: Negative  Binomial w/ spatial  Weights 

Binomial  

Level-2  VPC  Atlanta  11.0%  89.0%  85.7%  14.3%  84.7%  15.3%  Austin  19.0%  81.0%  89.4%  10.6%  86.2%  13.8%  Cincinnati  27.2%  72.8%  82.5%  17.5%  80.0%  20.0%  Denver  48.2%  51.8%  89.4%  10.6%  89.0%  11.0%  Gainesville  41.5%  58.5%  92.2%  7.8%  91.0%  9.0%  Los Angeles  11.0%  89.0%  84.7%  15.3%  83.6%  16.4%  Orlando  32.7%  67.3%  90.8%  9.2%  89.3%  10.7%  Philadelphia  30.5%  69.5%  71.8%  28.2%  70.9%  29.1% 

  Level-1  VPC 

Level-2  VPC 

Level-1  VPC 

Level-2  VPC 

Level-1  VPC 

For all cities, the Model 3 estimates were marginally preferred to the Model 2  estimates based on goodness of fit statistics. Additionally, the variance estimates for each  spatial unit within each city were almost identical between the two methods. However,  concerning marginal estimates and β0 values made for complicated interpretation.  Because of the interpretation issues, the marginal difference between Model 2 and 3  VPCs, and preference for parsimony Model 2 was identified as the superior fit for this  study.  

Conclusion 

This study conducts a new test of the law of crime concentration and our findings  provide continued support for the key components of this law. Our findings reaffirm the  importance of micro-places for examining the spatial distribution of crime within cities.  Robbery incidents were concentrated at a small number of micro-places and the total  spatial variability accounted for by micro-places was substantial. Between 71.8% and  92.2% of the total spatial variability of robbery is accounted for by census blocks 

between the eight U.S. cities we examined. The remaining 7.8%-28.2% of the total  spatial variability is attributed to the census tracts. Our study provided unique insight on  the role of cities in understanding the spatial variability of crime patterns. In general,  cities played a modest role with the range of estimates at both micro-places and  neighborhoods varying around only 20%. Combined, these results provide the foundation  of a new distributional bandwidth which summarizes this variability. Across these eight  cities, an average of 85.8% is attributed to micro-places and 14.2% to neighborhoods  with the standard deviation capturing the potential city-level effect around 6.5%. These  findings reinforced the importance of understanding local processes as functions of larger  geographic spaces (Braga et al., 2011; Groff et al., 2010; Malleson et al., 2019; Sherman  & Weisburd, 1995). These findings support the key observation from the law of crime  concentration that despite varying social and physical characteristics of cities the spatial  distribution of crime incidents at micro-places is remarkably consistent. More so, our  systematic approach to examine city-to-city differences has found that despite the  discernable differences between two cities such as Los Angeles and Orlando, estimates of  the spatial variability of robbery between cities are similar.  

There are implications of this research for place-based theories, methodology, and  crime prevention. While our estimates of the city-level effect on the spatial variability of  robbery were small they still warrant further investigation. In addition, 7 of 8 cities  estimates were relatively comparable but Philadelphia’s estimates were more divergent.  Collectively, there is little theoretical understanding of the forces which could influence  differences in the spatial distribution of crime between cities. How is the opportunity  structure for crime both similar and different across these spaces (see Weisburd et al., 

2012)? The conceptualization of these potential differences is difficult to grasp. Based on  our assessment key considerations would include the number of locations which  experience crime, the degree of distributional concentration of these incidents, and extent  of variability across key spatial units of analysis. These differences could be the result of  more simple features such as a physical characteristics like a city’s expansion was limited  by the proximity to a body of water or mountain range. On the other hand, these  differences could be the result of more compelling behavioral differences (i.e., are  residents of city X more violent?) or political distinctions (i.e., this law in City Y impacts  residents in a tangible way).  

Our findings provide reinforcement for the continue adaptation of general placebased crime prevention strategies. Interventions such as problem-oriented policing or  crime prevention through environmental design (CPTED) strike the same balance of  being generally adaptable across a wide-range of places but also malleable enough to  account for unique characteristics of places which facilitate crime (Goldstein, 1979,  1990; Hinkle et al., 2020). Another example is hot spots policing strategies which have  been found to be effective at reduce crime by targeting the concentration of crime at a  small number of micro-places across very different cities (see Braga et al. 2020). Our  findings also suggest policy not move completely past the importance of higher-order  units such as tracts or those representing neighborhoods. For a few cities in our study,  tract-level variance was higher than expected. Much variability occurs at micro-places  but to unlock the next wave of crime reduction these larger units of analysis are critical to  understand.  

There were several limitations to this study. Due to the large number of options  for spatial units of analysis even within cities there is always subjectivity to the selection  of a unit of analysis to study. There are inherent concerns when micro-units (often street  segments) far exceed the number of crimes being analyzed (see Andresen & Linning,  2012; Bernasco & Steenbeek, 2017). While we address this issue for our measurement of  Gini coefficients the broader concern permeates all analyses on spatial variability. Due to  the large number of places when examining micro-places and rare crime events this could  influence the magnitude of which variability is observed between these units.  Furthermore, our findings are limited to variance estimates of robbery. Other crime types  were not examined which could influence our observed estimates of variance. The  number of cities observed is only a small fraction of the locations with populations which  exceed 100,000 residents. We attempted a systematic approach, but this cannot account  for the fact that while growing, the number of cities which provide public data is still  small.  

Our study compliments prior crime and place research while offering excellent  avenues for future research to build upon. The modest differences among the estimates of  robbery variability between the eight cities is surprising and an avenue for future  research. For example, there are massive differences between the cities in the population  and number of units of analysis. Despite the large range for these two characteristics  between the cities, variance estimates differed slightly. Future research should continue  to explore additional cities and explanations for this variance. Additionally, questions  arise as to whether “shifting” the units down from blocks to street segments and tracts to  block groups would observe similar estimates. Further, future research will need to 

incorporate different spatial weighting processes to better understand the proximal  influences within and between units. Replicating our approach, future research should  incorporate more variables such as different spatial lags and or city characteristics to the  models. Comparing estimates between units such as street segments versus blocks or  street segments within blocks are additional possibilities. Opportunities also exist to  incorporate models which can provide a more sophisticated treatment of these complex  spatial-temporal processes.  

Overall, estimates of the spatial variability of robbery within and between eight  U.S. cities are generally aligned with previous research on the spatial distribution of  crime at micro-places. Our study provided additional evidence to support the law of  crime concentration and a new framework to assess this seminal proposition. The effect  of cities was small but not negligible. In general, this component of the law of crime  concentration is striking to consider even years after its proposal. That despite the wide  range of differences for cities the actual spatial distribution of crime is similar. An  abundance of methods and techniques for selecting units of analysis exist making  traditional comparisons of these variance estimates difficult. This study systematically  analyzed robbery variability within and between eight U.S. cities. While micro-places  account for most of the total spatial variability, the contribution of larger spatial  aggregations is still critical to understanding where crime happens in place.  

References  Andresen, M. A. (2011). Estimating the probability of local crime clusters: The impact of 

immediate spatial neighbors. Journal of Criminal Justice, 39, 394-404. 

Andresen, M. A., & Linning, S. J. (2012). The (in)appropriateness of aggregating across  crime types. Applied Geography, 35, 275-282.  

Andresen, M. A., Malleson, N., Steenbeek, W., Townsley, M., & Vandeviver, C. (2020).  Minimum geocoding match rates: An international study of the impact of data and  areal unit sizes. International Journal of Geographical Information Science, 34,  1306-1322.  

Austin, P. C., Stryhn, H., Leckie, G., & Merlo, J. (2017). Measures of clustering and  heterogeneity in multilevel Poisson regression analyses of rates/count data.  Statistics in Medicine, 37, 572-589.  

Baumer, E. P., Wolff, K. T., & Arnio, A. N. (2012). A multicity neighborhood analysis of  foreclosure and crime. Social Science Quarterly, 93, 577-601.  

Bernasco, W., & Block, R. L. (2011). Robberies in Chicago: A block-level analysis of the  influence of crime generators, crime attractors, and offender anchor points.  Journal of Research in Crime and Delinquency, 48, 33-57.  

Bernasco, W., & Elffers, H. (2010). Statistical analysis of spatial crime data. In A. R.  Piquero & D. Weisburd (Eds.), Handbook of quantitative criminology (pp. 699724). Springer. 

Bernasco, W., & Steenbeek, W. (2017). More places than crimes: Implications for  evaluating the law of crime concentration at place. Journal of Quantitative  Criminology, 33, 451-467. 

Block, L. R., & Block, C. B. (1995). Space, place, and crime: Hot spot areas and hot  places of liquor-related crime. In J. Eck & D. Weisburd (Eds.), Crime and place:  Crime prevention studies, Vol. 4 (pp. 123-137). Criminal Justice Press.  

Braga, A. A., Hureau, D. M., & Papachristos, A. V. (2011). The relevance of micro  places to citywide robbery trends: A longitudinal analysis of robbery incidents at  street corners and blocks faces in Boston. Journal of Research in Crime and  Delinquency, 48, 7-32.  

Braga, A. A., & Weisburd, D. L. (2020). Does Hot Spots Policing Have Meaningful  Impacts on Crime? Findings from An Alternative Approach to Estimating Effect  Sizes from Place-Based Program Evaluations. Journal of Quantitative  Criminology, 1-22. 

Brantingham, P. J., & Brantingham, P. L. (1981). Environmental criminology. Sage.   Cohen, L. E., & Felson, M. (1979). Social change and crime rate trends: A routine 

activity approach. American Sociological Review, 44, 588-605.  Cornish, D. B., & Clarke, R. V. (1986). The reasoning criminal. Springer.  Deryol, R., & Payne, T. (2021). Environmental design and neighborhood context: A 

multi-level analysis of crime at apartments in Cincinnati neighborhoods. Crime &  Delinquency, 67, 1819-1855. 

Duru, H., & Kim, M. (2021). Testing a multilevel opportunity theory of crime (place in  neighborhood theory). Crime Prevention and Community Safety, 23, 319-340. 

Eck, J. E., Lee, Y., O., S., & Martinez, N. (2017). Compared to what? Estimating the  relative concentration of crime at places using systematic and other reviews.  Crime Science, 6, 1-17.  

Eck, J. E., & Weisburd, D. (1995). Crime places in crime theory. In J. E. Eck & D.  Weisburd (Eds.), Crime and place. Crime prevention studies, vol. 24 (pp. 1-33).  Willow Tress Press. 

Fisher, W. D. (1958). On grouping for maximum homogeneity. Journal of American  Statistical Association, 53, 789-798.  

Gill, C., Wooditch, A., & Weisburd, D. (2017). Testing the “law of concentration at  place” in suburban settings: Implications for research and practice. Journal of  Quantitative Criminology, 33, 519-545. 

Gini, C. (1912). Variabilità e mutabilità. vamu.  Goldstein, H. (1979). Improving policing: A problem-oriented approach. Crime and 

Delinquency, 25, 236-258.   Goldstein, H. (1990). Problem-oriented policing. Temple University Press.   Goldstein, H., Browne, W., & Rasbash, J. (2002). Partitioning variation in multilevel 

models. Understanding Statistics: Statistical Issues in Psychology, Education,  and the Social Sciences, 1, 223-231.  

Grannis, R. (1998) The importance of trivial streets: residential streets and residential  segregation. American Journal of Sociology, 103, 1530–1564 

Groff, E. R., Weisburd, D., & Yang, S-M. (2010). Is it important to examine crime trends  at a local “micro” level?: A longitudinal analysis of street to street variability in  crime trajectories. Journal of Quantitative Criminology, 26, 7-32.  

Haberman, C. P., Sorg, E. T., & Ratcliffe, J. H. (2017). Assessing the validity of the law  of crime concentration across different temporal scales. Journal of Quantitative  Criminology, 33, 547-567.  

Hinkle, J. C., Weisburd, D., Telep, C. W., & Peterson, K. (2020). Problem-oriented  policing for reducing crime and disorder: An updated systematic review and  meta-analysis. Campbell Systematic Reviews, 16, 1-86.  

Hipp, J. R., & Kim, Y. A. (2017). Measuring crime concentration across cities of varying  sizes: Complications based on the spatial and temporal scale employed. Journal of  Quantitative Criminology, 33, 595-632. 

Hipp, J. R., Kim, Y., Wo, J. C. (2020). Micro-scale, meso-scale, macro-scale, and  temporal scale: Comparing the relative importance for robbery risk in New York  City. Justice Quarterly. https://doi.org/10.1080/07418825.2020.1730423.  Hipp, J. R., & Williams, S. A. (2021). Accounting for meso- or micro-level effects when  estimating models using city-level crime data: Introducing a novel imputation  technique. Journal of Quantitative Criminology, 37, 915-951. 

Hox, J. J. (1998). Multilevel modeling: When and why. In I. Balderjahn, R. Mathar, & M  Schader (Eds.), Classification, Data analysis and data highways (pp. 147-154).  Springer.  

Jones, R. W., & Pridemore, W. A. (2019). Toward an integrated multilevel theory of  crime at place: Routine activities, social disorganization, and the law of crime  concentration. Journal of Quantitative Criminology, 35, 543-572. 

Kim, Y-A., & Hipp, J. R. (2018). Physical boundaries and city boundaries: Consequences  for crime patterns on street segments? Crime & Delinquency, 64, 227-254.   Leckie, G., Browne, W., Goldstein, H., Merlo, J., & Austin, P. (2019). Variance 

partitioning in multilevel models for count data. arXiv preprint arXiv:1911.06888. 

Lee, Y., Eck, J. E., O, S., & Martinez, N. N. (2017). How concentrated is crime at places?  A systematic review from 1970 to 2015. Crime Science, 6, DOI 10.1186/s40163017-0069-x. 

Levin, A., Rosenfeld, R., & Deckard, M. (2017). The law of crime concentration: An  application and recommendations for future research. Journal of Quantitative  Criminology, 33, 635-647. 

Lorenz, M. O. (1905). Methods of measuring the concentration of wealth. Publications of  the American Statistical Association, 9, 209-219. 

Lyons, C. J., Vélez, M. B., & Santoro, W. A. (2013). Neighborhood immigration,  violence, and city-level immigrant political opportunities. American Sociological  Review, 78, 604-632. 

Malleson, N., Steenbeek, W., & Andresen, M. A. (2019). Identifying the appropriate  spatial resolution for the analysis of crime patterns. PLoS One, 14(6), 1-23. 

Mohler, G., Short, M. B., & Brantingham, J. P. (2017). The concentration-dynamics  tradeoff in crime hot spotting. In D. Weisburd & J. E. Eck (Eds.)., Unraveling the  crime-place connection. New directions in theory and policy (pp. 19-40).  Routledge.

Nezlek, J. B. (2008). An introduction to multilevel modeling for social and personality  psychology. Social and Personality Psychology Compass, 2, 842-860.   O’Brien, D. T. (2019). The action is everywhere, but greater at more localized spatial  scales: Comparing concentrations of crime across addresses, streets, and  neighborhoods. Journal of Research in Crime and Delinquency, 56, 339-377. 

O’Brien, D. T., & Winship, C. (2017). The gains of greater granularity: The presence and  persistence of problem properties in urban neighborhoods. Journal of Quantitative  Criminology, 33, 649-674.  

Openshaw, S. (1984). The modifiable areal unit problem. Geo Books. 

Pareto, V. (1909). Manuel d’économie politique. Vol. 7 of Oeuvres comple`tes. Droz.  Park, R. E., & Burgess, E. W. (1925). The city. The University of Chicago Press.   Peterson, R. D., & Krivo, L. J. (2010). Divergent social worlds: Neighborhood crime and 

the racial-spatial divide. Russell Sage Foundation.  

Richter, T. (2006). What is wrong with ANOVA and multiple regression? Analyzing  sentence reading times with hierarchical linear models. Discourse Processes, 41,  221-250.  

Quetelet, A. (1831[1984]). Research on the propensity for crime at different ages.  Anderson Publishing.  

Quick, M. (2019). Multiscale spatiotemporal patterns of crime: A Bayesian crossclassified multilevel modelling approach. Journal of Geographical Systems, 21, 339-365.  

Sampson, R. J., & Groves, W. B. (1989). Community structure and crime: testing socialdisorganization theory. American Journal of Sociology, 94, 774-802.  

Schnell, C., Braga, A. A., & Piza, E. L. (2017). The influence of community areas,  neighborhood clusters, and street segments on the spatial variability of violent  crime in Chicago. Journal of Quantitative Criminology, 33, 469-496.  

Sherman, L. W., Gartin, P., & Buerger, M. E. (1989). Hot spots of predatory crime:  Routine activities and the criminology of place. Criminology, 27, 27-55.  Sherman, L. W., & Weisburd, D. (1995). General deterrent effects of police patrol in  crime hot spots: A randomized controlled trial. Justice Quarterly, 12, 625-648. 

Steenbeek, W., & Weisburd, D. (2016). Where the action in in crime? An examination of  variability of crime across different spatial units in The Hague, 2001-2009.  Journal of Quantitative Criminology, 32, 449-469.  

Umar, F., Johnson, S. D., & Cheshire, J. A. (2021). Assessing the spatial concentration of  urban crime: An insight from Nigeria. Journal of Quantitative Criminology, 37,  605-624. 

U.S. Census Bureau (2019). City and town population totals: 2010-2019. Retrieved from  https://www.census.gov/data/tables/time-series/demo/popest/2010s-total-citiesand-towns.html 

Walker, J. T., & Drawve, G. R. (2018). Foundations of crime analysis. Data, analyses,  and mapping. Routledge.   Weisburd, D. (2015). The law of crime concentration and the criminology of place.  Criminology, 53, 133-157.  Weisburd, D., Bernasco, W., & Bruinsma, G. (2009). Putting crime in its place: units of  analysis in geographic criminology. Springer.   Weisburd, D., Groff, E. R., & Yang, S.M. (2012). The criminology of place: Street  segments and our understanding of the crime problem. Oxford University Press.

CHAPTER 5  BEST PRACTICES FOR ILLUSTRATING THE SPATIAL  VARIABILITY OF CRIME: RE-IMAGINING THE CRIME MAP19

19 Spencer, M. D. To be submitted to Cartography and Geographic Information Science. 

Abstract 

Objective   Many methods exist in mapping software to illustrate the spatial variability of crime. Yet, the use  of maps from recent research does not parallel cartographic advancements. This study examines  the current use of maps in research of the spatial variability of crime and presents innovative  methods for illustrating crime across multiple geographic levels.   Data/Methods   To examine the current use of maps, data from studies on the spatial variability of crime were  used. Further, using crime data from Atlanta, GA, estimates of spatial variability were illustrated  using dynamic maps.  Results  No prior use of dynamic maps to illustrate the spatial variability of crime were observed.  Multiple open-source methods are discussed and presented on how to create dynamic maps.  These types of maps allow for a nuanced illustration of crime variability across multiple  geographic levels.   Conclusions  Presently, maps are underutilized in research on the spatial variability of crime. To properly  illustrate the spatial variability of crime, methods which incorporate multiple geographic levels  are necessary. Dynamic maps are an effective method that should be embraced by future  research.  

Introduction 

Criminal behavior and subsequently crime is explicitly linked to place. Crime is a  measurable outcome directly influenced by places within space; all of which can be  visualized by maps. The connection between geography and crime is hardly new, nor is  the use of maps for illustrating it (Chainey 2021; Chainey & Ratcliffe, 2005). When  compared to tables full of statistics and visuals such as bar charts or line graphs, maps  can be more effective forms of communication when well designed (see Brewer, 2016;  Monmonier, 2018; Peterson, 2021; Tufte, 2001). Maps are particularly useful for  communicating how crime varies across space by revealing its non-uniform distribution  and clustering (Anselin et al., 2008). Within criminology, maps have been used to study  and illustrate crime for over 200 years. The earliest examples of crime maps were quite  simplistic yet informative for their time (see Guerry, 1833; Mayhew, 1862; Quetelet  ,1831 [1984]). Within the interest of crime and place research, these historical maps were  the first indications that crime was not randomly oriented across space.  

Despite their earlier use during the Chicago School (see Burgess, 1925; Shaw and  McKay, 1942), the use of maps in criminology became mainstream with the growing  interest in hot spots policing (Sherman et al., 1989; Sherman & Weisburd, 1995).  Research of hot spots can loosely be attributed from the late 1980s to the early 2000s  (Chainey & Ratcliffe, 2005). Technological improvements in data collection and  mapping capabilities are a key reason why hot spots were extensively studied during this  time. Additionally, hot spots were of use to law enforcement agencies and of public  curiosity, furthering their reach. The dissemination of hot spots information often came in  the form of maps which could appropriately illustrate them rather than through 

descriptive language. Even before the advent of modern computing and map making  software, creating maps during this period was much easier compared to the handdrawing techniques of the past. 

Crime maps are still common; however, their use appears to have lessened after  intense research on hot spots towards more advanced methods that rely heavily on  numerical descriptions (see Ratcliffe, 2010). In their place, spatial measures of crime  patterns and measures of statistical concentration such as the Lorenz curve and Gini  coefficient have dominated much of the recent literature. Additionally, a focus on microplaces, which often number in the thousands compared to observed crime, lead to  visualization issues. While still being used, the designs of maps have changed little from  early research. Journal restrictions are partly responsible, but a lack of interest may also  be a contributing factor. In fact, across multiple scientific fields, the advancements made  in the discipline of cartography rarely translate to academia (O’Sullivan & Unwin, 2010).  Rather, outside groups such as news organizations appear to be adopting the new trends  in mapping. Whatever the explanations, maps have been and still are an important  method for communicating information about crime. Their continued use will be  instrumental in retaining interest and attracting new researchers to the subject. 

Two research goals frame this study. One, to understand the recent use and to  promote the continued use of maps in criminological research. Two, to discuss and  present innovative mapping techniques by using the spatial variability of crime as an  example. These research goals will be addressed by using data from a systematic review  on the spatial variability of crime as well as public crime incident data for the mapping  components. How maps are used, and their design will be analyzed from the studies 

included in the systematic review. Then, innovative techniques for mapping crime will be  presented using crime incident data from Atlanta, GA. Finally, how maps can be  potentially integrated into the current structure of peer-reviewed journal publications will  be discussed.  

The History of Crime Mapping 

The use of maps for crime research is older than the field of criminology. Interest  in the geographic analysis of crime has varied from the early 1800’s to present with much  of the relevant research utilizing maps. Maps are often used to familiarize the reader to an  area of interest or for elementary descriptive analyses. Following the periods as defined  by Chainey and Ratcliffe (2005), the history of crime mapping and to a broader extent  crime and place research, can be placed into three periods: the Cartographic school, the  Chicago school, and the GIS school.  

Before the establishment of criminology as a discipline, European researchers  were interested in the distribution of crime. This period is called the cartographic school  as much of the research was descriptive and contingent on communicating information  using basic thematic maps to government agencies. In France, Guerry (1833) examined  the spatial variation of violent and property crime across jurisdictional divisions of the  country. Guerry’s thematic maps were shaded using grayscale to illustrate areas of lower  and higher crime rates based on urban-rural divisions. Though hardly useful by present  standards, Guerry’s research is one of the earliest examples of a crime map. Around the  same time as Guerry’s research, Quetlet (1842), combined the visual benefit of maps with  statistics; a precursor to much of the work that would follow. Mayhew (1862) is another  historical example of how maps were used to study crime. In his research of London, 

Mayhew (1862) published maps that showed patterns of offending across the city.  Similar work from Mayhew mapped intensity levels of crime across England and Wales  by county.  

After a lull resulting from diminished interest for analyzing crime geographically,  occurred perhaps the most-well known period of research that utilized maps: the Chicago  school. During this time, much of the research was focused on understanding crime at the  meso-level using neighborhoods. Researchers such as Burgess (1925), and Shaw and  McKay (1942) had access to more finely detailed data than what was available during the  cartographic school. Therefore, they were able to analyze crime at a finer spatial level  which shifted the research away from macro-units such as countries to cities and their  sub-units. Combining land use and socioeconomic data for Chicago, Burgess (1925),  examined how crime among other factors transitioned across the city. To illustrate his  work, Burgess created the concentric model, comprised of five zones. Each zone  represented a portion of Chicago with corresponding socio-demographic characteristics  including observed crime rates. Shaw and McKay (1942) later extended the concentric  model by hand mapping thousands of addresses for the locations of juvenile delinquent’s  homes. They did this for multiple cities and observed consistent patterns of offending  with concentrations of crime in certain areas. The zones with the highest concentrations  of crime were located towards the city center. Much of the maps created during the  Chicago school were intended for academics and city agencies tasked with reducing  crime and addressing juvenile delinquency.  

The GIS school of crime mapping is more loosely defined but can largely be  attributed to the advent of geographic information systems (GIS) and other computer 

advancements. This period between the 1970’s and early 2000’s is when the development  of mapping software and data with geographic attributes allowed for novel research. Hot  spot analysis and by extension, hot spot maps, were a very popular technique during this  time and often used by law enforcement agencies (Ratcliffe, 2010). Hot spot maps  illustrate a more localized fluidity of crime based on levels of concentration. They also  can only be accurately created using computers; a stark contrast to the hand-made maps  of prior. Numerous other techniques flourished during the GIS school that are the  foundation for much of how crime maps are created today such as certain design  principles involving color and projecting geographic data onto a screen (see Chainey &  Ratcliffe, 2005; Walker & Drawve, 2018). Maps during this period were often used to  disseminate crime information to the public or law enforcement agencies. Therefore, the  maps were designed to orient users quickly to recognizable features in the area of  analysis.  

A representation of the modern period of crime mapping can be described using a  relatively new term, geocomputation. This term extends the ‘quantitative geography’  beyond the use of spatial statistics by focusing on creativity and experimental methods  that appeal to diverse audiences (Lovelace et al., 2019; Openshaw & Abrahart, 2000).  Another important aspect of geocomputation is reproducibility which often occurs in the  form of open-access data and accompanying programming code (e.g., R, Python, SQL).  A Geocomputation school (2010-present) fits well with recent crime and place work that  frequently incorporates novel methodology beyond that of hot spot analysis (see Hipp et  al., 2021; Quick, 2019). However, equally sophisticated maps typically do not  accompany the innovative statistical analyses observed across recent research. Current 

cartographic technology allows for crime maps to expand beyond static 2D computer  images to 3D and even 4D (including a time component). Other creative mapping  techniques exist but are rarely, if ever, utilized in crime and place research of the last  decade. The disconnect between the methods and mapping techniques used in the  Geocomputation school are of central concern for this paper. 

New Methods of Map Design    At present, mapping software commonly used is proprietary such as Esri’s suite  of software. Other, open-source options exist such as QGIS and the R and Python  programming languages. Regardless of the chosen software or programming language, at  present, most allow for the researcher to quickly create appealing maps. A good-looking  map does not always translate to a useful one, though (see Brewer, 2016).     Extending beyond the traditional design elements of maps such as color or scale,  this paper aims to focus on how a map is visualized from the researcher to the user. For  example, static maps are those that are observed among all current and past crime and  place research. Static maps are non-interactive and are images of maps created using  some software. A dynamic map, a central topic of this research, is interactive in some  form. Dynamic maps can have multiple layers that can be turned “on” or “off” by the  user for post-production analysis. They can also have a zoom or a time feature that allows  for direct interaction with the map and data. How crime varies across different  geographic levels can be easily visualized using a dynamic map. To do the same  visualization using static maps would require multiple maps for each spatial level.  Additionally, fine details are often overlooked or ignored when using static maps. More 

detail can be added to dynamic maps as they have the capacity for zooming or panning  which interactively changes the geographic view as dictated by the user.      The printing process of academic journals prevents the use of non-static maps in  publications. However, as many journals have adopted online versions and advocate for  open-data and code availability, appendices, and external extensions to sites such as  GitHub are becoming more common. Linking to dynamic maps from within online  publication versions is a possibility. Exploiting this possibility can advance crime  mapping and the crime and place field broadly by visualizing difficult-to-understand  topics such as spatial variability.  

Data and Methods  Present Study 

Ratcliffe (2010) provides one of the most recent examples of advocacy for the  continued use of crime maps and insights into their future use (see also Kindynis, 2014).  One of the many important points Ratcliffe made is that while maps are relatively easy to  create using computer software, often their design is limiting, and the user is left  confused. As a growing body of research has found that crime varies by spatial level (O’  Brien & Winship, 2017; Schnell et al., 2017; Steenbeek & Weisburd, 2016), static maps  are ill-suited for illustrating such hierarchical variances. A solution for increasing users’  understanding of the map is to incorporate a dynamic design. This study has two research  goals that are each framed by the primary objective to observe the spatial variability of  crime using different mapping techniques.     To address the first research goal of the present study, an additional examination  of the studies identified in the systematic review by Spencer (2022) was conducted. In the 

systematic review, relevant research on the study of the spatial variability of crime from  2010-2019 was identified and analyzed. Presently, those studies which utilized maps  from Spencer (2022) were further analyzed on a few criteria based on their utilization of  crime maps. Whether a map was used, the type of map used, design features, and the  existence of links to external maps among others are examples of review criteria.  

The second research goal is addressed by the creation of examples of dynamic  maps using appropriate packages within the R statistical environment. Publicly accessible  crime data for Atlanta, GA from 2015-2019 was used to create measures of variance  across multiple spatial levels. Local tests of autocorrelation and variance estimates were  calculated at the census blocks, and census tracts. Dynamic maps were created that  enable the user to interact with the data and see the distribution of crime at each spatial  level within a single map. Specifically, these maps help illustrate the hierarchical spatial  variability of crime across multiple units within Atlanta. Attempting the same process  with static maps would require multiple maps for each unit such.   Data 

The data on map usage for this study comes from the Spencer (2022) systematic  review of research on the spatial variability of crime. Studies that were captured in the  review were examined based on their use of crime maps. To create the dynamic crime  maps, crime incident data from Atlanta between 2015-2019 was used.20 Atlanta was  selected out of convenience to the researcher. The time frame was selected to ensure a  large enough sample was available for mapping purposes.  

20 This data was obtained from the Atlanta Open Data Portal (https://www.atlantapd.org/i-want-to/crimedata-downloads). Geographic data for Atlanta was downloaded directly from the U.S. Census TIGER/Line  Shapefiles database using the Tigris (version 1.0) package into R where the appropriate shapefiles were  created (Walker, 2020). 

Mapping Strategy 

Many methods exist for creating dynamic maps. This paper focuses on using the  open-source R statistical environment for creating dynamic maps. Specifically, the  Leaflet (version 2.0.4.1), Tmap (version 3.3-1), and Shiny (version 1.6.0) packages are  used to create maps and web-based dashboards (see Chang et al., 2021; Cheng et al.,  2021; Tennekes, 2018). In each application, the user has the ability to interact with the  crime data and visualize crime variability across multiple spatial levels and units. 

Results  Research Question 1 

Key features regarding the use of maps were examined using the 11 studies  identified by Spencer (2022). The majority (82%) of the studies utilized maps. In sum, 81  maps were used and on average nine maps were used per study by those which used  them. No use of dynamic maps was observed either within the studies or as supplemental  material. A little less than half (47%) of the maps were in color or included color  components. Seven of the nine (77%) studies used multiple maps to illustrate levels of  concentration or variance per unit; thus, highlighting the difficultly of illustrating nested  spatial variance with static maps. The two other studies which used maps did so to  illustrate spatial units.     To further examine the use of maps from recent spatially related research, a  simple random sample of 10% (n = 53) was taken of the original 524 (with the 11  reviewed studies excluded) studies identified through database searching by Spencer 

(2022). Though these studies were not included as part of the systematic review they are  a robust representation of spatial research conducted from 2010-2019. Of those sampled, 

75% used maps with an average of 4 maps per study. Maps that incorporated color were  used slightly less compared to black and white maps. Studies from geography journals  often included more maps and maps that utilized color or other unique designs such as  raster images and 3D designs. No temporal trend was apparent that indicated an increased  or decreased use of maps across the study period.     These findings indicate maps are commonly used by studies dedicated to  analyzing spatial variability as well as the broader research on crime and place.  Geography journals appear to be more accepting of detailed maps and the quantity  included per study. Our results also highlight the difficulty of illustrating the  concentration and variability of crime using a single map. Of particular difficulty are  attempts at illustrating these phenomena at the micro-scale where many units are present  and can overwhelm the map. In no case were dynamic maps used to illustrate crime  across multiple levels and units. Static maps can also only visually communicate so much  information and numerous maps are often required to illustrate concepts such as hot spots  across multiple units.   Research Question 2

In this section, examples of crime maps (static and dynamic) are presented and  discussed. Figure 5.1 contains three maps of robbery by census blocks in Atlanta from  2015-2019. The first map (left-most) is of robbery counts using a Fisher-Jenks binning  method (Fisher, 1958). Using the same method, the second (middle) map is of variance  estimates per block in the city (see Leckie et al., 2019 for discussion on how estimates of  variance were calculated). Lastly, the third map (right-most) is of hot and cold spots 

determined by the GI* test of spatial autocorrelation (Ord & Getis, 1995). The maps in  Figure 5.2 are analogous to those in Figure 5.1 but for census tracts rather than blocks.  

The focus of these maps is not the method for analyzing the spatial distribution of  robbery, but the presentation of results. The maps in Figures 5.1 and 5.2 are typical  examples that can be seen in much of the prior research. While useful to a degree, data  interpretation at a finer level is difficult if not impossible. Zooming in on the images  often will distort them, thus, their usefulness is limited. For example, when viewing the  map of robbery hot and cold spots by block, the user is left ill-informed of any detail as to  which blocks contain high levels of crime and exactly where they are located. Only broad  geographic clusters are readily apparent. To some degree the level of interpretability  provided by these maps is sufficient for general conclusions of where crime is occurring  at the city-level despite being analyzed at a much smaller-scale. Often, when more detail  is necessary accompanying “zoomed-in” or subset maps such as those in Figures 5.3 and  5.4 are provided.  

The maps in Figures 5.3 and 5.4 are images captured from dynamic maps of  robbery in Atlanta. These images illustrate the nuances that dynamic maps offer with the  addition of a street network layer that assists in identification akin to Google Maps.  Figure 5.4 offers more detail with the inclusion of a marker for Mercedes Benz Stadium,  a popular sporting arena in Atlanta. A popup marker appears over one of the identified  blocks that contains more information about the levels of robbery for that block. These  options, while possible on static maps, can easily be overwhelming when occurring  hundreds if not thousands of times.  

112 

Figure 5.1 Choropleth maps of robbery incidents by census block in Atlanta (2015-2019) 

113 

Figure 5.2 Choropleth maps of robbery incidents by census tract in Atlanta (2015-2019)

Figure 5.3 Image of dynamic map with increased detail 

Figure 5.4 Image of dynamic map with increased detail and reference information  The maps in Figures 5.3 and 5.4 are images captured from dynamic maps of  robbery in Atlanta. These images illustrate the nuance that dynamic maps offer with the 

addition of a background overlay of the street network that assists in identification of  areas in the city; akin to Google Maps. Figure 5.4 offers even more detail with the  inclusion of a marker for Mercedes Benz Stadium, a popular sporting arena in Atlanta.  Additionally, a popup marker appears over one of the identified blocks that contains more  information about the levels of robbery for that block. These options, while possible on  static maps, can easily be overwhelming when occurring hundreds if not thousands of  times. For example, Atlanta has 6,735 census blocks and 139 tracts. It would be  impractical to display information for each block using a static map.  

A dynamic map allows for zooming and the ability to display information when  needed such as by clicking or hovering over a block. Additionally, with the incorporation  of background overlays (called tiles in Leaflet; the package used to create these dynamic  maps) endless detail can help familiarize the reader to locations within the map. The  OpenStreetMap background used in Figures 5.3 and 5.4 is free to use and like those of  popular mapping software such as Google Maps. The familiarity of these type of maps  helps users navigate them easily and ultimately gain greater insight into the phenomenon  being explained.  

Perhaps the most limiting factor of static maps is the lack of multi-level  incorporation. For example, to illustrate the spatial variability of robbery in Atlanta  separate maps for estimates at the block and tract were necessary as evident by Figures  5.1 and 5.2. A more practical and useful method is to create a map that has both estimates  on the same map. Thus, a dynamic map with the ability to turn layers “on” and “off” is  highly useful. An image from a dynamic map that has this feature is presented in Figure  5.5. On the right-side of this image a feature is present that allows the user to select 

which layer (one, both or none) they want to view. The option of highlighting certain  units within the layers correspondingly switches and is evident in Figure 5.6 by the  presence of a dashed border. This feature helps clarify what units are within larger units.  For example, with both layers turned “on”, a user can view which blocks are located  within which tracts. Therefore, in this example it becomes clearer that many tracts are not  completely inundated with instances of robbery, yet certain blocks within tracts are  responsible for the high rates. The tract highlighted in Figure 5.6 is not identified as a hot  spot, yet multiple blocks with the tract are. This phenomenon of high crime concentration  and variability has been well supported in prior research (Eck et al., 2017; Haberman et  al., 2017). Yet, multiple maps are routinely required to illustrate the hierarchical nature of  crime variability; often, leaving the user to constantly browse one before switching back  to another.  

Figure 5.5 Image of dynamic map with multiple layers 

Figure 5.6 Image of dynamic map with highlighted area (dashed border)

Figure 5.7 Image of Shiny dashboard 

Figure 5.7 is the final image presented. This figure is of an image of a Shiny  dashboard. This example of a basic dashboard contains a dynamic map just like those  previously shown. The difference being that a Shiny dashboard is designed to be hosted 

online and includes many more options beyond that of the dynamic maps shown in  Figures 5.3, 5.4, and 5.5. The options for a Shiny dashboard are overwhelming and not  discussed in-depth here (see Chang et al., 2021 for more details). One example is the  option for post-processing data such as linking user selections to dynamic graphical  displays like histograms. It should be noted that the other dynamic maps presented are  also hosted and viewable using an internet browser, yet they are less like an interactive  website and more like a single webpage (see footnote for URLs to dynamic maps).21 While the options for post-processing and other characteristics of a Shiny dashboard are  impressive the skill required to create one can become too time-intensive and beyond  what is necessary for most researchers. The example provided here only includes the  addition of a banner title alongside the dynamic map. During the process of creating the  dashboard, it was realized the time committed and possibility of hosting fees due to the  processing power required for spatial tasks was too great. Therefore, for this study the  development of the dashboard was not pursued further nor is it hosted online. 

Discussion    Interest in crime and place research has grown immensely in the past few decades.  While maps are still commonly used in the related research, rarely are newer cartographic  techniques embraced. The likely culprit is journal restrictions or programming and  software expertise required to create dynamic maps. Other barriers may also exist that  prevent the adoption and use of some of the newer mapping techniques. However, 

21 Multi-layer map (https://block-tract-lisa.netlify.app/); Tract hot spot map (https://tract-lisa.netlify.app/);  Tract robbery count map (https://tract-counts.netlify.app/); Block hot spot map (https://blocklisa.netlify.app/); Block robbery count map (https://block-counts.netlify.app/) 

addressing many of those issues discussed in this paper are relatively straightforward and  can greatly enhance how hierarchical relationships of crime and space are illustrated. 

At present, peer-reviewed journals are often printed and to the author’s  knowledge do not have the integrated capabilities for including dynamic maps within  articles posted online. Options do exist to accommodate them, though. The use of  supplementary links to external sites where dynamic maps are hosted online is one such  example. An important caveat is the intended audience. Certain audiences such as law  enforcement and academics respond to or expect different types of maps. Similarly, the  amount of time required to create more advanced maps is an important consideration. The  paradox of creating maps is that they will never be perfect, but we can stride to utilize the  most recent advancements in the field of cartography. While the dynamic maps displayed  in this study required a lot of programming to create, the process to do so is similar to  learning a new statistical method; it requires time and practice. In the short term,  dedicating time to develop these skills may seem like a loss on investment. Yet, it should  be stressed that dynamic maps are an asset that will likely become more commonplace as  technology is further incorporated into research including the dissemination of findings.  Continuing the use of maps and including newer cartographic techniques will serve crime  and place research well.  

Conclusion    In this study, the use of maps in research on the spatial variability of crime from  2010-2019 were examined. Additionally, new methods for creating maps and  disseminating research findings using these methods were discussed. At present, the  current and past use of maps in crime and place research can be improved by adopting 

newer cartographic techniques. The benefits of adopting these techniques have been  discussed and suggestions made for their use.     Within crime and place research, the transition to becoming more technologically  integrated is prudent for researchers recognize and embrace. Accepting and utilizing  these advancements will make research findings more accessible to relevant stakeholders  and potentially grow interest among younger generations of crime and place researchers.  As evident by the findings in this study, static maps have a long history in criminological  research and will continue to do so. However, technology presently allows for much  more advanced iterations of maps which can communicate more information via a more  accessible medium. As peer-reviewed journals continue to transition resources online and  expand beyond printed copies, limitations of creating and disseminating maps are  decreasing. The methods to create dynamic maps discussed in this article are but a few of  the many options available. All of which, can hopefully inspire a new generation of crime  cartographers, and strengthen relationships between researchers and practitioners. 

References 

Anselin, L., Griffiths, E., & Tita, G. (2008). Crime mapping and hot spot analysis. In. R.  Wortley & L. Mazerolle (Eds.), Environmental criminology and crime analysis  (pp. 97-116). Willan Publishing.  

Brewer, C. A. (2016). Designing better maps. A guide for GIS users (2nd ed.). ESRI  Press.   Burgess, E. W. (1925). The growth of the city: An introduction to a research project. In  R. E. Park & E. W. Burgess (Eds.), The city: Suggestions for the investigations of 

human behavior in the urban environment (pp. 47-62). The University of Chicago  Press.  

Chainey, S. (2021). Understanding crime. Analyzing the geography of crime. ESRI Press.   Chainey, S., & Ratcliffe, J. (2005). GIS and crime mapping. Wiley.   Chang, W., Cheng, J., Allaire, J. J., Sievert, C., Schloerke, B., Xie, Y., Allen, J., 

McPherson, J., Dipert, A., & Borges, B. (2021). Shiny: Web application  framework for R. https://CRAN.R-project.org/package=shiny 

Cheng, J., Karambelkar, B., & Xie, Y. (2021). Leaflet: Create interactive web maps with  the JavaScript ‘leaflet’ library. https://CRAN.R-project.org/package=leaflet 

Eck, J. E., Lee, Y., O, S., & Martinez, N. (2017). Compared to what? Estimating the  relative concentration of crime at places using systematic and other reviews.  Crime Science, 6, 1-17.  

Fisher, W. D. (1958). On grouping for maximum homogeneity. Journal of American  Statistical Association, 53, 789-798.   Guerry, A. M. (1833). Essai sur la statistique morale de la France: Precede d’un rapport  a l’Academie de sciences. Chez Crochard.  

Haberman, C. P., Sorg, E. T., & Ratcliffe, J. H. (2017). Assessing the validity of the law  of crime concentration across different temporal scales. Journal of Quantitative  Criminology, 33, 547-567.  

Hipp, J. R., Lee, S., Ki, D., & Kim, J. H. (2021). Measuring the built environment with  google street view and machine learning. Consequences for crime on street  segments. Journal of Quantitative Criminology, https://doi.org/10.1007/s10940021-09506-9. 

Kindynis, T. (2014). Ripping up the map: Criminology and cartography reconsidered.  British Journal of Criminology, 54, 222-243.   Leckie, G., Browne, W., Goldstein, H., Merlo, J., & Austin, P. (2019). Variance 

partitioning in multilevel models for count data. arXiv preprint arXiv:1911.06888.  Lovelace, R., Nowosad, J., & Muenchow, J. (2019). Geocomputation with R. CRC Press.   Mayhew, H. (1862). London labor and the London poor. Griffin Bohn.   Monmonier, M. (2018). How to lie with Maps (3rd ed.). University of Chicago Press.   O’ Brien, D. T., & Winship, C. (2017). The gains of greater granularity: The presence 

and persistence of problem properties in urban neighborhoods. Journal of  Quantitative Criminology, 33, 649-674. 

Openshaw, S., & Abrahart, R. J. (2000). Geocomputation. CRC Press.   Ord, J. K., & Getis, A. (1995). Local spatial autocorrelation statistics: Distributional 

issues and an application. Geographical Analysis, 27, 286-306.   O’Sullivan, D., & Unwin, D. J. (2010). Geographic information analysis (2nd ed.). Wiley.   Peterson, G. N. (2021). GIS cartography. A guide to effective map design (3rd ed.). CRC 

Press.   Quetelet, A. (1842). A treatise in man. Chambers.   Quetelet, A. (1831[1984]). Research on the propensity for crime at different ages. 

Anderson Publishing.  

Quick, M. (2019). Multiscale spatiotemporal patterns of crime: A Bayesian crossclassified multilevel modelling approach. Journal of Geographical Systems, 21,  339-365.  

Ratcliffe, J. (2010). Crime mapping: Spatial and temporal challenges. In A. R. Piquero &  D. Weisburd (Eds.), Handbook of quantitative criminology (pp. 5-24). Springer. 

Schnell, C., Braga, A. A., & Piza, E. L. (2017). The influence of community areas,  neighborhood clusters, and street segments on the spatial variability of violent  crime in Chicago. Journal of Quantitative Criminology, 33, 469-496.  

Shaw, C. R., & McKay, H. D. (1942). Juvenile delinquency and urban areas. A study of  rates of delinquency in relation to differential characteristics of local  communities in American cities. The University of Chicago Press.  

Sherman, L. W., Gartin, P., & Buerger, M. E. (1989). Hot spots of predatory crime:  Routine activities and the criminology of place. Criminology, 27(1), 27-55.  Sherman, L. W., & Weisburd, D. (1995). General deterrent effects of police patrol in  crime hot spots: A randomized controlled trial. Justice Quarterly, 12, 625-648. 

Spencer, M. D. (2022). The spatial variability of crime: A review of methodological  choice, proposed models, and methods for illustrating the phenomenon  [Unpublished doctoral dissertation]. University of South Carolina.  

Steenbeek, W., & Weisburd, D. (2016). Where the action in in crime? An examination of  variability of crime across different spatial units in The Hague, 2001-2009.  Journal of Quantitative Criminology, 32, 449-469.  

Tennekes, M. (2018). Tmap: Thematic maps in R. Journal of Statistical Software, 84, 1-

39.   Tufte, E. R. (2001). The visual display of quantitative information (2nd ed.). Graphics  Press.  

Walker, K. (2020). Tigris: Load census TIGER/line shapefiles. https://CRAN.Rproject.org/package=tigris   Walker, J. T., & Drawve, G. R. (2018). Foundations of crime analysis. Data, analyses,  and mapping. Routledge. 

CHAPTER 6  CONCLUSION 

This dissertation, comprised of three related articles, sought to examine the  phenomenon of spatial variability of crime. Specifically, a systematic review of the  relevant literature, a proposed modeling strategy, and innovative mapping techniques  were conducted to further understand spatial variability. For more on those findings refer  to their respective chapters. A recap of each of these study’s findings can be stated  concisely: 

1. A lack of cohesiveness regarding methodological choice and the selection of units  of analysis exists in the crime and place literature.  

2. The spatial variability of crime between cities is remarkedly similar. Micro-units  account for the largest proportion of total crime variance. Ultimately, the  variability estimates calculated suggest city’s do not have a large effect on  shaping the spatial distribution of crime. 

3. In crime and place research, maps are still commonly used to illustrate the  distribution of crime. Visualizing the spatial variability of crime requires multiple  static maps. Mapping techniques such as dynamic maps address this issue by  illustrating crime across multiple units within a single map that is interactive.  

Important considerations for any spatial analyses of crime are the selection of a  unit(s) of analysis and appropriate methods. These considerations have been discussed in  great detail throughout this work. It is these issues that ultimately guided the primary goal  of this dissertation: examining and refining the concept of spatial variability.  

In this dissertation the concept was defined and studied in three unique ways. Each  study’s findings have contributed to crime and place literature by furthering our  understanding of spatial variability as a unique concept worthy of further attention.  Particularly, comparisons were made between crime concentration and spatial variability.  It is recognized that both concepts are important for framing how crime is distributed  across space and in some areas more than others. However, to understand the true spatial  context of crime in a city a test of spatial variability is required. That is, for example,  multiple units of analysis are required to study how some neighborhoods can be  identified as hot spots with relatively few micro-units within them also being identified as  such. Any combination of within and between unit comparisons are sufficient tests of the  concept. 

The Future  The findings of this dissertation support the use of multiple spatial units of  analysis while recognizing the considerable role micro-places have in related research.  Larger units of analysis such as neighborhoods, while still important, are relatively  limited by their scope of inference. More so, between-city estimates of variability are  similar. These findings hint at a few considerations for future research to expand upon.  First, future research should continue to apply new methodological approaches while  replicating past ones for an array of crimes at various spatial scales. Second, as research  on crime concentration and spatial variability become more refined, areas of focus should  expand beyond urban areas. Each of these considerations are discussed further.    As observed from the findings of the systematic review, no consistency for  selecting units of analysis or methods exists. This point is not made for the opinion that a 

typology should exist with little deviation. However, a clear lack of replication and  purposeful methodological selections is evident. Future research should continuously test  the boundaries of what defines a micro-place and neighborhood. Often, pre-determined  boundaries are used for geographic delineation. Other processes are available such as grid  cells that can be created using different inputs such as social characteristics to determine  their size and quantity. A downfall with this method is their usefulness to law  enforcement may be diminished compared to units commonly used. Additionally, as  increased volumes of data become easily accessible crime and place researchers will soon  be met with a question of what defines a micro-place? Is it street segments, addresses,  census blocks, or each of these? Is it possible that data can become detailed enough  where crime can be analyzed at single addresses vertically (e.g., by apartment floor)? As  urban areas continuously evolve, so should our definitions of place.     Another question that will inevitably become a topic of increasing interest is what  combination of units is best, if one exists? Like the units used in the second study within  this dissertation, are polygon units that nest neatly preferred? Or is it some combination  of multiple micro-units and a meso-units? Aside from a few studies, these questions are  largely still unanswered. Related, is whether a different set of units in the same city such  as street segments and census block groups will have similar estimates of variability  compared to blocks and tracts. Using this scenario, is it a case of variance estimates  shifting to similar units, or will they significantly change?    Pertaining to the analysis phase of research, like unit choice, no clear  methodology to measure the spatial variability of crime is apparent. Many options are  available, with some being more appropriate than others. Future researchers should also 

concern themselves with the use of covariates of spatial variability. While this  dissertation did not analyze covariates in its models, crime and place theories often  explicitly link characteristics such as race, economic status, and education levels, among  others to place. These covariates likely serve an important role in understanding why  certain locations are persistently crime prone and distributed in certain patterns.  Likewise, covariates such as land use are often easily obtainable and spatially informed  for many areas in the U.S. and may add more context to this area of research.     Beyond unit and methodological choice, are decisions about what crime(s) and in  which cities or non-urban areas to analyze. A historical query that has yet to be  sufficiently addressed is whether crime and place research findings apply to suburban and  rural areas. I advocate for expanding research beyond urban areas, particularly major  cities in the U.S., to increase the applicability of research findings. Examining the spatial  of variability of crime in non-urban areas will undoubtedly present methodological  challenges such as edge effects and a lack of quality data. This task is becoming easier  though as more data for non-urban areas is being collected and increasingly open-source

REFERENCES 

Andresen, M. A. (2011). Estimating the probability of local crime clusters: The impact of  immediate spatial neighbors. Journal of Criminal Justice, 39, 394-404.  

Andresen, M. A., Curman, A. S., & Linning, S. J. (2017). The trajectories of crime at  places: Understanding the patterns of disaggregated crime types. Journal of  Quantitative Criminology, 33, 427-449.  

Andresen, M. A., & Linning, S. J. (2012). The (in)appropriateness of aggregating across  crime types. Applied Geography, 35, 275-282.  

Andresen, M. A. & Malleson, N. (2011). Testing the stability of crime patterns:  Implications for theory and policy. Journal of Research in Crime and  Delinquency, 48, 58-82.  

Andresen, M. A., Malleson, N., Steenbeek, W., Townsley, M., & Vandeviver, C. (2020).  Minimum geocoding match rates: An international study of the impact of data and  areal unit sizes. International Journal of Geographical Information Science, 34,  1306-1322.  

Anselin, L. (1988). Spatial econometrics: Methods and models. Kluwer Academic  Publishers.   Anselin, L. (1995). Local indicators of spatial association: LISA. Geographical Analysis,  27(2), 93-115.

Anselin, L., & Bera, A. K. (1998). Spatial dependence in linear regression models with  an introduction to spatial econometrics. In A. Ullah & D. E. A. Giles (Eds.),  Handbook of applied economic statistics (pp. 237-290). Marcel Dekker.  

Anselin, L., Griffiths, E., & Tita, G. (2008). Crime mapping and hot spot analysis. In. R.  Wortley & L. Mazerolle (Eds.), Environmental criminology and crime analysis  (pp. 97-116). Willan Publishing 

Balbi, A. & Guerry, A. M. (1829). Statistique comparée de l’état de l’instruction et du  nombre des crimes dans les divers arrondissements des Académies et des Cours  Royales de France. Everat.  

Baumer, E. P., Wolff, K. T., & Arnio, A. N. (2012). A multicity neighborhood analysis of  foreclosure and crime. Social Science Quarterly, 93, 577-601.  

Berk, R. A. (2010). An introduction to statistical learning from a regression perspective.  In A. R. Piquero & D. Weisburd (Eds.), Handbook of quantitative criminology  (pp. 725-740). Springer. 

Berk, R. A., & Bleich, J. (2013). Statistical procedures for forecasting criminal behavior.  A comparative assessment. Criminology & Public Policy, 12, 513-544.  

Bernasco, W., & Block, R. L. (2011). Robberies in Chicago: A block-level analysis of the  influence of crime generators, crime attractors, and offender anchor points.  Journal of Research in Crime and Delinquency, 48, 33-57.  

Bernasco, W., & Steenbeek, W. (2017). More places than crimes: Implications for  evaluating the law of crime concentration at place. Journal of Quantitative  Criminology, 33, 451-467. 

Block, L. R., & Block, C. B. (1995). Space, place, and crime: Hot spot areas and hot  places of liquor-related crime. In J. Eck & D. Weisburd (Eds.), Crime and place:  Crime prevention studies, Vol. 4 (pp. 123-137). Criminal Justice Press.  

Braga, A. A., Hureau, D. M., & Papachristos, A. V. (2011). The relevance of micro  places to citywide robbery trends: A longitudinal analysis of robbery incidents at  street corners and blocks faces in Boston. Journal of Research in Crime and  Delinquency, 48, 7-32.  

Braga, A. A., Papachristos, A. V., & Hureau, D. M. (2014). The effects of hot spots  policing on crime: An updated systematic review and meta-analysis. Justice  Quarterly, 31, 633-663. 

Braga, A. A., & Weisburd, D. (2012). The effects of focused deterrence strategies on  crime: A systematic review and meta-analysis of the empirical evidence. Journal  of Reseach in Crime and Delinquency, 49, 323-358.  

Brantingham, P. J., & Brantingham, P. L. (1981). Environmental criminology. Sage  Publications.  

Brantingham, P. J., Brantingham, P. L., & Andresen, M. A. (2017). The geometry of  crime and crime pattern theory. In R. Wortley & M. Townsley (Eds.),  Environmental criminology and crime analysis (2nd ed., pp. 98-115). Routledge.  

Breiman, L. (2001). Random forests. Machine learning, 45, 5-32.   Brewer, C. A. (2016). Designing better maps. A guide for GIS users (2nd ed.). ESRI 

Press.  

Buil-Gil, D., Moretti, A., & Langton, S. H. (2021). The accuracy of crime statistics:  Assessing the impact of police data bias on geographic crime analysis. Journal of  Experimental Criminology. https://doi.org/10.1007/s11292-021-09457-y.  

Burgess, E. W. (1925). The growth of the city: An introduction to a research project. In  R. E. Park & E. W. Burgess (Eds.), The city: Suggestions for the investigations of  human behavior in the urban environment (pp. 47-62). The University of Chicago  Press.  

Bursik, R., Jr. (1988). Social disorganization and theories of crime and delinquency:  Problems and prospects. Criminology, 26(4), 519-552.  Bursik, R. Jr., & Grasmick, H. G. (1993). Neighborhoods and crime: The dimensions of 

effective community control. Lexington Books.  Chainey, S. (2021). Understanding crime. Analyzing the geography of crime. ESRI Press.   Chainey, S., & Ratcliffe, J. (2005). GIS and crime mapping. Wiley.   Chang, W., Cheng, J., Allaire, J. J., Sievert, C., Schloerke, B., Xie, Y., Allen, J., 

McPherson, J., Dipert, A., & Borges, B. (2021). Shiny: Web application  framework for R. https://CRAN.R-project.org/package=shiny 

Cheng, J., Karambelkar, B., & Xie, Y. (2021). Leaflet: Create interactive web maps with 

the JavaScript ‘leaflet’ library. https://CRAN.R-project.org/package=leaflet Chi, G., & Zhu, J. (2020). Spatial regression models for the social sciences. Sage 

Publications.   Cohen, L. E., & Felson, M. (1979). Social change and crime rate trends: A routine  activity approach. American Sociological Review, 44, 588-608.  

Cornish, D. B., & Clarke, R. V. (1986). The reasoning criminal: Rational choice  perspectives on offending. Springer.  

Cornish, D. B., & Clarke, R. V. (2017). The rational choice perspective. In R. Wortley &  M. Townsley (Eds.), Environmental criminology and crime analysis (2nd ed., pp.  29-61). Routledge.  

Cressie, N. (1993). Statistics for spatial data. John Wiley & Sons.   Darmofal, D. (2015). Spatial analysis for the social sciences. Cambridge University 

Press.   Dubin, R. (2009). Spatial weights. In A. S. Fotheringham & P. A. Rogerson (Eds.), The 

SAGE handbook of spatial analysis (pp. 125-158). Sage Publications.  Eck, J. E., Lee, Y., O, S., & Martinez, N. (2017). Compared to what? Estimating the  relative concentration of crime at places using systematic and other reviews.  Crime Science, 6, DOI 10.1186/s40163-017-0070-4.  

Eck, J. E., & Weisburd, D. (1995). Crime places in crime theory. In J. E. Eck & D.  Weisburd (Eds.), Crime and place. Crime prevention studies, vol. 24 (pp. 1-33).  Willow Tress Press. 

Felson, M., & Eckert, M. A. (2019). Crime and everyday life (6th ed.). Sage Publications.   Geary, R. C. (1954). The contiguity ratio and statistical mapping. The Incorporated 

Statistician, 5, 115-145.  Gelman, A. (2006). Prior distributions for variance parameters in hierarchical models.  Bayesian Analysis, 1, 515-533.   Getis, A., & Ord, J. K. (1992). The analysis of spatial association by use of distance  statistics. Geographical Analysis, 24(3), 189-206. 

Gill, C., Wooditch, A., & Weisburd, D. (2017). Testing the “law of concentration at  place” in suburban settings: Implications for research and practice. Journal of  Quantitative Criminology, 33, 519-545. 

Gini, C. (1912). Variabilità e mutabilità. vamu.  Goodchild, M. F., & Janelle, D. G. (2004). Spatially integrated social science. Oxford 

University Press.   Grekousis, G. (2020). Spatial analysis methods and practice. Describe-explore-explain  through GIS. Cambridge University Press.  

Groff, E. R., Weisburd, D., & Yang, S-M. (2010). Is it important to examine crime trends  at a local “micro” level?: A longitudinal analysis of street to street variability in  crime trajectories. Journal of Quantitative Criminology, 26, 7-32.  

Guerry, A. M. (1833). Essai sur la statistique morale de la France: Precede d’un rapport  a l’Academie de sciences. Chez Crochard.  

Haberman, C. P., Sorg, E. T., & Ratcliffe, J. H. (2017). Assessing the validity of the law  of crime concentration across different temporal scales. Journal of Quantiative  Criminology, 33, 547-567.  

Harries, K. (1999). Mapping crime: Principles and practice. U.S. National Institute of 

Justice.   Harris, R. (2016). Quantitative geography: The basics. Sage Publications.   Hipp, J. R., & Kim, Y. A. (2017). Measuring crime concentration across cities of varying 

sizes: Complications based on the spatial and temporal scale employed. Journal of  Quantitative Criminology, 33, 595-632. 

Hipp, J. R., Kim, Y., Wo, J. C. (2020). Micro-scale, meso-scale, macro-scale, and  temporal scale: Comparing the relative importance for robbery risk in New York  City. Justice Quarterly. https://doi.org/10.1080/07418825.2020.1730423. 

Hipp, J. R., Lee, S., Ki, D., & Kim, J. H. (2021). Measuring the built environment with  google street view and machine learning. Consequences for crime on street  segments. Journal of Quantitative Criminology, https://doi.org/10.1007/s10940021-09506-9.

Hipp, J. R., & Williams, S. A. (2020). Accounting for meso- or micro-level effects when  estimating models using city-level crime data: Introducing a novel imputation  technique. Journal of Quantitative Criminology. https://doi.org/10.1007/s10940020-09473-7

Hox, J. J. (1998). Multilevel modeling: When and why. In I. Balderjahn, R. Mathar, & M  Schader (Eds.), Classification, Data analysis and data highways (pp. 147-154).  Springer.  

Finch, W. H., Bolin, J. E., Kelley, K. (2019). Multilevel modeling using R (2nd ed.). CRC  Press.  

Fortin, M. J., & Dale, M. R. T. (2009). Spatial autocorrelation. In A. S. Fotheringham &  P. A. Rogerson (Eds.), The SAGE handbook of spatial analysis (pp. 89-104). Sage  Publications. 

Fotheringham, A. S., Brunsdon, C., & Charlton, M. (2000). Quantitative geography:  Perspectives on spatial data. Sage Publications.   James, G., Witten, D., Hastie, T., & Tibshirani, R. (2013). An introduction to statistical  learning. Springer.  

Johnson, B. D. (2010). Multilevel analysis in the study of crime and justice. In A. R.  Piquero & D. Weisburd (Eds.), Handbook of quantitative criminology (pp. 615648). Springer. 

Johnson, S. D. (2017). Crime mapping and spatial analysis. In R. Wortley & M.  Townsley (Eds.), Environmental criminology and crime analysis (2nd ed., pp.  199-223). Routledge. 

Jones, R. W., & Pridemore, W. A. (2019). Toward an integrated multilevel theory of  crime at place: Routine activities, social disorganization, and the law of crime  concentration. Journal of Quantitative Criminology, 35, 543-572. 

Kim, Y. A., & Hipp, J. R. (2018). Physical boundaries and city boundaries:  Consequences for crime patterns on street segments? Crime & Delinquency, 64,  227-254.  

Kochel, T. M., & Weisburd, D. (2019). The impact of hot spots policing on collective  efficacy: Findings from a randomized field trial. Justice Quarterly, 36, 900-928.  

Lee, Y., Eck, J. E., O, S., & Martinez, N. N. (2017). How concentrated is crime at places?  A systematic review from 1970 to 2015. Crime Science, 6, DOI 10.1186/s40163017-0069-x. 

Long, J. D. (2011). Longitudinal data analysis for the behavioral sciences using R. Sage.   Lovelace, R., Nowosad, J., & Muenchow, J. (2019). Geocomputation with R. CRC Press.   Lorenz, M. O. (1905). Methods of measuring the concentration of wealth. Publications of 

the American Statistical Association, 9, 209-219.  Malleson, N., Steenbeek, W., & Andresen, M. A. (2019). Identifying the appropriate  spatial resolution for the analysis of crime patterns. PLoS One, 14(6), 1-23. 

Mayhew, H. (1862). London labor and the London poor. Griffin Bohn.   Mohler, G., Brantingham, P. J., Carter, J., & Short, M. B. (2019). Reducing bias in  estimates for the law of crime concentration. Journal of Quantitative  Criminology, 35, 747-765. 

Mohler, G., Short, M. B., & Brantingham, J. P. (2017). The concentration-dynamics  tradeoff in crime hot spotting. In D. Weisburd & J. E. Eck (Eds.)., Unraveling the  crime-place connection. New directions in theory and policy (pp. 19-40).  Routledge.

Monmonier, M. (2018). How to lie with Maps (3rd ed.). University of Chicago Press.   Moran, P. A. P. (1950). Notes on continuous stochastic phenomena. Biometrika, 37, 17-

23. 

Nezlek, J. B. (2008). An introduction to multilevel modeling for social and personality  psychology. Social and Personality Psychology Compass, 2, 842-860.   O’Brien, D. T. (2019). The action is everywhere, but greater at more localized spatial  scales: Comparing concentrations of crime across addresses, streets, and  neighborhoods. Journal of Research in Crime and Delinquency, 56(3), 339-377. 

Openshaw, S. (1984). The modifiable areal unit problem. Geo Books.  Openshaw, S., & Abrahart, R. J. (2000). Geocomputation. CRC Press.   Ord, J. K., & Getis, A. (1995). Local spatial autocorrelation statistics: Distributional 

issues and an application. Geographical Analysis, 27(4), 286-306.  O’Sullivan, D., & Unwin, D. J. (2010). Geographic information analysis (2nd ed.). Wiley.   Paccagnella, O. (2011). Sample size and accuracy of estimates in multilevel models. New 

simulation results. Methodology, 7, 111-120.  

Pareto, V. (1909). Manuel d’économie politique. Vol. 7 of Oeuvres comple`tes. Droz.  Peterson, G. N. (2021). GIS cartography. A guide to effective map design (3rd ed.). CRC 

Press.   Peterson, R. D., & Krivo, L. J. (2010). Divergent social worlds: Neighborhood crime and  the racial-spatial divide. Russell Sage Foundation.  

Pierce, G. L., Spaar, S., & Briggs, L. R. (1988). The character of police work: Strategic  and tactical implications. Northeastern University Center for Applied Social  Research.  

Quetelet, A. (1831[1984]). Research on the propensity for crime at different ages. 

Anderson Publishing.   Quetelet, A. (1842). A treatise in man. Chambers.   Quick, M. (2019). Multiscale spatiotemporal patterns of crime: A Bayesian cross-

classified multilevel modelling approach. Journal of Geographical Systems, 21 339-365.  

Quick, M., Li, G., & Brunton-Smith, I. (2018). Crime-general and crime-specific spatial  patterns: A multivariate spatial analysis of four crime types at the small-area  scale. Journal of Criminal Justice, 58, 22-32. 

Ratcliffe, J. (2010). Crime mapping: Spatial and temporal challenges. In A. R. Piquero &  D. Weisburd (Eds.), Handbook of quantitative criminology (pp. 5-24). Springer. 

Richter, T. (2006). What is wrong with ANOVA and multiple regression? Analyzing  sentence reading times with hierarchical linear models. Discourse Processes, 41,  221-250.  

Ripley, B. D. (1976). The second-order analysis of stationary point processes. Journal of  Applied Probability, 13(2), 255-266.  Robinson, W. S. (1950). Ecological correlations and the behavior of individuals. 

American Sociological Review, 15, 351-357.   Robson, K., & Pevalin, D. (2016). Multilevel modeling in plain language. Springer.   Rosser, G., Davies, T., Bowers, K. J., Johnson, S. D., & Cheng, T. (2017). Predictive 

crime mapping: Arbitrary grids or street networks? Journal of Quantitative  Criminology. 33¸569-594. 

Sampson, R. J. (2012). Great American city: Chicago and the enduring neighborhood  effect. The University of Chicago Press.  

Schnell, C., Braga, A. A., & Piza, E. L. (2017). The influence of community areas,  neighborhood clusters, and street segments on the spatial variability of violent  crime in Chicago. Journal of Quantitative Criminology, 33, 469-496.  

Schnell, C., DeWitt, S., & Spencer, M. D. (2021). Mapping the hierarchical spatial  distribution of robberies in Chicago: An examination of variance across microplaces and neighborhoods. Manuscript submitted for publication.  

Shaw, C. R., & McKay, H. D. (1942). Juvenile delinquency and urban areas. A study of  rates of delinquency in relation to differential characteristics of local  communities in American cities. The University of Chicago Press.  

Shaw, C. R., Zorbaugh, F. M., McKay, H. D., & Cottrell, L.S. (1929). Delinquency  areas: A study of the geographical distribution of school truants, juvenile  delinquents, and adult offenders in Chicago. The University of Chicago Press.  

Sherman, L. W., Gartin, P., & Buerger, M. E. (1989). Hot spots of predatory crime:  Routine activities and the criminology of place. Criminology, 27, 27-55.  Sherman, L. W., & Weisburd, D. (1995). General deterrent effects of police patrol in  crime hot spots: A randomized controlled trial. Justice Quarterly, 12, 625-648. 

Steenbeek, W., & Weisburd, D. (2016). Where the action in in crime? An examination of  variability of crime across different spatial units in The Hague, 2001-2009.  Journal of Quantitative Criminology, 32, 449-469.  

Taylor, R. B. (2015). Community criminology: Fundamentals of spatial and temporal 

scaling, ecological indicators, and selectivity bias.  New York University Press.   Tennekes, M. (2018). Tmap: Thematic maps in R. Journal of Statistical Software, 84, 1-

39.   Tufte, E. R. (2001). The visual display of quantitative information (2nd ed.). Graphics  Press.  

U.S. Census Bureau (2019). City and town population totals: 2010-2019. Retrieved from  https://www.census.gov/data/tables/time-series/demo/popest/2010s-total-citiesand-towns.html 

Walker, K. (2020). Tigris: Load census TIGER/line shapefiles. https://CRAN.Rproject.org/package=tigris   Walker, J. T., & Drawve, G. R. (2018). Foundations of crime analysis. Data, analyses,  and mapping. Routledge.  

Waller, L. A. (2009). Detection of clustering in spatial data. In A. S. Fotheringham & P.  A. Rogerson (Eds.), The SAGE handbook of spatial analysis (pp. 299-320). Sage  Publications. 

Ward, M. D., & Gleditsch, K. S. (2019). Spatial regression models. Sage Publications.   Weisburd, D. (2015). The law of crime concentration and the criminology of place. 

Criminology, 53, 133-157. 

Weisburd, D., Eck, J. E., Braga, A. A., Telep, C. W., Cave, B., Bowers, K., Bruinsma, G.,  Gill, C., Groff, E. R., Hibdon, J., Hinkle, J. C., Johnson, S. D., Lawton, B., Lum,  C., Ratcliffe, J. H., Rengert, G., Taniguchi, T., & Yang, S. M. (2016). Place  matters: Criminology for the twenty-first century. Cambridge University Press.  

Weisburd, D., Groff, E. R., & Yang, S.M. (2012). The criminology of place: Street  segments and our understanding of the crime problem. Oxford University Press.  

Wheeler, A. P., & Steenbeek, W. (2020). Mapping the risk terrain for crime using  machine learning. Journal of Quantitative Criminology. https://doi.org/10.1007/s10940-020-09457-7. 

Wong, D. (2009). The modifiable areal unit problem (MAUP). In A. S. Fotheringham &  P. A. Rogerson (Eds.), The SAGE handbook of spatial analysis (pp. 105-124).  Sage Publications. 

Woolredge, J. (2002). Examining the (ir)relevance of aggregation bias for multilevel  studies of neighborhoods and crime with an example comparing census tracts to  official neighborhoods in Cincinnati. Criminology, 40, 681-710.   

APPENDIX A  ELIGIBILITY CHECK SHEET

1. Document ID __ __ __ __ 

2. First author last name: _______________ 

3. Study title: _______________________________ 

4. Journal name, volume and issue: ___________________________________ 

5. Coder’s initials __ __ __ 

6. Date eligibility determined: ______________ 

7. A study must meet the following criteria in order to be eligible. Answer each question  with a “yes” of a “no”  a. The study is an examination of the spatial variability of crime. _____  b. The study utilizes spatial methodology. _____  c. The study is written in English. _____  If the study does not meet the criteria above, answer the following question:  a. The study is a review article that is relevant to this project (e.g., may have references to  other studies that are useful, may have pertinent background information) _____ 

9. Eligibility status (circle one): Eligible, Not eligible, Relevant review 

APPENDIX B  CODING PROTOCOL 

1. Document ID: __ __ __ __ 

2. Study author(s): ________________ 

3. Study title: _______________________  4a. Publication type: ____    1. Book    2. Book chapter    3. Journal article (peer reviewed)    4. Doctoral dissertation    5. Government report     6. Police department report    7. Technical report    8. Conference paper    9. Other (specify)  4b. Specify (other) _______________ 

5. Publication date: _______________  6a. Journal name: ________________  6b. Journal volume and issue: ______________ 

7. Date range of research (when research was conducted):    Start: _______

Finish: __________ 

8. Source of funding for study: _______________ 

9. Country of publication: __________________ 

10. Date coded: ______________ 

11. Coder’s initials: __ __ __  Background Information 

12. Was this study original or a replication? __________________ 

13. What theory was used to provide background information? ___________________  14a. What type of crime was analyzed? (Select all that apply)    1. Predatory crimes against persons (sexual assault, robbery, homicide)    2. Predatory crimes against property (vandalism, auto theft)    3. Illegal service crimes (prostitution, selling drugs)    4. Public disorder crimes (disorderly conduct, drunkenness)    5. Vehicular/traffic offenses    6. Status crimes    7. Drug use    8. Overall crime/disorder    9. Other (specify)  14b. Specify (Other) __________________ 

15. Where was the crime data retrieved? ______________________ 

16. Is the crime data available open access? ________ 

17. What is the total sample size of analyzed crime? _________________ 

18. Is the crime aggregated? ______ 

Descriptive Statistics 

18. Was a Lorenz curve used? ______ 

19. Was the Gini coefficient used? ________ 

20. Was a statistical test for concentration performed? (i.e., 80/20). ________  21a. Was a descriptive graph/figure used to represent spatial concentration other than the  Lorenz curve? ________  21b. If yes, what type of graph or figure was used? ____________________ 

22. Were maps included? ______ 

23. How many maps were included? _______ 

24. Are any of the maps in color? _______  Spatial Methodology 

25. What spatial level of analysis was examined? (Select all that apply)    1. Micro    2. Meso    3. Macro 

26. What were the spatial unit types? (Select all that apply)    1. Lines    2. Polygons    3. Points    4. Raster  27a. What were the spatial units? (Select all that apply)    1. Street segments    2. Addresses 

  3. Blocks    4. Tracts    5. Neighborhoods/Community areas    6. City-wide    7. Other (specify)  27b. Specify (other) _______________________  28a. What type of test for spatial autocorrelation was performed?     1. Global (e.g., Moran’s I, Geary’s C, General G-Statistic)    2. Local (e.g., Local Moran’s I, Getis-Ord Gi and Gi

*) 

  3. None    4. Other (specify)  28b. Specify (other) __________________  28c. Indicate the test for spatial autocorrelation performed. ________________  29a. Was a spatial weights matrix mentioned? _______  29b. If yes, what type was used? _____________  30a. Was a multi-level model used? _________  30b. If yes, what type? __________  31a. Was a spatial regression model used? _______  31b. If yes, what type? ________  32a. Were hot spots analyzed? _______  32b. If yes, what method was used to calculate the hot spots? _________________  33a. Were spatial buffers or distance lags used? ______  33b. If yes, what was the distance(s) used? _______________________ 

34a. Was a point-pattern analysis performed? (e.g., Ripley’s K, Nearest neighbor) _____  34b. If yes, what type of point-pattern test was performed? __________________ 

35. What statistical software was used for the analysis? ____________ 

36. What spatial/mapping software was used for the analysis? ____________  Conclusions 

37. What were the estimates of the spatial variability of crime?     1. Micro level _________    2. Meso level __________    3. Macro level _________ 

