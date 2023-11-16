library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output) {
    # Tab A
    dens_boolA<-reactiveValues(data=F)
    null1A<-reactiveValues(data = generate_null_distribution(100,10))
    null2A<-reactiveValues(data = generate_null_distribution(110,10))
    null1_sA<-reactiveValues( data = get_sample_means(
        generate_null_distribution(100,10), m=5000,n=30
    )
    )
    
    null2_sA<-reactiveValues( data = get_sample_means(
        generate_null_distribution(100,10), m=5000,n=30
    )
    )
    
    observeEvent(input$dens_boolA,{
        dens_boolA$data=input$dens_boolA
    })
    
    
    observeEvent(input$mu_1A, {  
        null1A$data<-generate_null_distribution(input$mu_1A,10)
        null1_sA$data<-get_sample_means(null1A$data,m=5000,
                                       n=input$sample_sizeA)
    })
    
    observeEvent(input$mu_2A, {  
        null2A$data<-generate_null_distribution(input$mu_2A,10)
        null2_sA$data<-get_sample_means(null2A$data,m=5000,
                                       n=input$sample_sizeA)
    })
    
    
    observeEvent(input$sample_sizeA,{
        null1_sA$data<-get_sample_means(null1A$data,m=5000,
                                       n=input$sample_sizeA)
        
        null2_sA$data<-get_sample_means(null2A$data,m=5000,
                                       n=input$sample_sizeA)
        
    })
    
    output$popsA<-renderPlot({
        plot_paired_histograms(null1A$data,null2A$data,dens_boolA$data,'royalblue','tomato1')
        
    })
    
    output$samp_distsA<-renderPlot({
        plot_paired_histograms(null1_sA$data, null2_sA$data,dens_boolA$data,'blue4','red4')
        
    })
    
    
######################################################
    
    ## Tab B
    
    sample_numB<-reactiveValues(data = 1)
    dens_boolB<-reactiveValues(data=F)
    null1B<-reactiveValues(data = generate_null_distribution(100,10))
    null2B<-reactiveValues(data = generate_null_distribution(110,10))
    null1_sB<-reactiveValues( data = get_sample_means(
        generate_null_distribution(100,10), m=5000,n=30
    )
    )
    
    null2_sB<-reactiveValues( data = get_sample_means(
        generate_null_distribution(100,10), 
        m=5000,
        n=30
        )
    )
    
    #button stuff
    observeEvent(input$get_one_sampleB,{
        sample_numB$data<-sample_numB$data+1
    })
    
    observeEvent(input$get_one_hundred_samplesB,{
        sample_numB$data<-sample_numB$data + 100
    })
    
    observeEvent(input$resetB, {
        sample_numB$data<-1
    })
    
    
    
    
    observeEvent(input$dens_boolB,{
        dens_boolB$data<-input$dens_boolB
    })
    
    
    observeEvent(input$mu_1B, {  
        null1B$data<-generate_null_distribution(input$mu_1B,10)
        null1_sB$data<-get_sample_means(null1B$data,m=5000,
                                       n=input$sample_sizeB)
    })
    
    observeEvent(input$mu_2B, {  
        null2B$data<-generate_null_distribution(input$mu_2B,10)
        null2_sB$data<-get_sample_means(null2B$data,m=5000,
                                       n=input$sample_sizeB)
    })
    
    
    observeEvent(input$sample_sizeB,{
        null1_sB$data<-get_sample_means(null1B$data,m=5000,
                                       n=input$sample_sizeB)
        
        null2_sB$data<-get_sample_means(null2B$data,m=5000,
                                       n=input$sample_sizeB)
        
    })
    
    # output$pops<-renderPlot({
    #   plot_paired_histograms(null1$data,null2$data,dens_bool$data)
    # })
    
    output$samp_distsB<-renderPlot({
        plot_paired_histograms(null1B$data, null2B$data,dens_boolB$data)
    })
    
    output$diff_distB<-renderPlot({
        plot_hist_diff(null1_sB$data, null2_sB$data,dens_boolB$data,sample_numB$data)
    })

    
    
    
}
