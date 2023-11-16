########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Histograms and Normal Quantile Plots "),
    column(4,
         selectInput("shape","Choose shape:",
                     c(
                         "Normal" = "normal",
                         "Positively Skewed" = "positive_skew",
                         "Negatively Skewed" = "negative_skew",
                         "Uniform" = "uniform",
                         "Bimodal" = "bimodal"
                     )
            )
         ),
    column(4,
           sliderInput("sample_size",
                       "Fixed Sample Size for a given sample",
                       min = 5,
                       max = 300,
                       value = 50)
           ),
    column(4,br(),
           actionButton("update", "Get new sample.")
           ),
    column(6,
           plotOutput("histogram"),br(),
           sliderInput("bins",
                       "Adjust the bins of the histogram",
                       min = 5,
                       max = 30,
                       value = 15,
                       step=5)
           ),
    column(6,plotOutput("qq_plot")),
    # Sidebar with a slider for sample size and action button to get a new sample.
    
    
)
