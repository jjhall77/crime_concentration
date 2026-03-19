How Concentrated are Police on Crime? A Spatiotemporal Analysis of the  Concentration of Police Presence and Crime  

Philipp M. Dau1, Christophe Vandeviver1,2, Maite Dewinter3, Frank Witlox3,4,5, Tom Vander  Beken1 

1 Department of Criminology, Criminal Law and Social Law, Ghent University, Universiteitstraat 4,  Ghent 9000, Belgium 

2 Research Foundation-Flanders (FWO), Egmontstraat 5, Brussels 1000, Belgium 

3 Department of Geography, Ghent University, Krijgslaan 281 S8, Ghent 9000, Belgium 

4 Department of Geography, University of Tartu, Vanemuise 46, Tartu 51014, Estonia  

5 College of Civil Aviation, Nanjing University of Aeronautics and Astronautics, Nanjing 210016,  China 

Direct correspondence to: Christophe Vandeviver, Department of Criminology, Criminal Law and  

Social Law, Ghent University, Universiteitstraat 4, 9000 Ghent, Belgium.  

Email: Christophe.Vandeviver@UGent.be

Funding This work was supported in part by the Ghent University Research Council (UGent-BOF)  Interdisciplinary Research Project funding scheme [BOF18/IOP/001 to C.V., T.V.B., F.W.]. Christophe  Vandeviver’s  contribution  was  supported  in  part  by  the  Research  Foundation  Flanders  (FWO)  Postdoctoral  Fellowship  funding  scheme  [12CO619N  to  C.V.].  Frank  Witlox’s  contribution  was  supported by the Estonian Research Council [PUT PRG306 501 to F.W.]. 

Conflicts of interest The authors declare no conflict of interests. 

Acknowledgements The computational resources (Stevin Supercomputer Infrastructure) and services  used  in  this  work  were  provided  by  the  VSC  (Flemish  Supercomputer  Centre),  funded  by  Ghent  University, FWO and the Flemish Government – department EWI. 

We would like to thank the Antwerp Police Department (APD) for providing us with the anonymized  datasets. 

Availability of data and materials The research data (consisting of police recorded crime data and  patrol car GPS data) and code cannot be publicly shared.

QUICK MENU: 

INTRODUCTION

DATA

METHODS RESULTS

DISCUSSION

CONCLUSIONS

How Concentrated are Police on Crime? A Spatiotemporal Analysis of Concentration of  Police Presence and Crime  

Purpose Police  patrol  has  undergone  an  evidence-based  and  data  driven  transition  in  the  beginning of the 21st century. While crime patterns are well researched, patterns of police presence  are not. Despite the abundance of available GPS data, little is known about the spatiotemporal  patterns of police forces. Given the paucity of evidence on where everyday policing takes place,  we ask: what spatiotemporal patterns of police exist, how do these patterns change over time, and  how do these correspond to local crime patterns?  

Methods Therefore, we analysed more than 77 million GPS signals from 130 police patrol cars  and more than 50,000 recorded crimes from 2019.to investigate where and when police patrols  are present. All data were geocoded and map matched using high performance computing. 

Results We found that police, much like crime, concentrates on a small proportion of street  segments and that the spatial concentration experiences temporal instability at the micro level.  Further, spatiotemporal police presence and its concentration appear to be unrelated to local levels  of crime and crime concentration.  

Conclusions These findings inform police chiefs and researchers alike and enable alterations of  patrol deployment in order to refine the spatiotemporal focus of police on local crime. Future  considerations are required to research optimal spatiotemporal alignment of police presence to  effectively prevent crime. 

Keywords: tracking, policing, GPS, police presence, hot spots  

# Introduction 

“If crime is so concentrated at specific places in the city, then policing and other  crime prevention resources also should be concentrated” (Weisburd, 2015)

Policing has always been at the core of police officer’s duties (see, Carrabine, 2009; Emsley,  1983, 2006; Kelling et al., 1974; Wain & Ariel, 2014). Over the centuries policing practices  have evidently changed. What started with foot patrol based “fixed-point systems”1 rapidly  developed  into  motor  patrol,  where  officers  were  assigned  to  patrol  the  same  beats  continuously. This change from a reporting intensive and strictly guided approach to large  police beat oriented strategies provided officers with a novel level of discretion and freedom  (Wain & Ariel, 2014). Being able to independently decide where, when, and how to police  while on duty still remains highly important to police officers (Cordner, 1981; Koper et al.,  2020).  Prior  research  has  shown  that  crime  exhibits  a  high  spatiotemporal  concentration  (Weisburd 2015) and that focused police action can effectively reduce reported crime (see,  Ariel et al., 2019; Braga, Turchan et al., 2019; Braga, Weisburd, & Turchan, 2019; Hutt, 2020).  While research on crime has benefitted from evidence-based analyses (e.g., Lum & Koper,  2017; Mitchell, 2017; Sherman, 2006, 2013; Telep, 2013) and a focus on microgeographic  units (e.g., Andresen et al., 2020; Ariel et al., 2019; Hutt, 2020; Li et al., 2011; Vandeviver &  Steenbeek, 2019; Weisburd et al., 2010; Weisburd, 2015), everyday policing has received  comparingly little attention. A recent survey in the U.S. has shown that less than one third of  police agencies employ hot spots units and just about half are engaged in crime analysis (Koper  et al., 2020). In general, very little is known on how evidence-based research on crime and  police is translated into the everyday practice  of policing. This  urges  research to  identify  patterns of police presence to improve patrol allocation in correspondence to local crime. 

1 “Fixed” reporting points were distributed across patrol beats for officers to report back to patrol sergeants and  to receive intel on their assigned patrol beat. This system offered additional security for officers but came with a  certain level of supervision (Wain and Ariel 2014). 

## Concentration of Crime  

Evidence-based research has shed light on the distribution of crime as well as on policing  effectiveness and has proven central assumptions of theories in Environmental Criminology  (Lum & Koper, 2017; Mitchell, 2017; Weisburd, 2015). Routine activity theory and crime  pattern theory  hypothesize  that  crime  clusters  in  specific  places  (see,  Brantingham  &  Brantingham, 1993; Cohen & Felson, 1979; Felson, 2008). The main rationale behind these  theories is that, by the accumulation of criminal opportunities in certain places, the overall  crime risk at these locations is elevated (Felson & Clarke, 1998; Nagin et al., 2015), as the  rational decision matrix of offenders gets tilted toward committing criminal acts (Cornish &  Clarke,  1986).  This  has  been  confirmed  through  various  crime  studies  that  used  microgeographic units (e.g., street segments) for analysis (e.g., Andresen et al., 2017; Ariel et  al., 2016; Ariel et al., 2019; Braga, Turchan et al., 2019; Levin et al., 2017). Crime clusters  unevenly across place and time and is not random. Weisburd (2015) has shown that across  eight cities half of all crime incidents concentrate on 2.1% to 6.0% and a quarter of all crime  on 0.4% to 1.6% of street segments. Andresen et al. (2017) provided evidence that spatial crime  concentration exhibits a temporal stability over a ten year period. Due to temporally stable  concentrations and the fact that there are often more spatial units than crimes, a proportion of  street segments naturally tends to remain “crime-free” (Bernasco & Steenbeek, 2017; Levin et  al., 2017). Unfortunately, temporal research on crime and policing at the micro level (e.g.,  street segments, street blocks) and especially so in combination with spatial analysis, has not  received much attention (Felson & Poulsen, 2003; Ratcliffe, 2010).  

