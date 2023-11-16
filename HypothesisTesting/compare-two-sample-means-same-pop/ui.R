########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Comparing samples from populations with the same mean."),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    fluidRow( position = 'left',
              # Put slider and button in the sidebar
              column(4,
                     #This creates a button for us.
                     sliderInput("sample_size",
                                 "Fixed Sample Size for a given sample",
                                 min = 1,
                                 max = 50,
                                 value = 10),
                     
                     actionButton("get_new","Get new samples.")
              ),
              column(8,
                     plotOutput("boxplot",
                                height="300px"),
                     plotOutput("stripchart",
                                height="300px")
              )
              
    )
    
)