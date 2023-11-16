library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output) {
    
    coin1<-reactiveValues(data = coin)
    triple_heads2<-reactiveValues(data = triple_heads)
    dice3<-reactiveValues(data = die_results)
    # Tab 1
    output$line_with_rel_freq<-renderPlot({
        generate_plot(coin1$data,input$num_sims)
    })
    
    observeEvent(input$new_sim1,{
        set.seed(round(runif(1,0,1000),0))
        coin1$data<-coin_flip(n=5000)
        output$line_with_rel_freq<-renderPlot({
            generate_plot(coin1$data,input$num_sims)
        })
    })
    
    # Tab 2
    
    output$line_with_rel_freq_HHH<-renderPlot({
        generate_plot_HHH(triple_heads2$data,input$num_sims2)
    })
    
    observeEvent(input$new_sim2,{
        set.seed(round(runif(1,0,1000),0))
        triple_heads2$data<-three_flip_sim(n=5000)
        
        output$line_with_rel_freq_HHH<-renderPlot({
            generate_plot_HHH(triple_heads2$data,input$num_sims2)
        })
    })
    
    # Tab 3
    output$line_with_rel_freq_dice<-renderPlot({
        generate_plot_dice(dice3$data,input$num_sims3)
    })
    
    observeEvent(input$new_sim3,{
        set.seed(round(runif(1,0,1000),0))
        dice3$data<-die_roll(n=5000,roll_num=1)
        
        output$line_with_rel_freq_dice<-renderPlot({
            generate_plot_dice(dice3$data,input$num_sims3)
        })
    })
    
}