Nevertheless,  contemporary  findings  have  been  well-translated  into  police  research  through the introduction of focused police actions, most importantly hot spots policing (e.g.,  Ariel et al., 2019; Braga, Turchan et al., 2019; Braga, Weisburd, & Turchan, 2019; Mitchell,  2017; Williams & Coupe, 2017). When policing is focused upon crime hot spots, crime can be 

reduced effectively. With what is regarded as the Koper curve, Koper (1995) indicated that  police officers have to be present at crime hot spots for 10 to 15 minutes to effectively realize  these crime reduction effects. Williams & Coupe (2017) have further provided evidence that  police visits to hot spots of crime are more effective when delivered longer rather than more  frequent, given that the visits stay within the temporal extents of the Koper curve. However,  these findings remain contested. For example, Mitchell (2017) arguing that more frequent visits  deter more crime than longer ones do. To date, only few studies addressed compliance issues  and controlled for actual deployed police presence, in length or frequency (Ariel et al., 2016;  Collazos et al., 2020; Schaefer et al., 2019; Williams & Coupe, 2017). For example, Ariel et  al. (2016) reported compliance rates of 53% for 15-minute patrols, while Williams & Coupe  (2017) reported compliance rates of about 67%2.  

## Policing Activity Research 

Policing has attracted widespread interdisciplinary interest outside of Criminology and  was subject to various ex-ante research (e.g., Adler et al., 2014; Chen et al., 2015; Dewinter et  al., 2020; Sacks, 2000). Research on policing has mostly been limited to considerations of  staffing demands, fast response, and measures of uncommitted officer time (see, Cordner,  1979; DeAngelo et al., 2020; Famega, 2005; Kenneth R. Chelst, 1981; McCabe, 2013). A study  by Davies and Bowers (2019) analysed general supply and demand patterns of policing and  emergency calls. To our knowledge, no research has yet focused on the spatiotemporal analysis  of police presence and crime.  

2 Compliance rates in percent refer to the discrepancy between planned and deployed police presence. This means  that when officers are to conduct 15-minute patrol, at times they are present at patrol locations for about 10 minutes  or less. 

This is mainly due to two structural challenges. First, police chiefs are faced with balancing  surveillance and accountability of police officers (Wain & Ariel, 2014). Police officers value  discretion and providing them with freedom on where and how to patrol are important aspects  of job  satisfaction  (Cordner,  1981;  Koper  et  al.,  2020;  Wain  &  Ariel,  2014).  In  contrast,  introducing performance evaluations can potentially be perceived as loss of trust in officer’s  intuition and patrol conduct. Second, highly detailed spatiotemporal analyses have just recently  been enabled through technological advances in the Global Positioning System (GPS) (Davies  &  Bowers,  2019;  Elevelt  et  al.,  2019;  Ridgeway,  2018;  Vandeviver  &  Bernasco,  2017).  Documenting patrol activity has so far been tedious and cost-intensive work. Either, police  officers used paper-based documentation to report how, when, and where they were engaging  in policing tasks (Elevelt et al., 2019) or radio-calls were manually documented by police staff  at headquarters (Ariel et al., 2019). With the introduction of easily accessible as well as lowcost AVLs (Automated Vehicle Locator) and handheld GPS trackers, police departments are  now able to track their officers and vehicles while being deployed (Davies & Bowers, 2019;  Ridgeway, 2018; Wain & Ariel, 2014). Although this technological improvement allows for  more detailed and precise data collection, researchers are now facing substantial amounts of  data to analyse. Due to very precise GPS pings3, research is often limited to look at few hotspots  or short periods of time (Davies & Bowers, 2019; Oatley et al., 2019). For example, Oatley et  al. (2019) studied bike patrol officer’s ability to map crime hotspots over a ten-week period,  which required analysis of 1.7 million GPS signals4 from smartphone devices. 

As Weisburd (2015) suggested, we expect police presence to be just as concentrated as  crime. Therefore, this paper aims to answer how much police is concentrated in space and time 

3 GPS pings describe the frequency with which GPS signals are send to the receiving unit. Pings vary due to  technology and patrol types. Foot patrols are tracked through body worn radios and send signals every 30 seconds  to five minutes. Motor patrol can carry more powerful AVLs, which often have GPS pings of under ten seconds  (Hutt et al. 2018). 

4 Oatley et al. (2019) have not reported the GPS ping of the tracking app used to collect the officer GPS data. 

and how well this concentration corresponds to local crime patterns. We will first describe the  datasets and case study before we will move to the empirical results, showing that policing  activity is highly concentrated on a small proportion of street segments and remains rather  stable across space but not time. Further, the concentration of police corresponds weakly with  local crime. We argue, that these novel findings contribute to the understanding of how policing  is carried out in everyday practice and encourage comparative research on the concentration of  police presence.  

# Data 

We use data provided by the Antwerp Police Department (APD). The APD is policing the  City  of  Antwerp  across  21  police zones.  Antwerp,  as  the  second-largest  city  in  Belgium,  stretches over 204 km² and is populated by around 530,000 people. Data were collected from  January 1st 2019 to December 31st 2019 from the APD crime database and through AVLs from  130  patrol  cars5 with  a  general  GPS  ping  of  four  seconds.  In  order  to  understand  the  spatiotemporal concentration of policing activity, we analysed 77,680,983 unique GPS signals  from patrol cars and 52,512 reported crime events. The crime data were categorized according  to APD classification and aggregated to internationally comparable categories. All crimes that  categorized  as  public  order infractions  were  dropped  from  the  dataset.  For  more  detailed  analysis, seven crime types were selected: drug crimes, theft, motor vehicle theft, burglary,  assault, vandalism, and criminal homicide. Open-source street network data was retrieved  through  the  Flemish  Roads  Register  and  encompassed  31,156  segments.  All  data  were  processed using Python 3.8 and R 3.6. The geocoordinates were map matched with a static map  matching algorithm, which was run on a high-performance computing cluster. 

5 The 130 analysed patrol cars constitute 38% of the APD vehicle fleet, including unmarked and service cars.  

# Methods 

A multi-level spatiotemporal analysis has been deployed. Descriptive statistics are used to  present the concentration of police presence and crime on the meso and micro level. Police  presence is calculated from the GPS data of patrol cars. Signals are assigned a time value  (e.g., four seconds) based on the calculated lag between two consecutive pairs of GPS pings.  We excluded all GPS signals that were recorded at the police headquarter or at police stations.  Crime levels correspond to the number of reported crimes. Concentration is operationalized as  the proportion of spatial units that receives a certain percentage of police presence in minutes  and hours or a certain percentage of crime events and as the Gini coefficient. It is important to  note, that a low proportion expresses a high concentration and vice versa6. This measurement  was adapted from Weisburd (2015).  

Spatially, the meso level consists of the APD police zones (n = 21, mean area = 9.58 km²)  and the micro level of all street segments in Antwerp7 (n = 31,147, mean length = 93.3 m),  respectively. Both levels were included, as the zones are of high importance for the police  department in terms of patrol management and street segments allow for a fine-grained spatial  analysis of crime and police. This was done to investigate how much we can learn from the  two distinct levels of analysis in regard to the spatiotemporal patterns of police presence and  crime. 

