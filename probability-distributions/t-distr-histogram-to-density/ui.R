########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    fluidRow(
        titlePanel("Approximating using known distributions"),
        h4("Sampling Distributions of Means"),
        plotOutput("samp_dists", 
                   height="300px"),
        # Application title
        column(4,
               sliderInput("mu_1",
                           "Mean of Population 1",
                           min = 90,
                           max = 110,
                           value = 100),
               sliderInput("sample_size",
                           "Fixed Sample Size for Sampling Distributions",
                           min = 5,
                           max = 150,
                           value = 15)
        ),
        column(4,
               checkboxInput("dens_bool","Density Plot:"),
               checkboxInput("t_bool","Approximation By t-distribution")
        )
        
        
        
    )#end fluid page
    
) #end navbar
