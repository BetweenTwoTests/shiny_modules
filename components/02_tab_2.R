
# Button example from https://shiny.rstudio.com/articles/modules.html

source("modules/counter/counter.R")

list(
  ui = 
    tabItem(
      tabName = "tab_2",
      fluidRow(
        box(
          title = "Without Shiny modules",
          width = 12,
          column(
            width = 3,
            actionButton("A-button", label = "Counter A"),
            verbatimTextOutput("A-out")
          ),
          column(
            width = 3,
            actionButton("B-button", label = "Counter B"),
            verbatimTextOutput("B-out")
          )
        ),
        box(
          title = "With Shiny modules",
          width = 12,
          column(
            width = 3,
            counterUI("C", "Counter C")
          ),
          column(
            width = 3,
            counterUI("D", "Counter D")
          )
        ),
        box(
          title = "All the input$* and output$* values",
          width = 12,
          verbatimTextOutput("tab_2_reactives")
        )
      )
    ),
  server = function(input, output, session){
    # ...................................................#
    # Without shiny module ----
    # Server logic for counter A
    count_A <- reactiveVal(0)
    observeEvent(input$`A-button`, {
      count_A(count_A() + 1)
    })
    output$`A-out` <- renderText({
      count_A()
    })
    
    # Server logic for Counter B
    count_B <- reactiveVal(0)
    observeEvent(input$`B-button`, {
      count_B(count_B() + 1)
    })
    output$`B-out` <- renderText({
      count_B()
    })
    
    # ...................................................#
    # With shiny module ----
    # Server logic for button-C
    callModule(counterSERVER, "C")
    
    
    # Server logic for button-D
    callModule(counterSERVER, "D")
    
    # ...................................................#
    output$tab_2_reactives <- renderPrint({
      relevant_inputs <- grep("button|out", names(input))
      relevant_outputs <- grep("button|out", names(outputOptions(output)))
      
      list(
        input = setNames(
          sapply(relevant_inputs, function(i) input[[ names(input)[i] ]]),
          names(input)[relevant_inputs]
        ),
        outputs = names(outputOptions(output))[relevant_outputs]
      )
    })
    
  }
)