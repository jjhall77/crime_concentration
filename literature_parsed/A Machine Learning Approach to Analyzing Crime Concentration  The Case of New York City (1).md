Justice Quarterly

ISSN: 0741-8825 (Print) 1745-9109 (Online) Journal homepage: www.tandfonline.com/journals/rjqy20

A Machine Learning Approach to Analyzing Crime Concentration: The Case of New York City

Keungoui Kim & Young-An Kim

To cite this article: Keungoui Kim & Young-An Kim (2025) A Machine Learning Approach to Analyzing Crime Concentration: The Case of New York City, Justice Quarterly, 42:7, 1300-1320, DOI: 10.1080/07418825.2024.2401938

To link to this article: https://doi.org/10.1080/07418825.2024.2401938

View supplementary material

Published online: 04 Oct 2024.

Submit your article to this journal 

Article views: 369

View related articles

View Crossmark data

Citing articles: 2 View citing articles

Full Terms & Conditions of access and use can be found at https://www.tandfonline.com/action/journalInformation?journalCode=rjqy20

Justice  Quarterly 2025, VOl. 42, NO. 7, 1300–1320 https://doi.org/10.1080/07418825.2024.2401938

# A  Machine  Learning  Approach  to  Analyzing  Crime  Concentration: The  Case  of  New York  City

Keungoui  Kima   and Young-An  Kimb a

school  of applied artificial intelligence,  Handong  Global university,  Pohang, south  Korea;  bcollege  of  criminology and criminal Justice, Florida state university, tallahassee, Fl, usa

# ABSTRACT

Building  upon  prior  work,  we  propose  an  alternative  way  to  look  at the pattern of spatial crime concentration and temporal stability  of  it. We  first  identify  a  high-crime  cluster  using  the  sample  block  groups  in  New  York  City  by  employing  a  k-means  clustering  method. We then examine the temporal stability of the high-crime  cluster over time. We also longitudinally assess how our high-crime  cluster classification is associated with the actual amount of crime  while  accounting  for  the  measures  of  social  and  physical  environments. We observed that about 6–12% of total areas are identified  to  be  in  the  high-crime  cluster.  We  also  found  that  block  groups  identified  to  be  high-crime  cluster  in  one  year  are  more  likely  to  be  that  way  in  the  next  year.  We  hope  future  research  may  consider  using  data-driven  approaches  to  expand  understanding  of  spatial and temporal crime patterns.

ARTICLE  HISTORY

Received  18  December  2023

Accepted  3  September  2024

KEYWORDS

Crime;  spatial;  temporal

# Introduction

Despite the abundance of empirical evidence, some recent studies have suggested  methodological challenges when testing the law of crime concentration. Specifically,  according to Hipp (2022), these challenges include: (1) crime concentration may occur  by  random  chance;  (2)  the  law  of  crime  concentration  is  less  clear  about  what  “a  narrow bandwidth” specifically means; (3) it is largely unclear what spatial units (blocks,  street  segments,  etc.)  and  broader  areas  (city,  county,  metropolitan,  etc.)  should  be  used to measure crime concentration; (4) variability of crime concentration by different  crime  types;  and  therefore  (5)  conventional  methods  used  in  prior  work  (i.e. “5%  of  street  segments  account  for  about  50%  of  total  crime  events  in  a  city”)  are  less  applicable for generating comparative results and compiling empirical evidence across  different  types  of  crime  and  study  regions  (Chalfin  et  al.,  2021;  Hipp  &  Kim,  2017;  Levin  et  al.,  2017;  O’Brien  et  al.,  2022).  Previous  research  has  recognized  such  challenges  and  proposed  several  methodological  alternatives  to  address  them. these  alternatives include adjusting crime data historically or temporally (Hipp & Kim, 2017),  employing the Gini coefficient and Lorenz curve (O’Brien et al., 2022), assessing crime  concentration  in  areas  with  at  least  one  crime  incident  (Levin  et  al.,  2017)  or  measuring  marginal  crime  concentration  (Chalfin  et  al., 2021),  among  others.

A  large  body  of  studies  has  documented  the  pattern  of  spatial  crime  concentration  (Levin et al., 2017; Sherman & Weisburd, 1995; Weisburd, 2015; Weisburd et al., 2012).  Such a pattern has been consistently observed in many studies with varying sizes of  spatial units, from relatively larger units such as Census tracts down to micro places  including blocks or street segments. Moreover, studies have confirmed that the spatial  concentration of crime tends to be persistent over time—temporal stability of spatial  crime  concentration.  David  Weisburd  has  proposed  the  law  of  crime  concentration  that “for a defined measure of crime at a specific micro geographic unit, the concentration  of  crime  will  fall  within  a  narrow  bandwidth  of  percentages  for  a  defined  cumulative  proportion  of  crime”  (Weisburd,  2015,  p.  138).

CONTACT young-an Kim   youngan.kim@fsu.edu

 supplemental data for this article is available online at https://doi.org/10.1080/07418825.2024.2401938

© 2024 academy of criminal Justice sciences

Building upon prior work, we propose an alternative way to examine spatial pattern  of  crime  concentration  and  its  temporal  stability.  Specifically,  we  suggest  a  simple  but more inductive approach by employing a machine learning cluster analysis. using  the proposed approach, we identify a high-crime cluster1 in New York City from 2010  to 2015 and test its temporal stability. Moreover, we longitudinally examine the association  between  the  high-crime  classification  and  the  observed  number  of  crime  events, while accounting for the effects of social and physical environmental features.  in  the  subsequent  sections,  we  discuss  the  theoretical  motivations  for  our  study.  Following that, we describe our data and analytic strategies, and report the findings  from the analyses. Finally, we conclude by discussing the implications of the findings.2

# Theoretical  Motivations

## Spatial Concentration Pattern of Crime

Studies  have  confirmed  that  crime  is  not  randomly  distributed  but  rather  spatially  concentrated (Levin et al., 2017; Sherman & Weisburd, 1995; Weisburd, 2015; Weisburd  et  al.,  2012). this  pattern  of  spatial  concentration  of  crime  is  not  entirely  new  but  has been repeatedly observed since Quetelet (1994)’s work nearly 200 years ago. Prior  research has found this pattern at various levels of spatial scales from neighborhoods  such as Census tracts or block groups (Bellair & Browning, 2010; Hipp, 2007; Wo, 2014)  to  smaller  geographic  units  such  as  Census  blocks  or  street  segments  (Groff  et  al.,  2010;  Kim,  2018;  Steenbeek  &  Weisburd,  2016;  Weisburd  et  al.,  2004).  Also,  studies  have  confirmed  that  the  spatial  concentration  of  crime  is  not  limited  to  a  specific  study  area  but  has  been  observed  in  many  different  cities  across  the u.S.  as  well  as  other  regions  of  the  world  (Braga  et  al.,  2010;  Curman  et  al.,  2014; eck  et  al.,  2000;  Groff  et  al.,  2010;  Sherman  et  al.,  1989).

1 Note  that  we  use  the  term  cluster  to  refer  to  grouping  by  potential  risk  of  crime. therefore,  the  term  cluster  throughout  this  paper  refers  to  a  group  of  block  groups  that  share  the  potential  risk  of  crime,  rather  than  sharing  geographical  space.

2 the data and code (R and Stata) we used for the current study are available on our GitHub page: https:// github.com/awekim/CrimeMLClassification.

For  example,  as  one  of  the  pioneering  studies,  Sherman  et  al.  (1989)  found  that  about 50% of crimes occurred at about 3.5% of the addresses in Minneapolis in one  year.  Similarly,  Spelman  (1995)  found  that  about  10%  of  public  spaces  such  as  high  schools,  subway  stations,  public  housing  projects,  and  parks  tend  to  produce  about  50%  of  crime  calls.  Likewise,  Weisburd  et  al.  (2004)  found  that  about  half  of  total  crime events in the city of Seattle occurred at only 4.5% of street segments. Weisburd  (2015)  also  showed  that  crime  concentration  patterns  are  quite  consistent  in  both  small and large uS cities. in a more comprehensive study of 42 cities in the Southern  California  region,  Hipp  and  Kim  (2017)  found  that  there  was  an  observed  spatial  concentration  pattern  of  crime  in  the  sample  cities  as  well  as  much  variability  of  concentration  across  these  cities.

