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

set.seed(2020)
# Set up stuff
die_roll<-function(n=1000,roll_num=1){
  die<-c(1, 2, 3, 4, 5, 6)
  if (roll_num %in% die){
    if (n>8000){
      print("Pick an n-value below 8000.")
      return(NA)
    } else {
      rel_freq <-numeric(n)
      rolls<-sample(die,3,replace=TRUE)
      for (i in 1:n){
        rolls<-c(rolls,sample(die,1,replace=TRUE))
        rel_freq[i]<-sum(rolls==roll_num)/length(rolls)
      }
      
    }
  } else{
    print("Please enter 1, 2, ..., 5, or 6 for the face of the die.")
    return(NA)
  }
  rel_freq
}


die_results<-die_roll(n=5000,roll_num=1)

generate_plot_dice<-function(data,n,roll_num=1){
  ggplot()+geom_line(aes(x=1:n,y=data[1:n]))+
    geom_hline(yintercept = 1/6,color='red')+
    ggtitle("Die Roll Simulation")+
    labs(x="Number of Rolls",y=paste("Relative Frequency of ",roll_num))
}
########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Simulating Die Rolls"),
   
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
      generate_plot(die_results,input$num_sims)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
