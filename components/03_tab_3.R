
list(
  ui =
    tabItem(
      tabName = "tab_3",
      fluidRow(
        box(
          width = 4, height = 345,
          h5("Output: lag function from library(stats)"),
          actionButton("tab-3-stats-lag-func", label = "stats::lag(1:5)"),
          verbatimTextOutput("tab-3-stats-lag-res")
        ),
        box(
          width = 4, height = 345,
          h5("Using lag function without Shiny modules"),
          actionButton("tab-3-lag-func", label = "lag(1:5)"),
          verbatimTextOutput("tab-3-lag-res")
        ),
        box(
          width = 4, height = 345,
          h5("Using library(modules) with correct syntax"),
          tabsetPanel(
            tabPanel(
              "stats",
              p("using 'library_modules_lab_stats.R'"),
              p("Desired output: stats::lag(1:5)"),
              uiOutput("tab-3-modules-stats-lag-ui")
            ),
            tabPanel(
              "dplyr",
              p("using 'library_modules_lab_dplyr.R'"),
              p("Desired output: dplyr::lag(1:5)"),
              uiOutput("tab-3-modules-dplyr-lag-ui")
            )
          )
        )
      ),
      fluidRow(
        box(
          width = 4, height = 345,
          h5("outout: lag function from library(dplyr)"),
          actionButton("tab-3-dplyr-lag-func", label = "dplyr::lag(1:5)"),
          verbatimTextOutput("tab-3-dplyr-lag-res")
        ),
        box(
          width = 4, height = 345,
          h5("Using lag function from Shiny module"),
          tabsetPanel(
            tabPanel(
              "stats",
              p("using 'lag_stats.R'"),
              p("Desired output: stats::lag(1:5)"),
              uiOutput("tab-3-shiny-module-stats-lag-ui")
            ),
            tabPanel(
              "dplyr",
              p("using 'lag_dplyr.R'"),
              p("Desired output: dplyr::lag(1:5)"),
              uiOutput("tab-3-shiny-module-dplyr-lag-ui")
            )
          )
        ),
        box(
          width = 4, height = 345,
          h5("Using Shiny modules while mimicking library(modules)"),
          tabsetPanel(
            tabPanel(
              "stats",
              p("using 'lag_stats.R'"),
              p("Desired output: stats::lag(1:5)"),
              uiOutput("tab-3-mimick-modules-stats-lag-ui")
            ),
            tabPanel(
              "dplyr",
              p("using 'lag_dplyr.R'"),
              p("Desired output: dplyr::lag(1:5)"),
              uiOutput("tab-3-mimick-modules-dplyr-lag-ui")
            )
          )
        )
      ),
      fluidRow(
        box(
          title = "Load 3rd-party Shiny module",
          width = 12,
          fluidRow(
            column(
              width = 6, 
              actionButton("tab-3-load-shiny-module-stats", label = "Load Shiny module using stats"),
              hidden(p(id = "tab-3-load-shiny-module-stats-status", "loaded Shiny module 'lag' using library(stats)"))
            ),
            column(
              width = 6, 
              actionButton("tab-3-load-shiny-module-dplyr", label = "Load Shiny module using dplyr"),
              hidden(p(id = "tab-3-load-shiny-module-dplyr-status", "loaded Shiny module 'lag' using library(dplyr)"))
            )
          ),
          hr(),
          fluidRow(          
            column(
              width = 6,
              actionButton("tab-3-load-modules-stats", label = "Load libary(module) using stats"),
              hidden(p(id = "tab-3-load-modules-stats-status", "loaded module 'stats_lag' using library(modules)"))
            ),
            column(
              width = 6,
              actionButton("tab-3-load-modules-dplyr", label = "Load libary(module) using dplyr"),
              hidden(p(id = "tab-3-load-modules-dplyr-status", "loaded module 'dplyr_lag' using library(modules)"))
            )
          ),
          hr(),
          fluidRow(          
            column(
              width = 6,
              actionButton("tab-3-load-mimick-modules-stats", label = "Load mimicked libary(module) using stats"),
              hidden(p(id = "tab-3-load-mimick-modules-stats-status", "loaded mimicked module 'stats_lag' using library(modules)"))
            ),
            column(
              width = 6,
              actionButton("tab-3-load-mimick-modules-dplyr", label = "Load mimicked libary(module) using dplyr"),
              hidden(p(id = "tab-3-load-mimick-modules-dplyr-status", "loaded mimicked module 'dplyr_lag' using library(modules)"))
            )
          ),
          hr(),
          fluidRow(
            column(
              width = 8,
              verbatimTextOutput("tab-3-packages-attached")
            ),
            column(
              width = 4,
              actionButton("tab-3-packages-unload-dplyr", label = "Unattach dplyr")
            )
          )
        )
      )
    ),
  server = function(input, output, session) {
    # packages ----
    # packages attached module
    packages_attached <- reactiveVal((.packages()))
    
    output$`tab-3-packages-attached` <- renderPrint({
      list(
        `Packages attached` = paste(packages_attached(),collapse = ", ")
      )
    })
    
    # package unload
    observeEvent(input$`tab-3-packages-unload-dplyr`, {
      if ("dplyr" %in% .packages()) {
        detach(name = "package:dplyr", unload = TRUE)
      }
      packages_attached(.packages())
    })
    
    # stats::lag ----
    observe({
      input$`tab-3-stats-lag-func`
      output$`tab-3-stats-lag-res` <- renderPrint({
        list(
          `Called Time` = Sys.time(),
          Output = stats::lag(1:5)
        )
      })
    })
    
    # dplyr::lag ----
    observe({
      input$`tab-3-dplyr-lag-func`
      output$`tab-3-dplyr-lag-res` <- renderPrint({
        list(
          `Called Time` = Sys.time(),
          Output = dplyr::lag(1:5)
        )
      })
    })
    
    # lag ----
    observeEvent(input$`tab-3-lag-func`,{
      output$`tab-3-lag-res` <- renderPrint({
        list(
          `Called Time` = Sys.time(),
          Output = lag(1:5)
        )
      })
    })
    
    
    # shiny module stats ----
    output$`tab-3-shiny-module-stats-lag-ui` <- renderUI({
      p('Click on button below "Load Shiny modules using stats" to use this')
    })
    
    observeEvent(input$`tab-3-load-shiny-module-stats`, {
      source("modules/lag/lag_stats.R")
      packages_attached(.packages())
      show("tab-3-load-shiny-module-stats-status")
      
      output$`tab-3-shiny-module-stats-lag-ui` <- renderUI({
        lagUI("tab-3-shiny-module-stats-lag")
      })
      
      callModule(
        lagSERVER, "tab-3-shiny-module-stats-lag"
      )
    })
    
    # shiny module dplyr ----
    output$`tab-3-shiny-module-dplyr-lag-ui` <- renderUI({
      p('Click on button below "Load Shiny module using dplyr" to use this')
    })
    
    observeEvent(input$`tab-3-load-shiny-module-dplyr`, {
      source("modules/lag/lag_dplyr.R")
      packages_attached(.packages())
      show("tab-3-load-shiny-module-dplyr-status")
      
      output$`tab-3-shiny-module-dplyr-lag-ui` <- renderUI({
        lagUI("tab-3-shiny-module-dplyr-lag")
      })
      
      callModule(
        lagSERVER, "tab-3-shiny-module-dplyr-lag"
      )
    })
    
    # library(modules) stats ----
    output$`tab-3-modules-stats-lag-ui` <- renderUI({
      p('Click on button below "Load library(modules) using stats" to use this')
    })
    
    observeEvent(input$`tab-3-load-modules-stats`, {
      used_module <- modules::use("modules/lag/library_modules_lag_stats.R")
      
      packages_attached(.packages())
      show("tab-3-load-modules-stats-status")
      
      output$`tab-3-modules-stats-lag-ui` <- renderUI({
        used_module$lagUI("tab-3-modules-stats-lag")
      })
      
      callModule(
        used_module$lagSERVER, "tab-3-modules-stats-lag"
      )
    })
    
    # library(modules) dplyr ----
    output$`tab-3-modules-dplyr-lag-ui` <- renderUI({
      p('Click on button below "Load library(modules) using dplyr" to use this')
    })
    
    observeEvent(input$`tab-3-load-modules-dplyr`, {
      used_module <- modules::use("modules/lag/library_modules_lag_dplyr.R")
      
      packages_attached(.packages())
      show("tab-3-load-modules-dplyr-status")
      
      output$`tab-3-modules-dplyr-lag-ui` <- renderUI({
        used_module$lagUI("tab-3-modules-dplyr-lag")
      })
      
      callModule(
        used_module$lagSERVER, "tab-3-modules-dplyr-lag"
      )
    })
    
    # mimicked library(modules) stats ----
    output$`tab-3-mimick-modules-stats-lag-ui` <- renderUI({
      p('Click on button below "Load mimicked library(modules) using stats" to use this')
    })
    
    observeEvent(input$`tab-3-load-mimick-modules-stats`, {
      used_module <- betweentwotests_use("modules/lag/lag_stats.R")
      
      packages_attached(.packages())
      show("tab-3-load-mimick-modules-stats-status")
      
      output$`tab-3-mimick-modules-stats-lag-ui` <- renderUI({
        used_module$lagUI("tab-3-mimick-modules-stats-lag")
      })
      
      callModule(
        used_module$lagSERVER, "tab-3-mimick-modules-stats-lag"
      )
    })
    
    # mimicked library(modules) dplyr ----
    output$`tab-3-mimick-modules-dplyr-lag-ui` <- renderUI({
      p('Click on button below "Load mimicked library(modules) using dplyr" to use this')
    })
    
    observeEvent(input$`tab-3-load-mimick-modules-dplyr`, {
      used_module <- betweentwotests_use("modules/lag/lag_dplyr.R")
      
      packages_attached(.packages())
      show("tab-3-load-mimick-modules-dplyr-status")
      
      output$`tab-3-mimick-modules-dplyr-lag-ui` <- renderUI({
        used_module$lagUI("tab-3-mimick-modules-dplyr-lag")
      })
      
      callModule(
        used_module$lagSERVER, "tab-3-mimick-modules-dplyr-lag"
      )
    })
  }
)

