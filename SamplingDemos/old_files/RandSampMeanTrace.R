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
  geom_hline(yintercept = mean(temperatures),color='green4',size=.7)+
  labs(x="Patient ID",
       y="Diastolic BP")

run_sample<-function(n=20){
  ind1<-sample(1:2000,n, replace=FALSE)
  observed1<-df_temp[ind1,]
  mean(observed1[,2])

}

alpha_fxn<-function(num_sims){
  if (num_sims<=10) {
    alpha<-.8
  } else if (num_sims <=100) {
    alpha<-.6
  } else {
    alpha<-0.5 + -0.055454*log(num_sims+1)
  }
  alpha
}

collect<-function(n=20,m=50){
  samples<-numeric(m)
  for (j in 1:m){
    samples[j]<-run_sample(n)
  }
  samples
}

add_bars<-function(plt,samples, strt, stp){
  alpha_adj<-alpha_fxn(stp)
  for (j in strt:stp){
    plt<-plt+geom_hline(yintercept=samples[j],
                          color='blue', alpha=alpha_adj,size=.8)
  }
  plt+geom_hline(yintercept = mean(temperatures),color='red',size=.9)
}


########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Natural Variation due to Sampling"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   sidebarLayout(
     # Put slider and button in the sidebar
      sidebarPanel(
        #This creates a button for us.
         actionButton("reset","Reset Sampling Distribution"),
         # This creates a 
         sliderInput("sample_size",
                     "Sample Size",
                     min = 1,
                     max = 100,
                     value = 5),
         actionButton("get_one_sample","Get one sample"),
         
         actionButton("get_one_hundred_samples","Get 100 samples")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("scatter_with_means",
                    height="450px",
                    width = "600px")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  num_sims<-reactiveValues(data=0)
  plt_main<-reactiveValues(plot=truth)
  
  observeEvent(input$get_one_sample,{
    strt<-num_sims$data+1
    num_sims$data<-num_sims$data+1
    stp<-num_sims$data
    plt_main$plot<-add_bars(plt_main$plot,sampled_full(),strt,stp)
  })
  
  observeEvent(input$get_one_hundred_samples,{
    strt<-num_sims$data+1
    num_sims$data<-num_sims$data+100
    stp<-num_sims$data
    plt_main$plot<-add_bars(plt_main$plot,sampled_full(),strt,stp)
    })
  
  observeEvent(input$reset, {
    strt<-1
    num_sims$data<-1
    stp<-1
    plt_main$plot<-truth
    
  })
  
  observeEvent(input$sample_size, {
    strt<-1
    num_sims$data<-1
    stp<-1
    plt_main$plot<-truth
  })
  
  sampled_full<-eventReactive(input$sample_size, {
    collect(n=input$sample_size,2000)
  })
  
  #Observe event connects the utton to the commands inside. Each time we click the
  # button, we will re=run the inside part.
  output$scatter_with_means<-renderPlot({
    plt_main$plot
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