Temporally, policing activity and crime events were analysed at the month, week, day,  and hour level. In addition, linear correlation analyses (Pearson’s correlation coefficient) were  used to investigate the association between the level of police and crime and their respective 

6 Given that 10% of all streets cause 25% of all crime at time x and that 5% of all streets cause 25% of all crime  at time y, it follows that 5% is more concentrated as a lower number of streets causes 25% of crime. 

7 Open access data retrieved from Flemish Roads Register (https://www.vlaanderen.be/)  

concentration at the 25, 50, and 75% level8 of street segments. We also employed a week-rank  comparison between the street segments that received most police presence and crime events,  respectively. The rank comparison was conducted on, both, the one hundred and ten most  frequented street segments.  

# Results 

## Level of Police and Crime 

The number of daily recorded crimes peak at the first day of the year (n = 281). Overall  the daily number of crimes remains stable over the course of the year (SD = 23.1), although  slightly rising in the second half of the year. A rise during the summer months (June to August),  especially in July (n = 217), and a drop in late December are visible (Figure 1a). In contrast,  police presence per day varies substantially over the course of the year, with a decrease as the  year  progresses  (SD = 118.1).  The  beginning  of  the  year  receives  little  police  presence  compared to the rest of January (675h). During summer (June to August), police presence  remains mostly under the annual median of 769 hours. Likewise, to the trajectory of recorded  crimes, police presence experiences a drop in late December (558h) (Figure 1b).  

[INSERT FIGURE 1] 

## Spatial Concentration of Police and Crime 

Across the police zones, crime is more concentrated than police presence (Figure 2a). The  meso level concentration of crime and police presence low differences in magnitude9. On the  micro level the concentrations are reversed. On the 25% and 50% level police presence is more  concentrated  than  reported  crime,  both  across  all  street  segments  and  non-zero  street 

8 The % levels describe that, for example, 10% of street segments receive 25% of all recorded crime. The levels  for police and crime are fixed, as we are interested in the proportion of street segments that receive these levels  of police and crime and, thus, examining their concentration. 

9 As there are 21 zones, each zone presents 4.76% of all meso level places. 

segments10. The magnitude of difference varies most across non-zero street segments. Police  presence is substantially more concentrated (25:0.3%, 50: 2.3%, 75: 9.1%) than reported crime  (25: 2.0%, 50: 9.8%, 75: 28.4%) for non-zero segments. However, at the 75% concentration  level, crime is more concentrated across all street segments (Figure 2b). 

 [INSERT FIGURE 2] 

Overall, the number of non-zero segments is considerably higher for police presence. Around  81.4% (n = 25,373) of all street segments receive at least one GPS signal of police presence,  while 20% (n = 6,296) do so for crime. The maximum proportions of police presence (1.5%)  and crime (1.2%) are roughly similar (see Table 1 in Appendix). Looking at the concentration  across all segments, crime (c) experiences a higher level of inequality than police presence (p)  (Figure 3). The Gini coefficients for crime and police are 0.92 and 0.89, respectively.  

 [INSERT FIGURE 3] 

Across time, the spatial concentrations on the meso level of both, police presence and  crime, remain stable. At some months the spatial concentrations are similar but the trend of  higher crime concentration is at no point reversed (see Figure 4 in Appendix). Given that the  monthly  spatial  concentration  is  stable,  we  were  interested  in  whether  the  level  of  police  concentration is caused by the same police zones each month. A rank approach showed that  the proportion distribution across police zones remained stable over the course of months (see  Table 2 in Appendix). Only three police zones experienced rank changes, expressed by the  standard deviation of monthly ranks, higher than 2.5. That means that the same police zones  are  consistently  ranked  high  and  low.  As  the  meso  level  yields  no  further  insights  into  microlevel changes within the respective zones, we drop the meso level from here on. 

10 Non-zero street segments include all segments that received crime or police presence at least once during the  study period. 

At  the  street  segment  level,  the  spatial  concentration  experiences  changes  in  its  spatiotemporal trajectory. At the 25% and 50% level, the concentrations of police and crime  cross  each  other.  Spatial  concentration  of  police  at  the  25%  level  is  higher  than  crime  concentration during January to June and shows similar levels thereafter (see Figure 5a in  Appendix). At the 50% level this change already manifests in March. However, for the rest of  the year police presence remains less concentrated than crime. For non-zero segments, crime  is more concentrated than police presence at each month. Apparently, the trajectories diverge  considerably at the 50% and 75% level during the period of September to November (see  Figure 5b in Appendix). Over the course of the year, we see that police presence is increasingly  less concentrated as the year goes on and that crime concentration remains rather stable over  time. 

Over the course of the day, the spatial concentration of police and crime shows instability  and dissimilarities. Across all street segments, police presence is less concentrated than crime  at each hour of the day at the 50% and 75% level, except for the time between 6.00 a.m. and  6.59 a.m. At the 25% level, police presence is mostly more or equally concentrated than crime  (see  Figure  6a  in  Appendix).  At  non-zero  street  segments,  spatial  concentration  is  more  instable. During night and early morning (1 a.m. to 7 a.m.) crime is more concentrated than  police presence but remains less concentrated thereafter. A similar but weaker trend is visible  at the 50% level of concentration. At the 25% level, police presence is consistently more  concentrated than crime (see Figure 6b in Appendix). Overall, police presence experiences less  variation in its concentration over the course of the day than crime. 

## Temporal Concentration of Police and Crime 

The  temporal  concentration  of  police  presence  and  reported  crime  refers  to  the  proportionate distribution of  both  resources over  time at  the  micro  level.  Police  presence  increases steadily during the days of the week, with the lowest proportion being deployed on  Monday and peaking at Saturday, before decreasing again (Figure 7). Crimes are proportionally  fewest on Wednesdays but likewise peak during Saturdays. Thus, weekdays receive less crime  and police presence than expected under the assumption of an equal temporal distribution. The  trajectories of crime and police presence are rather similar in  that regard. Likewise, these  trajectories progress similarly over the hours of the day (Figure 8). The proportions for both  are lowest during morning hours (1 a.m. to 7 a.m.) and increase thereafter above expected equal  proportions. However, crime and police presence do not peak at the same times during the day.  Police is most deployed during the period from 9 a.m. to 2 p.m. The highest proportions of  crime are reported at 12 p.m. and at 5 p.m. While crime is at its highest proportion, police  presence steadily reduces and regresses to the level of equal proportions. Although, crime and  police follow similar trajectories they are misaligned by about three hours. 

[INSERT FIGURE 7] 

[INSERT FIGURE 8] 

## Geography of Police and Crime 

The  prior  analysis  has  shown  that  police  presence  is  more  concentrated  across  street  segment than crime, especially at the highest level of concentration. However, police presence  spreads out across the street network more extensively than crime, which is evident in the  higher number of non-zero segments. Spatially this concentration is substantially clustered  within the central part of the city (Figure 9). Crime events are more clustered around the centre 

and sparse around the edges of the city’s core. Police presence is less clustered and is recorded  from South-Eastern parts to the West of the municipality. Highest levels of concentration are  along longer segments, which appear as connecting streets within the network. Whereas crime  is highly concentrated on visually shorter segments. Further, it appears that street segments  with the highest concentration of crime do not receive the highest level of police presence and  vice versa. Through the geographic extent of police presence, it also becomes apparent that  police presence is spread out further across the street network. Thus, the North-Western part  shows many street segments, which receive low levels of police presence, compared to no  crime for the same street segments. 

[INSERT FIGURE 9] 

## Spatiotemporal Independence of Police and Crime 

In  order  to  understand  the  spatiotemporal  relationship  of  police  and  crime,  we  have  analysed the daily levels and concentration of police presence and recorded crime. We see that  high numbers of crime events lead to a statistically significant lower concentration of crime  across street segments. Although the relationship is strong only at the 50% (r = 0.610) and 75%  (r = 0.856) level. The level of crime has almost no statistical influence on the level of police  nor on police concentration. The daily levels of crime are temporally stable as there is no  relationship between day of year and level of crime (r = 0.007). A statistically significant  positive correlation is found between all levels of crime concentration (see Table 3). The level  of  police  and  concentration  of  police  show  statistically  significant  moderate  negative  relationships on all levels, apart from a weak negative relationship at the 75% level (r = -0.475).  Thus, the more police are deployed, the more concentrated police presence is in space11. The 

11 Higher levels of police are negatively associated with the proportion of segments that hold a certain percentage  of police presence, thus expressing a higher concentration. 

strongest effect from elevated police levels is seen at the 25% level (r = - 0.598). Like crime  concentration,  strong  relationships  are  found  between  all  levels  of  police  presence  concentration. However, levels of police and its concentration are not stable over time. The  daily levels of police decline significantly during the course of the year (r = -0.367). Thus, also  the police presence concentration declines gradually, most strongly at the 25% level (r = 0.577). 

The  correlation  analysis  suggests  that  crime  at  the  segment  level  has  no  statistical  relationship with the level of police nor with its concentration. Comparing the distribution of  highest  weekly  ranked  street  segments  for  police  presence  and  crime  confirms  this.  We  calculated, both, the 100 and ten highest ranked street segments for each week for police  presence, all crime, and selected crime types (assault, theft, motor vehicle theft, vandalism,  burglary, drug crimes, and criminal homicide). We report four major findings from the weekrank analysis.  

First, we see a high level of concentration of police presence and crime, for both modes of  analysis. It is important to note that this concentration does not describe the concentration of  all crimes or police presence across all segments, but the concentration within the highest  ranked street segments. Further, we report a slightly higher concentration at the 25% level for  police presence (2.38%) than for crime (2.64%) for the 100 highest (h100) ranked segments,  but find that crime (1.75%) is substantially more concentrated than police presence (3.26%)  for the ten highest (h10) ranked segments (Table 4). Second, the overlap12 of street segments  that are within both ranked sets is rather low. The overlap between all crime and police presence  lies at about 23% for h100 and 2% for h10. This supports the dissimilar spatial pattern that is  visible in the geographic maps (Figure 9). Third, certain crime types show particularly higher 

12 The overlap describes the number of segments that were included in the subsets for the whole year. It shows  whether one street segment that ranked at least once in h100 or h10 for police presence is within the set of ranked  segments for crime (and crime types). The spatiotemporal exact overlap expresses that one segments ranked the  same during the same week for both police presence and crime. 

overlap with police presence. At h100 the overlap for assault is at 29.74%, the highest reported  overlap across all crime types. At h10 motor vehicle (5.43%), drug crimes (4.35%), theft  (4.35%),  assault  (3.26%),  and  vandalism  (3.26%)  show  higher  overlap  than  all  crimes  combined. Further, we report high concentrations of crime at both h100 and h10, with theft and  drug crimes being most concentrated at the 25% level (Table 4). Fourth, the spatiotemporal  alignment of police presence and crime is found to be low. We calculated the exact overlap of  all rankings of police presence, all crime, and all analysed crime types. The spatiotemporal  exact overlap did not exceed 0.3% for any of the crime types nor all crime. 

[INSERT TABLE 4] 

# Discussion 

Policing activity shows similar overall trends in its concentration as crime activity, which  can be expressed through the Gini coefficients of 0.89 and 0.92 for police presence and crime,  respectively. However, at the micro level we have found a two-fold policing paradox. First,  police presence and crime are misaligned in space and time. High concentrations of police  presence are recorded at street segments that do not receive equally high proportions in crime,  and vice versa. Temporally, police presence is recorded along a similar trajectory across hours  of the day but appears to be ahead of crime by about three hours. Researchers have advocated  constantly for hot spots orientated policing (e.g., Ariel et al., 2016; Ariel et al., 2019; Braga,  Turchan et al., 2019; Braga, Weisburd, & Turchan, 2019; Williams & Coupe, 2017). In this  regard, police activity must be focused on the right places and the right time. We see that there  is an overall decline in the level of police deployed over the study period and over the course  of  the  day.  This  might  be  due  to  staffing  plans  or  administrative  work  that  needs  to  be 

completed before the end of patrol shifts. As routine activities have been recognized as a cause  of crime events (Cohen & Felson, 1979), police (routine) activities could be more effective  when orientated toward these13. This is not the case for our study. During summer, when  arguably outdoor activities increasingly take place, the level of police was lowest. This could  be caused by a lower number of patrol officers available during summer holidays. Further,  crime risk is elevated when many people come together in time and space and thus creating  more opportunities for crime (Felson & Clarke, 1998; Nagin et al., 2015), which is visible in  the analysed crime dataset. Arguably, times of high mobility (e.g., rush hours and commuting  times) are moments when myriad crime opportunities arise. In our data we see that the policing  activity responds to that general pattern during morning hours (6 a.m. to 10 a.m.) with a peak  at around 9 a.m. The second peak of policing occurs around 2 p.m. and activity regresses  towards the mean proportion afterwards. The pattern of police presence and crime could be  better aligned by deploying police resources proportionally to recorded crime and potentially  altering shifts in order to lower the three hours lag between police presence and crime. 

Second,  we  found  that  an  increase  in  the  amount  of  police  presence  leads  to  higher  concentration of presence at the street segments. In contrast, increases in the daily level of  crime lead to lower crime concentrations. These antithetic relationships require considerations.  We  offer three.  The  sample  size  for  the  crime  data  is  52,512,  compared  to  31,156  street  segments.  Theoretically,  recorded  crimes  cannot  be  equally  distributed  across  the  street  segments. Thus, around 31.5% of street segments (n = 9,800) would receive 50% less crime  than the remaining street segments in a theoretical equal distribution. As we know from prior  analysis (see, Weisburd 2015) and have demonstrated here, crime is highly concentrated and  not randomly distributed on the micro level. Therefore, increasing numbers of crime raise the 

13 Felson questioned the ability of police officers to act as a guardian due to the unlikeliness of their presence as  crimes occur infrequently and police beats are hard to cover in their entirety (Felson 2002) 

probability that we encounter less non-zero segments, as the number of street segments remains  constant, and thus lower the concentration. In contrast, increases in police presence lead to an  increase in its concentration. This, arguably, could be caused by their dependence to the street  network. As we have seen in Figure 9, high concentrations of police presence are recorded  isolated in the north and at longer street segments at the centre of the city. The high number of  signals in the north is due proximity to the police station, where all patrol cars are parked.  Longer street segments act as connectors in the street network and, as Davies and Bower (2019)  remarked, show a high level of “betweenness”. Police officers need to frequent these streets in  order to reach their point of destination, may it be in response to an emergency call or during  officer-initiated patrol. Therefore, these streets will inevitably show higher values of police  presence. In contrast to crime, the entire trajectory of police vehicles is mapped and not just  the event or patrol visits per se. Further, increases in the overall police presence and thus  increases in the number of deployed patrol cars and teams, might free up officers to engage in  self-initiated  patrol.  Therefore,  high  concentration  of  police  presence  at  particular  street  segments might be a result of officer discretion in regard to patrolling activity and location. 

That being said, the spatiotemporal concentration of police activity cannot be assessed on  its singular structure alone. Methodological frameworks that focus on microlevels of space and  time are needed to identify alignment between deployed police forces and reported crime.  Police departments need to investigate where and when criminal activity occurs and based on  that evidence shape their modus operandi of patrol and response. In our case we have found  that police resources concentrate more when more time is spent in the field. Without knowledge  on how this concentration is directed at places, an evaluation in terms of allocation remains  impractical. In addition, theoretical and empirical implications need to be considered when  looking at potential alignments and misalignments of police presence and crime. Prior research  has shown that deterrent effects of police slowly decay over time, known as “deterrence decay” 

(see,  Sorg  et  al.,  2013).  Following  that, a  certain  temporal  lead of  police  presence  and  a  temporal (not spatial) misalignment might be favourable. When looking at the results of our  analysis, we see that the overlap between police presence and crime is rather low (~ 23%) (see  Table 5) over the course of the study period. This means that police focus seems to react little  to spatial patterns of crime. This urges two future research paths. First, reliable measures need  to  be  established  to  adequately  assess  the  spatiotemporal  focus  of  police  on  crime.  By  comparing policing programs in regard to their successfulness in deterring crime, the measures  can be used to understand underlying spatiotemporal complexities and dependencies. Second,  overall police presence needs to be investigated on a visit basis. Given that optimal crime  deterrent  effects  are  achieved  by  visits  between  10  to  15  minutes  (Koper,  1995),  police  presence needs to be assessed on this level. By doing so, we might be able to better understand  how often police are at crime places and whether these everyday patrol visits are supporting  crime deterrence. 

 In regard to comparability, we urge researchers and police departments alike to contribute  to these novel findings of police concentration. As research has shown, focused police activity  can  deter  crime  effectively  within  high  crime  hot  spots  (e.g.,  Collazos  et  al.,  2020).  The  adaption  of  this  knowledge  into  policing  practice  can  be  evaluated  by  first  investigating  spatiotemporal concentrations of police presence and then by modelling hot spots and hot times  of crime and police against each other. Yet, this framework is not to be seen as a measure to  impose surveillance on police officers but to act as a retrospective feedback loop to improve  and validate contemporary policing practices. In some cases, police departments might focus  their policing activity to the most crime prone places but at the wrong times. In other cases,  police officers might already be present in the right places and at the right time according to  the local crime context and implementing innovative hot spots policing programs ends up being 

costly with no practical benefits. We now have the capabilities to inform police chiefs, officers,  and researchers alike on the evidence of spatiotemporal concentration of police presence.  

### Limitations 

The study needs to be viewed within its quantitative context and understood in regard to  the analysed datasets. The developed map matching algorithm used static computation to assign  each  of  the  77,680,983  signals  to  the  appropriate  street  segment.  A  static  approach  was  necessary due to computational limitations. Even though the static map matching approach is  exposed to inaccuracies of GPS signals and could potentially assign signals incorrectly to street  segments,  these  inaccuracies  are  neglectable  due  to  data  size  and  precision.  Our  analysis  focused on marked patrol cars of the APD (n = 130). These cars respond to emergency calls  and take up patrol during the remainder of their shift. Thus, we cannot give any evidence in  regard  to  policing  activity  of  all  police  units  (e.g.,  bike  patrol,  foot  patrol,  traffic  patrol,  unmarked service cars). However, our data are comprehensive for motor patrol units which  make up most of policing resources (Ariel et al., 2019). 

In this analysis police presence represents the time police patrol cars were recorded at  different street segments. Due to the fact that the GPS data is retrieved from AVLs, there is no  information regarding the number of officers present. Thus, we report police presence in patrol  time and not officer time (see, Williams & Coupe, 2017). GPS data do not show what officers  are doing and why they police certain places more (or less) than others (Wain & Ariel, 2014).  This  limitation  can  be  overcome  by  developing  and  introducing  novel  spatiotemporal  methodologies  that  combine  data  from,  both,  AVLs  and  officer  worn  radios.  These  methodologies might enable us to differentiate between times when officers are conducting  motor patrol and when they are engaging in foot patrol. As the amount of recorded police data  continuously grows, understanding qualitative aspects of police patrol and its management  becomes equally important. 

Ultimately, a reflection on the interdependence of police and crime is appropriate. We used  data about crime from an urban police department. It must be noted, that the Harbour districts  in the North-West of the municipality belong to the Federal Police jurisdiction. Thus, crimes  in these were not available for analysis. The provided data is limited to all recorded crime and  can, naturally, not include criminal activity which was not reported to or by the police. Further,  the identified misalignment of police presence and crime at the micro level could be caused by  deterrent effects. Meaning that high levels of police presence at certain street segments might  have deterred (potential) offenders from engaging in criminal activities in these particular  places. Research designs that extend the temporal focus and add detailed analysis at the micro  level of time and space will contribute to the understanding of how police forces are effectively  deployed to prevent crime in everyday practice.  

# Conclusions 

This analysis presents the first study that examined the concentration of police presence  and crime and investigated both their spatial and temporal patterns. Police concentration and  crime concentration follow similar patterns on the microlevel. By analysing over 77 million  GPS  signals  from  police  patrol cars, we  have  shown  that police concentration  and  crime  concentration  are  misaligned,  both,  temporally  and  spatially.  However,  this  temporal  misalignment  is  partly  caused  by  a  lag  of  three  hours  and  could  be  addressed  through  consolidation of officer shifts. This might indicate that police are already deterring crimes or  that more patrol officers and units are needed to address crimes at later hours of the day. Further  we found that police presence and crime are strongly concentrated within highest ranked street  segments  of  police  and  crime.  These  preliminary  results  require  more  empirical  backing  through comparative analyses of both rural and urban environments to broaden evidence-based  research on police presence. Nonetheless, our examination of police concentration implies the 

importance  of  research  into  the  spatiotemporal  dimensions  of  police  work  and  the  establishment of new data driven methodologies in police research. 

References 

Adler, N., Hakkert, A. S., Kornbluth, J., Raviv, T., & Sher, M. (2014). Location-allocation  models for traffic police patrol vehicles on an interurban network. Annals of Operations  Research, 221(1), 9–31. 

Andresen, M. A., Linning, S. J., & Malleson, N. (2017). Crime at Places and Spatial  Concentrations: Exploring the Spatial Stability of Property Crime in Vancouver BC,  2003–2013. Journal of Quantitative Criminology, 33(2), 255–275.  https://doi.org/10.1007/s10940-016-9295-8 

Andresen, M. A., Malleson, N., Steenbeek, W., Townsley, M., & Vandeviver, C. (2020).  Minimum geocoding match rates: an international study of the impact of data and areal  unit sizes. International Journal of Geographical Information Science, 34(7), 1306–1322. 

Ariel, B., Sherman, L. W., & Newton, M. (2019). Testing hot‐spots police patrols against no‐ treatment controls: Temporal and spatial deterrence effects in the London Underground  experiment. Criminology, 8(8), 1–27. https://doi.org/10.1111/1745-9125.12231 

Ariel, B., Weinborn, C., & Sherman, L. W. (2016). “Soft” policing at hot spots—do police  community support officers work? A randomized controlled trial. Journal of Experimental  Criminology, 12(3), 277–317. 

Bernasco, W., & Steenbeek, W. (2017). More Places than Crimes: Implications for  Evaluating the Law of Crime Concentration at Place. Journal of Quantitative Criminology,  33(3), 451–467. https://doi.org/10.1007/s10940-016-9324-7 

Braga, A. A., Turchan, B. S., Papachristos, A. V., & Hureau, D. M. (2019). Hot spots  policing and crime reduction: an update of an ongoing systematic review and metaanalysis. Journal of Experimental Criminology, 15(3), 289–311. 

Braga, A. A., Weisburd, D., & Turchan, B. (2019). Focused deterrence strategies effects on  crime: A systematic review. Campbell Systematic Reviews, 15(3). 

Brantingham, P. L., & Brantingham, P. J. (1993). Environment, routine and situation: Toward  a pattern theory of crime. Advances in Criminological Theory, 5(2), 259–294. 

Carrabine, E. (2009). Criminology: A sociological introduction (2. ed.). Routledge.  

Chen, H., Cheng, T., & Wise, S. (2015). Designing Daily Patrol Routes for Policing Based on  Ant Colony Algorithm. ISPRS Annals of Photogrammetry, Remote Sensing and Spatial  Information Sciences, II-4/W2, 103–109. 

Cohen, L. E., & Felson, M. (1979). Social-Change and Crime Rate Trends - Routine Activity  Approach. American Sociological Review, 44(4), 588–608. 

Collazos, D., García, E., Mejía, D., Ortega, D., & Tobón, S. (2020). Hot spots policing in a  high-crime environment: An experimental evaluation in Medellin. Journal of  Experimental Criminology, 1–34. 

Cordner, G. (1981). While on Routine Patrol: What the Police Do When They're Not Doing  Anything. Am. J. Police, 1, 94. 

Cordner, G. W. (1979). Police patrol work load studies: A review and critique. Police Stud.:  Int'l Rev. Police Dev., 2, 50. 

Cornish, D. B., & Clarke, R. V. G. (Eds.). (1986). Research in criminology. The reasoning  criminal: Rational choice perspectives on offending /  edited by Derek B. Cornish, Ronald  V. Clarke. Springer-Verlag.  

Davies, T., & Bowers, K. (2019). Patterns in the supply and demand of urban policing at the  street segment level. Policing and Society, 1–23. 

DeAngelo, G., Toger, M., & Weisburd, S. (2020). Police Response Times and Injury  Outcomes. CEPR Discussion Papers.  

Dewinter, M., Vandeviver, C., Vander Beken, T., & Witlox, F. (2020). Analysing the Police  Patrol Routing Problem: A Review. International Journal of Geo-Information,  SUBMITTED (8). 

Elevelt, A., Bernasco, W., Lugtig, P., Ruiter, S., & Toepoel, V. (2019). Where You at? Using  GPS Locations in an Electronic Time Use Diary Study to Derive Functional Locations.  Social Science Computer Review, 13, 1-18. 

Emsley, C. (1983). Policing and its Context 1750–1870. Macmillan Education UK.  https://doi.org/10.1007/978-1-349-17043-2 

Emsley, C. (Ed.). (2006). Police detectives in history, 1750 - 1950. Ashgate.  

Famega, C. N. (2005). Variation in officer downtime: a review of the research. Policing: Int'l  J. Police Strat. & Mgmt., 28, 388. 

Felson, M. (2002). Crime and everyday life. Sage.  

Felson, M. (2008). Routine activity approach. In R. Wortley & L. Mazerolle (Eds.),  Environmental Criminology and Crime Analysis (70–77). Willan. 

Felson, M., & Clarke, R. V. (1998). Opportunity makes the thief. Police Research Series,  Paper, 98, 1–36. 

Felson, M., & Poulsen, E. (2003). Simple indicators of crime by time of day. International  Journal of Forecasting, 19(4), 595–601. 

Hutt, O., Bowers, K., Johnson, S., & Davies, T. (2018). Data and evidence challenges facing  place-based policing. Policing: An International Journal of Police Strategies &  Management. 

Hutt, O. K. (2020). Understanding the deterrent effect of police patrol [, UCL (University  College London)]. EndNote Tagged Import Format. 

Kelling, G. L., Pate, T., Dieckman, D., & Brown, C. E. (1974). The Kansas City Preventive  Patrol Experiment: A Summary Report. Washington. Police Foundation.  

Kenneth R. Chelst (1981). Deployment of One- vs. Two-Officer Patrol Units: A Comparison  of Travel Times. Management Science, 27(2), 213–230. 

Koper, C. S. (1995). Just enough police presence: Reducing crime and disorderly behavior by  optimizing patrol time in crime hot spots. Justice Quarterly, 12(4), 649–672. 

Koper, C. S., Lum, C., Wu, X., & Fritz, N. (2020). Proactive policing in the United States: a  national survey. Policing: An International Journal of Police Strategies & Management. 

Levin, A., Rosenfeld, R., & Deckard, M. (2017). The law of crime concentration: An  application and recommendations for future research. Journal of Quantitative  Criminology, 33(3), 635–647. 

Li, L., Jiang, Z., Duan, N., Dong, W., Hu, K., & Sun, W. (2011, January). Police Patrol  service optimization based on the spatial pattern of hotspots. In 2011 IEEE International  Conference on Service Operations, Logistics, and Informatics (pp. 45–50). IEEE.  https://doi.org/10.1109/SOLI.2011.5986526 

Lum, C. M., & Koper, C. S. (2017). Evidence-based policing: Translating research into  practice. Oxford University Press Oxford, UK.  

McCabe, J. (2013). An analysis of police department staffing: How many officers do you  really need. ICMA Center for Public Safety Management White Paper. 

Mitchell, R. J. (2017). Frequency versus duration of police patrol visits for reducing crime in  hot spots: non-experimental findings from the Sacramento hot spots experiment.  Cambridge Journal of Evidence-Based Policing, 1(1), 22–37. 

Nagin, D. S., Solow, R. M., & Lum, C. (2015). Deterrence, criminal opportunities, and  police. Criminology, 53(1), 74–100. 

Oatley, G., Barnes, G. C., Clare, J., & Chapman, B. (2019). Crime concentration in Perth  CBD: a comparison of officer predicted hot spots, data derived hot spots and officer GPS  patrol data. Australian Journal of Forensic Sciences, 51(1), 136-140. 

Ratcliffe, J. H. (2010). Crime Mapping: Spatial and Temporal Challenges. In A. R. Piquero &  D. Weisburd (Eds.), Handbook of quantitative criminology (5–24). Springer. 

Ridgeway, G. (2018). Policing in the era of big data. 

Sacks, S. R. (2000). Optimal spatial deployment of police patrol cars. Social Science  Computer Review, 18(1), 40–55. 

Schaefer, B. P., Hughes, T., & Cameron Stelzig, W. (2019). Hot spots across the metropolis:  Evaluating hot spots directed patrol at city and suburban locations. Justice Quarterly, 1– 23. 

Sherman, L. W. (Ed.). (2006). Evidence-based crime prevention (Rev. ed.). Routledge.  

Sherman, L. W. (2013). The Rise of Evidence-Based Policing: Targeting, Testing, and  Tracking. Crime and Justice, Vol 43: Why Crime Rates Fall, and Why They Don't, 42(1),  377–451. 

Sorg, E. T., Haberman, C. P., Ratcliffe, J. H., & Groff, E. R. (2013). Foot Patrol in Violent  Crime Hot Spots: The Longitudinal Impact of Deterrence and Posttreatment Effects of  Displacement. Criminology, 51(1), 65–101. https://doi.org/10.1111/j.17459125.2012.00290.x 

Telep, C. W. (2013). Moving Forward with Evidence-Based Policing: What Should Police Be  Doing and Can We Get Them to Do It? George Mason University.  

Vandeviver, C., & Bernasco, W. (2017). The geography of crime and crime control. Applied  Geography, 86, 220–225. 

Vandeviver, C., & Steenbeek, W. (2019). The (in) stability of residential burglary patterns on  street segments: the case of Antwerp, Belgium 2005–2016. Journal of Quantitative  Criminology, 35(1), 111–133. 

Wain, N., & Ariel, B. (2014). Tracking of police patrol. Policing: A Journal of Policy and  Practice, 8(3), 274–283. 

Weisburd, D. (2015). The Law of Crime Concentration and the Criminology of Place.  Criminology, 53(2), 133–157. 

Weisburd, D., Telep, C. W., Braga, A. A., & Groff, E. R. (2010). The importance of place in  policing: Empirical evidence and policy recommendations. Brottsförebyggande rådet  (BRÅ) Stockholm.  

Williams, S., & Coupe, T. (2017). Frequency vs. length of hot spots patrols: a randomised  controlled trial. Cambridge Journal of Evidence-Based Policing, 1(1), 5–21. 

# Figures & Tables 

(a) 

(b) 

Figure 1: Daily levels of crime (a) and police presence (b) in 2019. Dotted line indicates annual median. 

(a)

60%

57.1%

50%

47.6%

Percentage of Police Zones

40%

30%

20%

10%

9.5%

14.3%

23.8%

33.3%

0%

25% of Crime 25% of Police Presence

50% of Crime 50% of Police Presence

75% of Crime 75% of Police Presence

30%

(b) 

28.4%

25%

Percentage of Street Segments

20%

15%

10%

5%

0%

9.8% 9.1%

7.4%

2.0% 2.3%

1.9% 2.0%

0.2% 0.4%

0.3%

25% of Police Presence

25% of Crime 50% of Police Presence

50% of Crime 75% of Police Presence

Segments Non-Zero Segments

5.7%

75% of Crime

Figure 2: Concentration of crime and police across police zones (a) (n = 21) and street segments (b) (n = 31,156). 

(S) Table 1: Overview of concentration of police presence and crime in proportions across all units of analysis. 

Police Zones Street Segments Non-Zero Segments

25% of Police Presence 0.143 0.002 0.003 50% of Police Presence 0.333 0.019 0.023 75% of Police Presence 0.571 0.074 0.091 At least 1 visit 1 0.814 1

Min 0.019 0 0.000 Max 0.085 0.015 0.015 Mean 0.048 0.000 0.000 SD 0.018 0.000 0.000 N 21 31,156 25,373

Police Zones Street Segments Non-Zero Segments

25% of Crime 0.095 0.004 0.020 50% of Crime 0.286 0.020 0.098 75% of Crime 0.524 0.057 0.284 At least 1 crime 1 0.202 1

Min 0.005 0 0.000 Max 0.135 0.012 0.012 Mean 0.048 0.000 0.000 SD 0.031 0.000 0.000 N 21 31,156 6,296

c

p

e

Figure 3: Lorenz curve for distribution of police presence (p) and crime (c) across street segments. e represents a  theoretical equal distribution. 

60%

50%

40%

Percentage of Police Zones

30%

20%

10%

0%

January February March April May June July August September October November December

Police Zones 25% of Police Presence Police Zones 50% of Police Presence Police Zones 75% of Police Presence Police Zones 25% of Crime Police Zones 50% of Crime Police Zones 75% of Crime

(S) Figure 4: Concentration of police presence and crime across police zones.  

Delta 2Echo 3Foxtrot 2Foxtrot 1Charlie 2Zulu 1Zulu 3Echo 3Tango 1Echo 1Delta 1

321July1081576954

532June13101576841

473May1211298165

715April12103911246

714March1110298365

614February15122117385

814January1163109257

12October89141076543

231September81114106754

261August7915841035

1181495736241November

8914122756341December

10.59.49.49.36.65.44.94.84.32.82.42Mean

11101496755311Mode

2.291.555.951.422.252.931.321.462.091.991.44SD

861359956664Range

Tango 3Echo 2Charlie 3Delta 4Charlie 1Delta 3Zulu 2Tango 2AlphaZulu 4

October12111513171916182120

September9151213181917162120

August12141311181617192120

July11131412171619182120

June9141112171619182120

May10151314161820171921

April8131415161820191721

March13121416151817202119

February1413181617109201921

January12141315171816192021

November12101315161917182021

December10131115161719182021

11.013.113.413.916.717.017.218.320.120.4Mean

12131315171817182121Mode

1.731.441.801.610.852.382.821.111.190.64SD

65753911442Range

Table 2: Results of rank test for each month on the police zone level. Ranks were assigned from lowest to highest, thus, rank1 represents (S)  the police zone with most recorded police presence and rank 21 the police zones with the least recorded policeThe names of the presence. police zone were anonymized due to confidentiality requirements.

8%

(a)

7%

6%

Percentage of Street Segments

5%

4%

3%

2%

1%

0%

January February March April May June July August September October November December

25% of Police Presence 50% of Police Presence 75% of Police Presence 25% of Crime 50% of Crime 75% of Crime

18%

16%

14%

Percentage of Street Segments

12%

10%

8%

6%

4%

2%

0%

(b)

January February March April May June July August September October November December

25% of Police Presence (Non-Zero) 50% of Police Presence (Non-Zero) 75% of Police Presence (Non-Zero) 25% of Crime (Non-Zero) 50% of Crime (Non-Zero) 75% of Crime (Non-Zero)

(S) Figure 5: Concentration of police presence and crime across street segments (a) and non-zero street segments  (b). 

(a)

8%

7%

6%

5%

4%

3%

Percentage of Street Segments

2%

1%

00:00 - 00:5901:00 - 01:5902:00 - 02:5903:00 - 03:5904:00 - 04:5905:00 - 05:5906:00 - 06:5907:00 - 07:5908:00 - 08:5909:00 - 09:5910:00 - 10:5911:00 - 11:5912:00 - 12:5913:00 - 13:5914:00 - 14:5915:00 - 15:5916:00 - 16:5917:00 - 17:5918:00 - 18:5919:00 - 19:5920:00 - 20:5921:00 - 21:5922:00 - 22:5923:00 - 23:59

0%

75% of Crime50% of Crime25% of  Crime75% of Police Presence50% of Police Presence25% of Police Presence

(b)

18%

16%

14%

12%

10%

8%

Percentage of Street Segments

6%

4%

2%

00:00 - 00:5901:00 - 01:5902:00 - 02:5903:00 - 03:5904:00 - 04:5905:00 - 05:5906:00 - 06:5907:00 - 07:5908:00 - 08:5909:00 - 09:5910:00 - 10:5911:00 - 11:5912:00 - 12:5913:00 - 13:5914:00 - 14:5915:00 - 15:5916:00 - 16:5917:00 - 17:5918:00 - 18:5919:00 - 19:5920:00 - 20:5921:00 - 21:5922:00 - 22:5923:00 - 23:59

0%

25% of Police Presence (Non-Zero)50% of Police Presence (Non-Zero)75% of Police Presence (Non-Zero)25% of Crime (Non-Zero)50% of Crime (Non-Zero)75% of Crime (Non-Zero)

: Concentration of police presence and crime across street segments (a) and nonzero street segments (b) for each hour block of the Figure 6day. Hour blocks express time slots from, for example, 2:00 a.m. to 2:59 a.m. 

0.17

0.165

Proportion of Police Presence 

0.16

0.155

0.15

0.145

0.14

0.135

0.13

Monday Tuesday Wednesday Thurday Friday Saturday Sunday

Police Presence Expected Equal Distribution Crimes

Figure 7: Proportions of police presence and crime for each day of the week. Dotted line expresses theoretical  equal proportions. 

0.07

0.06

Proportion of Police Presence 

0.05

0.04

0.03

0.02

0.01

0

00:00 00:59

01:00 01:59

02:00 02:59

03:00 03:59

04:00 04:59

05:00 05:59

06:00 06:59

07:00 07:59

08:00 08:59

09:00 09:59

10:00 10:59

11:00 11:59

12:00 12:59

13:00 13:59

14:00 14:59

15:00 15:59

16:00 16:59

17:00 17:59

18:00 18:59

19:00 19:59

20:00 20:59

21:00 21:59

22:00 22:59

23:00 23:59

Police Presence Expected Equal Distribution Crimes

Figure 8: Proportions of police presence and crime for each hour block of the day. Dotted line expresses theoretical  equal distribution.  

of cumulative proportions of crime and police presence across all street segments in Antwerp. Lighter color (yellow) indicateFigure 9: Map s  ththpercentile. Darker color (purple) indicates segments that are in the lowest 25segments that are in the top 25percentile.

Table 3: Results of Pearson’s R correlation analysis for police and crime on street segments and nonzero street segments(S) -.

(75%) NZ Days

(50%) NZ Police Concentration 

(25%) NZ Police Concentration 

(75%) Police Concentration 

(50%) Police Concentration 

(25%) Police Concentration 

Presence Police Concentration 

(75%)  NZ Level of Police 

(50%)  NZ Crime Concentration 

(25%)  NZ Crime Concentration 

(75%) Crime Concentration 

(50%) Crime Concentration 

(25%) Crime Concentration 

Number of Crimes Crime Concentration 

0.0070.0340.114*0.124*0.0340.114*0.124*0.161**0.856***0.610***0.111*0.856***0.610***0.111*1Number of Crimes

-0.066-0.0430.0340.087-0.0430.0340.087-0.0930.580***0.813***1***0.580***0.813***1

-0.030-0.0030.1010.139**-0.0030.1010.139**-0.0170.931***1***0.813***0.931***1

-0.0150.0140.119*0.148**0.0140.119*0.148**0.0621***0.931***0.58***1

-0.066-0.0430.0340.087-0.0430.0340.087-0.0930.580***0.813***1

-0.030-0.0030.1010.139**-0.0030.1010.139**-0.0170.931***1

-0.0150.0140.119*0.148**0.0140.119*0.148**0.0621

Crime Concentration 

Crime Concentration 

Crime Concentration 

Crime Concentration 

Crime Concentration 

Crime Concentration 

(75%)  NZ

(50%)  NZ

(25%)  NZ

(75%)

(50%)

(25%)

-0.367***-0.475***-0.566***-0.598***-0.475***-0.566***-0.598***1Level of Police Presence

(75%) NZ 0.452***1

(25%) NZ 0.577***0.800***0.920***1

(75%) 0.452***1***0.952***0.80***1

(50%) 0.530***0.952***1***0.920***0.952***1

(25%) 0.577***0.800***0.920***1***0.800***0.920***1

(50%) NZ 0.5300.9521

Police Concentration 

Police Concentration 

Police Concentration 

Police Concentration 

Police Concentration 

Police Concentration 

1Days

≤ .05, **p ≤ .01, ***p ≤ .001 *p 

rank test for police presence, crime, and crime types for highest 100 and highest ten ranked segments per week in Table 4: Week(S) -

occurrence nNOverlap

% of single 

Occurrences n

75% of 

Occurrences n

50% of 

Occurrences n

in Top 10 25% of 

Segments Ranked 

Number of 

occurrence nNOverlap

% of single 

Occurrences n

75% of 

Occurrences n

50% of 

Occurrences n

in Top 100 25% of 

Segments Ranked 

Number of 

530100%39875%26550%13325%530100%397575%265050%132525%//530//5300Even DistributionEven Distribution

(Crime) 2.17%63.16%29.24%7.60%1.75%210850133171

(Police Presence) 5758.76%1717.53%77.22%33.26%//92

Distribution 

Distribution 

Observed 

Observed 

Distribution (Crime) 22.97%55.01%9.53%9.53%2.64%241895155155431627

Presence) 64161.11%15414.68%565.34%252.38%//1049

Distribution (Police 

Observed 

Observed 

Theft 5.43%75.95%64.32%29.19%8.92%528123810833370

29.74%57.47%47.08%19.73%5.55%312136611194691322377Assault Motor Vehicle 

4.35%75.39%58.04%20.50%4.73%22.88%53.15%36.85%12.56%2.85%42391846515317240952660225511791Drug CrimesTheft

4.35%62.41%21.99%7.09%1.42%21.83%64.92%56.68%24.20%7.16%48831102141229115110054291271773TheftMotor Vehicle Theft

3.26%78.63%62.11%24.22%5.98%20.50%69.75%61.73%26.88%9.12%32762188521351215113910084391491633AssaultVandalism

3.26%83.13%67.71%35.90%10.36%19.07%72.44%63.67%27.45%9.34%334528114943415200128011254851651767VandalismBurlgary

2.17%83.10%69.01%38.26%11.97%17.83%65.82%50.21%17.30%3.80%235429416351426187780595205451185BurlgaryDrug Crimes

Homicide 2.17%94.84%72.77%46.48%20.19%22021559943213

4.29%94.88%73.02%46.51%20.47%4520415710044215Criminal Homicide Criminal 

