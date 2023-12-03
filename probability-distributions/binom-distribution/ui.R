# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Exploring The Binomial Distribution"),
  fluidRow(
    withMathJax(),
    column(4, sliderInput("n","Select the sample size, n:",
                          min=5, max=30,val=15, step=1
    )),
    column(3, sliderInput("p","Select the probability of\nsuccess, p:",
                min=0.01, max=.99, val=.5, step=.01
    )),
    column(4,
           withMathJax(),
           h4(withMathJax(textOutput("mean"))),
          h4(withMathJax(textOutput("sd"))),
          checkboxInput("show_range",
                        "Highlight the 2-\\(\\sigma\\) Region")
    )),
  fluidRow(
    column(8, plotOutput("density",
                         width="700px",
                         height="400px"),
           h3(textOutput("pct_within"))
           )
)
)
