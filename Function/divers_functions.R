create_data_from_input <- function(df, month, year){
  df <- df %>%
    filter(df$mois == month & df$an == year)
  return(df)
}


summary_stat_airport<- function(df){
  sum_airport <- aggregate(cbind(as.numeric(df$apt_pax_dep), as.numeric(df$apt_pax_arr), as.numeric(df$apt_pax_tr), as.numeric(df$apt_peq)), list(df$apt, df$apt_nom), sum)
  colnames(sum_airport) <- c("apt", "apt_nom", "apt_pax_dep", "apt_pax_arr", "apt_pax_tr", "apt_peq")
  sum_airport <- sum_airport %>%
    arrange(desc(apt_peq))
  return(sum_airport)
}

