
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
              uiOutput("tab-3-shiny-module-lag-ui")
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
                  "stats_modules",
                  h4("Example of using stats::lag function from library(modules) 'stats_lag_modules.R'"),
                  uiOutput("tab-3-modules-stats-lag-ui")
                ),
                tabPanel(
                  "dplyr_modules",
                  h4("Example of using dplyr::lag function from library(modules) 'dplyr_lag_modules.R'"),
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
            actionButton("tab-3-load-shiny-module", label = "Load Shiny module"),
            hidden(p(id = "tab-3-load-shiny-module-status", "loaded module 'lag' using library(shiny)"))
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
    
    # shiny-module ----
    observeEvent(input$`tab-3-load-shiny-module`, {
      source("modules/lag/lag.R")
      packages_loaded(.packages())
      show("tab-3-load-shiny-module-status")
      
      output$`tab-3-shiny-module-lag-ui` <- renderUI({
        lagUI("tab-3-shiny-module-lag")
      })
      
      callModule(
        lagSERVER, "tab-3-shiny-module-lag"
      )
    })
    
    observeEvent(input$`tab-3-load-shiny-module`, {
      source("modules/lag/lag.R")
      packages_loaded(.packages())
      show("tab-3-load-shiny-module-status")
      
      output$`tab-3-shiny-module-lag-ui` <- renderUI({
        lagUI("tab-3-shiny-module-lag")
      })
      
      callModule(
        lagSERVER, "tab-3-shiny-module-lag"
      )
    })
    
    
    # shiny-module ----
    observeEvent(input$`tab-3-load-shiny-module`, {
      source("modules/lag/lag.R")
      packages_loaded(.packages())
      show("tab-3-load-shiny-module-status")
      
      output$`tab-3-shiny-module-lag-ui` <- renderUI({
        lagUI("tab-3-shiny-module-lag")
      })
      
      callModule(
        lagSERVER, "tab-3-shiny-module-lag"
      )
    })
    
    # library(modules) dplyr ----
    output$`tab-3-modules-dplyr-lag-ui` <- renderUI({
      p('Click on button below "Load library(modules) using dplyr" to use this')
    })
    
    observeEvent(input$`tab-3-load-modules-dplyr`, {
      used_module <- modules::use("modules/lag/dplyr_lag_modules.R")
      
      packages_loaded(.packages())
      show("tab-3-load-modules-dplyr-status")
      
      output$`tab-3-modules-dplyr-lag-ui` <- renderUI({
        used_module$lagUI("tab-3-modules-dplyr-lag")
      })
      
      callModule(
        used_module$lagSERVER, "tab-3-modules-dplyr-lag"
      )
    })
    
    # library(modules) stats ----
    output$`tab-3-modules-stats-lag-ui` <- renderUI({
      p('Click on button below "Load library(modules) using stats" to use this')
    })
    
    observeEvent(input$`tab-3-load-modules-stats`, {
      used_module <- modules::use("modules/lag/stats_lag_modules.R")
      
      packages_loaded(.packages())
      show("tab-3-load-modules-stats-status")
      
      output$`tab-3-modules-stats-lag-ui` <- renderUI({
        used_module$lagUI("tab-3-modules-stats-lag")
      })
      
      callModule(
        used_module$lagSERVER, "tab-3-modules-stats-lag"
      )
    })
  }
)

