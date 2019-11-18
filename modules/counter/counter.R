# Modules for counting and displaying counts


#' Module function returning UI code
counterUI <- function(id, label) {
  ns <- NS(id)
  tagList(
    actionButton(ns("button"), label = label),
    verbatimTextOutput(ns("out"))
  )
}

#' Module function containing SERVER code
counterSERVER <- function(input, output, session) {
  count <- reactiveVal(0)
  observeEvent(input$button, {
    count(count() + 1)
  })
  output$out <- renderText({
    count()
  })
  count
}