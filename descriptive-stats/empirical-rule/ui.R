########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Percent of Data Within 2 Std. Deviations"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    fluidRow( position = 'left',
              # Put slider and button in the sidebar
              column(8, plotOutput("histograms",
                                   width="700px",
                                   height="500px"),
                     h3(textOutput("pct_within"))
              ),
              
              column(4,
                     sliderInput("mu","Select the mean:",
                                 min=50, max=100, val=60, step=1
                     ),
                     sliderInput("sigma","Select the standard deviation:",
                                 min=5, max=30, val=10, step=1
                     ),
                     br(),
                     checkboxInput("show_range",'Highlight "Rule of Thumb" Region')
                     
              )
    )
)