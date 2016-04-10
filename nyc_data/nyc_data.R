nyc_data <-
  read.csv("NYPD_Motor_Vehicle_Collisions.csv", stringsAsFactors = FALSE)

str(nyc_data)

summary(nyc_data)

## change the date and time columns
library(lubridate)
nyc_data$dates <- mdy(nyc_data$DATE)
nyc_data$times <- hm(nyc_data$TIME)

str(nyc_data)

## set the missing borough as OTHER
nyc_data$BOROUGH <-
  replace(nyc_data$BOROUGH, nyc_data$BOROUGH == "",  "OTHER")
unique(nyc_data$BOROUGH)

date_count <- data.frame(table(nyc_data$dates, nyc_data$BOROUGH))
names(date_count) <- c("date", "borough", "count")
date_count$dates <- as.Date(date_count$date)
date_count$borough <- as.character(date_count$borough)
str(date_count)

unique(date_count$borough)
rows2keep <- date_count$borough != "OTHER"
date_count <- date_count[rows2keep,]
# 
# library(maps)
# figure(width = 800, padding_factor = 0) %>%
#   ly_map("usa", col = "gray") %>%
#   ly_points(nyc_data$LONGITUDE, nyc_data$LATITUDE, data = nyc_data, size = 5,
#             hover = c(dates, BOROUGH))
# 
# library(maps)
# gmap(lat = 40.73306, lng = -73.97351, zoom = 12,
#      width = 680, height = 600,
#      map_style = gmap_style("blue_water")) %>%
#   ly_points(nyc_data$LONGITUDE, nyc_data$LATITUDE, data = nyc_data, hover = c(BOROUGH, DATE, TIME))


# plot_man <-
#   figure(width = 800, height = 400) %>%
#   ly_lines(
#     x = dates, y = count, data = date_count, alpha = 0.6, color = borough, hover = list(dates, count, borough)
#   ) %>%
#   ly_points(
#     dates, count, data = date_count, color = borough,size = 4, hover = list(dates, count, borough)
#   )
# plot_man

# get the borough-wise data
# manh_data <- nyc_data[nyc_data$BOROUGH == "MANHATTAN",]
# bklyn_data <- nyc_data[nyc_data$BOROUGH == "BROOKLYN",]
# brnx_data <- nyc_data[nyc_data$BOROUGH == "BRONX",]
# stil_data <- nyc_data[nyc_data$BOROUGH == "STATEN ISLAND",]
# quns_data <- nyc_data[nyc_data$BOROUGH == "QUEENS",]
# othr_data <- nyc_data[nyc_data$BOROUGH == "OTHER",]

# plot the year-wise data for every borough
# plot(table(manh_data$dates), "b")
# plot(table(manh_data$dates))

# library(ggmap)
# mymap <- get_map(location = "New York", maptype = "roadmap")
# ggmap(mymap)
# mymap
