
plot_airport_line <- function(df, aeroport_name){
  df_aeroport <- df %>% filter(apt == aeroport_name)
  df_aeroport$date <- as.Date(paste("01", df_aeroport$mois, df_aeroport$an, sep = "/"),format = "%d/%m/%Y")
  fig <- plot_ly(df_aeroport, x = ~date, y = ~trafic, type = 'scatter', mode = 'lines+markers')
  fig <- fig %>% layout(title = paste0("Trafic de l'aéroport ", unique(df_aeroport$apt_nom)))
  fig
}
