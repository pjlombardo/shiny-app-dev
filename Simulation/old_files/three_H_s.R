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
set.seed(3030)
# Set up stuff
coin<-c(0,1)
three_flip<-function(){
  three<-sample(coin,3,replace=T)
  return(sum(three))
}


three_flip_sim<-function(n=500){
  if (n>8000){
    print("Pick an n-value below 8000.")
    return(NA)
  } else {
    rel_freq <-numeric(n)
    flips<-numeric(0)
    for (i in 1:n){
      flips<-c(flips,three_flip())
      rel_freq[i]<-sum(flips==3)/length(flips)
    }
  }
  rel_freq
}

triple_heads<-three_flip_sim(n=5000)

generate_plot<-function(data,n){
  ggplot()+geom_line(aes(x=1:n,y=data[1:n]))+
    geom_hline(yintercept = 0.125,color='red')+
    ggtitle("Triple Flip Simulation")+
    labs(x="Number of Simulations",
         y="Relative Frequency of Triple Heads")
}

########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Simulating Three Flips of a Coin"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   sidebarLayout(
     # Put slider and button in the sidebar
      sidebarPanel(
        #This creates a button for us.
         actionButton("reload_plot","Update Plot Simulation"),
         # This creates a slider to update the number of simulations
         sliderInput("num_sims",
                     "Number of Simulations",
                     min = 5,
                     max = 5000,
                     value = 5,
                     step=4,
                     animate=animationOptions(interval = 400,
                                              loop = TRUE))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("line_with_rel_freq")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #Observe event connects the button to the commands inside. Each time we click the
  # button, we will re=run the inside part.
  observeEvent(input$reload_plot, {
    # renderPlot connects the plotOutput with an actual plot. In our case, we 
    # create the plot in a function from earlier in the app.
    output$line_with_rel_freq<-renderPlot({
      generate_plot(triple_heads,input$num_sims)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
