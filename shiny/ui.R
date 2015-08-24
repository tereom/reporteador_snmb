library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Revisión de registros SNMB"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      textInput("path_sqlite", "Ruta a base de datos sqlite:", value = ""),
      textInput("path_reporte", "Nombre del reporte:", value = ""),
      helpText("Si solo se provee el nombre del reporte se guardará en la 
        carpeta reportes (dentro
        del directorio de la aplicación), si deseas guardarlo en otra ubicación 
        se debe especificar la ruta junto con el nombre, 
        ej: C:/Users/juan/Documents/reporte1"),
      actionButton("actualiza", "generar reportes")
  ), 
  mainPanel(
      textOutput("prueba"),
      DT::dataTableOutput("tbl")
    )
  )
))