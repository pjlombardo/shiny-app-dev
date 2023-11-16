fluidPage(
    
    # Application title
    h3("Means from Simple Random Samples"),
    plotOutput("scatter_with_means1",
               height="400px",
               width="700px"),
    
    fluidRow(
        column(1),
        column(5,
               h5("Explanation:"),
               HTML("<p>The green dots in the plot above represent an 
       entire population of patients with their
       diastolic blood pressure listed on the y-axis.
       When you click the button, it will randomly select 
       a sample of patients and highlight them. <br></br>
       The blue line shows the mean
       diastolic BP for the sample of patients, which we 
       can compare against the mean diastolic BP for the 
       entire population (the green line).</p>")
               
        ),
        # Put slider and button in the sidebar
        column(5,
               #This creates a button for us.
               br(),br(),
               p("Use the slider to control the size of the sample you",
                 "collect."),br(),
               actionButton("get_random_sample1","Sample from the population"),
               br(),br(), 
               sliderInput("sample_size1",
                           "Sample Size",
                           min = 1,
                           max = 100,
                           value = 5)
        )
        
    )
)