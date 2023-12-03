library(shiny)
library(ggplot2)
library(patchwork)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    sample_num<-reactiveValues(data=1)
    pop_chosen<-reactiveValues(data = norm_pop)
    
    observeEvent(input$pop_type,{
        pop_chosen$data <-populations[,input$pop_type]
    })
    
    observeEvent(input$get_one_sample,{
        sample_num$data<-sample_num$data+1
    })
    
    observeEvent(input$get_one_hundred_samples,{
        sample_num$data<-sample_num$data + 100
    })
    
    observeEvent(input$reset, {
        sample_num$data<-1
    })
    
    sampled_full<-eventReactive(c(input$sample_size,
                                  input$pop_type), {
                                      sample_num$data<-1
                                      collect(pop_chosen$data,n=input$sample_size)
                                  })
    
    
    output$histograms<-renderPlot({
        #since sampled_full is the ouput of eventReactive, need
        #sampled_full() to return the actual va
        pt2_temp<-update_sampling_dist(sampled_full(),sample_num$data, 
                                       input$binsize,
                                       input$sample_size)
        pt2<-get_segs(pt2_temp,sampled_full(),sample_num$data)
        pt1<-show_population(pop_chosen$data)
        # plt_list<-list(pt1,pt2)
        # grid.arrange(grobs=plt_list,nrow=2)
        pt1+pt2+plot_layout(design=layout_d)
    })
    
}
