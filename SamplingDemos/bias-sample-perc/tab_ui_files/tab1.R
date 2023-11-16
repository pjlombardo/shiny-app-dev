fluidRow(
    # Put slider and button in the sidebar
    column(1),
    column(4,
           tableOutput("pop_table1")),
    column(1),
    # Show a plot of the generated distribution
    # column(4,
    #        tableOutput("samp_table1")
    # ),
    column(1),
    column(8,
           actionButton("get_random_sample1",
                        "Get a biased sample from the population"),
           br(),br(),
           # This creates a 
           sliderInput("sample_size1",
                       "Sample Size",
                       min = 30,
                       max = 300,
                       value = 50),
           plotOutput("samples1",
                      height="400px",
                      width="800px")
    )
)