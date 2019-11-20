source("global.R")

shiny_component_tab_1 <- source("components/01_tab_1.R")$value
shiny_component_tab_2 <- source("components/02_tab_2.R")$value
shiny_component_tab_3 <- source("components/03_tab_3.R")$value


shinyApp(
  # ................................. #
  # Shiny UI Component ----
  # ................................. #
  ui = shinyUI(
    dashboardPage(
      title = "Module App",
      header = source("dashboardUI/ui.dashboard.header.R", local = T)$value,
      sidebar = source("dashboardUI/ui.dashboard.sidebar.R", local = T)$value,
      body = source("dashboardUI/ui.dashboard.body.R", local = T)$value
    )
  ),
  # ................................. #
  # Shiny SERVER Component ----
  # ................................. #
  #
  # Server logic
  server = function(input, output, session) {
    # Server logic for setup menuItem (01_tab_1.R)
    shiny_component_tab_1$server(input, output, session)
    
    # Server logic for toc menuItem (02_tab_2.R)``
    shiny_component_tab_2$server(input, output, session)
    
    # Server logic for toc menuItem (03_tab_3.R)
    shiny_component_tab_3$server(input, output, session)
    
    # To reset the lag example on app refresh (session and restart)
    onSessionEnded(function() { 
      if ("dplyr" %in% .packages()) {
        detach(name = "package:dplyr", unload = TRUE)
      }
    })
    
    onStop(function() { 
      if ("dplyr" %in% .packages()) {
        detach(name = "package:dplyr", unload = TRUE)
      }
      if(exists("lagUI")) {
        rm(lagUI,envir = .GlobalEnv)
      }
      if(exists("lagSERVER")) {
        rm(lagSERVER,envir = .GlobalEnv)
      }
    })
  }
)
