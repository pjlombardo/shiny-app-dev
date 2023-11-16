library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output) {
    dens_bool<-reactiveValues(data=F)
    null2<-reactiveValues(data = pop2)
    null1_s<-reactiveValues(data =get_sample_means(pop1,15) )
    null2_s<-reactiveValues(data =get_sample_means(pop2,15) )
    sig_level_cut<-reactiveValues(data =NULL)
    power<-reactiveValues(data = NULL)
    
    observeEvent(input$mu_2, {  
        null2$data<-generate_null_distribution(95 + input$mu_2,10)
        null2_s$data<-get_sample_means(null2$data, input$sample_size) 
        sig_level_cut$data<-quantile((null1_s$data)$values,0.95)
        power$data<-sum((null2_s$data)$values>sig_level_cut$data)/length((null2_s$data)$values)
        
    })
    
    
    observeEvent(input$sample_size,{
        null1_s$data<-get_sample_means(pop1, input$sample_size)
        null2_s$data<-get_sample_means(null2$data, input$sample_size)
        sig_level_cut$data<-quantile((null1_s$data)$values,0.95)
        power$data<-sum((null2_s$data)$values>sig_level_cut$data)/length((null2_s$data)$values)
    })
    
    observeEvent(input$alpha, {
        sig_level_cut$data<-quantile((null1_s$data)$values,1-input$alpha)
        power$data<-sum((null2_s$data)$values>sig_level_cut$data)/length((null2_s$data)$values)
        
    })
    
    output$pops<-renderPlot({
        plot_paired_density(pop1,null2$data,"blue","turquoise4")
        
    })
    
    output$sampdists<-renderPlot({
        plot_paired_density_samp(null1_s$data, null2_s$data, 
                                 "dodgerblue","green4",
                                 sig_level_cut$data)
    })
    
    output$power<-renderText({
        paste("Power = ",round(power$data,3))
    })
    
}
