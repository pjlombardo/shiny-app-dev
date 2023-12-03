fluidRow(
    # Put slider and button in the sidebar
    column(4,
           actionButton("get_random_sample1",
                        "Get a biased sample from the population"),
           br(),br(),
           # This creates a 
           sliderInput("sample_size1",
                       "Sample Size",
                       min = 30,
                       max = 300,
                       value = 50)
    ),column(1),
    column(6,
           tableOutput("pop_table1")
           ),

    # ),
    column(12,
           plotOutput("samples1",
                      height="400px",
                      width="800px")
    )
)