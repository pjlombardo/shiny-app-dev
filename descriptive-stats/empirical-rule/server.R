library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    population<-reactiveValues(data = get_population(60,10))
    pop_plot<-reactiveValues(data = show_population(
        get_population(60,10),F
    ))
    
    
    observeEvent(c(input$mu,input$sigma),{
        population$data<-get_population(input$mu,input$sigma)
        pop_plot$data<-show_population(population$data,
                                       input$show_range)
    })
    
    observeEvent(input$show_range,{
        pop_plot$data <-show_population(population$data,
                                        input$show_range)
        
        output$pct_within<-renderText({
            text_pct_within(population$data,
                            crit=2,
                            input$show_range)
        })
        
    })
    
    output$histograms<-renderPlot({
        pop_plot$data
    })
    
    
}
