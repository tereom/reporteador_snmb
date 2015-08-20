### Reporteador Shiny

Desarrollo de una aplicación de escritorio usando Shiny. La aplicación genera reportes para el SNMB, 
los reportes serán similares a los producidos por el reporteador ubicado en el repositorio 
[Integración SNMB](https://github.com/tereom/integracion_snmb).

### Funcionamiento
El procedimiento sigue los pasos descritos en el post 
[Deploying desktop apps with R](http://oddhypothesis.blogspot.de/2014/04/deploying-self-contained-r-apps-to.html).

La carpeta que se comprime y reparte incluye las siguientes carpetas y archivos:

```
reporteador_shiny
│   README.md
|   runShinyApp.R
└───scripts
|   |   revision_gral_iso.Rmd
│   │   revision_repetidos_iso.Rmd
└───shiny
|   │   server.R
|   │   ui.R
└───pandoc
└───R-Portable
└───reportes*
```

**pandoc:** Rmarkdown lo necesita para poder crear los reportes, esta carpeta esta incluída en RStudio, es necesario copiarla
de una descarga de [RStudio](https://www.rstudio.com/products/RStudio/) (de Windows), y se encuentra en `RStudio/bin/pandoc`.
