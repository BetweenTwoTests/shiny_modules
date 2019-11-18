# Shiny code for sidebarMenu item: setup
# 
#
# source any shiny modules needed for this shiny code
# -- This tab is an example of not using a module::use because this tab is a simple tab

list(
  ui = 
    tabItem(
      tabName = "tab_1",
      fluidRow(
        box(
          width = 12,
          h2("Using Shiny modules and library(modules)"),
          p(
            "'Shiny Module' tab is an example of how Shiny modules can be used to re-use R logic",
            "and have same input$ and output$ ID pattern as raw Shiny code"
          ),
          hr(),
          p(
            "'Module' tab is an example of how Shiny modules can affect the packages loade",
            "and therefore affect the result of 'lag(1:5)' result based on the order of execution", 
            "(Press 'Load Shiny module' button to see how list of packages loaded change and",
            "'Example of using lag function without specifying' outputs change based on whether the",
            "'Load Shiny module' was clicked or not"
          ),
          p(
            "Loading Shiny module via library(modules) module prevents such error"
          )
        )
      )
    ),
  server = function(input, output, session){
    
  }
)