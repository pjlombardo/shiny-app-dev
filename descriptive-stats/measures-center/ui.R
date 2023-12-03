# Define UI for application that draws a histogram
ui <- navbarPage("Exploring Summary Statistics for Quantitative Data",
                 tabPanel("Outliers",
                          fluidRow(
                              titlePanel("Exploring the effect of outliers on summary statistics"),
                              column(8,align="center", tableOutput("comp_stats")),
                              column(8,
                                     numericInput("outlier","Choose a value",100000),
                                     actionButton("add_outlier","Add observation to the data"),
                                     actionButton("reset","Reset Population"),
                                     plotOutput("histogram_outliers",
                                                height="250px")
                                     
                              )
                              # add some reactive text ouput that shows the mean and median after adding outliers
                          )
                 ),
                 
                 tabPanel("Multi-modal",
                          plotOutput("bimodal_histogram",width="600px"),
                          
                          column(4,
                                 h4("Instructions:")
                                 
                          ),
                          
                          column(4,
                                 sliderInput("mean1",
                                             "Adjust  peak 1:",
                                             min = -10,
                                             max = 10,
                                             step=.05,
                                             value = -4),
                                 
                                 sliderInput("mean2",
                                             "Adjust peak 2:",
                                             min = -10,
                                             max = 10,
                                             step=.05,
                                             value = 5)
                                 
                          )
                          
                 ),
                 
                 
                 tabPanel("Skewed Data",
                          # Application title
                          titlePanel("Mean and Median with Histogram of Data"),
                          plotOutput("histogram1"),
                          hr(),
                          # Sidebar with a slider for sample size and action button to get a new sample.
                          fluidRow(
                              # Put slider and button in the sidebar
                              column(1, br()),
                              column(4,
                                     #This creates a button for us. 
                                     radioButtons("show_var","Show ...",
                                                  c("Just the histogram"="","Histogram and Mean" = "mean",
                                                    "Histogram and Median" = "median",
                                                    "Histogram and both"="both"))
                              ),
                              
                              column(5,         
                                     sliderInput("skew",
                                                 "Adjust the skew:",
                                                 min = -1,
                                                 max = 1,
                                                 step=.05,
                                                 value = 0,
                                                 animate=animationOptions(interval = 300,
                                                                          loop = TRUE))
                              )
                          )
                 )
                 
)