Another  important  aspect  of  crime  concentration  is  its  temporal  stability. that  is,  high-crime  areas  in  one  year  are  at  higher  risk  of  crime  later  year  as  well. indeed,  many studies have confirmed this temporal stability of spatial concentration of crime.  For  example,  Spelman  (1995)  examined  the  spatial  concentration  of  calls  for  service  in  Boston  and  found  that  the  pattern  is  stable  over  time.  Likewise,  Weisburd  et  al.  (2004)  categorized  street  segments  in  Seattle  by  employing  group-based  trajectory  models  and  found  that  street  segments  identified  as  high-crime  areas  were  stable  over  14 years.  in  another  seminal  work,  Weisburd  et  al.  (2012)  observed  a  similar  pattern  of  temporal  stability  of  crime  concentration  in  Seattle.

Although prior studies have provided important insights, recent research has highlighted  technical  challenges  for  assessing  crime  concentration  and  provided  various  modifications  (Bernasco  &  Steenbeek,  2017;  Chalfin  et  al.,  2021;  Hipp  &  Kim,  2017;  O’Brien,  2018).  Specifically,  one  methodological  concern  is  that  the  observed  crime  concentration  may  occur  simply  by  random  chance.  One  conventional  method  for  measuring  the  level  of  crime  concentration  is  sorting  data  based  on  the  observed  counts of crime and calculating the proportion of areas that produce a certain amount  of  total  crime  in  a  city.  However,  this  approach  may  not  be  entirely  accurate  as  it  does  not  rule  out  the  possibility  that  the  concentration  occurs  by  random  chance.  For a stylized example, consider an example city with 100 areas with 5 crime events  within  it.  We  may  still  observe  a  5%  crime  concentration  in  this  city  if  five  crime  events  occurred  at  each  of  five  areas,  even  if  each  crime  event  happened  to  occur  at  those  locations  by  random  chance  (Hipp  &  Kim,  2017).

Prior work has already recognized this issue and developed more methodologically  refined  techniques,  such  as  adjusting  crime  data  historically  or  temporally  (Hipp  &  Kim, 2017), using the Gini coefficient and Lorenz curve (O’Brien et al., 2022), removing  crime-free areas when measuring crime concentration (Levin et al., 2017) or comparing  the  observed  crime  data  to  the  randomly  generated  distributions  of  crime  (Chalfin  et  al.,  2021).  Despite  the  important  methodological  advancements,  the  proposed  approaches  in  prior  work  are  not  free  from  limitations.  For  instance,  the  Gini  index  is  widely  employed  to  measure  inequality  (or  segregation  vs.  concentration,  interchangeably). therefore,  its  application  to  the  context  of  spatial  crime  concentration  seems plausible. However, as Chalfin et al. (2021) pointed out, its interpretation may  not be readily intuitive, so it is difficult to understand the meaning of the Gini value  for  the  crime  concentration.  Removing  crime-free  areas,  according  to  Levin  et  al.  (2017),  seems  reasonable  from  a  statistical  point  of  view,  especially  when  dealing  with sparse crime data. Yet, a remaining question is how effectively such an approach  may  reflect  the  level  of  crime  concentration  in  real-life  if  it  artificially  removes  most  areas  with  zero  crime  in  a  study  site.  Above  all,  the  proposed  methods  in  previous  work  require  some  additional  modifications  to  the  existing  observed  crime  data  to  calibrate  the  measurement  of  crime  concentration,  which  may  introduce  potential  statistical artifacts. indeed, Chalfin et al. (2021) empirically demonstrated that removing  zero-crime  areas  may  introduce  an  upward-bias  in  the  measurement  of  crime  concentration.  instead,  Chalfin  et  al.  (2021)  suggested  a  marginal  crime  concentration  method, which directly compares the observed crime data to the randomly generated  distributions of crime to rule out the possibility of crime concentration occurring by  random  chance.

Building  upon  prior  work,  the  current  study  proposes  a  more  parsimonious  and  inductive approach that requires no additional modifications to the existing observed  data.  Specifically,  we  suggest  a  clustering  technique  of  data  mining  to  analyze  the  high  volume  of  crime  data:  A  machine-learning  approach  using  k-means  clustering.  Despite the methodological refinements and modifications, a baseline of prior studies  is  to  define  a  certain  small  proportion  of  areas  a  priori  and  measure  crime  concentration. this assumes an abrupt break point between high-crime areas and those not.  However,  this  break  point  is  not  clear;  so  at  which  point  an  area  should  be  labeled  and classified as high-crime area is largely uncertain. therefore, if we classify high-crime  areas in such a way, we may end up with those grouped with an average high number of crime events vs. the rest, with an uncertain breakpoint. instead, it is arguably  more  plausible  to  apply  a  “let-the-data-speak”  approach  by  using  an  unsupervised  learning  method,  which  allows  us  to  obtain  the  classification  of  high-crime  areas  based on the data itself. in sum, we propose an alternative way to examine the spatial  concentration  pattern  of  crime  employing  a  clustering  technique  of  data  mining  (k-means  clustering  algorithms).  Specifically,  we  first  identify  the  high-crime  cluster  using  the  sample  block  groups  in  New  York  City.  We  then  examine  the  temporal  stability  of  the  high-crime  cluster  over  time.  We  also  longitudinally  assess  how  our  high-crime  cluster  classification  is  associated  with  the  actual  amount  of  crime  while  accounting  for  the  measures  of  social  and  physical  environments.

Our study site is New York City with five boroughs within it. We chose New York City  given  that  it  allows  us  a  wide  variety  of  population  and  crime  density.  Specifically,  New York City is the largest city in the u.S. with population over 8 million according  to the 2020 u.S. Census. the city’s high population density provides a rich environment  for  studying  the  spatial  pattern  of  crime.  Moreover,  although  it  is  a  single  city,  New  York  City  includes  the  five  boroughs  (the  Bronx,  Brooklyn,  Manhattan,  Queens,  and  Staten island),  which  provides  a  considerable  variability  across  different  boroughs  in  the  region  and  gives  us  better  understanding  of  spatial  crime  locations.  Also,  New  York City has a unique history and background for a criminological study. For example,  the city experienced the largest crime decline as well as primary changes in policing  including increases in the number of police officers, adaptation of order maintenance  or zero tolerance strategies, and changes in the management of police activity, such  as  COMPStAt  during  the  1990s  and  2000s  with  a  large  population  growth,  which  makes  it  suitable  study  site  “as  a  laboratory  for  new  theories  about  the  linkage  between  crime  and  social  structure  in  urban  American  life”  (Zimring,  2006,  p.  135).  For such reasons, prior criminological research has selected New York City as a study  site for testing various criminological research questions (Hipp et al., 2020; Li & Kim,  2022;  Rosenfeld  et  al.,  2007;  Zimring,  2006).

# Data  and  Methods

Our  unit  of  analysis  is  the u.S.  Census  block  group. the u.S.  Census  block  group  is  defined  as  a  group  of  Census  blocks  that  contains  600–3000  population  within  it.  Given the extremely high population density of New York City, block groups tend to  be much smaller in terms of their geographic perimeters and areas. thus, block groups  in  New  York  City  can  be  considered  as  a “not-too-large”  or  a  meso-level  unit  for  a  study  of  spatial  crime  patterns,  while  taking  advantage  of  utilizing  the  existing  longitudinal Census data to measure sociodemographic characteristics of places.3 Although  using  a  small  geographic  unit  can  be  advantageous  for  identifying  where  crime  spatially concentrates, it may not fully capture certain social and physical aspects of  a place that are important for understanding the spatial concentration of crime (Hipp  & Boessen, 2013; Kim & Hipp, 2020). For this reason, careful theoretical considerations  should be given when selecting the spatial unit of analysis for studying spatial crime  patterns. therefore,  although  there  is  no  set  rule  of  thumb  for  the  selection  of  a  spatial unit of analysis, it is important to consider some amount of larger areas when  studying  the  spatial  patterns  of  crime.  For  these  reasons,  we  chose  the u.S.  Census  block  group  as  our  unit  of  analysis.

the  primary  goal  of  this  study  is  to  identify  the  high-crime  cluster  in  New  York  City  across  multiple  years  by  using  k-means  clustering  algorithms.  in  addition,  we   assess  the  temporal  stability  of  the  high-crime  cluster  by  examining  whether  areas  classified  in  the  high-crime  cluster  in  one  year  tend  to  remain  in  the  high-crime  cluster in the following year. to do so, we employed official crime data from 2010 to  2015  reported  by  the  New  York  Police  Department  (NYPD). this  dataset  includes  incident-level  crime  data  with  geolocation  information  (latitude  and  longitude  coordinates). We spatially joined and aggregated the crime incident points to block groups  based  on  their  locations  by  three  crime  types:  total,  violent,  and  property  crime.  Specifically, the measure of violent crime includes robberies and aggravated assaults,  while property crime includes burglaries, larcenies, and motor vehicle thefts, according  to  the uniform  Crime  Report  (uCR)  Part i  crime  types.

