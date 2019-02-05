#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(ggmap)
library(leaflet)
library(dplyr)
library(tools)


df_train_features <- read.csv("./Data/train.csv")
df_train_label <- read.csv("./Data/train_label.csv")
df_train <- df_train_features %>% left_join(
  df_train_label,
  by = "id"
)

factor_levels <- 
  toTitleCase(levels(df_train_label$status_group))
pal <- colorFactor(
  palette = c("green", "yellow", "red"),
  levels = levels(df_train_label$status_group)
)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  df_train_sampled = reactive({head(df_train, input$wells)})
  output$map <- renderLeaflet({
    leaflet() %>% 
      addProviderTiles("CartoDB") %>% 
      addCircleMarkers(
        data = df_train_sampled(),
        lat = ~latitude, 
        lng = ~longitude,
        radius = 0.5,
        color = ~pal(status_group),
        label = ~status_group
      ) %>% 
      addLegend(
        data = df_train_sampled(),
        position = "bottomright",
        pal = pal,
        values = ~levels(status_group),
        title = "Status"
      )
  }) 
  
  output$download_data <- downloadHandler(
    filename = "data.csv",
    content <- function(file) {
      write.csv(df_train_sampled(), file, row.names = FALSE)
    }
  )
  

})
