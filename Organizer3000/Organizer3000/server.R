#Importar paquete Shiny
library(shiny)
library(readxl)

#Se crea servidor
shinyServer(function(input, output) {
  
  #Se crea elemento reactivo que lee la tabla de datos importada anteriormente
  dat<-reactive({
    inFile<- input$datos
    #Notese que tengo (skip=2), entonces, siempre se tienen que poner los nombres de las columanas
    #en la segunda fila.
    datos<-read_xlsx(inFile$datapath, sheet= 1, skip = 2) #datapath se crea automaticamente y es la dirección del documento.
    return(datos)
  })
  #Se crea elemento reactivo que contiene una lista con los nombres únicos
  list_nom <- reactive({levels(factor(dat()$`Nombre del Tercero`))})
  
  
  #Se desarrolla el documento que será descargado por el usuario
  output$db <- downloadHandler(
    filename = function(){
      paste0(input$ti, ".zip")
    },
    content = function(file){
      
      sf<-c()
      for(i in list_nom()){
     
        
        rmarkdown::render("plantilla1.Rmd", 
                        output_format = "pdf_document",
                        output_file = paste0(i,".pdf"))
        setwd
      sf<-c(sf, paste0(i,".pdf"))
      }
      for(i in list_nom()){
        sf <- c(sf,  paste0(i,".pdf"))
      }
    zip(zipfile = file, files = sf)
    
    }
    
    
  )
  
})