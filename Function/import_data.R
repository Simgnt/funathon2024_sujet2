

import_airport_data  <- function(list_files){
  df <- readr::read_csv2(unlist(list_files['airports']), col_types = readr::cols(
    ANMOIS = readr::col_character(),
    APT = readr::col_character(),
    APT_NOM = readr::col_character(),
    APT_ZON = readr::col_character(),
    .default = readr::col_character()
  ) )
  df <- clean_dataframe(df,coldate = df$ANMOIS)
  return(df)
}


import_compagnies_data  <- function(list_files){
  df <- readr::read_csv2(unlist(list_files$compagnies)
                         , col_types = readr::cols(
                           ANMOIS = readr::col_character(),
                           CIE = col_character(),
                           CIE_NOM = col_character(),
                           CIE_NAT = col_character(),
                           CIE_PAYS = col_character(),
                           .default = col_double())
  )
  df <- clean_dataframe(df,coldate = df$ANMOIS)
  return(df)}

import_liaisons_data <- function(list_files){
  df <- readr::read_csv2(unlist(list_files$liaisons)
                         , col_types = readr::cols(
  
                             ANMOIS = col_character(),
                             LSN = col_character(),
                             LSN_DEP_NOM = col_character(),
                             LSN_ARR_NOM = col_character(),
                             LSN_SCT = col_character(),
                             LSN_FSC = col_character(),
                             .default = col_double()
                    
  ))
  df <- clean_dataframe(df,coldate = df$ANMOIS)
  return(df)}