Figure 1 summarizes the process that we conducted in the present study. We observed  significant  variation  in  our  crime  measures  across  years. therefore,  we  standardized  our  crime  variables  by  conducting  a  min-max  normalization. this  is  a  common  way  to  normalize  a  variable  in  machine  learning  literature  as  well  as  studies  looking  at  the  spatial  concentration  of  crime  -  e.g.  a  historically  adjusted  crime  concentration  measure  and  a  temporally  adjusted  crime  concentration  measure  proposed  by  Hipp  and  Kim  (2017).  Next,  using  this  rescaled  crime  data,  we  conducted  a  clustering  analysis  of  k-means  algorithms  for  each  year’s  crime  data. the  k-means  clustering  algorithm  is  one  of  the  most  widely  employed  methods  for  effective  unsupervised  classification. it partitions samples into k numbers of clusters where each belongs to  the  cluster  with  the  nearest  mean.  Specifically,  first,  each  block  group  is  positioned  in 5-dimensional space consisting of five crime variables (robbery, aggravated assault,  burglar,  larceny,  and  motor  vehicle  theft),  and  k  cluster  centroids  are  also  randomly  positioned  in  the  same  space. then,  each  block  group  is  assigned  to  the  nearest  cluster  centroid  based  on  the  distance. that  is,  if  the  distance  between  block  group  A and cluster 1 is the closest, then it is assigned to cluster 1. the next step is updating the position of centroids by calculating the mean of all block groups within each  cluster. through this step, randomly positioned cluster centroids move to the center  of  their  respective  clusters;  and  this  process  repeats  until  the  position  of  the  cluster  centroid  stabilizes.

## High-Crime Area Classification

3 Note  that  the  average  perimeter  of  the  Census  block  groups  included  in  the  current  study  was  about  1,400  meters  (0.9 mile,  approximately).

Figure 1.  analysis plan.

this  step  is  crucial  for  defining  clusters  so  that  each  of  them  can  be  apart  (or  differentiated) from each other. From a computer algorithm’s perspective, it automatically  categorizes  block  groups  into  five-dimensional  spaces,  without  knowing  any  contextual  information  about  crime. in  other  words,  all  decisions  made  during  this  process  are  based  solely  on  data  observations,  allowing  us  to  uncover  otherwise  unobservable  tendencies.  For  instance,  this  may  result  in  a  situation  where  a  block  group is included in the high-crime cluster even though its actual crime count is not  high.  By  assigning  this  block  group  to  the  high-crime  cluster  with  others  that  share  the most similarities, we can identify cases where block groups have crime tendencies  similar to those with high crime rates. that is, this algorithm enables us to categorize  block  groups  without  introducing  predefined  biases  from  observed  crime  data  and  identify their unobserved crime-related tendency or so-called “potential risk” of crime  based  solely  on  the  given  data.

When  applying  such  an  unsupervised  classification  method,  there  are  some  important methodological issues to be considered. First, the unit of analysis should  be clearly defined in alignment with the purpose and the contextual background.  For  the  current  study,  the  unit  of  analysis  is  the u.S.  Census  block  group  and  the  purpose of applying k-means clustering is to classify block groups using the given  crime data to identify those with higher potential risk of crime. Another important  consideration  should  be  given  to  a  longitudinal  aspect  of  the  crime  data. that  is,  there  may  be  temporal  trends  that  potentially  affect  a  block  group’s  crime  condition. in other words, a block group’s crime occurrence may vary over years, which  may  lead  to  changes  in  the  clustering  process.  For  this  reason,  we  conducted  k-means clustering for each year from 2010 to 2015, respectively. Also, the number  of clusters, k, must be carefully selected as this choice can significantly impact the  final  results.  For  this  reason,  several  methods  for  selecting  the  number  of  k  have  been  proposed;  yet  it  is  still  an  empirical  question  and  a  case-sensitive  issue.  therefore,  we  ran  k-means  clustering  algorithms  with  varying  numbers  of  k  from  3  to  9  to  check  the  robustness  of  our  models.  Note  that  our  diagnostic  test  (e.g.  “elbow  test”)  suggested  that  k’s  3–5  are  the  optimal  numbers  of  clusters  for  each  year  from  2010  to  2015  (see  Figure  2).  Consequently,  we  employed  the  k-means  clustering  algorithm  with  k  values  ranging  from  3  to  5  using  the  six  annually  normalized  crime  datasets.

through  the  clustering  process,  we  identified  what  we  refer  to  as  “high-crime  cluster.” Specifically, first, we selected the top 60 block groups with the highest crime  occurrences, which is about one percent of the total number of block groups in the  study area. We chose one percent following the lead of previous studies that sorted  the data from highest to lowest based on the number of crime events and calculated  how  many  crime  events  concentrated  in  the  top  one  (or  a  few)  percent  of  all  areas  to determine the level of crime concentration. When selecting these 60 block groups,  we  used  crime  per  capita  rather  than  the  sheer  crime  counts. this  is  because  the  literature  suggests  that  areas  with  larger  and  denser  population  generally  exhibit  more  crime  than  others  (Hipp  et  al.,  2017;  Hipp  &  Roussell,  2013). then,  we  labeled  a cluster that includes the majority of top 60 block groups as the high-crime cluster.  Note  that  the  top  60  block  groups  are  highly  concentrated  in  one  specific  cluster  regardless  of  the  number  of  cluster  k.  However,  it  is  also  worth  highlighting  that  there  are  many  block  groups  that  are  in  the  high-crime  cluster  but  not  in  the  top  60. Specifically, we cross-tabulated a binary measure of the high-crime cluster (1 = block  group  is  in  the  high-crime  cluster,  0 = No)  with  another  binary  measure  indicating  if  a block group is in the top 60 or not (1 = top 60, 0 = No). We found that, for all cluster  numbers (k) and years (2010–2015), about 45–52% of the top 60 block groups were  identified to be in the high-crime cluster. Also, about 2–3% of total block groups are  identified  to  be  in  the  high-crime  cluster  but  not  in  the  top  60,  on  average. this  suggests that although the high-crime  cluster  includes  areas  with  higher  number  of  crime incidents (i.e. some of the top 60 block groups), there are block groups not in  the top 60 but with higher potential risk of crime identified by the k-means algorithm  classification.

Figure 2.  elbow test results for years 2010–2015.

## Control Variables

Another  primary  goal  of  the  current  study  is  to  examine  whether  these  block  groups included in the high-crime cluster (identified to be at higher potential risk  of  crime)  indeed  experience  higher  crime  rates  while  accounting  for  structural  characteristics  and  criminal  opportunities. to  do  so,  we  employed  a  longitudinal  regression  analysis,  which  will  be  discussed  in  detail  later. to  create  our  control  measures of structural characteristics included in the regression analyses (described  in  section  below),  we  used  the  u.S.  Census  data  for  2010  and  the  American  Community  Survey  5-year  estimates  (ACS)  for  each  year  from  2011  to  2015  based  on  the  midpoint  of  the  5-year  ACS  data  (e.g.  the  2009–2013  ACS  was  used  to  create  the  2011  measures,  etc.).  Specifically,  first,  we  constructed  a  concentrated  disadvantage index, which is a composite measure based on factor analysis including  (1)  %  at  or  below  125%  of  the  poverty  level;  (2)  %  single-parent  households;  (3)  average  household  income;  and  (4)  %  with  at  least  a  bachelor’s  degree. the  last  two  measures  were  loaded  reversely.  Second,  to  measure  residential  stability,  we  utilized  the  percent  homeowners. to  capture  racial  diversity,  we  included  a  Herfindahl index based on five racial/ethnic groups (White, African-American, Latino,  Asian, and Other races). We also included the racial composition measures including  the percent Asian, the percent African-American,  and  the  percent  Latino/Hispanic.  We also included the percent occupied housing units to account for occupancy in  the area. We included the percent persons aged 15–29 to capture the age structure  of  residents  in  the  area.  We  also  employed  the  land  use  data  (2010–2015)  from  the  NYC  Department  of  City  Planning  data  portal.  Specifically,  we  included  the  percentage  measures  for  various  land  use  types:  Residential,  Retail,  Office,  and  industrial.

