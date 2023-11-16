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
library(boot)
library(gridExtra)

# Set up stuff
# New approach:
# initialize a huge list of important information.
pop1<-data.frame(plant_heights = round(rnorm(1000,12,3.7),2))
PS<-sd(pop1$plant_heights)
PM<-mean(pop1$plant_heights)
z_crit<-2

mean_boot<-function(samp,indices){
  dt<-samp[indices]
  mean(dt)
}

get_se<-function(n){
  samp_est<-sample(pop1[,1],n)

  Bootstrap<-boot(samp_est,mean_boot,R = 2000)
  se<-sd(Bootstrap$t)
  se
}



# samp_est<-sample(pop1[,1],30)
# Bootstrap<-boot(test_samp,mean_boot,R = 2000)
# sd(Bootstrap$t)

get_index_and_bars<-function(n){
  se<-get_se(n)
  
  index_list<-list()
  ms<-numeric(2000)
  ymins<-numeric(2000)
  ymaxes<-numeric(2000)
  flag<-character(2000)
  for (j in 1:2000){
    samp_index<-sample(1:1000,n)
    sampj<-pop1[samp_index,1]
    ms[j]<-mean(sampj)
    ymins[j]<-ms[j]-z_crit*se
    ymaxes[j]<-ms[j]+z_crit*se
    if (ymins[j]>PM | ymaxes[j]<PM) {
      flag[j]<-"red"
    } else {flag[j]<-"blue"}
    index_list[[j]]<-samp_index
  }
  df_errorbars<-data.frame(m=ms,
                           x=1:2000,
                           ymin=ymins,
                           ymax=ymaxes,
                           flag=flag)
  
  return(list(index_list,df_errorbars))
}

# hist_data<-numeric(500)
# for (j in 1:500){
#   test<-get_index_and_bars(20)
#   hist_data[j]<-(sum(test[[2]]$flag=='blue')/2000)
# }
# hist(hist_data,col=rgb(0,0,1,.4))

# index_list<-list()
# ms<-numeric(2000)
# ymins<-numeric(2000)
# ymaxes<-numeric(2000)
# flag<-character(2000)
# for (j in 1:2000){
#   samp_index<-sample(1:1000,20)
#   ms[j]<-mean(pop1[samp_index,1])
#   se<-sd(pop1[samp_index,1])/sqrt(20)
#   ymins[j]<-ms[j]-qt(.975,df=20)*se
#   ymaxes[j]<-ms[j]+qt(.975,df=20)*se
#   if (ymins[j]>PM | ymaxes[j]<PM) {
#     flag[j]<-"red"
#   } else {flag[j]<-"blue"}
#   index_list[[j]]<-samp_index
# }
# df_errorbars<-data.frame(m=ms,
#                          x=1:2000,
#                          ymin=ymins,
#                          ymax=ymaxes,
#                          flag=flag)


truth<-ggplot()+geom_point(aes(x=1:1000,
                               y=pop1$plant_heights),
                           col='green',
                           alpha=.4)+
  coord_cartesian(ylim=c(0,25))+
  geom_hline(yintercept=PM,col='green4',size=1.25)+
  labs(x="Plant ID Number",
       y="Plant Height (inches)",
       title="Population of Plant Heights One Month After Germination")

plot_with_sample<-function(plot,record_num,
                           index_list, 
                           df_errorbars){
  
  plot +
    geom_point(aes(x=index_list[[record_num]],
                   y=pop1[index_list[[record_num]],1]),
               col='blue',alpha=.6)+
    geom_hline(yintercept=df_errorbars$m[record_num],
               col='blue',size=1,lty=2)+
    geom_hline(yintercept=PM,col='green4',size=1.25,
               alpha=.75)+
    labs(x="Plant ID Number",
         y="Plant Height (inches)",
         title="Population of Plant Heights One Month After Germination")+
    coord_cartesian(ylim=c(0,25))
}

#create CI tracker
ci_record<-ggplot()+geom_hline(yintercept=PM,col='green4',size=1.25,
                               alpha=.75)+
  labs(y="",
       title="Record of Confidence Intervals")+
  coord_cartesian(xlim=c(0,10),
                  ylim=c(0,25))+
  geom_hline(yintercept=0)+geom_vline(xintercept=0)


