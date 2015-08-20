library(shiny)
# this message is printed on several lines (one per path) to make multiple paths
# easier to spot
Sys.setenv(PATH="../miktex/miktex/bin/;../pandoc")

message('library paths:\n', paste('... ', .libPaths(), sep='', collapse='\n'))

shiny::runApp('./shiny/', port = 6452)