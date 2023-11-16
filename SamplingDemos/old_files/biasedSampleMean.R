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
set.seed(102003)
heights<-rnorm(2000, 68,8)
taller<-heights>=72
smaller<-heights<72
bball<-sample(1:629, 350)
df_temp<-data.frame(heights=heights[taller])
df_temp$bball<-c(rep(T,350),rep(F,279))
d2<-data.frame(heights=heights[smaller],
               bball = rep(F,sum(smaller==T)))
df_all<-rbind(df_temp,d2)
df_all<-df_all[sample(1:2000,2000),]
truth<-ggplot(data = df_all)+geom_point(aes(x=1:2000,
                                             y=heights,
                                             color=bball,
                                            alpha=bball),
                                        size=2.5) +
  geom_hline(yintercept = mean(heights),color='black',size=1)+
  scale_color_manual(name="",
                     labels=c("TRUE"="Basketball","FALSE" = "Not Basketball"),
                     values=c("red","dodgerblue3"))+
  scale_alpha_manual(values=c(.3,.6),guide="none")+
  labs(x="Population ID")

truth
run_sample<-function(n=20){
  df_temp<-data.frame(pos=which((df_all$bball==T)==T),
                      heights=df_all[df_all$bball,1])
  ind1<-sample(1:350,n, replace=FALSE)
  m1<-mean(df_temp[ind1,"heights"])
  
  ggplot()+geom_point(aes(x=1:2000,
                                       y=df_all$heights,
                                       color=df_all$bball,
                                       alpha=df_all$bball),
                      size=2.5) +
    scale_color_manual(name="",
                       labels=c("TRUE"="Basketball","FALSE" = "Not Basketball"),
                       values=c("red","dodgerblue3"))+
    scale_alpha_manual(values=c(.3,.6),guide="none")+
    labs(x="Population ID") +
    geom_point(aes(x=df_temp[ind1,"pos"],
                   y=df_temp[ind1,"heights"]),
               shape=1,size=2.5,stroke=1.75)+
    geom_hline(yintercept = mean(heights),color='black',size=1.75)+
    geom_hline(yintercept = m1,color='blue',size=1.75)
}

########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Biased Sample Means Vs. Population Mean"),
   plotOutput("scatter_with_means",
              height="400px",
              width="800px"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   fluidRow(
     # Put slider and button in the sidebar
     column(1),
      column(4,
        #This creates a button for us.
         actionButton("get_random_sample","Get a biased sample from the population"),
         # This creates a 
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
