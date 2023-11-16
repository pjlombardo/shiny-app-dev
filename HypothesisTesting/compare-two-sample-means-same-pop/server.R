library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    samples<-reactiveValues(data = samples_st)
    
    observeEvent(c(input$sample_size,input$get_new),{
        samples$data <- get_samples(input$sample_size)
    })
    
    output$boxplot<-renderPlot({
        get_boxplot(samples$data)
    })
    
    output$stripchart<-renderPlot({
        get_stripchart(samples$data)
    })
    
}
