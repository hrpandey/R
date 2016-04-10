library(ggplot2)
library(scales)

source("mcfc.R")

shinyServer(function(input, output) {
  output$eplPlots <- renderPlot({
    inputType <- input$statType
    
    if ("PLAYER" == inputType) {
      Top100Shots <-
        head(goalsEachPlayerFrame[order(goalsEachPlayerFrame$TotalShots, decreasing = TRUE),], n = 100)
      
      convRatioPlot <-
        ggplot(Top100Shots, aes(x = Top100Shots$TotalShots, y = Top100Shots$GoalsScored))
      convRatioPlot <-
        convRatioPlot + geom_point(shape = 1, size = 2, col = "blue")
      convRatioPlot <-
        convRatioPlot + ggtitle("Coversion ratio for top 100 shots ")
      convRatioPlot <-
        convRatioPlot + theme(legend.title = element_blank())
      convRatioPlot <- convRatioPlot + xlab("Shots") + ylab("Goals")
      convRatioPlot <-
        convRatioPlot + geom_smooth(method = lm, se = FALSE, col = "red")
      convRatioPlot
    }
    else {
      goalsDataFrame <-
        head(goalsDataFrame[order(goalsDataFrame$TeamName, decreasing = TRUE),], n = 20)
      
      goalsPlot <-
        ggplot(goalsDataFrame, aes(goalsDataFrame$TeamName)) + ggtitle("Goal Difference")
      goalsPlot <-
        goalsPlot  + geom_point(aes(y = goalsDataFrame$GoalsScored, colour = "GoalsScored"))
      goalsPlot <-
        goalsPlot  + geom_point(aes(y = goalsDataFrame$GoalsAllowed, colour = "GoalsAllowed"))
      goalsPlot <-
        goalsPlot  + geom_point(aes(y = goalsDataFrame$GoalsDifference, colour = "GoalsDifference"))
      goalsPlot <- goalsPlot + xlab("Teams") + ylab("Goals")
      goalsPlot <- goalsPlot + labs("Legend")
      goalsPlot <-
        goalsPlot + theme(axis.text.x = element_text(
          angle = 50, size = 8, vjust = 0.5
        ))
      goalsPlot
    }
  })
  
  output$hover_info <- renderPrint({
    # cat("input$plot_hover:\n")
    cat("Mouse hover:\n")
    
    if ("PLAYER" == input$statType) {
      xValue = round(as.numeric(input$plot_hover$x))
      yValue = round(as.numeric(input$plot_hover$y))
      #       dataSubset <- subset(Top100Shots, (Top100Shots$TotalShots <= xValue & Top100Shots$TotalShots >=  xValue - 1 & Top100Shots$GoalsScored == yValue))
      dataSubset <-
        subset(Top100Shots, ((
          Top100Shots$TotalShots == xValue |
            Top100Shots$TotalShots == xValue - 1
        ) & Top100Shots$GoalsScored == yValue
        ))
      print(dataSubset, row.names = TRUE)
    }else{
      xValue = round(as.numeric(input$plot_hover$x))
      yValue = round(as.numeric(input$plot_hover$y))
      
      teamName <- goalsDataFrame$TeamName[xValue]
      goalsScored <- (goalsDataFrame$GoalsScored[xValue])
      goalsAllowed <- (goalsDataFrame$GoalsAllowed[xValue])
      goalDifference <- (goalsDataFrame$GoalsDifference[xValue])
      teamConst <- paste('Team = ', teamName)
      goalsScoredConst <- paste('GoalsScored = ', goalsScored)
      goalsAllowedConst <- paste('GoalsAllowed = ', goalsAllowed)
      goalDifferenceConst <-
        paste('GoalsDifference = ', goalDifference)
      
      cat(
        paste(
          teamConst, goalsScoredConst, goalsAllowedConst, goalDifferenceConst, sep = "\n"
        )
      )
    }
  })
  output$click_info <- renderPrint({
    cat("Mouse Click :\n")
    
    if ("PLAYER" == input$statType) {
      nearPoints(Top100Shots, input$plot_click, xvar = "TotalShots", yvar = "GoalsScored")
    }else{
      xValue = round(as.numeric(input$plot_click$x))
      yValue = round(as.numeric(input$plot_click$y))
      
      teamName <- goalsDataFrame$TeamName[xValue]
      goalsScored <- (goalsDataFrame$GoalsScored[xValue])
      goalsAllowed <- (goalsDataFrame$GoalsAllowed[xValue])
      goalDifference <- (goalsDataFrame$GoalsDifference[xValue])
      teamConst <- paste('Team = ', teamName)
      goalsScoredConst <- paste('GoalsScored = ', goalsScored)
      goalsAllowedConst <- paste('GoalsAllowed = ', goalsAllowed)
      goalDifferenceConst <-
        paste('GoalsDifference = ', goalDifference)
      cat(
        paste(
          teamConst, goalsScoredConst, goalsAllowedConst, goalDifferenceConst, sep = "\n"
        )
      )
    }
  })
  
  
})