add_ci<-function(record_num,df_errorbars,show_eb){
  if (show_eb){
    ci_record+ geom_errorbar(data=df_errorbars[1:record_num,],
                        aes(x =x, 
                            ymin = ymin,
                            ymax = ymax,
                            col=flag),
                        size=1,
                        width=.1+.2*(record_num/(record_num+10)))+
      geom_point(data=df_errorbars[1:record_num,],
                 aes(x = x,
                     y = m,
                     col=flag))+
      scale_color_manual("",values=c("blue","red"),guide=F)+
      coord_cartesian(xlim=c(0,max(10,record_num+3)),
                      ylim=c(0,25))
  } else {
    ci_record+
      geom_point(data=df_errorbars[1:record_num,],
                 aes(x = x,
                     y = m,
                     col=flag))+
      scale_color_manual("",values=c("blue","red"),guide=F)+
      coord_cartesian(xlim=c(0,max(10,record_num+3)),
                      ylim=c(0,25))
  }

}

# add_ci(ci_record,3,test[[2]])
#### GET THIS WORKING
# ci_record+ geom_errorbar(data=df_errorbars[1:30,],
                         # aes(x =x, 
                         #    ymin = ymin,
                         #    ymax = ymax),
                         # size=1)
                    


# add_ci(ci_record,5)

########################
# Create Shiny Page ####
########################
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Success rate for confidence intervals"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   fluidRow( position = 'left',
     # Put slider and button in the sidebar
     column(5,
            plotOutput("sampling",
                       height="450px")
            ),
     column(7,
            plotOutput("conf_int",
                       height="450px"))
   ),
   
   fluidRow(
      column(4,
        actionButton("get_samp", "Get one sample"),
        actionButton("get_50", "Get 50 samples"),
        checkboxInput("show_interval","Show confidence interval",
                      value=F)
      ),
      column(4,
        sliderInput("sample_size","Set the fixed sample size",
               min=5, max = 100, step=5, value=5),
        actionButton("reset","Reset plot")
      ),
      column(4,
             h3(textOutput("success_rate")),
             h3(textOutput("boot_se"))
             )
     
   )
   
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$sampling<-renderPlot({
      plot_samples$data
    })
    output$conf_int<-renderPlot({
        plot_cis$data+
          labs(x="",
               y="")+
        geom_hline(yintercept=rlist$data[[2]][record_num$data,'m'],
                   col='blue',
                   lty=2, size=.7)
    })
    
    output$success_rate<-renderText({
      sr<-100*(sum(rlist$data[[2]]$flag[1:record_num$data]=='blue')/record_num$data)
      paste("Success Rate: ",sr,"%")
      })
    
    output$boot_se<-renderText({
      paste("Bootstrap Std. Error: ",round(bsse$data,1))
    })
    

    record_num<-reactiveValues(data=0)
    rlist<-reactiveValues(data=get_index_and_bars(5))
    plot_samples<-reactiveValues(data= truth)
    plot_cis<-reactiveValues(data= ci_record)
    bsse<-reactiveValues(data =get_se(5))
    
    observeEvent(input$sample_size,{
      bsse$data <- get_se(input$sample_size)
      rlist$data= get_index_and_bars(input$sample_size)
      plot_samples$data<-truth
      plot_cis$data<-ci_record
      record_num$data<-0
    })

    observeEvent(input$get_samp,{
      record_num$data<-record_num$data+1
      plot_samples$data<-plot_with_sample(truth,record_num$data,
                                          rlist$data[[1]],
                                          rlist$data[[2]])
      
      plot_cis$data<-add_ci(record_num$data,
                            rlist$data[[2]],input$show_interval)
      
    })
    
    observeEvent(input$show_interval,{
      if (record_num$data==0) {
        plot_cis$data<-ci_record
      } else {
        plot_cis$data<-add_ci(record_num$data,
                            rlist$data[[2]],input$show_interval)}
    })
    
    observeEvent(input$get_50,{
      record_num$data<-record_num$data+50
      plot_samples$data<-plot_with_sample(truth,record_num$data,
                                          rlist$data[[1]],
                                          rlist$data[[2]])
      
      plot_cis$data<-add_ci(record_num$data,
                            rlist$data[[2]],input$show_interval)
      
    })
    
    observeEvent(input$reset, {
      plot_samples$data<-truth
      plot_cis$data<-ci_record
      record_num$data<-0
    })
  
    
    #workflow: 
    # sample_index as reactive value that updates
    # success_rate as reactive value that updates
    # record_num as reactive value that updates
    # get sample: updates sample_index, show the sample and sample mean
    # in pane 1, adds mean and CI in pain 2, update 
    # success_rate.
    # render the current success rate of the CI
    # get 100 sample: repeats process above 100 times.
}

# Run the application 
shinyApp(ui = ui, server = server)
