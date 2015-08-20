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
      helpText("El reporte se guarda por omisión en el escritorio, si 
        deseas guardarlo en otra ubicación se debe especificar la ruta junto
        con el nombre, ej: ~/Documents/conafor"),
      actionButton("actualiza", "generar reportes")
  ), 
  mainPanel(
      textOutput("prueba")
    )
  )
))