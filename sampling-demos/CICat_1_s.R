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
start_prop<-c(rep("GM+",.45*5000),rep("GM-",(1-.45)*5000))
length(start_prop)
get_pop<-function(p){
  data.frame(marker = c(rep("GM+",p*5000),
                        rep("GM-",(1-p)*5000))
             )
}

pop1<-get_pop(.3)

get_truth_plot<-function(p){
  ggplot()+geom_col(aes(x=c("GM+","GM_"),
                        y= c(p,1-p)),
                    width=.7,
                    fill='red1',alpha=.8)+
    theme(legend.text=element_text(size=14), 
          legend.title=element_text(size=14))+
    scale_y_continuous(limits=c(0,.95))+
    labs(title="Population Proportion vs. Sample Proportions",
         y="Proportions",x="Presence of Genetic Marker")
}

truth<-get_truth_plot(.3)

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
  prop_sample<-numeric(2)
  prop_sample[1]<-(df=="GM-")%>%sum()/n
  prop_sample[2]<-(df=="GM+")%>%sum()/n
  
  return(prop_sample)
}

get_segment_df<-function(pop,m=10,n=50){
  temp<-get_props(pop1[sample(1:5000,n,replace=F),1],n)
  # print(length(temp))
  for (i in 1:m){
    temp2<-get_props(pop[sample(1:5000,n,replace=F),1],n)
    # print(paste(length(temp2),"||"))
    temp<-c(temp,temp2)
    # print(paste(length(temp),"|||"))
  }
  props<-temp + rnorm(length(temp),0,.0015)
  df<-data.frame(x=rep(1:2-.42,m+1),xend=rep(2:3-.58,m+1),y_h=props)
  df
}

# x=1:5-.42, xend=2:6-.58,
add_bars_sample<-function(plt,df,strt,stp){
  df_bars<-df[(2*strt-1):(2*stp),]
  df_bars[,3]<-df_bars[,3]
  alpha_adj<-alpha_fxn(stp)
  plt<-plt + 
    geom_segment(data=df_bars,
                 aes(x=x, y=y_h,xend=xend,yend=y_h),
                 color='blue',alpha=alpha_adj)
  plt
}


# pop1<-get_pop(.3)
# main_plt<-get_truth_plot(.3)
# df<-get_segment_df(pop1,m=300,n=20)
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
        sliderInput("p_set",
                    "Set the population parameter p",
                    min = .05,
                    max = .95,
                    value = .3),
        sliderInput("sample_size",
                    "Sample Size",
                    min = 10,
                    max = 300,
                    value = 15)
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
  pop_data<-reactiveValues(data=get_pop(.3))
  plt_main<-reactiveValues(plot=get_truth_plot(.3))
  
  observeEvent(input$p_set,{
    plt_main$plot<-get_truth_plot(input$p_set)
  })
  
  observeEvent(c(input$p_set,input$sample_size),{
    pop_data$data<-get_pop(input$p_set)
  })
  
  sampled_full<-eventReactive(c(input$sample_size,input$p_set), {
    get_segment_df(pop_data$data,n=input$sample_size,m=2000)
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
  
  observeEvent(c(input$sample_size,input$p_set), {
    strt<-1
    num_sims$data<-1
    stp<-1
    plt_main$plot<-get_truth_plot(input$p_set)
  })
    
  
  output$bar_plot_with_props<-renderPlot({
      plt_main$plot
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
