fluidPage(
    # Application title
titlePanel("Exploring The Sampling Distribution of Sample Percentages"),

# Sidebar with a slider for sample size and action button to get a new sample.
fluidRow( position = 'center',
          # Put slider and button in the sidebar
          column(4,
                 #This creates a button for us.
                 sliderInput("p_val2",
                             "Fix a population proportion",
                             min = .05,
                             max = .95,
                             value = .45)
          ),
          column(4,
                 sliderInput("sample_size2",
                             "Fixed Sample Size for the Sampling Distribution",
                             min = 10,
                             max = 300,
                             value = 10)
                 
          ),
          column(4,
                 checkboxInput("show_pop", "Show Population Percentage.", value = FALSE, width = NULL)
                 ),
          column(12,
                 plotOutput("histograms2",
                     width="700px",
                     height="400px")
                 ),
          
          column(12,
          h4(textOutput("p_hat2"), align="left"),
          h4(textOutput("std_error2"), align="left"),
          br(),br()
          )
          
          
)
)