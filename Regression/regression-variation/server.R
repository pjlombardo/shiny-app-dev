
library(shiny)
library(tidyverse)
library(knitr)
library(kableExtra)
source('functions.R')

server<-function(input,output){
    sampVals<-reactiveValues(data = s)
    
    output$regPlot1<-renderPlot({
        init_plot
    })
    
    observeEvent(c(input$get1, input$get2, input$get3),{
        sampVals$data<-sample(1:500,35)
    })
    
    output$regPlot1<-renderPlot({
        get_plot(sampVals$data,input$show1)
    })
    
    
    # corr
    # plot_shown<-reactiveValues(p = init_plot)
    # 
    # observeEvent(input$get2,{
    #     sampVals$data<-sample(1:500,35)
    #     plot_shown$p <- get_plot(sampVals$data)
    # })
    
    output$regPlot2<-renderPlot({
        get_plot(sampVals$data,input$show2)
    })
    
    output$t2<-function(){
        get_sample_table_cor(sampVals$data) %>%
            knitr::kable("html",
                         col.names = c("Population Correlation (rho)",
                                       "Sample Correlation (r)"),
                         escape=FALSE) %>%
            kable_styling("striped", full_width = F) 
    }
        #code goes here for table.

    
    # output$t2<-renderTable({
    #     #code goes here for table.
    #     get_sample_table_cor(sampVals$data)
    # })
    
    
    # coef
    # sampVals<-reactiveValues(data = s)
    # plot_shown<-reactiveValues(p = init_plot)
    # 
    # observeEvent(input$get,{
    #     sampVals$data<-sample(1:500,35)
    #     plot_shown$p <- get_plot(sampVals$data)
    # })
    
    output$regPlot3<-renderPlot({
        get_plot(sampVals$data,input$show3)
    })
    
    
    output$t3<-function(){
        get_sample_table_coef(sampVals$data) %>%
            knitr::kable("html",
                         col.names = c("Type",
                                       "Population Parameters",
                                       "Sample Statisics"),
                         row.names = FALSE) %>%
            kable_styling("striped", full_width = F) 
    }
        
    # renderTable({
    #     #code goes here for table.
    #     get_sample_table_coef(sampVals$data)
    # })
    
    
    
    
}