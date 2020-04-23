# ksacovid19

## Overview

ksacovid19 is an R package which shows COVID-19 cases in Saudi Arabia on country and city level with few additional stats functions. 

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

   date                city        city_eng      confirmed deaths recovered active
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

## Data source

The data is obtained from [The Saudi Ministry of Health](https://covid19.moh.gov.sa/)

