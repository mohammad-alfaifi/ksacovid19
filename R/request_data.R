.request_data <- function(){

  base_url <- "https://services8.arcgis.com/uiAtN7dLXbrrdVL5/arcgis/rest/services/Saudi_COVID19_Cases/FeatureServer/1/query"

  params <- list(where = "1=1",
                 f= "json",
                 returnGeometry = "true",
                 spatialRel= "esriSpatialRelIntersects",
                 outFields= "*",
                 orderByFields= "Reportdt asc",
                 resultOffset= 0,
                 resultRecordCount= 100000,
                 cacheHint= "true"
  )

  if(!curl::has_internet()) stop("you need internet connection to get data")

  r <- httr::GET(url = base_url, query = params)

  if(r$status_code == 200 ) r else stop(paste("request failed with error#", r$status_code))
}

.clean_date <- function(){

  stop_message <- "source of data website has changed. Please report as an issue on the package repo on github "

  #used to ensure that the request returned the expected result (data frame with the following column names)
  data_columns <- c(
    "attributes.OBJECTID", "attributes.Reportdt" , "attributes.Name",
    "attributes.Name_Eng", "attributes.City_IDs" , "attributes.Confirmed",
    "attributes.Deaths",   "attributes.Recovered", "attributes.Active",
    "attributes.Tested" ,   "attributes.GlobalID"
                    )


  covid19_ksa <-
    .request_data() %>%
    httr::content() %>%
    jsonlite::fromJSON(flatten = TRUE)


# validate data -----------------------------------------------------------


  if(is.null(try(covid19_ksa$features))) stop(stop_message)

  if(sum(data_columns %in% names(covid19_ksa$features)) != 11) stop(stop_message)



# process data ------------------------------------------------------------


  df <-
    covid19_ksa$features %>%
    as_tibble() %>%
    janitor::clean_names() %>%
    purrr::set_names(
      ~ stringr::str_remove_all(., pattern = "attributes_") %>%
        stringr::str_replace_all(., pattern = "name", replacement = "city")
      )%>%
    mutate(date = lubridate::as_datetime(.data$reportdt/1000)) %>%
    rename(city_name = .data$city) %>%
    select(
      .data$date, everything(), -.data$reportdt,
      -.data$objectid,-.data$city_i_ds, -.data$tested,
      -.data$global_id)

  .ksacovid19_env$data <- df
  .ksacovid19_env$last_request <- Sys.Date()

  df
}
