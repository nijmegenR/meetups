library(ggplot2)
library(ggmap)

## Read data
dfNijmegen <- read.csv("dataNijmegen.csv")

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

selection <- c("P_GESCHEID", "BEV_DICHTH", "P_KOOPW", "P_LAAGINKP", "G_GAS_TOT", "P_GESCHEID")
dfNijmegen[, c("BU_NAAM", selection[1])]

grpNijmegen <- group_by(dfNijmegen, BU_NAAM)
tblNijmegen <- summarise(grpNijmegen,
                         P_GESCHEID = mean(P_GESCHEID),
                         BEV_DICHTH = mean(BEV_DICHTH),
                         P_KOOPWON = mean(P_KOOPWON),
                         P_LAAGINKP = mean(P_LAAGINKP),
                         G_GAS_TOT = mean(G_GAS_TOT)
)

ggplot(tblNijmegen, aes(x = BU_NAAM, y = P_GESCHEID)) + geom_bar(stat = "identity") + coord_flip()
