library(shiny)
library(miniUI)
library(leaflet)
library(ggplot2)
library(ggmap)
library(dplyr)


## Read data
dfNijmegen <- read.csv("dataNijmegen.csv")
grpNijmegen <- group_by(dfNijmegen, BU_NAAM)
tblNijmegen <- summarise(grpNijmegen,
                        mean(P_GESCHEID),
                        mean(BEV_DICHTH),
                        mean(P_KOOPWON),
                        mean(P_LAAGINKP),
                        mean(G_GAS_TOT)
                        )

ui <- miniPage(
  gadgetTitleBar("Shiny gadget example"),
  miniTabstripPanel(
    miniTabPanel("Parameters", icon = icon("sliders"),
                 miniContentPanel(
                   selectInput(inputId = "var", "Variabele", c("P_GESCHEID", "BEV_DICHTH", "P_KOOPWON", "P_LAAGINKP", "G_GAS_TOT"), "P_GESCHEID")
                 )
    ),
    miniTabPanel("Visualize", icon = icon("area-chart"),
                 miniContentPanel(
                   plotOutput("cars", height = "100%")
                 )
    ),
    miniTabPanel("Map", icon = icon("map-o"),
                 miniContentPanel(padding = 0,
                                  plotOutput("map", height = "100%")
                 )
    ),
    miniTabPanel("Data", icon = icon("table"),
                 miniContentPanel(
                   DT::dataTableOutput("table")
                 )
    )
  )
)

server <- function(input, output, session) {
  
  
  
  output$cars <- renderPlot({
    require(ggplot2)
    ggplot(cars, aes(speed, dist)) + geom_point()
  })
  
  output$map <- renderPlot({
  
    filldata <- reactive({input$var})  
    ## Plot data
    mapCenter <- geocode("Nijmegen")
    Nijmegen <- get_map(c(lon=mapCenter$lon, lat=mapCenter$lat),zoom = 12)#, maptype = "terrain", source="google")
    NijmegenMap <- ggmap(Nijmegen)
    NijmegenMap <- NijmegenMap +
      geom_polygon(aes_string(x="long", y="lat", group="group", fill=filldata()),
                   size=.2 ,color='black', data=dfNijmegen, alpha=0.8) +
      scale_fill_gradient(low = "green", high = "red")
    NijmegenMap
  })
  
  output$table <- DT::renderDataTable({
    tblNijmegen
  })
  
  observeEvent(input$done, {
    stopApp(TRUE)
  })
}

shinyApp(ui, server)