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
raw_prop<-c(rep("Finch",3),rep("Sparrow",8),rep("Robin",6),"Hawk",rep("Crow",4))

# create a population of birds via sampling with replacement so that
# proportions are roughly kept.
bird_pop<-sample(raw_prop,2000,replace=TRUE)

pop_params<-data.frame(table(kind=bird_pop)/2000)

truth<-ggplot()+geom_col(aes(x=pop_params$kind,
                             y= pop_params$Freq),
                         width=.7,
                         fill='red1',alpha=.5)+
  labs(x='Kind of Bird',y='Percentage')+
  theme(legend.text=element_text(size=14), 
        legend.title=element_text(size=14))+
  coord_cartesian(ylim=c(0,.85))+
  labs(title="Comparing Proportions in the Population to a Sample",
       y="Proportions",x="Kind of bird")
  # theme_light()

#m = # of samples to plot
#n = sample_size

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

get_props<-function(df,n){
  prop_sample<-numeric(5)
  prop_sample[1]<-(df=="Crow")%>%sum()/n
  prop_sample[2]<-(df=="Finch")%>%sum()/n
  prop_sample[3]<-(df=="Hawk")%>%sum()/n
  prop_sample[4]<-(df=="Robin")%>%sum()/n
  prop_sample[5]<-(df=="Sparrow")%>%sum()/n
  
  return(prop_sample)
}

get_segment_df<-function(m=10,n=50){
  temp<-get_props(bird_pop[sample(1:2000,n,replace=T)],n)
  # print(length(temp))
  for (i in 1:m){
    temp2<-get_props(bird_pop[sample(1:2000,n,replace=T)],n)
    # print(paste(length(temp2),"||"))
    temp<-c(temp,temp2)
    # print(paste(length(temp),"|||"))
  }
  props<-temp + rnorm(length(temp),0,.0015)
  df<-data.frame(x=rep(1:5-.42,m+1),xend=rep(2:6-.58,m+1),y_h=props)
  df
}

# x=1:5-.42, xend=2:6-.58,
add_bars_sample<-function(plt,df, strt,stp){
  df_bars<-df[(5*strt-4):(5*stp),]
  df_bars[,3]<-df_bars[,3]
  alpha_adj<-alpha_fxn(stp)
  plt<-plt + 
    geom_segment(data=df_bars,
                 aes(x=x, y=y_h,xend=xend,yend=y_h),
                 color='blue',alpha=alpha_adj)
  plt
}

# truth+geom_segment(data=collect_bars[1:5,],
#                    aes(x=x,y=y_h,xend=xend,yend=y_h),
#                    color='blue',
#                    alpha=.2)
# 
# truth
# collect_bars<-get_segment_df(m=100,n=20)
# dim(collect_bars)
# add_bars_sample(truth,collect_bars,100,100)
# 
# truth+geom_segment(data=collect_bars[1:10,],
#                    aes(x=x,y=y_h,xend=xend,yend=y_h),
#                    color='blue')
########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Random Sample Proportions Vs. Population Proportions"),
   
   plotOutput("bar_plot_with_props"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   fluidRow(
     # Put slider and button in the sidebar
     column(2),
      column(4,
        actionButton("reset","Reset Sampling Distribution"),

        sliderInput("sample_size",
                    "Sample Size",
                    min = 1,
                    max = 300,
                    value = 5)
        ),
        
      column(2,
        actionButton("get_one_sample","Get one sample"),
        
        actionButton("get_one_hundred_samples","Get 100 samples")
      )

   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  num_sims<-reactiveValues(data=0)
  plt_main<-reactiveValues(plot=truth)
  
  sampled_full<-eventReactive(input$sample_size, {
    get_segment_df(n=input$sample_size,2000)
  })
  
  
  observeEvent(input$get_one_sample,{
    strt<-num_sims$data+1
    num_sims$data<-num_sims$data+1
    stp<-num_sims$data
    plt_main$plot<-add_bars_sample(plt_main$plot,sampled_full(),strt,stp)
  })
  
  observeEvent(input$get_one_hundred_samples,{
    strt<-num_sims$data+1
    num_sims$data<-num_sims$data+100
    stp<-num_sims$data
    plt_main$plot<-add_bars_sample(plt_main$plot,sampled_full(),strt,stp)
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
    
  
  output$bar_plot_with_props<-renderPlot({
      plt_main$plot
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
