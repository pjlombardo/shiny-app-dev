########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Comparing MS_groups to MS_error:"),
    
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
                     
                     actionButton("get_new","Get new samples.")
              ),
              column(8,
                     plotOutput("stripchart",
                                height="300px"),
                     h3(textOutput("MS_group")),
                     h3(textOutput("MS_error")),
                     h2(textOutput("F_ratio"))
                     
              )
              
    )
    
)