## Regression Analysis

Once  we  identified  the  block  groups  in  the  high-crime  cluster,  we  created  a  binary  measure of the high-crime cluster (1 = block group is in the high-crime cluster, 0 = No),  which  is  our  main  independent  variable.  First,  to  check  the  temporal  stability  of  the  high-crime  cluster,  we  estimated  a  set  of  panel  logistic  regression  models  including  the  binary  outcome  of  high-crime  cluster  regressed  on  the  same  binary  measure  of  high-crime  cluster  in  previous  year,  while  accounting  for  the  measures  of  structural  characteristics  and  land  uses  as  explained  above. We  also  included  a  set  of  dummy  variables for each borough to capture any baseline difference across different boroughs  in  the  study  area.  A  general  form  of  this  longitudinal  model  is:

Pr x x ( | ) x , , , y e y S L B it i B i it i i i i = = + =[ ] − − 1 1 1 1

where  yit  is  the  dependent  variable  (the  binary  measure  of  high-crime  cluster  in  current year t),  yit−1 is the same binary measure of high-crime cluster but in previous  year  t  −  1  to  capture  the  temporal  stability,  S  contains  the  structural  characteristic  variables,  L  contains  the  land  use  measures,  and  B  indicates  the  borough  the  block  group  is  located  within  for  the  borough-fixed  effects.

Next, to check the association between the high-crime area classification and the  actual  amount  of  crime,  we  estimated  a  set  of  models  using  the  number  of  total,  violent,  and  property  crime  incidents  in  the  block  group  in  the  current  year  as  the  outcome variables while the binary measure of the high-crime cluster as a key independent  variable.  For  this  set  of  models,  since  our  dependent  variable  is  count  outcome,  with  a  potential  issue  of  overdispersion,  we  employed  a  negative  binomial  regression model (Osgood, 2000). that is, we estimated a series of panel longitudinal  fixed-effect negative binomial regression models including a set of dummy variables  for borough-fixed effects. We included block group population as an exposure variable,  which effectively makes the outcomes interpretable as crime rate. A general form of  the  model  is:

µi i i= =E x[ | ]y exi iB v+ ⊤

e Gammavi � � �1/� �,

xi i i i i=[ ]H S L B, , ,

where y is the number of crime events, H represents the binary measure of high-crime  cluster, S is for the structural characteristic variables, L is for the land use measures,  B is for borough-fixed effects, and α refers to the overdispersion parameter where evi follows the Gamma distribution. Next, to check the temporal effect of the high-crime  cluster  on  the  actual  amount  of  crime  one  year  later,  we  estimated  the  same  set  of  models  explained  above  but  including  the  binary  measure  of  high-crime  cluster  in  previous  year  predicting  the  level  of  crime  in  the  block  group  one  year  later. then,  a  general  form  of  this  temporally  lagged  model  is:

� � � it it i v v i it it it it y e e Gamma H S L B i i i � � � � � � � � e x x [ | ] x / , , , , � 1 1 �� �

where  yit  is  the  number  of  crime  events  in  current  year, Hit−1  represents  the  binary  measure  of  high-crime  cluster  in  previous  year,  S  is  for  the  structural  characteristic  variables in current year, L is for the land use measures in current, B is for borough-fixed  effects,  and α  refers  to  the  overdispersion  parameter  where  evi  follows  the  Gamma  distribution. the  summary  statistics  for  the  variables  included  in  the  models  are  reported  in table  1.  Note  that  for  our  k-means  clustering  analysis,  we  used  R  4.2.1.  Our  negative  binomial  regression  models  were  estimated  using  Stata  15.  We  used  ArcMap 10.7 to create the maps presented. We also calculated the Variance inflation  Factor (ViF) score to check the potential issue of multicollinearity. the maximum ViF  score  was  3.01  and  the  average  ViF  score  was  1.81,  which  is  significantly  less  than  the  commonly  used  cutoff  of  10  (Wooldridge,  2009).

We begin with the maps of the high-crime cluster by various numbers of k. Figure 3 visually  displays  the  spatial  locations  of  the  high-crime  cluster  block  groups  in  2013  by  various  numbers  of  k. the  red  areas  indicate  block  groups  identified  to  be  in  the  high-crime cluster, while the yellow are not. For all k’s, we observed that the highest  concentration of red areas is in the northern part of Manhattan and southern part of  the  Bronx,  which  encompasses  Harlem  and  the  West  Bronx. the  southern  part  of  Brooklyn also exhibits a concentration of red areas. We present the summary statistics  for block groups in the high-crime cluster vs. others in table 2 for k = 3 and in Online  Appendix tables A1 and A2 for k = 4 and 5, respectively. We observed that block groups  in the high-crime cluster are at higher level of concentrated disadvantage and higher  proportion of racial minority population (% Black and % Latino), in general. in contrast,  those not in the high-crime cluster have more homeowners and more residential land  use  but  less  office  or  retail  land  use. We  next  report  the  average  crime  rates  for  the  block groups in the high-crime cluster vs. those not, by different years. Given that the  patterns  are  similar  across  the  number  of  clusters, k,  we  chose  k = 3  to  represent  the  pattern. As shown in table 3, block groups in the high-crime cluster have substantially  higher rates of total, violent, and property crime compared to others. We also observed  that about 6–12% of total block groups are identified to be in the high-crime cluster.

# Results

Table 1.  summary statistics.

| | |Mean| |s.D.|
|---|---|---|---|---|
|crime rates|crime rates|crime rates|crime rates|crime rates|
|Violent crime| |.006| |.048|
|Property crime| |.013| |.104|
|total crime| |.018| |.140|
|crime cluster|crime cluster|crime cluster|crime cluster|crime cluster|
|High-crime cluster (1/0)|High-crime cluster (1/0)|High-crime cluster (1/0)|High-crime cluster (1/0)|High-crime cluster (1/0)|
|k = 3| |.085| |.279|
|k = 4| |.040| |.197|
|k = 5| |.030| |.171|
|structural characteristics|structural characteristics|structural characteristics|structural characteristics|structural characteristics|
|concentrated disadvantage| |−.001| |11.387|
|racial heterogeneity| |45.103| |18.027|
|% asian| |12.862| |17.499|
|% Black| |22.487| |29.273|
|% latino| |27.563| |25.250|
|% Occupied units| |91.399| |8.021|
|% Homeowners| |34.799| |27.887|
|% aged 15–29| |22.099| |9.066|
|land use|land use|land use|land use|land use|
|% residential| |78.074| |24.351|
|% Office| |4.521| |10.639|
|% retail| |4.597| |6.820|
|% industrial| |1.193| |5.134|
|s.D.: standard deviation.|s.D.: standard deviation.|s.D.: standard deviation.|s.D.: standard deviation.|s.D.: standard deviation.|
|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|


Figure 3. High-crime cluster in Nyc by various numbers of k (year 2013).

Table 2.  summary statistics for block groups in the high-crime cluster vs. others (k = 3).

| | |H-c|H-c|H-c| |Others|Others|Others|
|---|---|---|---|---|---|---|---|---|
| | |Mean| |s.D.| |Mean| |s.D.|
|crime rates|crime rates|crime rates|crime rates|crime rates|crime rates|crime rates|crime rates|crime rates|
|Violent crime| |0.03| |0.14| |0.00| |0.02|
|Property crime| |0.04| |0.25| |0.01| |0.08|
|total crime| |0.07| |0.38| |0.01| |0.10|
|structural characteristics|structural characteristics|structural characteristics|structural characteristics|structural characteristics|structural characteristics|structural characteristics|structural characteristics|structural characteristics|
|concentrated disadvantage| |6.07| |10.22| |−0.56| |11.29|
|racial heterogeneity| |47.06| |16.43| |44.94| |18.14|
|% asian| |8.04| |13.73| |13.31| |17.73|
|% Black| |36.07| |28.79| |21.23| |28.98|
|% latino| |38.49| |26.87| |26.53| |24.81|
|% Occupied units| |90.03| |8.45| |91.52| |7.96|
|% Homeowners| |18.89| |19.63| |36.29| |28.07|
|% aged 15–29| |25.16| |9.06| |21.82| |9.02|
|land use|land use|land use|land use|land use|land use|land use|land use|land use|
|% residential| |62.47| |28.33| |79.40| |23.55|
|% Office| |9.43| |15.67| |4.07| |9.93|
|% retail| |7.93| |10.20| |4.28| |6.47|
|% industrial| |2.42| |7.52| |1.08| |4.87|
|s.D.: standard deviation; H-c: high-crime cluster.|s.D.: standard deviation; H-c: high-crime cluster.|s.D.: standard deviation; H-c: high-crime cluster.|s.D.: standard deviation; H-c: high-crime cluster.|s.D.: standard deviation; H-c: high-crime cluster.|s.D.: standard deviation; H-c: high-crime cluster.|s.D.: standard deviation; H-c: high-crime cluster.|s.D.: standard deviation; H-c: high-crime cluster.|s.D.: standard deviation; H-c: high-crime cluster.|
|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|summary statistics for all years (2010–2015) were pooled together.|


