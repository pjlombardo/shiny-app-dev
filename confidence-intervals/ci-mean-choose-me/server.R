library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # Reactive values
    record_num<-reactiveValues(data=0)
    rlist<-reactiveValues(data=get_index_and_bars(5, 1))
    plot_samples<-reactiveValues(data= truth)
    plot_cis<-reactiveValues(data= ci_record)
    
    
    output$sampling<-renderPlot({
        plot_samples$data
    })
    
    output$conf_int<-renderPlot({
        plot_cis$data+
            labs(x="",
                 y="")+
            geom_hline(yintercept=rlist$data[[2]][record_num$data,'m'],
                       col='blue',
                       lty=2, linewidth=.7)
    })
    
    output$success_rate<-renderText({
        sr<-100*(sum(rlist$data[[2]]$flag[1:record_num$data]=='blue')/record_num$data)
        paste("Success Rate: ",sr,"%")
    })
    
    observeEvent(input$sample_size,{
        rlist$data= get_index_and_bars(input$sample_size, input$ME)
        plot_samples$data<-truth
        plot_cis$data<-ci_record
        record_num$data<-0
    })
    
    observeEvent(input$ME,{
        rlist$data <- update_margin_error(rlist$data,input$ME)
        plot_cis$data<-add_ci(record_num$data,
                              rlist$data[[2]],input$show_interval)
    })
    
    observeEvent(input$get_samp,{
        record_num$data<-record_num$data+1
        plot_samples$data<-plot_with_sample(truth,record_num$data,
                                            rlist$data[[1]],
                                            rlist$data[[2]])
        
        plot_cis$data<-add_ci(record_num$data,
                              rlist$data[[2]],input$show_interval)
        
    })
    
    observeEvent(input$show_interval,{
        if (record_num$data==0) {
            plot_cis$data<-ci_record
        } else {
            plot_cis$data<-add_ci(record_num$data,
                                  rlist$data[[2]],input$show_interval)}
    })
    
    observeEvent(input$get_50,{
        record_num$data<-record_num$data+50
        plot_samples$data<-plot_with_sample(truth,record_num$data,
                                            rlist$data[[1]],
                                            rlist$data[[2]])
        
        plot_cis$data<-add_ci(record_num$data,
                              rlist$data[[2]],input$show_interval)
        
    })
    
    observeEvent(input$reset, {
        plot_samples$data<-truth
        plot_cis$data<-ci_record
        record_num$data<-0
    })
    
    
    #workflow: 
    # sample_index as reactive value that updates
    # success_rate as reactive value that updates
    # record_num as reactive value that updates
    # get sample: updates sample_index, show the sample and sample mean
    # in pane 1, adds mean and CI in pain 2, update 
    # success_rate.
    # render the current success rate of the CI
    # get 100 sample: repeats process above 100 times.
}
