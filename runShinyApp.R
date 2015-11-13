require(htmlwidgets)
library(shiny)

# ponemos pandoc en el path para que lo encuentre knitr 
Sys.setenv(PATH="../miktex/miktex/bin/;../pandoc")

# esta línea sirve para asegurarnos de que se este utilizando R-portable
message('library paths:\n', paste('... ', .libPaths(), sep='', collapse='\n'))

shiny::runApp('./shiny/', launch.browser = TRUE)