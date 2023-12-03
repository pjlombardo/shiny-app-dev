library(shiny)
library(ggplot2)

source('functions.R')

server <- function(input, output) {
    f_scores<-reactiveValues(data = f_scores_st)
    
    observeEvent(c(input$sample_size, input$num_grps),{
        f_scores$data = get_f_scores(input$num_grps,input$sample_size)
    })
    
    output$f_samp_dist<-renderPlot({
        ggplot()+geom_line(aes(x=x_range, y=f_scores$data),
                           col='red',
                           linewidth=1.35)+
            labs(x = "F-scores",y="",title = "")
        
    })
    
    
}
