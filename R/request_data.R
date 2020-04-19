.request_data <- function(){

  base_url <- "https://services8.arcgis.com/uiAtN7dLXbrrdVL5/arcgis/rest/services/Saudi_COVID19_Cases/FeatureServer/1/query"

  params <- list(where = "1=1",
                 f= "json",
                 returnGeometry = "true",
                 spatialRel= "esriSpatialRelIntersects",
                 outFields= "*",
                 orderByFields= "Reportdt asc",
                 resultOffset= 0,
                 resultRecordCount= 1000,
                 cacheHint= "true"
  )

  r <- httr::GET(url = base_url, query = params)

  if(r$status_code == 200 ) r else stop(paste("request failed with error#", r$status_code))
}

.clean_date <- function(){

  covid19_ksa <-
    .request_data() %>%
    httr::content() %>%
    jsonlite::fromJSON(flatten = TRUE)

  df <-
    covid19_ksa$features %>%
    as_tibble() %>%
    janitor::clean_names() %>%
    purrr::set_names(
      ~ stringr::str_remove_all(., pattern = "attributes_") %>%
        stringr::str_replace_all(., pattern = "name", replacement = "city")
      )%>%
    mutate(date = lubridate::as_datetime(.data$reportdt/1000)) %>%
    select(
      .data$date, everything(), -.data$reportdt,
      -.data$objectid,-.data$city_i_ds, -.data$tested,
      -.data$global_id)

  .ksacovid19_env$data <- df
  .ksacovid19_env$last_request <- Sys.Date()

  df
}
