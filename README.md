### Reporteador Shiny

Desarrollo de una aplicación de escritorio usando Shiny, la aplicación genera reportes de entrega para una base de datos creada 
con el cliente de captura del [SNMB](https://github.com/tereom/cliente_web2py), así como una estructura de archivos para facilitar la revisión de los mismos (en caso de ser necesario, además genera reportes acerca del proceso de migración de archivos).

Los reportes consisten en dos archivos word: el primero contiene tablas que indican las secciones del cliente en que se capturó información y da medidas del volumen de información almacenada, número de archivos, número de grabaciones, número de fotos, etc. El segundo archivo se genera únicamente cuando se detectan conglomerados repetidos en la base de datos, indica si la información en los repetidos es la misma. Los reportes son similares a los producidos por el reporteador ubicado en el repositorio [Integración SNMB](https://github.com/tereom/integracion_snmb). Adicionalmente, se crea una copia de la base de datos sqlite, esto en caso de que se desee explorar directamente la base de datos.

La estructura de archivos es similar a la del migrador (repositorio [Integración SNMB](https://github.com/tereom/integracion_snmb)). Y, al igual que este último, genera el reporte correspondiente en cualquiera de los casos siguientes:
* Cuando existen archivos registrados en la base de datos pero que no se encontraron (y por lo tanto, no se pudieron migrar).
* Cuando existen archivos registrados en la base de datos, que también se encontraron, pero no se pudieron migrar por alguna razón.

### Funcionamiento
Para construir la aplicación se siguieron los pasos descritos en el post 
[Deploying desktop apps with R](http://oddhypothesis.blogspot.de/2014/04/deploying-self-contained-r-apps-to.html). La aplicación funciona únicamente en Windows y para repartirla se crea una carpeta con la siguiente estructura de archivos:

```
reporteador_shiny
│   README.md
|   run.bat
|   runShinyApp.R
└───shiny
|   │   server.R
|   │   ui.R
└───scripts
|   |   revision_gral_iso.Rmd
│   │   revision_repetidos_iso.Rmd
│   │   migracion_archivos.R
└───datos
|   |   malla.RData
└───pandoc
└───R-Portable
└───reportes*
```

Explicamos la función de cada archivo:
* run.bat: llama a runShinyApp.R dando inicio a la aplicación.
* runShinyApp.R: corre la aplicación shiny usando el R-portable que esta en la carpeta.
* ui.R (shiny): define la interfaz de usuario, donde se explica el funcionamiento de la aplicación y se solicita información al usuario.
* server.R (shiny): recibe la información de *ui.R* y llama a los scripts *revision_gral_iso.Rmd* y *revision_repetidos_iso.Rmd*.
* revision_gral_iso.Rmd: crea el reporte de Word con información encontrada en la base de datos. El sufijo iso en el nombre indica que se guardaron con encoding iso, esto es necesario para que los acentos y caracteres especiales están bien en Windows.
* revision_repetidos_iso.Rmd: en caso de existir conglomerados repetidos en la base de datos, compara la información con el fin de que se determine cuál es la versión más completa.
* migracion_archivos.R: crea la estructura de archivos, basándose en la información capturada en la base de datos.
* malla.RData: almacena las coordenadas teóricas de los conglomerados, el script revision_gral_iso.Rmd lo utiliza para determinar la distancia entre la malla teñórica y las coordenadas ingresadas al cliente.
* pandoc: Rmarkdown lo necesita para poder crear los reportes, esta carpeta esta incluída en RStudio, es necesario copiarla
de una descarga de [RStudio](https://www.rstudio.com/products/RStudio/) (de Windows), y se encuentra en `RStudio/bin/pandoc`.
* reportes: la aplicación tiene la opción de especificar la ruta donde se guardarán los reportes/archivos; sin embargo, en caso de que no se especifique, éstos se almacenarán en la carpeta reportes.
