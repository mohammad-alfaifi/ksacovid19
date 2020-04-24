

# retrieve paths to datafiles
sf_cities <- system.file(
  "extdata",
  "sf_cities.shp",
  package = "ksacovid19"
)

cities_desc <- system.file(
  "extdata",
  "sf_cities.csv",
  package = "ksacovid19"
)

sf_cities <- sf::read_sf(sf_cities)

cities_desc <-
  readr::read_csv(cities_desc) %>%
  select(-.data$snd_city_name)

ksa_shapefiles <-
  sf_cities %>%
  inner_join(cities_desc) %>%
  select(-.data$region) %>%
  select(-.data$id, -.data$index, -.data$pop_100k)

usethis::use_data(ksa_shapefiles, overwrite = TRUE)
