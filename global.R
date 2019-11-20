# R Options ----------------------------------------------------------------
options(
  shiny.autoload.r = FALSE # for shiny 1.4.0+, R/ folder is automatically sourced.
)
# Packages ----------------------------------------------------------------
# Quick way to install all necessary packages
required_packages <- c("modules", "shiny", "shinydashboard", "shinyjs", "dplyr")
for (package in required_packages) {
  if (!(package %in% row.names(installed.packages()))) {
    install.packages(package)
  }
}
rm(package, required_packages)

# Load Packages. The order of loading package is intentiontal. 
# library(modules)
library(shiny)
library(shinydashboard)
library(shinyjs)

# don't load library(dplyr)

wahani_use <- function(file) {
  ## - custom definition of modules::use to circumvent base::library
  ## - use with care
  ## - still throws a warning, which is expected
  e <- new.env(parent = baseenv())
  e$library <- modules::import
  modules::as.module(file, topEncl = e)
}

betweentwotests_use <- function(file) {
  # create base environment with module_filename
  # because module_filename is determined by user input (app requirement)
  e <- new.env(parent = baseenv())
  e$file <- file
  
  modules::module({
    # Load base & friends
    modules::import("stats")
    # ... rest omitted for demo purpose
    
    # mask base::library
    library <- modules::import
    
    source(file, local=TRUE)
  },topEncl = e)
}

# Test
# module_filename <- "modules/lag/lag_stats.R"
# wahani_m <- wahani_use(module_filename)
# wahani_m$lagUI("test")       # Doesn't work; shiny::NS functions not found
# wahani_m$lag_test()          # Doesn't work; stats::lag function not found
#
# betweentwotests_m <- betweentwotests_use(module_filename)
# betweentwotests_m$lagUI("test")
# betweentwotests_m$lag_test()