library(maptools)
library(ggplot2)
library(ggmap)
library(sp)
library(rgdal)


# Use maptools to read shape data en make test plot
shapes <- readShapePoly("uitvoer_shape/buurt_2014.shp")
shapesNijmegen <- shapes[na.omit(shapes$GM_NAAM == "Nijmegen"),]
plot(shapesNijmegen)
text(coordinates(shapesNijmegen), labels=shapesNijmegen$BU_NAAM, cex=0.6)

# Use rgdal to read shape data and build plot with data.

## Read data and transform coordinates into Google type
shapes <- readOGR("uitvoer_shape", "buurt_2014")
shapes <- spTransform(shapes, CRS("+proj=longlat +datum=WGS84"))

## Select only Nijmegen with test plot
shapesNijmegen <- shapes[na.omit(shapes$GM_NAAM == "Nijmegen"),]
plot(shapesNijmegen, col=shapesNijmegen@data$AANT_INW)

## Change shape data into normal data frame
dfNijmegen <- fortify(shapesNijmegen)

## Add values form shape data to coordinate data frame and clean up
dfNijmegen$id <- as.factor(dfNijmegen$id)
shapesNijmegen@data <- cbind(shapesNijmegen@data, id = rownames(shapesNijmegen@data))
dfNijmegen <- merge(dfNijmegen, shapesNijmegen@data, by.x = "id", by.y = "id")
dfNijmegen[dfNijmegen == -99999999] <- NA

## Plot data
mapCenter <- geocode("Nijmegen")
Nijmegen <- get_map(c(lon=mapCenter$lon, lat=mapCenter$lat),zoom = 12)#, maptype = "terrain", source="google")
NijmegenMap <- ggmap(Nijmegen)
NijmegenMap <- NijmegenMap +
  geom_polygon(aes(x=long, y=lat, group=group, fill=P_GESCHEID),
               size=.2 ,color='black', data=dfNijmegen, alpha=0.8) +
  scale_fill_gradient(low = "green", high = "red")
NijmegenMap
