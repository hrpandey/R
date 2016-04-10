library(scales)
source("nyc_data.R")

shinyServer(function(input, output) {
  output$collisionsPlot <- renderRbokeh({
    # print(input$borough)
    # print(class(input))
    inType <- input$statType
    inBorough <- input$borough
    startDate <- input$dateRange[1]
    endDate <- input$dateRange[2]
    print(paste("Borough selected : ",inBorough, sep = " "))
    print(paste("Date range : ", startDate, " and ", endDate))
    
    data_to_plot <- date_count[date_count$borough == inBorough,]
    data_to_plot <- data_to_plot[data_to_plot$dates > startDate,]
    data_to_plot <- data_to_plot[data_to_plot$dates < endDate,]
    print(dim(data_to_plot))
    # dim(data_to_plot)
#     
    if("LINE" == inType){
      plot_man <- 
        figure(width = 800, height = 400) %>%
        ly_lines(
          x = dates, y = count, data = data_to_plot, alpha = 0.6, color = borough, hover = list(dates, count, borough)
        )  
    }else if("SCATTER" == inType){
      plot_man <- 
        figure(width = 800, height = 400) %>%
        ly_points(
          dates, count, data = data_to_plot, color = borough,size = 4, hover = list(dates, count, borough)
        )
      # %>%
      # lm.fit(x = dates, y = count, data = data_to_plot)
    }else{
      plot_man <- NULL
    }
    
#     library(maps)
#     
#     plot_man <- 
#     gmap(lat = 40.73306, lng = -73.97351, zoom = 12,
#          width = 680, height = 600,
#          map_style = gmap_style("blue_water")) %>%
#       ly_points(nyc_data$LONGITUDE, nyc_data$LATITUDE, data = nyc_data, hover = c(BOROUGH, DATE, TIME))
    
    
  })
})