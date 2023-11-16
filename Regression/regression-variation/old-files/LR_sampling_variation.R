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

x<-rnorm(300,250,30)
y<-2.13*x + 10 + rnorm(300,0,55)

s<-sample(1:300,35)
full.lm<-lm(y~x)
samp.lm<-lm(y[s]~x[s])
cff<-coef(full.lm)
pop_corr<-cor(x,y)

get_plot<-function(s){
  cfs<-coef(lm(y[s]~x[s]))
  
  ggplot()+geom_point(aes(x = x, y = y),
                      color='blue',
                      alpha = .25,size=3)+
    geom_abline(slope=cff["x"],
                intercept = cff["(Intercept)"], color='blue',
                alpha= .3,size=2)+
    geom_point(aes(x= x[s], y = y[s]),
               color='red',
               pch =16,size=4)+
    geom_point(aes(x= x[s], y = y[s]),
               color='black',
               pch =4,size=4)+
    geom_abline(slope=cfs["x[s]"],
                intercept = cfs["(Intercept)"], color='red',size=1.5)
}

get_plot(sample(1:300,35))


########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Sample estimted Regression vs. Population level regression"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   fluidRow( position = 'left',
     # Put slider and button in the sidebar
      column(2,
        #This creates a button for us.
        actionButton("get","Get a new sample")
      ),
     column(8,
             plotOutput("regPlot",
                        width ="800px",
                        height ="600px")
             )
     
   )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  sampVals<-reactiveValues(data = s)
  
  observeEvent(input$get,{
    sampVals$data<-sample(1:300,35)
  })
  
  output$regPlot<-renderPlot({
    get_plot(sampVals$data)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
