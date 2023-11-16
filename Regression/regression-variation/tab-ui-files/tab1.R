# Sidebar with a slider for sample size and action button to get a new sample.

fluidRow( position = 'left',
          # Put slider and button in the sidebar
          br(),
          column(12,
                 #This creates a button for us.
                 actionButton("get1","Get a new sample"),
                 checkboxInput("show1", "Show the sample?", value = FALSE, width = NULL),
                 br()
          ),
          column(12,
                 plotOutput("regPlot1",
                            width ="650px",
                            height ="400px")
          )
          
)