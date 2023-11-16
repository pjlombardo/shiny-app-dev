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

# Set up stuff
set.seed(101001)
temperatures<-rnorm(2000, 80,7)
df_temp<-as.data.frame(cbind(1:2000,temperatures))

truth<-ggplot(data = df_temp)+geom_point(aes(x=V1,
                                             y=temperatures), 
                                         colour='green3',
                                         alpha=.25,size=2.3) +
  geom_hline(yintercept = mean(temperatures),
             color='green4',linewidth=1)+
  labs(x="Patient ID",
       y="Diastolic BP")+theme_bw()


run_sample<-function(n=20){
  ind1<-sample(1:2000,n, replace=FALSE)
  observed1<-df_temp[ind1,]
  m1<-mean(observed1[,2])
  
  ggplot()+geom_point(aes(x=1:length(temperatures),
                          y=temperatures), 
                      colour='green3',
                      alpha=.3,size=2.3) +
    geom_point(aes(x=observed1[,1],
                   y=observed1[,2]), 
               colour='blue',
               alpha=.5,size=2.3)+
    geom_hline(yintercept = mean(temperatures),color='green4',linewidth=1)+
    geom_hline(yintercept = m1,color='blue',size=1)+
      theme_bw()+
    labs(x="Patient ID",
         y="Diastolic BP")
}

########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Random Sample Means Vs. Population Mean"),
   plotOutput("scatter_with_means",
              height="400px",
              width="700px"),
   
   fluidRow(
     column(1),
     column(5,
     h5("Explanation:"),
     HTML("<p>The green dots in the plot above represent an 
       entire population of patients with their
       diastolic blood pressure listed on the y-axis.
       When you click the button, it will randomly select 
       a sample of patients and highlight them. <br></br>
       The blue line shows the mean
       diastolic BP for the sample of patients, which we 
       can compare against the mean diastolic BP for the 
       entire population (the green line).</p>")
     
     ),
     # Put slider and button in the sidebar
      column(5,
        #This creates a button for us.
        br(),br(),
        p("Use the slider to control the size of the sample you",
          "collect."),br(),
         actionButton("get_random_sample","Sample from the population"),
            br(),br(), 
        sliderInput("sample_size",
                     "Sample Size",
                     min = 1,
                     max = 100,
                     value = 5)
      )
      
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$scatter_with_means<-renderPlot({truth})
  #Observe event connects the utton to the commands inside. Each time we click the
  # button, we will re=run the inside part.
  observeEvent(input$get_random_sample, {
    #renderPlot connects the plotOutput with an actual plot. In our case, we 
    # create the plot in a function from earlier in the app.
    output$scatter_with_means<-renderPlot({
      run_sample(input$sample_size)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
