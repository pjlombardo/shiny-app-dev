########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Success rate for categorical confidence intervals, Agresti-Coull"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    fluidRow( position = 'left',
              # Put slider and button in the sidebar
              column(5,
                     plotOutput("sampling",
                                height="350px",
                                width="400px"),
                     h4(textOutput("p_hat"))
              ),
              column(7,
                     plotOutput("conf_int",
                                height="450px"))
    ),
    
    fluidRow(
        column(4,
               actionButton("get_samp", "Get one sample"),
               actionButton("get_50", "Get 50 samples"),
               sliderInput("sample_size","Set the fixed sample size",
                           min=5, max = 100, step=5, value=5)
        ),
        column(4,
               sliderInput("p_val","Set the population proportion",
                           min=.1, max=.9, step=.05,value=.3),
               actionButton("reset","Reset plot")
        ),
        column(4,
               h3(textOutput("success_rate"))
        )
    )
    
)