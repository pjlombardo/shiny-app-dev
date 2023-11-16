
fluidRow(
    # Put slider and button in the sidebar
    column(1),
    column(4,
           tableOutput("pop_table2")),
    column(1),
    # Show a plot of the generated distribution
    # column(4,
    #        tableOutput("samp_table2")
    # ),
    column(1),
    column(8,
           actionButton("get_random_sample2","Sample from the population"),
           # This creates a 
           sliderInput("sample_size2",
                       "Sample Size",
                       min = 10,
                       max = 500,
                       value = 30),
           plotOutput("samples2",
                      height="400px",
                      width="800px")
    )
)