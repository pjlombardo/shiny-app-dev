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
library(patchwork)

# Set up stuff
set.seed(123)
norm_pop<-2*rnorm(2000, 98.7,2.7)+runif(2000,-15,20)
chisq_pop<-5*rchisq(2000,3)+170
left_pop<-228-5*rchisq(2000,3)
unif_pop<-runif(2000,160,230)
bimod_pop<-c(rnorm(800,185,8),rnorm(1200,220,5))

populations<-data.frame(
  "norm_pop" = norm_pop,
  "chisq_pop" = chisq_pop,
  "left_pop" = left_pop,
  "unif_pop" = unif_pop,
  "bimod_pop"= bimod_pop
)

sample_num <- 1

show_population<-function(data){
  ggplot()+geom_histogram(aes(x=data), 
                                        breaks = 160 + 2.5*0:32,
                                        colour='black',
                                        fill='green3',
                                        alpha=.25)+
        coord_cartesian(xlim=c(160,240))+
        # xlim(160,240)+
    geom_vline(aes(xintercept = mean(data)),
               color='green4',lwd=2)+ylab("")+
        labs(title="Histogram of Population Data",
             x="Individual Measurements")+
        theme_bw()+
    theme(axis.text.y=element_blank(),
          plot.title = element_text(size=18),
          axis.title.x = element_text(size=14))
}

boot_fxn<-function(data,index){
  return(mean(data[index]))
}

collect<-function(data,n=50) { 
  boot_data<-numeric(2000)
  for (i in 1:2000){
    boot_data[i]<-boot_fxn(data,sample(1:2000,n))
  }
  boot_data
}

# show_sampling_dist<-function(data,n=50){
#   data_temp<-collect(data,n)
#   ggplot()+geom_histogram(aes(x=data_temp), 
#                                         bins=50,
#                                         colour='black',
#                                         fill='blue2',
#                                         alpha=.25)+
#     xlim(160,240)
# }


update_sampling_dist<-function(data,sample_num,binsize,n){
  data_temp<-data[1:sample_num]
  ggplot()+geom_histogram(aes(x=data_temp), 
                          breaks = 160 + binsize*(0:(80/binsize)),
                          colour='black',
                          fill='blue2',
                          alpha=.25)+
      coord_cartesian(xlim=c(160,240))+
    # xlim(160,240)+
    geom_vline(aes(xintercept=mean(data_temp)),
               color='blue',lwd = 1.3)+ylab("")+
      labs(title="Histogram Of Sample Means Drawn From The Population",
           x=paste("Sample Means (based on a sample size of ",n,")",sep=""))+
      theme_bw()+
    theme(axis.text.y=element_blank(),
          plot.title = element_text(size=18),
          axis.title.x = element_text(size=14))
}


get_segs<-function(plot,sample,sample_num){
  m1<-max(ggplot_build(plot)$data[[1]]$ymax)
  yend<-rep(.1*m1,sample_num)
  y<- rep(-.05*m1,sample_num)
  x<-sample[1:sample_num]
  xend<-sample[1:sample_num]
  plot<-plot+geom_segment(aes(
    x=x, y=y, xend=xend, yend=yend
  ),color='red',alpha=.35*(1+1/sample_num))
  
  plot
}

layout_d<-"
AAA
AAA
AAA
AAA
###
BBB
BBB
BBB
BBB
"


########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Generating a Sampling Distribution"),
   
   # Sidebar with a slider for sample size and action button to get a new sample.
   sidebarLayout( position = 'left',
     # Put slider and button in the sidebar
      sidebarPanel(
        #This creates a button for us.
        selectInput("pop_type","Select your model:",
                    c("Normal" = "norm_pop",
                      "Right-skewed" = "chisq_pop",
                      "Left_skewed" = "left_pop",
                      "Uniform" = "unif_pop",
                      "Bimodal" = "bimod_pop")),
        #
        sliderInput("sample_size",
                    "Fixed Sample Size for a given sample",
                    min = 1,
                    max = 50,
                    value = 1),
        
        actionButton("get_one_sample","Get one sample"),
        
        actionButton("get_one_hundred_samples","Get 100 samples"),
        
        actionButton("reset","Reset Sampling Distribution"),
        
        sliderInput("binsize",
                    "Choose a bin size for the sampling distribution.",
                    min = 0.25,
                    max = 3,
                    value = 2.5,
                    step=0.25)
        
        
         # This creates a checkbox
         # checkboxInput('sampling',"Show Sampling Distribution",value=T),
         # checkboxInput('pops',"Show Population Distribution",value=T)
         # This creates a 
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("histograms",
                    width="500px",
                    height="700px")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  sample_num<-reactiveValues(data=1)
  pop_chosen<-reactiveValues(data = norm_pop)
  
  observeEvent(input$pop_type,{
    pop_chosen$data <-populations[,input$pop_type]
  })
  
  observeEvent(input$get_one_sample,{
    sample_num$data<-sample_num$data+1
  })
  
  observeEvent(input$get_one_hundred_samples,{
    sample_num$data<-sample_num$data + 100
  })
  
  observeEvent(input$reset, {
    sample_num$data<-1
  })
  
  sampled_full<-eventReactive(c(input$sample_size,
                                input$pop_type), {
    sample_num$data<-1
    collect(pop_chosen$data,n=input$sample_size)
  })

  
  output$histograms<-renderPlot({
    #since sampled_full is the ouput of eventReactive, need
    #sampled_full() to return the actual va
    pt2_temp<-update_sampling_dist(sampled_full(),sample_num$data, 
                                   input$binsize,
                                   input$sample_size)
    pt2<-get_segs(pt2_temp,sampled_full(),sample_num$data)
    pt1<-show_population(pop_chosen$data)
    # plt_list<-list(pt1,pt2)
    # grid.arrange(grobs=plt_list,nrow=2)
    pt1+pt2+plot_layout(design=layout_d)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
