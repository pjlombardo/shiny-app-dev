library(shiny)
library(ggplot2)

source('functions.R',local=TRUE)

server <- function(input, output) {
  xbar<-reactiveValues(data = s1)
  
  observeEvent(input$get_one_sample,{
    xbar$data <- sample(pop,1)
  })
  output$picture<-renderPlot({
    #since sampled_full is the ouput of eventReactive, need
    #sampled_full() to return the actual va
    picture(xbar$data,input$ci)
  })
  
}