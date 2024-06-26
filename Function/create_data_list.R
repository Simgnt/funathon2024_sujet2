
## Create data list
create_data_list<- function(source){
  list_fichier <- yaml::read_yaml(source)
  return(list_fichier)
}