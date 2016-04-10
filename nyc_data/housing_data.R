library(maptools)
library(rgdal)

fema.points<-readOGR(".../femaPoints/", "femaPoints")
boros<-readOGR(".../nybb/", "nybb")

fema.points<-spTransform(fema.points, CRS("+proj=longlat +datum=NAD83"))
boros<-spTransform(boros, CRS("+proj=longlat +datum=NAD83"))


x <- c("ggmap", "rgdal", "rgeos", "maptools", "dplyr", "tidyr", "tmap")
install.packages(x)
lapply(x, library, character.only = TRUE)
