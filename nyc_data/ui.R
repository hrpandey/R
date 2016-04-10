library(htmlwidgets)
library(stringr)
library(rbokeh)

shinyUI(fluidPage(
  tags$head(tags$style(
    HTML("
         pre, table.table{
         font-size:smaller;
         }
         ")
    )),
  titlePanel("NYC road collisions"),
  
  fluidRow(column(width = 3, wellPanel(
    radioButtons(
      "borough", "Borough",
      c("MANHATTAN","QUEENS","BRONX","BROOKLYN","STATEN ISLAND"),
      selected = "MANHATTAN"
    )
  )),
  
  column(
    width = 5,
    rbokehOutput("collisionsPlot", height = 400, width = 800)
  )),
  fluidRow(column(width = 3,
                  wellPanel(
                    radioButtons(
                      "statType", "MapType",
                      c("LINE","SCATTER","HEATMAP"),
                      selected = "SCATTER"
                    )
                  ))),
  fluidRow(column(
    width = 3,
    dateRangeInput(
      "dateRange", label = "Date range for plot", start = "2012-01-01", end = "2016-03-31"
    )
  ))
  
    ))