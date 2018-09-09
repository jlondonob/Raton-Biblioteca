setwd("/Users/puchu/Documents/EAFIT Completo/Semestre Actual/Semillero de Investigación/Proyectos Daniel/Proyecto 1/Organizer3000")
library(readxl)

biblio<- read_xlsx("transacciones.xlsx", sheet=1, skip=2)[,c("Nro. Registro","Nombre del Tercero","Nombre Transacción","Tipo Asiento","Precio/Valor Bruto")]

#Se crea un subset que solo tenga la información de la persona seleccionada
individuo <- subset(biblio, biblio$`Nombre del Tercero`=="ADRIANA MILENA CASTANO MUNOZ")

# Se ordena para que los debitos queden primero
individuo <-individuo[order(individuo$`Tipo Asiento`, decreasing = T), ,drop=F]


#Se hace un loop para discriminar entre créditos y débitos
for(i in 1:nrow(individuo)){
  
  if(individuo$`Tipo Asiento`[i]=="DB"){
    individuo$`Sumas`[i] <- individuo$`Precio/Valor Bruto`[i]} 
  else{
    individuo$`Sumas`[i] <- c("")}
  if(individuo$`Tipo Asiento`[i]=="CR"){
    individuo$`Restas`[i] <- individuo$`Precio/Valor Bruto`[i]} 
  else{
    individuo$`Restas`[i] <- c("")}
}

#Se eliminan las variables: "Tipo asiento y Precio/Valor Bruto"
# En un futuro también se debe eliminar "Nombre Tercero"
individuo <- individuo[,c("Nro. Registro","Nombre del Tercero","Nombre Transacción","Sumas","Restas")]
