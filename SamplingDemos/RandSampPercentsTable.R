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
library(dplyr)

#####################
### Set up stuff ####
#####################
population<-c(rep("Infected",305),rep("Not-infected",771))
popul_table<-data.frame(population_counts = c(305,771),
                      population_proportions = c(305,771)/(305+771))
popul_table$population_counts<-round(popul_table$population_counts,0)
N<-length(population)

x<-1:N + rnorm(N,0,.1)
y<-rnorm(N,1,.25)
c<-population =="Infected"
df_plot<-data.frame(x=x,y=y,col_level=c)
df_plot

truth<-ggplot()+geom_point(aes(x=df_plot$x,
                               y=df_plot$y,
                               color=df_plot$col_level),
                           alpha=.5)+
  scale_color_manual('',labels=c('Infected','Not-infected'),
                     values=c('blue','red'))

get_sample_indices<-function(n=50){
  samp_indices<-sample(1:N,n,replace=F)
  samp_indices
}

get_sample_table<-function(index){
  n<-length(index)
  samp<-population[index]
  samp_inf<-samp =="Infected"
  counts <- c(sum(samp_inf),n-sum(samp_inf))
  prop_inf<-sum(samp_inf)/n
  
  df<-data.frame(sample_counts = counts,
                 sample_proportions = counts/n
  )
  df
}

get_sample_plot<-function(data,index){
  N<-length(data)
  sample_ind<-index
  df_sample<- df_plot[sample_ind,]
  
  ggplot()+geom_point(aes(x=df_plot$x,
                          y=df_plot$y,
                          color=df_plot$col_level),
                      alpha=.5)+
    scale_color_manual('',labels=c('Infected','Not-infected'),
                       values=c('blue','red'))+
    geom_point(aes(x=df_sample$x,
                   y=df_sample$y),
               shape=1,size=2,stroke=1.75)+
    labs(x='',y='')+
    theme(axis.text.x=element_blank(),
          axis.text.y=element_blank())
  
}

########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Counts and Proportions for Sampling"),
   fluidRow(
     # Put slider and button in the sidebar
     column(1),
      column(4,
             tableOutput("pop_table")),
      # Show a plot of the generated distribution
      column(4,
             tableOutput("samp_table")
         )
   ),
fluidRow(
  column(1),
  column(8,
         actionButton("get_random_sample","Sample from the population"),
         # This creates a 
         sliderInput("sample_size",
                     "Sample Size",
                     min = 5,
                     max = 100,
                     value = 5),
         plotOutput("samples",
                    height="400px",
                    width="800px")
         )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$samples<-renderPlot({truth})
  output$pop_table<-renderTable({
    #code goes here for table.
    popul_table
  })
  #Observe event connects the utton to the commands inside. Each time we click the
  # button, we will re=run the inside part.
  observeEvent(input$get_random_sample, {
    #renderPlot connects the plotOutput with an actual plot. In our case, we 
    # create the plot in a function from earlier in the app.
    index<-get_sample_indices(n=input$sample_size)
    
    output$samp_table<-renderTable({
      #code goes here for table.
      get_sample_table(index)
    })
    
    output$samples<-renderPlot({
      get_sample_plot(population, index)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
