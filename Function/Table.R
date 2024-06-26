belle_table <- function(stats_aeroports){
  stats_aeroports_table <- stats_aeroports %>%
    mutate(name_clean = paste0(str_to_sentence(apt_nom), " _(", apt, ")_")
    ) %>%
    select(name_clean, everything())
  beautifulltable <- stats_aeroports_table %>% select(-apt, -apt_nom )  %>% gt() %>% fmt_number(columns = starts_with("apt"), 
                                                                                                decimals = 0,  suffixing = TRUE) %>% 
    fmt_markdown(columns = "name_clean") %>%   cols_label(
      name_clean = "Nom de l'aéroport",
      apt_pax_dep = "Départ",
      apt_pax_arr = "Arrivée",
      apt_pax_tr = "Transit",
      apt_peq = "Total"
    )  %>% tab_header(
      title = "Trafic des aéoroports en octobre 2019 ") %>% tab_source_note( md("_Source: DGAC, à partir des données sur data.gouv.fr_")) %>%   tab_style(
        style = list(
          cell_fill(color = "#F9E3D6"),
          cell_text(style = "italic")
        ),
        locations = cells_body(
          columns = apt_pax_tr,
          rows = apt_pax_tr < 1000
        )
      ) %>% opt_interactive()
  
  return(beautifulltable)
  
}
