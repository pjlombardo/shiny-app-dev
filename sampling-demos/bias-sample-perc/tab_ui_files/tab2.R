
fluidRow(
    # Put slider and button in the sidebar
    column(4,
           actionButton("get_random_sample2","Sample from the population"),
           # This creates a 
           sliderInput("sample_size2",
                       "Sample Size",
                       min = 10,
                       max = 500,
                       value = 30)),
    column(1),
    column(6,
           tableOutput("pop_table2")
           ),
    column(12,
           plotOutput("samples2",
                      height="400px",
                      width="800px")
    )
)