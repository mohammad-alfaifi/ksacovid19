#' @importFrom httr GET
#' @importFrom jsonlite fromJSON
#' @importFrom janitor clean_names
#' @importFrom purrr set_names
#' @importFrom lubridate as_datetime week month
#' @importFrom readr read_rds
#' @importFrom stringr str_remove_all str_replace_all
#' @import dplyr rlang
 NULL

.onLoad <- function(...){
  .ksacovid19_env <<- new.env(parent = emptyenv())
}

#'  Covid19 cases in Saudi cities
#' @description  use this to view covid19 cases in cities in Saudi Arabia
#' @return data frame with cities covid19 cases
#' @export
#'
cities_cases <- function(){
  if(is.null(.ksacovid19_env$data)){
    .clean_date()
  }else {
    if(.ksacovid19_env$last_request != Sys.Date()){
      .clean_date()
    }else{
      .ksacovid19_env$data
    }
  }

}

#' KSA covid19 cases
#' @description  use this to view the number of Covid19 cases reported in Saudi arabia
#' @return data frame with daily reported cases
#' @export
#'
country_cases <- function(){
  ksacovid19::cities_cases() %>%
     group_by(.data$date) %>%
     summarise(
      confirmed = sum(.data$confirmed),
      deaths = sum(.data$deaths),
      recovered = sum(.data$recovered)
    )
}

#' data of first record case in Saudi cities
#'@description This function returns cities with their first reported cases
#' @return data frame with first reported cases in each city
#' @export
#'
cities_first<- function(){
  ksacovid19::cities_cases() %>%
    group_by(.data$city) %>%
    filter(.data$date == min(.data$date))

}

#' Growth of Covid 19 cases in Saudi Arabia
#' @param freqeuncy, weekly or monthly
#' @description view the weekly or monthly number of covid19 cases in Saudi Arabia
#' @return data frame with either weekly or monthly % growth of cases
#' @export
#'
country_cases_growth <- function(freqeuncy = "weekly"){

  if(freqeuncy == "weekly") g_var <- "week" else g_var <- "month"

  group_var <- NULL

    ksacovid19::country_cases() %>%
     mutate(
       week = week(.data$date),
       month = month(.data$date)
       ) %>%
       rename(group_var := g_var) %>%
       group_by(.data$group_var) %>%
       summarise(
         confirmed = sum(.data$confirmed),
          deaths = sum(.data$deaths),
          recovered = sum(.data$recovered)
         ) %>%
      arrange(.data$group_var) %>%
      mutate(
        confirmed_growth = .data$confirmed/if_else(lag(.data$confirmed)==0, as.integer(NA),  lag(.data$confirmed)) -1,
        deaths_growth = .data$deaths/if_else(lag(.data$deaths)==0, as.integer(NA),  lag(.data$deaths)) -1,
        recovered_growth = .data$recovered/if_else(lag(.data$recovered)==0, as.integer(NA),  lag(.data$recovered)) -1
        ) %>%
      rename(!!g_var:=.data$group_var)


}



#' Growth of Covid 19 cases in Saudi cities

#' @param freqeuncy, weekly or monthly
#' @description view the weekly or monthly number of covid19 cases in Saudi cities
#' @return data frame with either weekly or monthly % growth of cases in each city
#' @export
#'
cities_cases_growth <- function(freqeuncy = "weekly"){

  if(freqeuncy == "weekly") g_var <- "week" else g_var <- "month"

  group_var <- NULL

  ksacovid19::cities_cases() %>%
     mutate(
       week = lubridate::week(date),
       month = lubridate::month(date)
       ) %>%
     rename(group_var := g_var) %>%
     group_by(.data$group_var, .data$city, .data$city_eng) %>%
     summarise(
      confirmed = sum(.data$confirmed),
      deaths = sum(.data$deaths),
      recovered = sum(.data$recovered)
    ) %>%
     ungroup() %>%
     group_by(.data$city_eng, .data$city) %>%
     arrange(.data$group_var) %>%
     mutate(
      confirmed_growth = .data$confirmed/if_else(lag(.data$confirmed)==0, as.integer(NA),  lag(.data$confirmed)) -1,
      deaths_growth = .data$deaths/if_else(lag(.data$deaths)==0, as.integer(NA),  lag(.data$deaths)) -1,
      recovered_growth = .data$recovered/if_else(lag(.data$recovered)==0, as.integer(NA),  lag(.data$recovered)) -1
    ) %>%
     rename(!!g_var:=.data$group_var)

}


