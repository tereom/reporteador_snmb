# Diferencias con reporteador (integracion_snmb):
# No genera lista de ids repetidos a eliminar
# En revisión general no se compara con la base de datos "final"

library(rmarkdown)
library(DT)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    # terminación de la base de datos a considerar
    pattern_db <- "\\.sqlite$"
    
    # lista con retornos
    resp <- list()
    
    # función que crea los reportes cuando se presiona "generar_reportes"
    crear_reportes <- eventReactive(input$actualiza, {
      
        # leemos las rutas ingresadas en la aplicación
        ruta_entrega <- input$path_reporte
        ruta_base <- input$path_sqlite
        
        # si no se ingresó una ruta lo guarda en la carpeta "reportes"
        if(dirname(ruta_entrega) == "."){
            ruta_entrega <- paste("../reportes/", ruta_entrega, sep = "")
        }
        
        dir.create(ruta_entrega)
        # creamos nombres de reporte, carpetas y dbs como: fecha + nombre_entrega
        fecha_reporte <- format(Sys.time(), "%Y_%m_%d")
        entrega <- paste(fecha_reporte, "_", basename(ruta_entrega), sep = "")
        
        base_sqlite <- list.files(path = ruta_base,
        recursive = TRUE, full.names = TRUE, pattern = pattern_db)
        
        if(length(base_sqlite) > 0){
            output_reporte = paste(entrega, ".docx", sep = "")
            render('../scripts/revision_gral_iso.Rmd', output_file = output_reporte,
            output_dir = ruta_entrega)
            
            # tabla a desplegar en a app
            resp[["tab_cgl"]] <- tab_cgl %>% arrange(cgl) %>% convert_to_encoding()
            
            # revisamos su hay repetidos, y si hace falta creamos reporte y txt
            conglomerado_reps <- collect(tbl(base_input, "Conglomerado_muestra"))
            cgl_reps <- conglomerado_reps %>%
            select(nombre, fecha_visita, id)
            ids_reps <- cgl_reps$id[duplicated(select(cgl_reps, nombre, fecha_visita))]
            
            if(length(ids_reps) > 0){
                output_rep = paste(entrega, "_rep.docx", sep = "")
                render('../scripts/revision_repetidos_iso.Rmd', output_file = output_rep,
                output_dir = ruta_entrega)
            }
            
            # estructura de archivos:
            # ruta a carpeta de archivos:
            ruta_archivos <- paste0(dirname(ruta_entrega), "/", entrega)
            
            # ruta a base de datos:
            base_archivos <- base_sqlite[1]

            # ruta a carpeta con archivos antes de procesarlos:
            dir_j <- ruta_base
            
            source('../scripts/migracion_archivos.R', local = TRUE)
            
            imprimir <- paste("Los reportes se crearon en el directorio:", ruta_entrega)
        }else{
            imprimir <- "No se encontró niguna base de datos con terminación sqlite,
            considera que las rutas a archivos deben usar diagonales derechas (/)."
        }
        
        resp[["imprimir"]] <- imprimir
        resp
        
    })
    output$prueba <- renderText({
        crear_reportes()[["imprimir"]]
    })
    output$tbl <- DT::renderDataTable(
    crear_reportes()[["tab_cgl"]], 
    options = list(lengthMenu = c(10, 15, 20, 30, -1), 
    pageLength = 15,
    searchHighlight = TRUE)
    )
    
    session$onSessionEnded(function() {
        stopApp()
    })
})

