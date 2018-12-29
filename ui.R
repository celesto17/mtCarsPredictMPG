# Course 9 - Developing Data Products: Week 4 Course Project
# Author: Sanjay Lonkar
# Date: 29-Dec-2018

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title/Title in browser
  titlePanel("Predicting a Car's MPG"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      h4("Instructions: "),
      helpText ("Select ", strong("Transmission Type"), ", ", strong ("Number of Cylinders"), ", ", strong("Weight of Car"), " and ", strong("Horse Power"), " to get predicted ", strong("Miles Per Gallon (MPG)")),
      
      tags$br (),
      
      radioButtons ("Trans", "Transmission", list ("Automatic" = 0,"Manual" = 1), "0"),
      radioButtons ("Cyl","Number of Cylinders",list("4" = 4,"6" = 6, "8" = 8),"4"),
      
      numericInput ("Weight","Weight of Car", value=2, min=1.513, max=5.424),
      sliderInput ("HP", "Gross Horse Power (HP):", min = 52, max = 335, value = 80),
      
      actionButton ("actionButton", "Predict MPG!", align = "center"),
      
      tags$br (),tags$br (),
      helpText("Note: "),
      helpText("a. Predicted results are displayed in ", strong("Prediction"), " tab."),
      helpText("b. For reference, complete mtcars dataset details are given in respective ", strong("Data Summary, Dataset")," and" ,strong("Comparision Plots")," tabs.")
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Prediced Results"),
      
      tabsetPanel (
        tabPanel("Prediction", 
          tags$br (),
          h3 ("Predicted MPG for given parameters of Transmission Type , Number of Cylinders , Weight of Car and Horse Power is "),         
          h3 (code (textOutput("newCarPredictedMPG"))) 
        ),
        
        tabPanel("Data Summary", 
          tags$br (),
          h3 ("Summary of mtcars dataset is as follows:"),    
          verbatimTextOutput ("summaryDataset")
        ), 
        
        tabPanel("Dataset",
          tags$br (),
          h3 ("Complete values of mtcars dataset are as follows:"),       
          tableOutput("mtcarsDataset")
        ),
        
        tabPanel("Comparision Plots", 
          tags$br (),
          h3 ("Plots showing MPG vis-a-vis different paramenters are as follows:"),
          plotOutput ("mtcarsPlots")
        )
      )
    )
  )
))