Next,  we  estimated  a  set  of  panel  logistic  regression  models  for  testing  the  temporal  stability  of  the  high-crime  cluster  by  including  the  binary  outcome  of  the  high-crime  cluster  (1 = High-crime  cluster,  0 = No)  in  previous  year.  We  reported  the  odds  ratios  for  each  k’s  in  table  4.  Please  refer  to  the  row  for “High-Crime  Cluster  (one-year  lagged)”  in  table  4.  We  reported  the  full  regression  table  for  the  logistic  regression models with various k’s (3–9) in Online Appendix table A3. We also visually  display the odds ratios in Figure 4 for k’s 3–9. We found that block groups identified  to be high-crime cluster in one year are more likely to be that way in the next year  for all numbers of k. For example, the average odds ratios for k’s 3–5 was about 2.4.  that is, block groups in the high-crime cluster in one year are about 2.4 times more  likely  to  remain  as  high-crime  cluster  areas  one  year  later,  on  average. this  shows  the temporal stability of high-crime cluster, which is consistent with previous findings  for  temporal  stability  of  spatial  crime  concentration.

Table 3.  the means of crime rates for high-crime cluster and others by years (k = 3).

| | |2010|2010|2010| |2011|2011|2011| |2012|2012|2012| |2013|2013|2013| |2014|2014|2014| |2015|2015|2015|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| | |H-c| |Others| |H-c| |Others| |H-c| |Others| |H-c| |Others| |H-c| |Others| |H-c| |Others|
|Violent crime| |.056| |.010| |.028| |.011| |.044| |.010| |.052| |.011| |.052| |.010| |.033| |.010|
|Property crime| |.025| |.004| |.016| |.004| |.024| |.005| |.036| |.005| |.031| |.004| |.021| |.004|
|total crime| |.080| |.014| |.044| |.015| |.068| |.015| |.088| |.016| |.083| |.015| |.054| |.013|
|N| |396| |5818| |834| |5378| |370| |5844| |375| |5839| |431| |5781| |771| |5440|
|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|H-c: high-crime cluster.|


Table 4.  logistic regression models for high-crime cluster by various k’s (odds ratios).

| | |High-crime cluster (current year t)|High-crime cluster (current year t)|High-crime cluster (current year t)|High-crime cluster (current year t)|High-crime cluster (current year t)|
|---|---|---|---|---|---|---|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High crime cluster (one-year lagged)| |2.1149**| |3.7407**| |3.4717**|
| | |(.217)| |(.640)| |(.692)|
|concentrated disadvantage| |1.0117| |1.0289**| |1.0071|
| | |(.007)| |(.011)| |(.011)|
|racial hetero.| |1.0158**| |1.0139**| |1.0109**|
| | |(.003)| |(.004)| |(.004)|
|% asian| |1.0143**| |1.0072| |1.0104|
| | |(.004)| |(.006)| |(.007)|
|% Black| |1.0439**| |1.0388**| |1.0368**|
| | |(.003)| |(.004)| |(.005)|
|% latino| |1.0390**| |1.0302**| |1.0351**|
| | |(.003)| |(.005)| |(.005)|
|% Occupied units| |.9783**| |.9709**| |.9705**|
| | |(.005)| |(.007)| |(.007)|
|% Homeowners| |.9849**| |.9896**| |.9900**|
| | |(.003)| |(.004)| |(.004)|
|% aged 15–29| |1.0168**| |1.0259**| |1.0215**|
| | |(.005)| |(.007)| |(.007)|
|% residential| |.9867**| |.9791**| |.9813**|
| | |(.002)| |(.003)| |(.003)|
|% Office| |1.0368**| |1.0361**| |1.0364**|
| | |(.004)| |(.006)| |(.006)|
|% retail| |1.0624**| |1.0489**| |1.0540**|
| | |(.006)| |(.008)| |(.008)|
|% industrial| |1.0151| |1.0183| |1.0171|
| | |(.008)| |(.010)| |(.010)|
|intercept| |.0054**| |.0045**| |.0037**|
| | |(.003)| |(.004)| |(.003)|
|N| |30,938| |30,938| |30,938|
|**p < 0.0. standard error in parentheses below Odds ratios. Borough-fixed effects were included but not shown.|**p < 0.0. standard error in parentheses below Odds ratios. Borough-fixed effects were included but not shown.|**p < 0.0. standard error in parentheses below Odds ratios. Borough-fixed effects were included but not shown.|**p < 0.0. standard error in parentheses below Odds ratios. Borough-fixed effects were included but not shown.|**p < 0.0. standard error in parentheses below Odds ratios. Borough-fixed effects were included but not shown.|**p < 0.0. standard error in parentheses below Odds ratios. Borough-fixed effects were included but not shown.|**p < 0.0. standard error in parentheses below Odds ratios. Borough-fixed effects were included but not shown.|


Figure 4.  effect of high-crime cluster on high-crime cluster one year later.

We next estimated a set of negative binomial regression models by various numbers of k’s (3–5) to longitudinally examine the association between the actual amount  of crime in block groups and the binary measure of the high-crime cluster (table 5).  Note that all other controls were included in each model but not shown. We reported  the complete tables for the negative binomial regression models with various k’s 3–9  in  Online  Appendix tables  A4–A6.  Of  particular  interest  to  us,  we  found  that  the  coefficient  estimates  across  different  numbers  of k  exhibit  positive  associations  with  the  total  number  of  crimes  in  block  groups. that  is,  if  a  block  group  is  classified  to  be in the high-crime cluster, it is more likely to have higher number of crimes compared  to  those  not.  For  example,  block  groups  in  the  high-crime  cluster  have  about  28–34% ((exp (β)−1)×100) more total crime for k’s 3–5, on average. Next, we estimated  the  models  for  different  types  of  crime:  violent  and  property  crime  types.  Although  we  found  similar  patterns  compared  to  the  model  for  total  crime,  the  effect  magnitudes of the high-crime cluster are greater for violent crime but smaller for property  crime. For example, block groups identified to be in the high-crime cluster are about  53–59%  higher  risk  of  violent  crime  while  12–20%  higher  risk  of  property  crime  for  k’s  3–5.

Table 5. Negative binomial regression models for various types of crime.

| | |Dependent variable: total crime|Dependent variable: total crime|Dependent variable: total crime|Dependent variable: total crime|Dependent variable: total crime|
|---|---|---|---|---|---|---|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High crime cluster (1/0)| |.2567**| |.2956**| |.2486**|
| | |(.007)| |(.009)| |(.010)|
|intercept| |−2.8048**| |−2.8188**| |−2.8429**|
| | |(.062)| |(.062)| |(.063)|
|N| |37,138| |37,138| |37,138|
| | |Dependent variable: violent crime|Dependent variable: violent crime|Dependent variable: violent crime|Dependent variable: violent crime|Dependent variable: violent crime|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High crime cluster (1/0)| |.4624**| |.4576**| |.4242**|
| | |(.009)| |(.011)| |(.012)|
|intercept| |−3.5415**| |−3.6444**| |−3.6746**|
| | |(.087)| |(.088)| |(.088)|
|N| |37,138| |37,138| |37,138|
| | |Dependent variable: property crime|Dependent variable: property crime|Dependent variable: property crime|Dependent variable: property crime|Dependent variable: property crime|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High crime cluster (1/0)| |.1111**| |.1782**| |.1248**|
| | |(.009)| |(.011)| |(.012)|
|intercept| |−2.9320**| |−2.9330**| |−2.9314**|
| | |(.069)| |(.069)| |(.069)|
|N| |37,138| |37,138| |37,138|
|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included but not shown.|


