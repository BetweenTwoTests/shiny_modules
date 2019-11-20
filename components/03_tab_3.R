
list(
  ui =
    tabItem(
      tabName = "tab_3",
      fluidRow(
        box(
          title = "Without Shiny modules",
          width = 12,
          fluidRow(
            column(
              width = 4,
              h4("Example of using lag function from library(stats)"),
              actionButton("tab-3-stats-lag-func", label = "stats::lag(1:5)"),
              verbatimTextOutput("tab-3-stats-lag-res")
            ),
            column(
              width = 4,
              h4("Example of using lag function without specifying"),
              actionButton("tab-3-lag-func", label = "lag(1:5)"),
              verbatimTextOutput("tab-3-lag-res")
            ),
            column(
              width = 4,
              h4("Example of using lag function from Shiny module 'lag'"),
              tabsetPanel(
                tabPanel(
                  "Shiny modules 'stats'",
                  p("Example of using library(stats) lag function from 'lag_stats.R'"),
                  p("Desired output: stats::lag(1:5)"),
                  uiOutput("tab-3-shiny-module-stats-lag-ui")
                ),
                tabPanel(
                  "Shiny modules 'dplyr'",
                  p("Example of using library(dplyr) lag funciton from 'lag_dplyr.R'"),
                  p("Desired output: dplyr::lag(1:5)"),
                  uiOutput("tab-3-shiny-module-dplyr-lag-ui")
                )
              )
              
            )
          ),
          fluidRow(
            column(
              width = 4,
              h4("Example of using lag function from library(dplyr)"),
              actionButton("tab-3-dplyr-lag-func", label = "dplyr::lag(1:5)"),
              verbatimTextOutput("tab-3-dplyr-lag-res")
            ),
            column(
              width = 4,
              h4("Example of using lag function without specifying (copy)"),
              actionButton("tab-3-lag-copy-func", label = "lag(1:5)"),
              verbatimTextOutput("tab-3-lag-copy-res")
            ),
            column(
              width = 4,
              tabsetPanel(
                tabPanel(
                  "library(modules) stats",
                  p("Example of using stats::lag function from library(modules) 'library_modules_lab_stats.R'"),
                  p("Desired output: statslag(1:5)"),
                  uiOutput("tab-3-modules-stats-lag-ui")
                ),
                tabPanel(
                  "library(modules) dplyr",
                  p("Example of using dplyr::lag function from library(modules) 'library_modules_lab_dplyr.R'"),
                  p("Desired output: dplyr::lag(1:5)"),
                  uiOutput("tab-3-modules-dplyr-lag-ui")
                )
              )
            )
          )
        )
      ),
      fluidRow(
        box(
          title = "Load 3rd-party Shiny module",
          width = 12,
          column(
            width = 3, 
            actionButton("tab-3-load-shiny-module-stats", label = "Load Shiny module using stats"),
            hidden(p(id = "tab-3-load-shiny-module-stats-status", "loaded Shiny module 'lag' using library(stats)"))
          ),
          column(
            width = 3, 
            actionButton("tab-3-load-shiny-module-dplyr", label = "Load Shiny module using dplyr"),
            hidden(p(id = "tab-3-load-shiny-module-dplyr-status", "loaded Shiny module 'lag' using library(dplyr)"))
          ),
          column(
            width = 3,
            actionButton("tab-3-load-modules-stats", label = "Load libary(module) using stats"),
            hidden(p(id = "tab-3-load-modules-stats-status", "loaded module 'stats_lag' using library(modules)"))
          ),
          column(
            width = 3,
            actionButton("tab-3-load-modules-dplyr", label = "Load libary(module) using dplyr"),
            hidden(p(id = "tab-3-load-modules-dplyr-status", "loaded module 'dplyr_lag' using library(modules)"))
          ),
          column(
            width = 12,
            verbatimTextOutput("tab-3-packages-loaded")
          )
        )
      )
    ),
  server = function(input, output, session) {
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
    
    # lag-copy ----
    observeEvent(input$`tab-3-lag-copy-func`,{
      output$`tab-3-lag-copy-res` <- renderPrint({
        list(
          `Called Time` = Sys.time(),
          Output = lag(1:5)
        )
      })
    })
    
    # packages loaded module
    packages_loaded <- reactiveVal((.packages()))
    
    output$`tab-3-packages-loaded` <- renderPrint({
      list(
        `Packages Loaded` = paste(packages_loaded(),collapse = ", ")
      )
    })
    
    # shiny module stats ----
    observeEvent(input$`tab-3-load-shiny-module-stats`, {
      source("modules/lag/lag_stats.R")
      packages_loaded(.packages())
      show("tab-3-load-shiny-module-stats-status")
      
      output$`tab-3-shiny-module-stats-lag-ui` <- renderUI({
        lagUI("tab-3-shiny-module-stats-lag")
      })
      
      callModule(
        lagSERVER, "tab-3-shiny-module-stats-lag"
      )
    })
    
    # shiny module dplyr ----
    observeEvent(input$`tab-3-load-shiny-module-dplyr`, {
      source("modules/lag/lag_dplyr.R")
      packages_loaded(.packages())
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
      
      packages_loaded(.packages())
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
      
      packages_loaded(.packages())
      show("tab-3-load-modules-dplyr-status")
      
      output$`tab-3-modules-dplyr-lag-ui` <- renderUI({
        used_module$lagUI("tab-3-modules-dplyr-lag")
      })
      
      callModule(
        used_module$lagSERVER, "tab-3-modules-dplyr-lag"
      )
    })
  }
)

