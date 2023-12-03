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
library(knitr)
library(kableExtra)

#####################
### Set up stuff ####
#####################
v1<-.35
p1<-data.frame(x=rnorm(1000,3,v1),y=rnorm(1000,3,v1),
               pol=c(rep("R",940),rep("D",60)),
               grp = rep("p1",1000))
p2<-data.frame(x=rnorm(1000,5,v1),y=rnorm(1000,3,v1),
               pol=c(rep("R",220),rep("D",780)),
               grp = rep("p2",1000))
p3<-data.frame(x=rnorm(1000,1,v1),y=rnorm(1000,1,v1),
               pol=c(rep("R",440),rep("D",560)),
               grp = rep("p3",1000))
p4<-data.frame(x=rnorm(1000,1,v1),y=rnorm(1000,5,v1),
               pol=c(rep("R",700),rep("D",300)),
               grp = rep("p4",1000))
p5<-data.frame(x=rnorm(1000,5,v1),y=rnorm(1000,1,v1),
               pol=c(rep("R",390),rep("D",610)),
               grp = rep("p5",1000))

df_all<-rbind(p1,p2,p3,p4,p5)
# df_all %>% group_by(pol) %>%
#     summarise(count=n(),
#               perc=n(),nrow(df_all))
# ggplot(data=df_all) + geom_point(aes(x=x, y=y, color=pol),size=2)
table(df_all$pol)
# population<-c(rep("Infected",305),rep("Not-infected",771))
popul_table<-data.frame(population_counts = as.integer(c(2310,2690)),
                      population_proportions = c(2310,2690)/(5000))
popul_table$population_counts<-round(popul_table$population_counts,0)
row.names(popul_table)<-c("Democ","Repub.")
# N<-length(population)
# 
# x<-1:N + rnorm(N,0,.1)
# y<-rnorm(N,1,.25)
# c<-population =="Infected"
# df_plot<-data.frame(x=x,y=y,col_level=c)
# df_plot

truth<-ggplot()+geom_point(aes(x=df_all$x,
                               y=df_all$y,
                               color=df_all$pol),
                           alpha=.3)+
    scale_color_manual('',labels=c('Democ.','Repub.'),
                       values=c('dodgerblue','red'))+theme_bw()

get_sample_indices<-function(n=50){
  samp_indices<-sample(1:1000,n,replace=F)
  samp_indices
}

get_sample_table<-function(index){
  n<-length(index)
  samp<-df_all[df_all$grp=="p2",][index,]
  samp_rep<-samp$pol == "R"
  counts <- c(n-sum(samp_rep),sum(samp_rep))
  prop_inf<-sum(samp_rep)/n
  
  df_table<-data.frame(sample_counts = counts,
                 sample_proportions = counts/n
  )
  df_table
}

get_sample_plot<-function(index){
  df_sample<-df_all[df_all$grp=="p2",][index,]
  
  truth+
    geom_point(aes(x=df_sample$x,
                   y=df_sample$y),
               shape=1,size=2,stroke=1.25)+
    labs(x='',y='')+
    theme(axis.text.x=element_blank(),
          axis.text.y=element_blank())
  
}

# get_sample_plot(sample(1:100,50))


########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Counts and Proportions for Biased Sampling"),
   fluidRow(
     # Put slider and button in the sidebar
     column(1),
      column(4,
             tableOutput("pop_table")),
     column(1),
      # Show a plot of the generated distribution
      column(4,
             tableOutput("samp_table")
         )
   ),
fluidRow(
  column(1),
  column(8,
         actionButton("get_random_sample",
                      "Get a biased sample from the population"),
         br(),br(),
         # This creates a 
         sliderInput("sample_size",
                     "Sample Size",
                     min = 5,
                     max = 80,
                     value = 25),
         plotOutput("samples",
                    height="400px",
                    width="800px")
         )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$samples<-renderPlot({truth})
  output$pop_table<-renderTable({popul_table}, 
                                include.rownames=T)
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
      get_sample_plot(index)
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
