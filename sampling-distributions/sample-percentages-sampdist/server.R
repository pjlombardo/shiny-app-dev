library(shiny)
library(dplyr)
library(ggplot2)
library(patchwork)
library(scales)

source('functions.R')

server <- function(input, output) {
  # Tab 1
  sample_num1<-reactiveValues(data=1)
  population1<-reactiveValues(data = initial_pop1)
  sampled_full1<-reactiveValues(data = initial_indices1)
  # 
  observeEvent(input$p_pop1,{
    sample_num1$data<-1
    population1$data<-gen_pop(input$p_pop1)
    sampled_full1$data <-get_indices1(population1$data,
                                n=input$sample_size1)
  })

  observeEvent(input$get_one_sample1,{
      if (sample_num1$data <4000){
          sample_num1$data<-sample_num1$data+1
      }
  })

  observeEvent(input$get_one_hundred_samples1,{
      if (sample_num1$data <3900){
          sample_num1$data<-sample_num1$data+100
      }
  })

  observeEvent(input$reset1, {
    sample_num1$data<-1
  })

  observeEvent(input$sample_size1, {
    sample_num1$data<-1
    sampled_full1$data <-get_indices1(population1$data,
                                    n=input$sample_size1)
  })
  
  
  output$plots1<-renderPlot({
    # show_pop_sample(population$data,
    #                 sampled_full$data,
    #                 sample_num$data)
    #since sampled_full is the ouput of eventReactive, need
    #sampled_full() to return the actual va
    pt2_temp<-update_sampling_dist1(sampled_full1$data,
                                   sample_num1$data,
                                   input$bin_count1)
    # pt2<-get_segs(pt2_temp,sampled_full$data,sample_num$data)
    pt1<-show_pop_sample1(population1$data,
                         sampled_full1$data,
                         sample_num1$data,
                         input$p_pop1)
    pt1/pt2_temp
  })
  
  
#####################################################
  
  # Tab 2
  
  
  output$histograms2<-renderPlot({

      output$histograms2<-renderPlot({
          plot_tab_2(sample_means2$data, input$sample_size2, input$p_val2, input$show_pop)
      })
      
  })   
  
  # output$popdata<-renderTable({sample_means$data})
  
  population2<-reactiveValues(
      data = start_pop
  )
  
  sample_means2<-reactiveValues(
      data= get_sampling_distribution2(start_pop, m=m2,n=10)
      
  )
  # 
  observeEvent(input$p_val2,{
      
      population2$data<-data.frame(values = c(rep("Crow",input$p_val2*5100),
                                             rep("Other",(1-input$p_val2)*5100))
      )
      
      sample_means2$data <- get_sampling_distribution2(population2$data,
                                                     m=m2,
                                                     n=input$sample_size2)
      
      output$std_error2<-renderText({
          paste("Standard Error =",
                round(sd(sample_means2$data[,1],
                         na.rm=T),5)
          )
      })
      
      output$p_hat2<-renderText({
          paste("Estimated Population Proportion =",
                round(mean(sample_means2$data[,1],
                           na.rm=T),5)
          )
      })
  })
  
  
  observeEvent(input$sample_size2, {
      sample_means2$data = get_sampling_distribution2(population2$data,
                                                    m=m2,
                                                    n=input$sample_size2)
      
      output$histograms2<-renderPlot({
          plot_tab_2(sample_means2$data, input$sample_size2, input$p_val2, input$show_pop)
      })
      
  })
  
  observeEvent(input$show_pop, {
      output$histograms2<-renderPlot({
          plot_tab_2(sample_means2$data, input$sample_size2, input$p_val2, input$show_pop)
      })
  })
  
  
  
}

