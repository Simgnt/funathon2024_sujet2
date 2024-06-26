
plot_airport_line <- function(df, aeroport_name){
  df_aeroport <- df %>% filter(apt == aeroport_name)
  df_aeroport$date <- as.Date(paste("01", df_aeroport$mois, df_aeroport$an, sep = "/"),format = "%d/%m/%Y")
  fig <- plot_ly(df_aeroport, x = ~date, y = ~trafic, type = 'scatter', mode = 'lines+markers')
  fig <- fig %>% layout(title = paste0("Trafic de l'aéroport ", unique(df_aeroport$apt_nom)))
  fig
}


map_leaflet_airport  <- function(df, airports_location, month, year){
  palette <- c("green", "blue", "red")
  
  trafic_date <- create_data_from_input(df, month, year)
  
  trafic_aeroports <- left_join(airports_location, trafic_date, by = join_by(Code.OACI == apt))
  
  
  trafic_aeroports <- trafic_aeroports %>%
    mutate(
      volume = ntile(trafic.y, 3)
    ) %>%
    mutate(
      color = palette[volume]
    )
  
  icons <- awesomeIcons(
    icon = 'plane',
    iconColor = 'black',
    library = 'fa',
    markerColor = trafic_aeroports$color
  )
  
  p <- leaflet(data = trafic_aeroports) %>% addTiles() %>%
    addAwesomeMarkers(label  = ~paste0(Nom, ": ", trafic.y), icon = icons)
  p
}