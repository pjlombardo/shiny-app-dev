library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    population<-reactiveValues(data = population_norm)
    pop_plot<-reactiveValues(data = show_population(
        population_norm,F
    ))
    
    output$pop_details<-renderTable(
        {pop_details[get_pop_number(input$pop_set),]})
    
    observeEvent(input$pop_set,{
        population$data<-get_population(input$pop_set)
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
