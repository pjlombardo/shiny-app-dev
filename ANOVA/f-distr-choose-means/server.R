library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    f_scores<-reactiveValues(data = f_scores_st)
    f_range<-reactiveValues(data = f_range)
    
    observeEvent(input$sample_size,{
        f_range$data = df(x_range, 2, input$sample_size*3-3)
    })
    
    observeEvent(c(input$sample_size,
                   input$mu1, input$mu2, input$mu3),{
                       f_scores$data<-get_F_scores(input$sample_size,
                                                   m=500,
                                                   input$mu1, input$mu2, input$mu3)
                   })
    
    output$f_samp_dist<-renderPlot({
        if (input$dens){
            ggplot()+geom_line(aes(x=x_range, y=f_range$data),
                               col='red',
                               size=1.5)+
                geom_density(aes(x=f_scores$data,y=..density..),
                             col='gray20',
                             fill='dodgerblue',
                             alpha=.4)
        } else {
            ggplot()+geom_line(aes(x=x_range, y=f_range$data),
                               col='red',
                               size=1.5)+
                geom_histogram(aes(x=f_scores$data,y=..density..),
                               col='gray20',
                               bins=20,
                               fill='dodgerblue',
                               alpha=.4)
        }
    })
    
    
}
