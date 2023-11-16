########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("F-distribution Probability Model"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    fluidRow( position = 'left',
              # Put slider and button in the sidebar
              column(4,
                     #This creates a button for us.
                     sliderInput("sample_size",
                                 "Fixed Sample Sizes for Groups",
                                 min = 15,
                                 max = 200,
                                 value = 30),
                     #This creates a button for us.
                     sliderInput("num_grps",
                                 "Number of Groups",
                                 min = 3,
                                 max = 20,
                                 value = 4)
              ),
              column(8,
                     plotOutput("f_samp_dist",
                                height="500px")
                     
              )
              
    )
    
)
