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

# Set up stuff
test<-c(rep("Finch",3),rep("Sparrow",8),rep("Robin",6),"Hawk",rep("Crow",4))

# create a population of birds via sampling with replacement.
df_birds<-data.frame(kind=sample(test,500,replace=TRUE))
count_all<-(df_birds %>% group_by(kind) %>% count())$n
prop_all<-count_all/sum(count_all)

pop_params<-data.frame(table(kind=df_birds)/500)


truth<-ggplot()+geom_col(aes(x=pop_params$kind,
                             y= pop_params$Freq),
                         width=.7,
                         fill='red1',alpha=.5)+
  labs(x='Kind of Bird',y='Percentage')+
  theme(legend.text=element_text(size=14), 
        legend.title=element_text(size=14))+
  scale_y_continuous(limits=c(0,.85))+
  labs(title="Comparing Proportions in the Population to a Sample",
       y="Proportions",x="Kind of bird")



get_props<-function(df,n){
  prop_sample<-numeric(5)
  prop_sample[1]<-(df=="Crow")%>%sum()/n
  prop_sample[2]<-(df=="Finch")%>%sum()/n
  prop_sample[3]<-(df=="Hawk")%>%sum()/n
  prop_sample[4]<-(df=="Robin")%>%sum()/n
  prop_sample[5]<-(df=="Sparrow")%>%sum()/n
  
  return(prop_sample)
}

get_sample_compare<-function(n=50){
  #create a random sample of indices from the population
  rsam<-sample(1:500,n,replace=TRUE)
  # create a dataframe of random samples from population
  df_sample<-data.frame(kind=df_birds[rsam,])
  # compute sample proportions.
  prop_sample<-get_props(df_sample,n)
  # print(prop_sample)
  
  #create output dataframe for plotting
  df2<-data.frame(props=c(prop_all,prop_sample))
  df2$grp<-c(rep("all",5),rep("sample",5))
  df2$kind<-(df_birds %>% 
               group_by(kind) %>% 
               count())$kind
  
  return(df2)
}

plot_sample<-function(n=50){
  temp_df<-get_sample_compare(n)
  #max_prop<-max(temp_df$props)
  
  ggplot(data=temp_df)+
    geom_col(aes(x=kind,
                 y=props,
                 fill=grp,alpha=grp),
             position=position_dodge(.2))+
    scale_fill_manual(name="Legend",labels=c("Population","Sample"),values=c("red","blue"))+
    scale_alpha_manual(values=c(.5,.65),guide=FALSE)+
    #scale_y_continuous(limits=c(0,max_prop+.05))+
    scale_y_continuous(limits =c(0,.8))+
    labs(title="",
         y="Proportions",x="Kind of bird")
}

########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Random Sample Proportions Vs. Population Proportions"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   fluidRow(
     # Put slider and button in the sidebar
     plotOutput("bar_plot_with_props"),
     
      column(4,
        #This creates a button for us.
         actionButton("get_random_sample","Sample from the population"),
         # This creates a 
         sliderInput("sample_size",
                     "Sample Size",
                     min = 5,
                     max = 100,
                     value = 5)
      )
      
      # Show a plot of the generated distribution

   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$bar_plot_with_props<-renderPlot({truth})
  #Observe event connects the utton to the commands inside. Each time we click the
  # button, we will re=run the inside part.
  observeEvent(input$get_random_sample, {
    #renderPlot connects the plotOutput with an actual plot. In our case, we 
    # create the plot in a function from earlier in the app.
    output$bar_plot_with_props<-renderPlot({
      plot_sample(input$sample_size)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
