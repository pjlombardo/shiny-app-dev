fluidRow( position = 'left',
          withMathJax(),
          # Put slider and button in the sidebar
          br(),
          column(12,
                 #This creates a button for us.
                 actionButton("get2","Get a new sample"),
                 checkboxInput("show2", "Show the sample?", value = FALSE, width = NULL),
                 br(),
                 tableOutput("t2")
          ),
          column(12,
                 plotOutput("regPlot2",
                            width ="650px",
                            height ="400px")
          )
          
)