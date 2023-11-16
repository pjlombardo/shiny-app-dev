library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$qq_plot<-renderPlot({
        normal_qp_explore(input$sample_size, input$shape)
    })
    
    observeEvent(input$update,{
        
        output$histogram<-renderPlot({
            histogram_explore(input$sample_size, 
                              input$shape, 
                              input$bins)
        })
        
        output$qq_plot<-renderPlot({
            normal_qp_explore(input$sample_size, input$shape)
        })
        
    })
    
    observeEvent(input$bins,{
        
        output$histogram<-renderPlot({
            histogram_explore(input$sample_size, 
                              input$shape, 
                              input$bins)
        })
        
    })
    
}
