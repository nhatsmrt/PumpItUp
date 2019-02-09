#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(ggplot2)
library(ggmap)
library(leaflet)
library(dplyr)
library(tools)
library(DT)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Wells"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("wells",
                   "Number of Wells Displayed:",
                   min = 1,
                   max = 1000,
                   value = 30),
       downloadButton("download_data", "Download"),
       selectInput(
         "type", 
         "Display",
         choices = c(
           "Functional" = "functional", 
           "Functional, but need repair" = "functional needs repair", 
           "Non-Functional" = "non functional"
          ),
         selected = "non functional",
         multiple = TRUE
        )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map"),
      DT::dataTableOutput("table")
    )
  )
))

