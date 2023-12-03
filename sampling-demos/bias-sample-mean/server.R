library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output){
    
    # Tab 1a
    
    output$scatter_with_means1<-renderPlot({truth1})
    #Observe event connects the utton to the commands inside. Each time we click the
    # button, we will re=run the inside part.
    observeEvent(input$get_random_sample1, {
        #renderPlot connects the plotOutput with an actual plot. In our case, we 
        # create the plot in a function from earlier in the app.
        output$scatter_with_means1<-renderPlot({
            run_sample1(input$sample_size1)
        })
    })
    
    # Tab 1b
    num_sims1b<-reactiveValues(data=0)
    plt_main1b<-reactiveValues(plot=truth1)
    sampled_full<-eventReactive(input$sample_size1b, {
        collect(n=input$sample_size1b,2000)
    })
    
    observeEvent(input$get_one_sample1b,{
        strt<-num_sims1b$data+1
        num_sims1b$data<-num_sims1b$data+1
        stp<-num_sims1b$data
        plt_main1b$plot<-add_bars(plt_main1b$plot,
                                  sampled_full(),
                                  strt,stp)
    })
    
    observeEvent(input$get_one_hundred_samples1b,{
        strt<-num_sims1b$data+1
        num_sims1b$data<-num_sims1b$data+100
        stp<-num_sims1b$data
        plt_main1b$plot<-add_bars(plt_main1b$plot,
                                sampled_full(),
                                strt,stp)
    })
    
    observeEvent(input$reset1b, {
        strt<-1
        num_sims1b$data<-1
        stp<-1
        plt_main1b$plot<-truth1
        
    })
    
    observeEvent(input$sample_size1b, {
        strt<-1
        num_sims1b$data<-1
        stp<-1
        plt_main1b$plot<-truth1
    })

    
    #Observe event connects the utton to the commands inside. Each time we click the
    # button, we will re=run the inside part.
    output$scatter_with_means1b<-renderPlot({
        plt_main1b$plot
    })
    
##########################################################
    
    # Tab 2
    output$scatter_with_means2<-renderPlot({truth2})
    #Observe event connects the utton to the commands inside. Each time we click the
    # button, we will re=run the inside part.
    observeEvent(input$get_random_sample2, {
        #renderPlot connects the plotOutput with an actual plot. In our case, we 
        # create the plot in a function from earlier in the app.
        output$scatter_with_means2<-renderPlot({
            run_sample2(input$sample_size2)
        })
    })
    
    
    
    
}
