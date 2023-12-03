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

generate_null_distribution<-function(mu,sigma){
  data.frame(values=rnorm(5000,mu,sigma))
}

plot_paired_histograms<-function(data1,data2,dens_bool){
  if (dens_bool == T) {
    ggplot()+ 
    geom_density(aes(x=data1$values, y=..density../100),
                   fill='blue',
                   alpha=.5)+
    geom_density(aes(x=data2$values, y=..density../100),
                   fill='red',
                   alpha=.5)+
      labs(x="",y="Relative Frequency")
    }
  else {
    ggplot()+ 
      geom_histogram(aes(x=data1$values, y=..density../100),
                     fill='blue',
                     col='gray60',
                     alpha=.25,
                     bins=20)+
      geom_histogram(aes(x=data2$values, y=..density../100),
                     fill='red',
                     col='gray20',
                     alpha=.5,
                     bins=20)+
      labs(x="",y="Relative Frequency")
  }
}



# plot_paired_histograms(null1,null2)

get_sample_means<-function(population,m=5000,n=20){
  sample_means<-numeric(m)
  for (j in 1:m){
    sample_means[j]<-mean( sample( population[,1], n) )
  }
  
  df<-data.frame(values=sample_means)
  
  df
}



########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    fluidPage(
       titlePanel("Null Distributions and Sampling"),
       # Application title
       sidebarPanel(
         sliderInput("mu_1",
                     "Mean of Population 1",
                     min = 90,
                     max = 110,
                     value = 95),
         sliderInput("mu_2",
                     "Mean of Population 2",
                     min = 90,
                     max = 110,
                     value = 105),
          sliderInput("sample_size",
                      "Fixed Sample Size for Sampling Distributions",
                      min = 5,
                      max = 300,
                      value = 15),
         checkboxInput("dens_bool","Density Plot:")
         ),
         
       mainPanel(
         h4("Raw Population Distribution"),
          plotOutput("pops",
                     height="300px"),
         h4("Sampling Distributions of Means"),
          plotOutput("samp_dists", 
                     height="300px")
       ) #end Main Panel

    )#end fluid page
  
) #end navbar

# Define server logic required to draw a histogram
server <- function(input, output) {
  dens_bool<-reactiveValues(data=F)
  null1<-reactiveValues(data = generate_null_distribution(100,10))
  null2<-reactiveValues(data = generate_null_distribution(110,10))
  null1_s<-reactiveValues( data = get_sample_means(
    generate_null_distribution(100,10), m=5000,n=30
    )
  )
  
  null2_s<-reactiveValues( data = get_sample_means(
    generate_null_distribution(100,10), m=5000,n=30
    )
  )
  
  observeEvent(input$dens_bool,{
    dens_bool$data=input$dens_bool
  })

  
  observeEvent(input$mu_1, {  
    null1$data<-generate_null_distribution(input$mu_1,10)
    null1_s$data<-get_sample_means(null1$data,m=5000,
                                   n=input$sample_size)
  })
  
  observeEvent(input$mu_2, {  
    null2$data<-generate_null_distribution(input$mu_2,10)
    null2_s$data<-get_sample_means(null2$data,m=5000,
                                   n=input$sample_size)
  })
  

  observeEvent(input$sample_size,{
    null1_s$data<-get_sample_means(null1$data,m=5000,
                              n=input$sample_size)
    
    null2_s$data<-get_sample_means(null2$data,m=5000,
                              n=input$sample_size)
  
  })
  
  output$pops<-renderPlot({
    plot_paired_histograms(null1$data,null2$data,dens_bool$data)
    
  })
  
  output$samp_dists<-renderPlot({
    plot_paired_histograms(null1_s$data, null2_s$data,dens_bool$data)
    
  })

  
}

# Run the application 
shinyApp(ui = ui, server = server)
