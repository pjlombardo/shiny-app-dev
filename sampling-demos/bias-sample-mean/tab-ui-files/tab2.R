fluidPage(
    
    # Application title
    h3("Biased Sample Means Vs. Population Mean"),
    plotOutput("scatter_with_means2",
               height="400px",
               width="800px"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    fluidRow(
        # Put slider and button in the sidebar
        column(1),
        column(4,
               #This creates a button for us.
               actionButton("get_random_sample2","Get a biased sample from the population"),
               # This creates a 
               sliderInput("sample_size2",
                           "Sample Size",
                           min = 1,
                           max = 100,
                           value = 5)
        )
        
        
    )
)