Next,  to  check  the  temporal  effect,  we  estimated  a  set  of  models  for  the  effects  of  high-crime  cluster  in  previous  year  on  the  actual  amount  of  crime  one  year  later  (table 6). We reported the full regression tables for the negative binomial regression  models  with  one-year  lagged  high-crime  cluster  in  Online  Appendix tables  A7–A9.  We  found  similar  patterns  compared  to  the  results  reported  in  table  5  but  weaker  effect magnitudes. For example, we observed that high-crime-cluster block groups in  previous  year  tend  to  have  about  3–5%  more  total  crime  one  year  later  as  well  as  about  6–8  and  5–9%  more  violent  and  property  crime  one  year  later,  respectively.

We briefly describe our findings of the control measures for the structural characteristics and physical environment in table 3. First, we observed that the concentrated  disadvantage  index  shows  positive  association  for  all  models  with  various  numbers  of  k,  but  they  are  not  statistically  significant,  except  for  the  model  with  k = 4.  Our  measure  of  racial  heterogeneity  exhibits  a  positive  relationship  with  the  probability  of an area being identified to be in a high-crime cluster for the models of k numbers  from  3  to  5. We  found  robust  positive  effects  of  the  percent  Black  and  the  percent  Latino in block groups, respectively. in contrast, our measures of residential stability,  the  percent  homeowners,  and  the  measure  of  occupancy  (the  percent  occupied  housing units) show negative associations, which is consistent with previous findings.  We  observed  that  higher  proportion  of  non-residential  land  uses  (retail,  industrial,  and office, respectively) are positively associated with high-crime cluster whereas the  proportion  of  residential  land  use  is  negatively  associated  with,  which  is  consistent  with  previous  studies.

Table 6. Models for various types of crime (one-year lagged high-crime cluster).

| | |Dependent variable: total crime (t)|Dependent variable: total crime (t)|Dependent variable: total crime (t)|Dependent variable: total crime (t)|Dependent variable: total crime (t)|
|---|---|---|---|---|---|---|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High-crime cluster (t − 1)| |.0490**| |.0496**| |.0391**|
| | |(.008)| |(.010)| |(.011)|
|intercept| |−2.8324**| |−2.8275**| |−2.8242**|
| | |(.070)| |(.070)| |(.070)|
|N| |30,938| |30,938| |30,938|
| | |Dependent variable: violent crime (t)|Dependent variable: violent crime (t)|Dependent variable: violent crime (t)|Dependent variable: violent crime (t)|Dependent variable: violent crime (t)|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High-crime cluster (t − 1)| |.0588**| |.0739**| |.0669**|
| | |(.011)| |(.013)| |(.015)|
|intercept| |−3.7556**| |−3.7501**| |−3.7473**|
| | |(.098)| |(.098)| |(.098)|
|N| |30,938| |30,938| |30,938|
| | |Dependent variable: property crime (t)|Dependent variable: property crime (t)|Dependent variable: property crime (t)|Dependent variable: property crime (t)|Dependent variable: property crime (t)|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High-crime cluster (t − 1)| |.0833**| |.0729**| |.0563**|
| | |(.010)| |(.012)| |(.014)|
|intercept| |−2.9416**| |−2.9325**| |−2.9264**|
| | |(.077)| |(.078)| |(.078)|
|N| |30,938| |30,938| |30,938|
|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|


## Robustness Check

to  further  check  the  robustness  of  the  models  reported  in tables  5  and  6,  we  estimated the same models but removing the top 60 high crime block groups from the  models (table 7 and Online Appendix tables A10–A12). the reason behind this robustness check is that one might suspect that the positive association between the binary  measure  of  the  high-crime  cluster  and  our  outcomes  is  possibly  due  to  the  endogenous nature between the two as the high-crime cluster includes the majority of top  60 high crime block groups. We report the models without top 60 high crime block  groups in table 7. the results confirm the robustness of our models that block groups  in  the  high-crime  cluster  have  about  30–36%  more  total  crime  for  k’s  3–5,  even  without  the  top  60  high  crime  block  groups  in  the  models.  Likewise,  block  groups  identified to be high-crime cluster show about 52–58 and 12–20% more violent and  property  crime,  respectively.

We  have  further  checked  the  robustness  of  our  regression  results.  One  concern  may be that the number of block groups classified as high-crime cluster, and the rest  are  uneven.  As  mentioned  above,  the  classification  of  the  high-crime  block  groups  relies on an unsupervised algorithm, which does not consider the proportion of classes  but  rather  focuses  on  the  differences  among  clusters. this  becomes  worse  with  the  case of greater number of k as the number of block groups listed in the high-crime  cluster  gets  smaller.  Also,  there  is  a  possibility  that  our  results  may  be  driven  by  unobserved structural characteristics rather than the high-crime classification, although  we explicitly accounted for this by including a set of measures of social and physical  environmental features in the regression models. that is, even if our clustering method  only  considers  the  crime  level  in  block  groups,  it  is  still  possible  that  block  groups  with greater number of crime events are with higher or lower level of certain unobserved  structural  characteristics.

Table  7. Negative  binomial  regression  models  for  various  types  of  crime  without  top  60  high  crime block groups.

| | |Dependent variable: total crime|Dependent variable: total crime|Dependent variable: total crime|Dependent variable: total crime|Dependent variable: total crime|
|---|---|---|---|---|---|---|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High crime cluster (1/0)| |.2638**| |.3052**| |.2652**|
| | |(.007)| |(.009)| |(.010)|
|intercept| |−2.7713**| |−2.7903**| |−2.8120**|
| | |(.063)| |(.064)| |(.064)|
|N| |36,766| |36,766| |36,766|
| | |Dependent variable: violent crime|Dependent variable: violent crime|Dependent variable: violent crime|Dependent variable: violent crime|Dependent variable: violent crime|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High crime cluster (1/0)| |.4561**| |.4472**| |.4176**|
| | |(.009)| |(.011)| |(.013)|
|intercept| |−3.5658**| |−3.6780**| |−3.7089**|
| | |(.089)| |(.090)| |(.090)|
|N| |36,766| |36,766| |36,766|
| | |Dependent variable: property crime|Dependent variable: property crime|Dependent variable: property crime|Dependent variable: property crime|Dependent variable: property crime|
| | |(1)| |(2)| |(3)|
| | |k = 3| |k = 4| |k = 5|
|High crime cluster (1/0)| |.1127**| |.1837**| |.1311**|
| | |(.009)| |(.012)| |(.013)|
|intercept| |−2.9110**| |−2.9096**| |−2.9084**|
| | |(.071)| |(.071)| |(.071)|
|N| |36,766| |36,766| |36,766|
|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|**p < 0.01. standard  error  in  parentheses  below  coefficients.  Borough-fixed  effects  were  included  but  not  shown.  all other controls were included in each model, respectively, but not shown.|


in light of these considerations, we applied the Random Forest Nearest Neighbor  (RFNN)  algorithm  to  correct  the  selection  bias  between  the  high-crime  and  the  remaining  block  groups. the  RFNN  algorithm  utilizes  propensity  score  matching  (PSM)  combined  with  a  random  forest  algorithm  to  estimate  the  likelihood  of  a  block  group  being  in  the  treatment  group.  By  employing  the  RFNN  approach,  we  successfully matched the distribution of potential confounding variables across both  groups. Some previous studies have recognized that this approach is superior compared to traditional methods (Wager & Athey, 2018). using this balanced subsample  that  accounts  for  classification  frequency  and  socioeconomic  characteristics,  we  conducted additional regression analysis. As shown, the findings in Online Appendix  tables  A13–A15  are  not  substantially  different  from  our  main  findings  reported  in  tables  5  and  6. this  suggests  that  our  results  are  robust  even  with  a  more  conservative approach where the size and socioeconomic propensities are more explicitly  controlled.

# Discussion

A  burgeoning  body  of  studies  has  examined  the  spatial  concentration  pattern  of  crime. One common way to measure the level of crime concentration is by calculating  the  proportion  of  total  crime  events  produced  by  a  small  number  or  proportion  of  spatial  units  within  the  study  area  (i.e.  50%  of  total  crime  produced  in  1%  of  all  blocks, etc.). However, recent studies have highlighted some measurement challenges  in assessing crime concentration. these studies have developed and introduced more  methodologically advanced techniques to overcome such challenges. in this respect,  we  proposed  an  alternative  method  to  examine  crime  concentration  and  estimated  a  set  of  models  to  check  the  validity  of  our  approach.  Our  results  indicate  that  the  identified  high-crime  cluster  was  positively  associated  with  the  observed  amount  of  crime, both in the current year and the following year, even after accounting for the  effects  of  sociodemographic  and  the  physical  environment.  Consistent  with  prior  studies,  we  observed  the  spatial  and  temporal  stability  of  high-crime  clusters  that  block  groups  classified  into  the  high-crime  cluster  in  one  year  are  more  likely  to  remain  in  the  high-crime  cluster  the  following  year.

