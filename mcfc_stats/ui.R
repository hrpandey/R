shinyUI(fluidPage(
  # Some custom CSS for a smaller font for preformatted text
  tags$head(tags$style(
    HTML("
         pre, table.table {
         font-size: smaller;
         }
         ")
    )),
  
  titlePanel("EPL Stats"),
  
  fluidRow(column(width = 2, 
                  wellPanel(
    radioButtons("statType", "Stat type",
                 c("TEAM", "PLAYER"), selected = "TEAM")
  )
  ),
  
  column(
    width = 3,
    plotOutput(
      "eplPlots", height = 450, width = 700,
      click = clickOpts(id = "plot_click"),
      hover = hoverOpts(id = "plot_hover")
    )
  )),
  fluidRow(
    column(width = 2,
           verbatimTextOutput("click_info")),
    column(width = 2,
           verbatimTextOutput("hover_info"))
  )
    ))
