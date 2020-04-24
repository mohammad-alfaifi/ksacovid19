![](https://github.com/mohammad-alfaifi/ksacovid19/blob/master/man/logo.png)
# ksacovid19

## Overview

ksacovid19 is an R package which shows COVID-19 cases in Saudi Arabia on country and city level with few additional stats functions. Further, it comes with a dataset for saudi cities shapefiles. 

## Installation
```
# development version for now
devtools::install_github("mohammad-alfaifi/ksacovid19")
```
## Usage

```
country_cases()

   date                confirmed deaths recovered
   <dttm>                  <int>  <int>     <int>
 1 2020-03-02 00:00:00         1      0         0
 2 2020-03-04 00:00:00         1      0         0
 3 2020-03-05 00:00:00         3      0         0
 4 2020-03-07 00:00:00         2      0         0
 5 2020-03-08 00:00:00         4      0         0
 6 2020-03-09 00:00:00         4      0         0
 7 2020-03-10 00:00:00         5      0         0
 8 2020-03-11 00:00:00         1      0         0
 9 2020-03-12 00:00:00        24      0         1
10 2020-03-13 00:00:00        41      0         0
```

```
cities_first()

   date                city_name   city_eng      confirmed deaths recovered active
   <dttm>              <chr>       <chr>             <int>  <int>     <int>  <int>
 1 2020-03-02 00:00:00 القطيف      Qatif                 1      0         0      1
 2 2020-03-09 00:00:00 الرياض      Riyadh                1      0         0      1
 3 2020-03-10 00:00:00 الدمام      Dammam                4      0         0      4
 4 2020-03-10 00:00:00 مكة المكرمة Mecca                 1      0         0      1
 5 2020-03-11 00:00:00 جدة         Jeddah                1      0         0      1
 6 2020-03-13 00:00:00 الهفوف‎      Hofuf                 1      0         0      1
 7 2020-03-15 00:00:00 الظهران     Dhahran               3      0         0      3
 8 2020-03-16 00:00:00 جازان       Jazan                 2      0         0      2
 9 2020-03-18 00:00:00 أبها        Abha                  1      0         0      1
10 2020-03-19 00:00:00 محايل عسير  Muhayil Aseer         1      0         0      1

```

```
data("ksa_shapefiles")

ksa_shapefiles

Simple feature collection with 74 features and 3 fields
geometry type:  MULTIPOLYGON
dimension:      XY
bbox:           xmin: 34.89769 ymin: 16.38176 xmax: 55.20916 ymax: 31.99073
epsg (SRID):    4326
proj4string:    +proj=longlat +datum=WGS84 +no_defs
# A tibble: 74 x 4
   name          population                                                   geometry city_name   
   <chr>              <dbl>                                         <MULTIPOLYGON [°]> <chr>       
 1 Al-Qatif          524182 (((49.99431 26.72129, 49.99421 26.7174, 49.9933 26.71514,… القطيف      
 2 Ad-Dammam         903312 (((50.07732 26.46815, 50.08116 26.46802, 50.08215 26.4681… الدمام      
 3 Al-Riyad         5188286 (((47.62633 25.02201, 47.62711 25.01288, 47.6448 24.99291… الرياض      
 4 Makkah Al-Mo…    1534731 (((40.23495 21.19492, 40.15956 21.21513, 40.08818 21.3483… مكة         
 5 Al-Madinah       1100093 (((39.96049 25.37379, 39.99566 25.37379, 40.00489 25.3687… المدينة الم…
 6 Jeddah           3430897 (((39.16186 21.36886, 39.15993 21.36786, 39.15908 21.3691… جدة         
 7 Tabouk            512629 (((38.24488 29.46766, 38.24526 29.44106, 38.24094 29.4341… تبوك        
 8 Al-Ahsa           660788 (((50.42785 25.47875, 50.42576 25.47266, 50.42271 25.4791… الأحساء     
 9 At-Taif           579970 (((40.78118 22.66184, 41.16977 22.48335, 40.96514 22.3501… الطائف      
10 Al-Khubar         219679 (((50.14536 25.81896, 50.145 25.81924, 50.10307 25.81668,… الخبر  

```
## Data source

The COVID-19 data is obtained from [The Saudi Ministry of Health](https://covid19.moh.gov.sa/)