Although  the  proposed  approach  in  the  current  study  provides  methodological  insights, we do not necessarily argue that our approach is superior to others employed  in previous studies; or the field should immediately switch to the approach we suggested. instead, we attempted to apply a machine learning approach and empirically  examine  if  such  data  driven  way  of  examining  crime  concentration  may  provide  potential  benefits  and  intellectual  insights  so  that  the  field  may  pay  attention  to  a  relatively  novel  approach  when  measuring  the  spatial  crime  concentration.  As  more  social  scientists  turn  to  employing  methods  based  on  computational  science  (e.g.  machine learning or deep learning), future criminological research may take advantage  of  using  such  a  computational  data-driven  approach  when  studying  the  spatial  and  temporal  crime  patterns.

One important finding was that there is a strong temporal stability of the high-crime  cluster  across  different  years. this  is  consistent  with  the  insights  provided  by  prior  work. Scholars are aware of the importance of such temporal stability, and empirical  research  has  paid  attention  to  this  when  assessing  spatial  patterns  of  crime.  Our  results  align  with  prior  work  that  the  high-crime  classification  remains  stable  over  time,  and  it  is  associated  with  higher  amount  of  crime  in  both  the  current  and  the  following year. A natural follow up would be to study longer temporal trajectories of  the high-crime cluster with additional data covering an extended period of time. Yet  another  recommendation  for  future  research  is  to  look  at  temporal  instability  or  variability  using  more  fine-grained  definitions  of  temporal  scales,  such  as  weeks  or  months  throughout  the  calendar  year  (Deckard  &  Schnell, 2023;  Kim  & Wo,  2021).

Another  takeaway  can  be  drawn  from  the  nature  of  the  employed  method  itself.  One  advantage  of  such  a  data  mining  approach  is  that  it  simultaneously  identifies  areas  already  with  the  high  amount  of  crime  as  well  as  those  not  necessarily  with  the high number of crime events yet, but with potential risk of “becoming” high-crime  areas.  Our  findings  from  the  robustness  check  confirmed  that  even  after  removing  the top 60 block groups with high amount of crime, those classified into the high-crime  cluster tend to be at higher risk. that is, some block groups do not necessarily have  high enough number of crime incidents based on the observed data, but they somehow have close similarity with the existing high-crime areas, which indicates “potential  risk” to becoming high-crime areas. this suggests policy implications for crime analysis  and  predictive  policing.  A  conventional  tactic  of  hotspot  policing  is  to  concentrate  policing efforts and resources to small number of areas identified as high-crime areas  based  exclusively  on  the  observed  crime  counts. Yet,  the  approach  introduced  here  may enable us to identify areas with potentials to becoming high-crime areas as they  were  clustered  together  with  the  existing  high-crime  areas.  Although  they  do  not  necessarily  exhibit  high-enough  number  of  crime  incidents  for  now,  they  somehow  have similar characteristics with those with high crime counts, so that it may require  additional  attention  to  keep  an  eye  on  for  surveillance.

Another  policy  implication  based  on  the  analysis  lies  in  its  ability  to  examine  the  spatial  crime  patterns  congruent  with  traditional  theories.  Our  analysis  demonstrated  that  a  data-driven  approach  suggested  in  the  current  study  may  have  important  implications for developing evidence-based crime policy with emphasis on the effects  of the demographic structure of neighborhoods (based on social disorganization theory)  and land uses (based on theories of criminal opportunities) on spatial crime patterns,  especially for crime analysts at police  departments.  As taylor et al. (2015) stated “the  use  of  structural  predictor  variables  will  enhance  analysts’  abilities  to  inform  police  executives  about  which  areas  in  their  jurisdiction  are  most  likely  to  foster  criminal  activity  in  the  medium  to  long-term  future”  (pp.  651–652).  Finally,  we  recognize  that  there is still room for more careful examination of the variations within the high-crime  cluster. the  main  focus  of  the  current  study  is  more  on  high-crime  cluster vs.  others  and  their  temporal  stability;  rather  than  the  variability  of  characteristics  of  the  areas  within  the  high-crime  cluster. that  is,  it  would  be  interesting  to  see  how  the  areas  with  relatively  lower  crime  events  but  still  identified  to  be  in  the  high-crime  cluster  are similar/different in terms of social and physical environmental characteristics, compared  to  those  with  higher  crime  incidents  in  the  high-crime  cluster.

in spite of the contributions, we acknowledge some limitations to this study. First,  although the suggested approach in the current study provides an important methodological  insight  and  allows  researchers  to  identify  the  extent  to  which  crime  is  spatially concentrated, direct policy implications still remain less clear. that is, although  we provide some policy implications for crime analysis above, what specific resources  should be utilized and deployed or to what extent they can be useful to reduce crime  in  high-crime  cluster  areas  is  still  unclear.  Although  we  acknowledge  that  this  is  an  important  question  for  a  study  of  crime  and  place,  it  is  also  somewhat  beyond  the  main  scope  of  the  current  study.  Yet,  future  research  will  want  to  delve  into  such  questions  by  conjoining  the  proposed  methodological  insights  with  an  examination  of  direct  policy  effectiveness  of  an  application  of  a  machine  learning  or  data  driven  approach. Next, although providing important insights for measuring and understanding the level of crime, we were unable to pinpoint the specific mechanisms how they  tend to have more crime than others. Although it seems somewhat beyond the scope  of  the  study,  but  it  is  certainly  encouraged  for  future  research  to  examine.  Finally,  our findings may not be generalizable to other regional contexts given that we studied  a  single  area  (New  York  City).  Future  studies  may  want  to  employ  the  proposed  approach and examine if our findings are generalizable to other cities across the u.S.  as  well  as  other  regions  of  the  world.

in  conclusion,  we  proposed  a  machine  learning  and  data  driven  approach  as  an  alternative to examine spatial patterns of crime in NYC block groups. We highlighted  our  theoretical  motivations  based  on  the  existing  literature  and  provided  detailed  explanations  for  the  method  employed.  We  then  empirically  demonstrated  the  high-crime cluster identification and examined the temporal stability of the high-crime  cluster  throughout  the  study  years  while  accounting  for  the  effects  of  the  measures  of  structural  characteristics  and  physical  environmental  features  in  block  groups. We  hope  future  research  may  consider  using  machine-learning  data-driven  approaches  to  expand  understanding  of  spatial  and  temporal  crime  patterns.

# Acknowledgements

this  research  was  supported  by  No.  202400500001  of  Handong  Global  university  Research  Grants.

# Disclosure  Statement

No potential conflict of interest was reported by  the  author(s).

# ORCID

Keungoui Kim  http://orcid.org/0000-0002-0839-8813

Young-An Kim  http://orcid.org/0000-0003-0244-4070

# References

Bellair,  P. e.,  &  Browning,  C.  R.  (2010).  Contemporary  disorganization  research:  An  assessment  and further test of the systemic model of neighborhood crime. Journal of Research in Crime  and Delinquency,  47(4),  496–521.  https://doi.org/10.1177/0022427810375578

Bernasco, W., & Steenbeek, W. (2017). More places than crimes: implications for evaluating the  law  of  crime  concentration  at  place.  Journal  of  Quantitative  Criminology,  33(3),  451–467.  https://doi.org/10.1007/s10940-016-9324-7

Braga, A., Papachristos, A., & Hureau, D. (2010). the concentration and stability of gun violence  at micro places in Boston, 1980–2008. Journal of Quantitative Criminology, 26(1), 33–53. https:// doi.org/10.1007/s10940-009-9082-x

Chalfin,  A.,  Kaplan,  J.,  &  Cuellar,  M.  (2021).  Measuring  marginal  crime  concentration:  A  new  solution  to  an  old  problem.  Journal  of  Research  in  Crime  and  Delinquency,  58(4),  467–504.  https://doi.org/10.1177/0022427820984213

