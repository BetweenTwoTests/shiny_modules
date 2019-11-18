dashboardSidebar(
  sidebarMenu(
    id = "sidebarMenuTab",
    menuItem(
      "App", 
      tabName = "tab_1", 
      icon = icon("globe"),
      selected = TRUE
    ),
    menuItem(
      "Shiny Module",
      tabName = "tab_2", 
      icon = icon("book-open")
    ),
    menuItem(
      "Module",
      tabName = "tab_3", 
      icon = icon("boxes")
    )
  )
)