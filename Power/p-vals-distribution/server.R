library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output) {
  p_vals<-reactiveValues(data = NULL)
  population<-reactiveValues(data = pop)
  
  observeEvent(input$pop_sd,{
    population$data<-rnorm(5000,100,input$pop_sd)
  })
  
  observeEvent(c(input$sample_size,input$null_mu, input$pop_sd),{
    p_vals$data<-run_HT_pval(input$sample_size,
                             input$null_mu,
                             population$data)
  })
  
  output$picture<-renderPlot({
    picture(p_vals$data)
  })
  
}