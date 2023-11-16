# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Exploring The Chi-squared Distribution"),
  fluidRow(
    withMathJax(),
    column(4, sliderInput("d","Select the degrees of\nfreedom, \\(d\\):",
                min=1, max=15, val=1, step=.1
    )),
    column(4, 
          checkboxInput("show_range",
                        "Show Sample Data")
    )),
  fluidRow(
    column(8, plotOutput("density",
                         width="700px",
                         height="400px"),
           h3(textOutput("pct_within"))
           )
)
)
