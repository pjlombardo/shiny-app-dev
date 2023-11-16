library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    dens_bool<-reactiveValues(data=F)
    null1<-reactiveValues(data = generate_null_distribution(100,10))
    null2<-reactiveValues(data = generate_null_distribution(110,10))
    sm_table<-reactiveValues(data = NULL)
    
    observeEvent(input$mu_1, {  
        null1$data<-generate_null_distribution(input$mu_1,10)
        sm_table$data<-get_sample_means(null1$data, null2$data,input$sample_size)
    })
    
    observeEvent(input$mu_2, {  
        null2$data<-generate_null_distribution(input$mu_2,10)
        sm_table$data<-get_sample_means(null1$data, null2$data,input$sample_size)
        
    })
    
    
    observeEvent(input$sample_size,{
        sm_table$data<-get_sample_means(null1$data, null2$data,input$sample_size)
    })
    
    observeEvent(input$get_samples,{
        sm_table$data<-get_sample_means(null1$data, null2$data,input$sample_size)
    })
    
    output$pops<-renderPlot({
        plot_paired_histograms(null1$data,null2$data)
        
    })
    
    output$sample_means<-renderTable({
        sm_table$data
    })
    
    
}
