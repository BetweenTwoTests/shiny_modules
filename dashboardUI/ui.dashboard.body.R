dashboardBody(
  useShinyjs(),
  tags$head(tags$style(HTML("pre { white-space: pre-wrap; word-break: keep-all; }"))),
  tabItems(
    shiny_component_tab_1$ui,
    shiny_component_tab_2$ui,
    shiny_component_tab_3$ui
  )
)
