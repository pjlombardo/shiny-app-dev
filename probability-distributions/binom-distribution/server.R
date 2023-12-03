library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output) {
  output$density<-renderPlot({
    gen_pmf_hist(input$n,input$p, input$show_range)
  })
  
  output$mean<-renderText({
    gen_text_mean(input$n,input$p)
  })
  output$sd<-renderText({
    gen_text_sd(input$n,input$p)
  })

}