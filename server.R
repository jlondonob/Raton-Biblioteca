#Importar paquete Shiny
library(shiny)
library(readxl)

#Se crea servidor
shinyServer(function(input, output) {
  
#-------------------------- (1) Creación de tablas de Datos-------------------------#
    
  #Se crea elemento reactivo para tabla sobre info. personal
  #Esta tabla solo tiene en cuenta características personales eliminando duplicados.
  pers <- reactive({
    inDile <- input$datos
    ppl<- read_xlsx(inDile$datapath, skip=2, col_types = "guess")[,c("Tercero","Nombre del Tercero","Precio/Valor Bruto","Cargo","Correo Electronico", "Centro de Costos")]
    ppl <- ppl[!duplicated(ppl$`Nombre del Tercero`),]
    return(ppl)
  })
  
  #Se crea elemento reactivo que lee la tabla de datos para discriminar transacciones.
  dat<-reactive({
    inFile<- input$datos
    #Notese que tengo (skip=2), entonces, siempre se tienen que poner los nombres de las columanas
    #en la segunda fila.
    
    datos<-read_xlsx(inFile$datapath, sheet= 1, skip = 2)[,c("Nro. Registro","Nombre del Tercero","Nombre Transacción","Tipo Asiento","Precio/Valor Bruto")] #datapath se crea automaticamente y es la dirección del documento.
    
    return(datos)
  })
  
  #Se crea elemento reactivo que contiene una lista con los nombres únicos
  list_nom <- reactive({levels(factor(dat()$`Nombre del Tercero`))})
  
  
 #-------------------------- (2) Creacion de los PDF ----------------------------# 
  
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