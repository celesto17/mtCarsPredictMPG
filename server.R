# Course 9 - Developing Data Products: Week 4 Course Project
# Author: Sanjay Lonkar
# Date: 29-Dec-2018

library(shiny)
library(ggplot2)
library(gridExtra)

# Fit linear model
mFit = lm (mpg ~ am + cyl + wt + hp, data=mtcars)

# Define server logic for this application
shinyServer(function(input, output) {
  
  # Reactive expression to predict the mpg. Called whenever the inputs change.
  output$myTrans <- renderText({ input$Trans })
  
  # TAB 1 - Predict MPG
  output$newCarPredictedMPG <- renderText({ 
    input$actionButton
    isolate({
      # am + cyl + wt + hp
      newCarPredictors = data.frame (am=as.numeric(input$Trans), cyl = as.numeric(input$Cyl), wt = as.numeric(input$Weight), hp=as.numeric(input$HP))
      newCarPredictedMPG  <- predict (mFit, newCarPredictors)
    })
  })
  
  # TAB 2 - Summary of dataset
  output$summaryDataset <- renderPrint({
    summary(mtcars)
  })
  
  # TAB 3 - Dataset
  # Generate an HTML table view of the data
  output$mtcarsDataset <- renderTable ({
    data.frame(mtcars)
  })
  
  # TAB 4 - PLOTS
  output$mtcarsPlots <- renderPlot ({
    plotMPGtoAM <- ggplot(mtcars, aes(am, mpg)) + labs (x = "Transmission 0 - Manual, 1 - Automatic", y = "Miles Per Gallon (MPG)", title = "MPG to Car Transmission Type") + geom_point() + geom_smooth (method="lm", color="Red")
    plotMPGtoCYL <- ggplot(mtcars, aes(cyl, mpg)) + labs (x = "Number of Cylinders", y = "Miles Per Gallon (MPG)", title = "MPG to Number of Car Cylinders") + geom_point() + geom_smooth (method="lm", color="Green")
    plotMPGtoWT <- ggplot(mtcars, aes(wt, mpg)) + labs (x = "Weight", y = "Miles Per Gallon (MPG)", title = "MPG to Weight of Car")  + geom_point() + geom_smooth(method="lm", color="Blue")
    plotMPGtoHP <- ggplot(mtcars, aes(hp, mpg)) + labs (x = "Horse Power (HP)", y = "Miles Per Gallon (MPG)", title = "MPG to Car Horse Power")  + geom_point() + geom_smooth(method="lm", color="Magenta")
    grid.arrange (plotMPGtoAM, plotMPGtoCYL, plotMPGtoWT, plotMPGtoHP, ncol = 2)
  })
})
