library(readr)
library(dplyr)
library(sf)
library(leaflet)
library(stringr)

library(plotly)


source("~/work/funathon2024_sujet2/Function/create_data_list.R")
source("~/work/funathon2024_sujet2/Function/clean_data_frame.R")
source("~/work/funathon2024_sujet2/Function/import_data.R")

urls <- create_data_list("sources.yml")

pax_apt_all  <- import_airport_data(urls)
pax_cie_all  <- import_compagnies_data(urls)
pax_lsn_all  <- import_liaisons_data(urls)

airports_location <- st_read(urls$geojson$airport)

leaflet(airports_location) %>%
  addTiles() %>%
  addMarkers(popup = ~Nom)



liste_aeroports <- unique(pax_apt_all$apt)
default_airport <- liste_aeroports[1]