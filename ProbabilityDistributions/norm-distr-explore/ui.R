# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Exploring The Normal Distribution"),
  fluidRow(
    withMathJax(),
    column(4, sliderInput("mu","Select the mean, \\(\\mu\\)",
                          min=-5, max=10,val=0, step=.5
    )),
    column(4, sliderInput("sigma","Select the standard\ndeviation, \\(\\sigma\\):",
                min=.8, max=4, val=1, step=.05
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
