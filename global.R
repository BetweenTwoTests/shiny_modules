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
rm(package)

# Load Packages. The order of loading package is intentiontal. 
library(modules)
library(shiny)
library(shinydashboard)
library(shinyjs)

# don't load library(dplyr)