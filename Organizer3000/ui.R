
#

library(shiny)
library(readxl)


shinyUI (fluidPage(
  #Titulo
  titlePanel("Bienvenidos"),
  #Aplicar organización con barra lateral
  sidebarLayout(
    sidebarPanel(
      #Se crea entrada para que usuario seleccione tabla de datos a utilizar
      fileInput("datos", "Seleccione el documento", accept = c(".xlsx")),
      #Se crea una entrada para que el usuario elija nombre para el archivo final
      textInput("ti", "Como desea llamar su archivo"),
      #Se crea boton interactivo para que usuario pueda descargar archivo.
      downloadButton("db")
      
    ),
    mainPanel(
      
      )
  )
  
))