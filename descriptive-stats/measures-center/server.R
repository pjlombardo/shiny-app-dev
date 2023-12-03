library(shiny)
library(ggplot2)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    pop_outliers<-reactiveValues(data=pop1)
    output$histogram_outliers<-renderPlot({
        m<-mean(pop_outliers$data)
        med<-median(pop_outliers$data)
        ggplot()+geom_histogram(aes(x=pop_outliers$data),
                                bins = 30,
                                color='black',
                                fill='blue',
                                alpha=.5)+
            labs(x="Bins")+
            geom_point(aes(x=m,y=-.5),pch=17,size=5,col='green3')+
            geom_segment(aes(x=m,y=-.2,xend=m,yend=7),size=1,col='green3')+
            geom_point(aes(x=med,y=-.45),pch=18,size=6,col='red')+
            geom_segment(aes(x=med,y=-.2,xend=med,yend=7),size=1,col='red')
        
    })
    output$comp_stats<-renderTable({create_stats_tbl(pop_outliers$data,
                                                     input$add_outlier)}, 
                                   include.rownames=T)
    
    
    output$histogram1<-renderPlot({truth})
    
    output$bimodal_histogram<-renderPlot({
        bimod_data<-get_data(input$mean1, input$mean2)
        m<-mean(bimod_data)
        med<-median(bimod_data)
        ggplot()+geom_histogram(aes(x=bimod_data),
                                bins = 30,
                                color='black',
                                fill='blue',
                                alpha=.5)+
            labs(x="Bins")+
            geom_point(aes(x=m,y=-.5),pch=17,size=5,col='green3')+
            geom_segment(aes(x=m,y=-.2,xend=m,yend=30),size=1,col='green3')+
            geom_point(aes(x=med,y=-.45),pch=18,size=6,col='red')+
            geom_segment(aes(x=med,y=-.2,xend=med,yend=30),size=1,col='red')
    })
    
    #Observe event connects the utton to the commands inside. Each time we click the
    # button, we will re=run the inside part.
    observeEvent(input$skew, {
        #renderPlot connects the plotOutput with an actual plot. In our case, we 
        # create the plot in a function from earlier in the app.
        output$histogram1<-renderPlot({
            plot_skew(input$skew,input$show_var)
        })
    })
    
    observeEvent(input$add_outlier, {
        pop_outliers$data <- c(pop_outliers$data,input$outlier)
    })
    observeEvent(input$reset, {
        pop_outliers$data <- pop1
    })
    
    
}
