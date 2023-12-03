library(shiny)
library(ggplot2)


source('functions.R')


server <- function(input, output) {
  n<-reactiveValues(data = 5)
  observeEvent(input$sample_size,{
    n$data <-input$sample_size
  })
  output$picture<-renderPlot({
    #since sampled_full is the ouput of eventReactive, need
    #sampled_full() to return the actual va
    picture(n$data-1)
  })
  
}