# Environment ----------------------------------
library(readr)
library(dplyr)
library(lubridate)
library(stringr)
library(sf)
library(ggplot2)
library(plotly)
library(gt)
library(leaflet)
library(bslib)
library(shiny)


source("~/work/funathon2024_sujet2/Function/create_data_list.R")
source("~/work/funathon2024_sujet2/Function/clean_data_frame.R")
source("~/work/funathon2024_sujet2/Function/import_data.R")
source("~/work/funathon2024_sujet2/Function/Figures.R")
source("~/work/funathon2024_sujet2/Function/divers_functions.R")
source("~/work/funathon2024_sujet2/Function/Table.R")

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

pax_apt_all$trafic  <- as.numeric(pax_apt_all$apt_pax_dep) +  as.numeric(pax_apt_all$apt_pax_tr) +  as.numeric(pax_apt_all$apt_pax_arr)

pax_apt_default <- pax_apt_all %>% filter(apt == default_airport)

pax_apt_default$date <- as.Date(paste("01", pax_apt_default$mois, pax_apt_default$an, sep = "/"),format = "%d/%m/%Y")

#ggplot
p <- ggplot(pax_apt_default, aes(x=date, y=trafic)) +
  geom_line() + 
  xlab("")
p

#Plotly
fig <- plot_ly(pax_apt_default, x = ~date, y = ~trafic, type = 'scatter', mode = 'lines+markers')


fig


plot_airport_line(pax_apt_all,  liste_aeroports[10])


## 4.4. 

YEARS_LIST  <- as.character(2018:2022)
MONTHS_LIST <- as.character(1:12)
month <- 11
year <- "2019"

stats_aeroports <- summary_stat_airport(create_data_from_input(pax_apt_all, month, year))

belle_table(stats_aeroports)

## 4.5 

month <- 1
year <- "2019"
palette <- c("green", "blue", "red")

trafic_date <- create_data_from_input(pax_apt_all, month, year)

trafic_aeroports <- left_join(airports_location, trafic_date, by = join_by(Code.OACI == apt))



