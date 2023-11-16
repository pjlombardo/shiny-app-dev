library(shiny)
library(ggplot2)
library(latex2exp)

source('functions.R')

server <- function(input, output) {
  output$density<-renderPlot({
    gen_pdf(input$d, input$show_range)
  })
  
  # output$mean<-renderText({
  #   gen_text_mean(input$n,input$p)
  # })
  # output$sd<-renderText({
  #   gen_text_sd(input$n,input$p)
  # })

}