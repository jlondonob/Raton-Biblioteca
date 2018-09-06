#Importar paquete Shiny
library(shiny)
library(readxl)

#Se crea servidor
shinyServer(function(input, output) {
  
  #Se crea elemento reactivo que lee la tabla de datos importada anteriormente
  dat<-reactive({
    inFile<- input$datos
    datos<-read_xlsx(inFile$datapath, sheet= 1) #datapath se crea automaticamente y es la dirección del documento.
    return(datos)
  })
  #Se crea elemento reactivo que contiene una lista con los nombres únicos
  list_nom <- reactive({levels(factor(dat()$Nombre))})
  
  #Se desarrolla el documento que será descargado por el usuario
  output$db <- downloadHandler(
    filename = function(){
      paste0(input$ti, ".zip")
    },
    content = function(file){
      
      sf<-c()
      for(i in list_nom()){
      sink(paste0(i,".Rmd"))
      cat("Nombre:", i, "\n") #La "\n" crea una nueva linea.
      sink()
      rmarkdown::render(paste0(i,".Rmd"), 
                        output_format = "pdf_document")
      unlink(paste0(i,".Rmd"))
      sf<-c(sf,paste0(i,".pdf"))
      }
    zip(zipfile = file, files = sf)
    }
    
    
    
  )
  
})