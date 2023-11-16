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

x<-rnorm(500,250,30)
y<-2.13*x + 10 + rnorm(500,0,55)

s<-sample(1:500,35)
full.lm<-lm(y~x)
samp.lm<-lm(y[s]~x[s])
cff<-coef(full.lm)
pop_corr<-cor(x,y)

get_plot<-function(s){
  cfs<-coef(lm(y[s]~x[s]))
  
  ggplot()+geom_point(aes(x = x, y = y),
                      color='blue',
                      alpha = .25,size=2)+
    geom_abline(slope=cff["x"],
                intercept = cff["(Intercept)"], color='blue',
                alpha= .3,size=2)+
    geom_point(aes(x= x[s], y = y[s]),
               color='red',
               pch =16,size=3)+
    geom_point(aes(x= x[s], y = y[s]),
               color='black',
               pch =4,size=3)+
    geom_abline(slope=cfs["x[s]"],
                intercept = cfs["(Intercept)"], color='red',size=1.5)
}

init_plot<- ggplot()+geom_point(aes(x = x, y = y),
                                color='blue',
                                alpha = .25,size=2)+
  geom_abline(slope=cff["x"],
              intercept = cff["(Intercept)"], color='blue',
              alpha= .3,size=2)


# get_plot(sample(1:300,35))
get_sample_table<-function(s){
  data.frame(population.correlation = pop_corr,
             sample.correlation = cor(x[s],y[s]))
  
}

get_sample_table(s)
########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Correlation: Population Vs. Sample"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   fluidRow( position = 'left',
     # Put slider and button in the sidebar
      column(12,
        #This creates a button for us.
        actionButton("get","Get a new sample"),
        tableOutput("t1")
      ),
     column(12,
             plotOutput("regPlot",
                        width ="650px",
                        height ="400px")
             )
     
   )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  sampVals<-reactiveValues(data = s)
  plot_shown<-reactiveValues(p = init_plot)
  
  observeEvent(input$get,{
    sampVals$data<-sample(1:500,35)
    plot_shown$p <- get_plot(sampVals$data)
  })
  
  output$regPlot<-renderPlot({
    plot_shown$p
  })
  
  
  output$t1<-renderTable({
    #code goes here for table.
    get_sample_table(sampVals$data)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
