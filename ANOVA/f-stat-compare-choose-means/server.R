library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    samples<-reactiveValues(data = samples_st)
    aov_obj<-reactiveValues(data = aov_st)
    
    observeEvent(c(input$sample_size,input$get_new,
                   input$mu1, input$mu2, input$mu3),{
                       samples$data <- get_samples(input$sample_size, input$mu1, input$mu2, input$mu3)
                       aov_obj$data <- get_anova(samples$data)
                   })
    
    output$stripchart<-renderPlot({
        get_stripchart(samples$data)
    })
    
    output$MS_group<-renderText({
        paste("Group Means Squared = ", 
              round((aov_obj$data)[[1]][,"Mean Sq"][1],2))
    })
    
    output$MS_error<-renderText({
        paste("Error Mean Squared = ", 
              round((aov_obj$data)[[1]][,"Mean Sq"][2],2))
    })
    
    output$F_ratio<-renderText({
        paste("F-score = ", 
              round((aov_obj$data)[[1]][,"F value"][1],2))
    })
    
}
