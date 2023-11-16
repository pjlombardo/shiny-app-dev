

library(shiny)
library(ggplot2)

# Set up stuff
set.seed(1001)
coin_flip<-function(n=500){
  if (n>8000){
    print("Pick an n-value below 8000.")
    return(NA)
  } else {
    coin<-c(0,1)
    rel_freq <-numeric(n)
    flips<-numeric(0)
    for (i in 1:n){
      flips<-c(flips,sample(coin,1,replace=TRUE))
      rel_freq[i]<-sum(flips)/length(flips)
    }
  }
  rel_freq
}


coin<-coin_flip(n=5000)

generate_plot<-function(data,n){
  ggplot()+geom_line(aes(x=1:n,y=data[1:n]))+
    geom_hline(yintercept = 0.5,color='red')+
    ggtitle("Coin Flip Simulation")+
    labs(x="Number of Flips",y="Relative Frequency of Heads")
}
########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Simulating Coin Flips, Law of Large Numbers"),
   
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
      generate_plot(coin,input$num_sims)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
