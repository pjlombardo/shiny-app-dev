# Sidebar with a slider for sample size and action button to get a new sample.
fluidRow( position = 'left',
          # Put slider and button in the sidebar
          br(),
          column(12,
                 #This creates a button for us.
                 actionButton("get3","Get a new sample"),
                 checkboxInput("show3", "Show the sample?", value = FALSE, width = NULL)
          ),
          column(12,
                 tableOutput("t3")
          ),
          column(12,
                 plotOutput("regPlot3",
                            width ="650px",
                            height ="400px")
          )
          
)