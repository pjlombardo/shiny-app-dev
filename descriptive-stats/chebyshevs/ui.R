########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Percent of Data within a Range"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    fluidRow( position = 'left',
              # Put slider and button in the sidebar
              column(8, plotOutput("histograms",
                                   width="700px",
                                   height="500px")
              ),
              
              column(4,
                     selectInput("pop_set","Choose non-normal population style:",
                                 list('Distribution Shape' = c(
                                     "Normal", "Bimodal", "Positive Skew", "Uniform"
                                 )
                                 )
                     ), br(),
                     tableOutput("pop_details"),
                     br(),
                     checkboxInput("show_range",'Highlight "Rule of Thumb" Region'),
                     textOutput("pct_within")
                     
              )
    )
)
