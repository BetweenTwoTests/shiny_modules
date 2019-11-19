source("global.R")

shiny_component_tab_1 <- source("components/01_tab_1.R")$value
shiny_component_tab_2 <- source("components/02_tab_2.R")$value
shiny_component_tab_3 <- source("components/03_tab_3.R")$value

use <- function(file) {
  ## - custom definition of modules::use to circumvent base::library
  ## - use with care
  ## - still throws a warning, which is expected
  e <- new.env(parent = baseenv())
  e$library <- modules::import
  modules::as.module(file, topEncl = e)
}

m <- use("modules/lag")

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
    
    # To reset the lag example
    onSessionEnded(function() { 
      if ("dplyr" %in% .packages()) {
        detach(name = "package:dplyr", unload = TRUE)
      }
    })
    
    onStop(function() { 
      if ("dplyr" %in% .packages()) {
        detach(name = "package:dplyr", unload = TRUE)
      }
    })
  }
)
