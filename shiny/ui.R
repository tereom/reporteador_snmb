library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

# Application title
titlePanel("Revisión de registros SNMB"),
p("Esta aplicación genera reportes de entrega para una base de datos creada
con el cliente de captura del SNMB, el resultado son dos archivos word, el
primero contiene tablas que indican las secciones del cliente en que se
capturó información y da medidas del volumen de información almacenada,
número de archivos, número de grabaciones, número de fotos, etc.

El segundo archivo se genera únicamente cuando
se detectan conglomerados repetidos en la base de datos, este reporte
indica si la información en los repetidos es la misma. Adicionalmente, se
crea una copia de la base de datos sqlite, esto en caso de que se desee
explorar esta base "),
br(),
# Sidebar with a slider input for the number of bins
sidebarLayout(
sidebarPanel(
textInput("path_sqlite", "Ruta a base de datos sqlite:", value = ""),
helpText("Especificar la ruta a la carpeta donde esta almacenada
la base de datos, basta con especificar la carpeta del cliente,
ej: C:/Users/juan/Desktop/cliente_snmb"),
textInput("path_reporte", "Nombre del reporte:", value = ""),
helpText("Especificar la ruta a la carpeta donde se almacenarán los
reportes y el nombre que identifique los reportes,
ej: em(C:/Users/juan/Doesktop/reporte_1), si solo se provee el
nombre del reporte, este se guardará en la carpeta reportes (dentro del
directorio de la aplicación)."),
actionButton("actualiza", "generar reportes")
),
mainPanel(
textOutput("prueba"),
br(),
DT::dataTableOutput("tbl")
)
)
))