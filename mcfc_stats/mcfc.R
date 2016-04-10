# Load the EPL data

eplData <- read.csv("Premier League 2011-12 Match by Match.csv")

# add the name of player ( FirstName + Surname)
eplData$PlayerName <-
  as.factor(paste(eplData$Player.Forename, eplData$Player.Surname, sep = ' '))

# Create data frame for every team's goals stats

TeamName <- names(tapply(eplData$Goals, eplData$Team, sum))
goalsDataFrame <- as.data.frame(TeamName)
goalsDataFrame$GoalsScored <-
  (tapply(eplData$Goals, eplData$Team, sum))
goalsDataFrame$GoalsAllowed <-
  (tapply(eplData$Goals, eplData$Opposition, sum))
goalsDataFrame$GoalsDifference <-
  goalsDataFrame$GoalsScored - goalsDataFrame$GoalsAllowed

## Create the data frame for players stats

PlayersName <- names(tapply(eplData$Goals, eplData$PlayerName, sum))
goalsEachPlayerFrame <- as.data.frame(PlayersName)
goalsEachPlayerFrame$GoalsScored <-
  tapply(eplData$Goals, eplData$PlayerName, sum, na.rm = TRUE)
goalsEachPlayerFrame$TotalShots <-
  tapply((
    eplData$Shots.On.Target.inc.goals + eplData$Shots.Off.Target.inc.woodwork
  ), eplData$PlayerName, sum
  )
goalsEachPlayerFrame$ConversionRatio <-
  (goalsEachPlayerFrame$GoalsScored / goalsEachPlayerFrame$TotalShots) * 100.0

# create a new data frame based on top 100 shots 
Top100Shots <-
  head(goalsEachPlayerFrame[order(goalsEachPlayerFrame$TotalShots, decreasing = TRUE),], n = 100)
