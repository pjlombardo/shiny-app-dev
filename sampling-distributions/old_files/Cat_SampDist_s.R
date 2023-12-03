#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(boot)
library(gridExtra)

# Set up stuff
start_pop<-data.frame(values = c(rep("Crow",.45*5100),
                                 rep("Other",(1-.45)*5100)),
                      m=10000,
                      n=10)


get_sampling_distribution2<-function(pop, m=10000, n=20){
  sample_means<-numeric(m)
  for (j in 1:m){
    sample_means[j]<-sum(pop[sample(1:5100,n),1]=="Crow")/n
  }
  data.frame(values = sample_means)
}

# test<-get_sampling_distribution(start_pop, m=100, n=15)

bin_fxn2<-function(n){
  round(2+4.5*log(n),0)
}


# p1<-ggplot(data = test, aes(x=values))+
#   geom_histogram(aes(y=..density../100),
#                  color='gray3',
#                  fill='gray',
#                  bins=bin_fxn(100))+
#   xlim(0,1)+ylim(0,.15)


m2<-5000

########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Generating a Sampling Distribution"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   fluidRow( position = 'center',
     # Put slider and button in the sidebar
     h4(textOutput("std_error"), align="center"),
     h4(textOutput("p_hat"), align="center"),
     plotOutput("histograms",
                width="700px",
                height="400px"),
     
      column(4,
        #This creates a button for us.
        sliderInput("p_val",
                    "Fix a population proportion",
                    min = .05,
                    max = .95,
                    value = .45)
      ),
     column(4,
        sliderInput("sample_size",
                    "Fixed Sample Size for the Sampling Distribution",
                    min = 10,
                    max = 300,
                    value = 10)

      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$histograms<-renderPlot({
    #since sampled_full is the ouput of eventReactive, need
    #sampled_full() to return the actual va
  
    p1<-ggplot(data = sample_means$data, aes(x=values))+
      geom_histogram(aes(y=..density../100),
                     color='gray3',
                     fill='deepskyblue2',
                     bins=bin_fxn(input$sample_size))+
      xlim(0,1)+ylim(-.02,.2)+
      geom_hline(yintercept=0)
    
    M1<-max(ggplot_build(p1)$data[[1]]$ymax)
    
    p1 +
      geom_segment(aes(x=values,xend = values, y=rep(-.01,m),
                   yend = rep(.03,m)),
                 color='red',size=1,
               alpha = .01)

  })   
  
  # output$popdata<-renderTable({sample_means$data})
  
  population<-reactiveValues(
    data = start_pop
  )
  
  sample_means<-reactiveValues(
    data= get_sampling_distribution(start_pop, m=m,n=10)

    )
  # 
  observeEvent(input$p_val,{
    
    population$data<-data.frame(values = c(rep("Crow",input$p_val*5100),
                       rep("Other",(1-input$p_val)*5100))
                       )
    
    sample_means$data <- get_sampling_distribution(population$data,
                                                  m=m,
                                                  n=input$sample_size)
    
    output$std_error<-renderText({
      paste("Standard Error =",
            round(sd(sample_means$data[,1],
                     na.rm=T),5)
      )
    })
    
    output$p_hat<-renderText({
      paste("Estimated Population Proportion =",
            round(mean(sample_means$data[,1],
                     na.rm=T),5)
      )
    })
  })
  

  observeEvent(input$sample_size, {
    sample_means$data = get_sampling_distribution(population$data,
                                                  m=m,
                                                  n=input$sample_size)
  
    output$histograms<-renderPlot({
      
      p1<-ggplot(data = sample_means$data, aes(x=values))+
        geom_histogram(aes(y=..density../100),
                       color='gray3',
                       fill='deepskyblue3',
                       bins=bin_fxn(input$sample_size))+
        coord_cartesian(xlim=c(0,1),
                        ylim=c(-.02,.25))+
        geom_hline(yintercept=0)
      
      M1<-max(ggplot_build(p1)$data[[1]]$ymax)
      
      p1 +
        geom_segment(aes(x=values,xend = values, y=rep(-.1*M1,m),
                         yend = rep(.25*M1,m)),
                     color='red',size=1,
                     alpha = .01)
      
    })
                                                               
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
