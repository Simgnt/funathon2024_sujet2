clean_dataframe  <- function(df, coldate){
  df <- df %>%
    mutate(an = substr(coldate, 1, 4),        
           mois = substr(coldate, 5, 6))      
  colnames(df) <- tolower(colnames(df))
  return(df)
}

