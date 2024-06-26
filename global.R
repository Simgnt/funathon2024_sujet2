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

source("~/work/funathon2024_sujet2/Function/create_data_list.R")
source("~/work/funathon2024_sujet2/Function/clean_data_frame.R")
source("~/work/funathon2024_sujet2/Function/import_data.R")
source("~/work/funathon2024_sujet2/Function/Figures.R")
source("~/work/funathon2024_sujet2/Function/divers_functions.R")
source("~/work/funathon2024_sujet2/Function/Table.R")
source("~/work/funathon2024_sujet2/Function/table_bis.R")

# Global variables --------------------------- 

YEARS_LIST <- as.character(2018:2022)
MONTHS_LIST <- as.character(1:12)

# Load data ----------------------------------

urls <- create_data_list("sources.yml")

pax_apt_all  <- import_airport_data(urls)
pax_cie_all  <- import_compagnies_data(urls)
pax_lsn_all  <- import_liaisons_data(urls)

airports_location <- st_read(urls$geojson$airport)


liste_aeroports <- unique(pax_apt_all$apt)
default_airport <- liste_aeroports[1]

# OBJETS NECESSAIRES A L'APPLICATION ------------------------



pax_apt_all$trafic  <- as.numeric(pax_apt_all$apt_pax_dep) +  as.numeric(pax_apt_all$apt_pax_tr) +  as.numeric(pax_apt_all$apt_pax_arr)

stats_aeroports <- summary_stat_airport(create_data_from_input(pax_apt_all, month, year))

trafic_aeroports <- left_join(airports_location, trafic_date, by = join_by(Code.OACI == apt))

