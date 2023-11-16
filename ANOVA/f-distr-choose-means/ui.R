########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Probability Model compared to Sampling Distribution of F-scores"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    fluidRow( position = 'left',
              # Put slider and button in the sidebar
              column(4,
                     #This creates a button for us.
                     sliderInput("sample_size",
                                 "Fixed Sample Size for a given sample",
                                 min = 15,
                                 max = 100,
                                 value = 30),
                     #This creates a button for us.
                     sliderInput("mu1",
                                 "Mean for group 1",
                                 min = 90,
                                 max = 110,
                                 value = 100),
                     #This creates a button for us.
                     sliderInput("mu2",
                                 "Mean for group 2",
                                 min = 90,
                                 max = 110,
                                 value = 100),
                     #This creates a button for us.
                     sliderInput("mu3",
                                 "Mean for group 3",
                                 min = 90,
                                 max = 110,
                                 value = 100),
                     checkboxInput("dens","Show density plot")
              ),
              column(8,
                     plotOutput("f_samp_dist",
                                height="500px"),
                     h4("The line in red is the probability model for where our",
                        "F-scores should fall under the null hypothesis that all means",
                        "are equal.  The blue histogram is an actual sampling distribution",
                        "of F-scores based on the group means you set using the sliders.",
                        "When the blue histogram doesn't follow the red probability model",
                        "we have reason to suspect the null hypothesis isn't true.")
                     
              )
              
    )
    
)