Curman, A. N., Andresen, M., & Brantingham, P. (2014). Crime and place: A longitudinal examination of street segment patterns in Vancouver, BC. Journal of Quantitative Criminology, 31(1),  127–147.  https://doi.org/10.1007/s10940-014-9228-3

Deckard, M., & Schnell, C. (2023). the temporal (in)stability of violent crime hot spots between  months and the modifiable temporal unit problem. Crime & Delinquency, 69(6–7), 1312–1335.  https://doi.org/10.1177/00111287221128483

eck, J., Gersh, J., & taylor, C. (2000). Finding crime hot spots through repeat address mapping.  in  J.  Mollenkopf  &  t.  Ross  (eds.),  Analyzing  crime  patterns:  Frontiers  of  practice.  Sage  Publications.

Groff, e., Weisburd, D., & Yang, S. M. (2010). is it important to examine crime trends at a local  “micro” level?: A longitudinal analysis of street to street variability in crime trajectories. Journal  of Quantitative Criminology,  26(1),  7–32.  https://doi.org/10.1007/s10940-009-9081-y

Hipp, J. (2007). Block, tract, and levels of aggregation: Neighborhood structure and crime and  disorder  as  a  case  in  point.  American  Sociological  Review,  72(5),  659–680.  https://doi. org/10.1177/000312240707200501

Hipp,  J.  R.  (2022).  The  spatial  scale  of  crime:  How  physical  and  social  distance  drive  the  spatial  location of crime.  Routledge.

Hipp,  J.  R.,  &  Boessen,  A.  (2013). egohoods  as  waves  washing  across  the  city:  A  new  measure  of  neighborhoods.  Criminology,  51(2),  287–327.  https://doi.org/10.1111/1745-9125.12006

Hipp,  J.  R.,  &  Kim,  Y.-A.  (2017).  Measuring  crime  concentration  across  cities  of  varying  sizes:  Complications  based  on  the  spatial  and  temporal  scale  employed.  Journal  of  Quantitative  Criminology,  33(3),  595–632.  https://doi.org/10.1007/s10940-016-9328-3

Hipp,  J.  R.,  &  Roussell,  A.  (2013).  Micro-  and  macro-environment  population  and  the  consequences  for  crime  rates.  Social Forces,  92(2),  563–595.  https://doi.org/10.1093/sf/sot091

Hipp,  J.  R.,  Kim,  Y.-A.,  &  Wo,  J.  C.  (2020).  Micro-scale,  meso-scale,  macro-scale,  and  temporal  scale: Comparing the relative importance for robbery risk in New York City. Justice Quarterly,  38(5),  1–25.  https://doi.org/10.1080/07418825.2020.1730423

Hipp,  J.  R., Wo,  J.  C.,  &  Kim, Y.-A.  (2017).  Studying  neighborhood  crime  across  different  macro  spatial scales: the case of robbery in 4 cities. Social Science Research, 68, 15–29. https://doi. org/10.1016/j.ssresearch.2017.08.007

Kim, Y.-A. (2018). examining the relationship between the structural characteristics of place and  crime by imputing census block data in street segments: is the pain worth the gain? Journal  of Quantitative Criminology,  34(1),  67–110.  https://doi.org/10.1007/s10940-016-9323-8

Kim, Y.-A., & Hipp, J. R. (2020). Street egohood: An alternative perspective of measuring neighborhood  and  spatial  patterns  of  crime.  Journal  of  Quantitative  Criminology,  36(1),  29–66.  https://doi.org/10.1007/s10940-019-09410-3

Kim,  Y.-A.,  &  Wo,  J.  C.  (2021).  Seasonality  and  crime  in  Orlando  neighbourhoods.  The  British  Journal of Criminology,  62(1),  124–144.  https://doi.org/10.1093/bjc/azab048

Levin,  A.,  Rosenfeld,  R.,  &  Deckard,  M.  (2017). the  law  of  crime  concentration:  An  application  and recommendations for future research. Journal of Quantitative Criminology, 33(3), 635–647.  https://doi.org/10.1007/s10940-016-9332-7

Li, N., & Kim, Y.-A. (2022). Subway station and neighborhood crime: An egohood analysis using  subway  ridership  and  crime  data  in  New York  City. Crime & Delinquency,  69(11),  2303–2328.  https://doi.org/10.1177/00111287221114803

O’Brien,  D. t.  (2018). the  action  is  everywhere,  but  greater  at  more  localized  spatial  scales:  Comparing concentrations of crime across addresses, streets, and neighborhoods. Journal of  Research in Crime and Delinquency, 56(3), 339–377. https://doi.org/10.1177/0022427818806040

O’Brien,  D. t.,  Ciomek,  A.,  & tucker,  R.  (2022).  How  and  why  is  crime  more  concentrated  in  some  neighborhoods  than  others?:  A  new  dimension  to  community  crime.  Journal  of  Quantitative Criminology,  38(2),  295–321.  https://doi.org/10.1007/s10940-021-09495-9

Osgood,  D.  W.  (2000).  Poisson-based  regression  analysis  of  aggregate  crime  rate.  Journal  of  Quantitative Criminology,  16(1),  21–43.  https://doi.org/10.1023/A:1007521427059

Quetelet, L.-A.-J. (1994). A treatise on man and the development of his faculties. Obesity Research,  2(1),  72–85.  https://doi.org/10.1002/j.1550-8528.1994.tb00047.x

Rosenfeld,  R.,  Fornango,  R.,  &  Rengifo,  A.  F.  (2007). the  impact  of  order-maintenance  policing  on New York City homicide and robbery rates: 1988–2001. Criminology, 45(2), 355–384. https:// doi.org/10.1111/j.1745-9125.2007.00081.x

Sherman,  L.,  &  Weisburd,  D.  (1995).  General  deterrent  effects  of  police  patrol  in  crime  “hot  spots”:  A  randomized,  controlled  trial.  Justice  Quarterly,  12(4),  625–648.  https://doi. org/10.1080/07418829500096221

Sherman,  L.,  Gartin,  P.,  &  Buerger,  M.  (1989).  Hot  spots  of  predatory  crime:  Routine  activities  and the criminology of place. Criminology, 27(1), 27–56. https://doi.org/10.1111/j.1745-9125.1989. tb00862.x

Spelman, W.  (1995).  Criminal  careers  of  public  places. in  J. e. eck  &  D. Weisburd  (eds.),  Crime  and place.  Criminal  Justice  Press.

Steenbeek,  W.,  &  Weisburd,  D.  (2016).  Where  the  action  is  in  crime?  An  examination  of  variability of crime across different spatial units in the Hague, 2001–2009. Journal of Quantitative  Criminology,  32(3),  449–469.  https://doi.org/10.1007/s10940-015-9276-3

taylor,  R.  B.,  Ratcliffe,  J.  H.,  &  Perenzin,  A.  (2015).  Can  we  predict  long-term  community  crime  problems? the  estimation  of  ecological  continuity  to  model  risk  heterogeneity.  Journal  of  Research in Crime and Delinquency, 52(5), 635–657. https://doi.org/10.1177/0022427815586062

Wager,  S.,  &  Athey,  S.  (2018).  estimation  and  inference  of  heterogeneous  treatment  effects  using  random  forests.  Journal  of  the  American  Statistical  Association,  113(523),  1228–1242.  https://doi.org/10.1080/01621459.2017.1319839

Weisburd, D. (2015). the law of crime concentration and the criminology of place. Criminology,  53(2),  133–157.  https://doi.org/10.1111/1745-9125.12070

Weisburd, D., Bushway, S., Lum, C., & Yang, S.-M. (2004). trajectories of crime at places: A longitudinal study of street segments in the city of Seattle. Criminology, 42(2), 283–322. https:// doi.org/10.1111/j.1745-9125.2004.tb00521.x

Weisburd, D., Groff, e. R., & Yang, S.-M. (2012). The criminology of place: Street segments and our  understanding of the crime problem.  Oxford university  Press.

Wo,  J.  C.  (2014).  Community  context  of  crime:  A  longitudinal  examination  of  the  effects  of  local  institutions  on  neighborhood  crime.  Crime  &  Delinquency,  62(10),  1286–1312.  https:// doi.org/10.1177/0011128714542501

Wooldridge, J. M. (2009). Introductory econometrics: A modern approach (4th ed.). South-Western  Cengage  Learning.

Zimring, F. e. (2006). The great American crime decline. Oxford Academic. https://doi.org/10.1093/ acprof:oso/9780195181159.001.0001

