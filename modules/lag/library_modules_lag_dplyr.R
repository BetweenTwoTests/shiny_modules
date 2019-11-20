# Modules for calculating lag() using 'dplyr' package
#
# Follows library(modules) rules

modules::import(shiny)
modules::import(dplyr)

#' Module function returning UI code
lagUI <- function(id) {
  ns <- NS(id)
  tagList(
    actionButton(ns("func"), label = "lag(1:5)"),
    verbatimTextOutput(ns("res"))
  )
}

#' Module function containing SERVER code
lagSERVER <- function(input, output, session) {
  observeEvent(input$`func`,{
    output$`res` <- renderPrint({
      list(
        `Called Time` = Sys.time(),
        Output = lag(1:5) # <--- note that which package's verison of lag is not being specified
      )
    })
  })
}