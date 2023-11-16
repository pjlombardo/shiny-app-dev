library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output) {
    
    null1<-reactiveValues(data = generate_null_distribution(100,10))
    null1_s<-reactiveValues( data = get_sample_means(
        generate_null_distribution(100,10), m=5000,n=30
    )
    )
    
    
    
    observeEvent(c(input$mu_1,input$sample_size), {  
        null1$data<-generate_null_distribution(input$mu_1,10)
        null1_s$data<-get_sample_means(null1$data,m=5000,
                                       n=input$sample_size)
    })
    
    
    
    # output$pops<-renderPlot({
    #   plot_pop_histograms(null1$data,dens_bool$data)
    #   
    # })
    # data1,dens_bool,t_bool,mu,n
    output$samp_dists<-renderPlot({
        plot_sample_histograms(data1 = null1_s$data,
                               dens_bool = input$dens_bool,
                               t_bool = input$t_bool,
                               mu = input$mu_1,
                               n = input$sample_size)
        
    })
    
    # output$diff_dist<-renderPlot({
    #   plot_hist_diff(null1_s$data, null2_s$data)
    #   
    # })
    
}
