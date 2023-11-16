library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output) {

  # set up reactive values and initial conditions.
  null_pop<-reactiveValues(data = initial_null_pop)
  null_samp_dist_mtx<-reactiveValues(
    data = NULL
  )
  
  act_pop_sampdist<-reactiveValues(data = get_sampling_distribution_mtx(actual_population,30))
  null_pop_sampdist<-reactiveValues(data =get_sampling_distribution_mtx(initial_null_pop,30))
  round<-reactiveValues(x=1)
  
  #set up observable events to update
  # tab 1
  observeEvent(input$p_0, {
    null_pop$data<-gen_pop(input$p_0)
    null_pop_sampdist$data <- get_sampling_distribution_mtx(null_pop$data, 
                                                            input$samp_size)
  })
  
  #tab 2
  observeEvent(input$samp_size, {
    null_pop_sampdist$data <- get_sampling_distribution_mtx(null_pop$data, 
                                                             input$samp_size)
    
    act_pop_sampdist$data<-get_sampling_distribution_mtx(actual_population,
                                                  input$samp_size)
  })
  
  observeEvent(input$get_one_sample,{
    if (round$x < 2000){
      round$x<-round$x+1
    } 
  })
  
  observeEvent(input$get_one_hundred_samples, {
    if (round$x < 1900) {
      round$x<-round$x+100
      }
  })
  
  observeEvent(input$reset,{
    round$x<-1
  })
  
  # should also depend on a reactive round_number
  # that we can update with get_sample and get_50_samples
  
  # observeEvent(input$samp_size,{
  #   actual_samp_dist_mtx$data<-
  # })
  
  
  
  # set up outputs.
  # Tab 1
  output$null_pop_plot<-renderPlot({
    create_pop_plot(null_pop$data,F)
    })
  
  output$actual_pop_plot<-renderPlot({
    create_pop_plot(actual_population,T)
  })
  
  #Tab 2
  output$sample_from_null<-renderPlot({
    sampling_plot(null_pop$data,null_pop_sampdist$data,round$x)
  })
  
  output$null_samp_dist<-renderPlot({
    hist_plots(null_pop_sampdist$data, 
               round$x,
               act_pop_sampdist$data,
               input$bin_count,
               input$pops)
    # hist(act_pop_sampdist$data)
  })

  # output$testing<-renderText({
  #   as.character(mean(null_pop$data))
  # })
  # 
  output$sample_counter<-renderText({
    paste("Total Samples Collected: ",as.character(round$x))
  })
}