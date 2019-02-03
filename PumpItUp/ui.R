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
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("map")
    )
  )
))