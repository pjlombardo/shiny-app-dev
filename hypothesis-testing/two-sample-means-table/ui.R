########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    fluidPage(
        titlePanel("Null Distributions and Sampling"),
        # Application title
        sidebarPanel(
            sliderInput("mu_1",
                        "Mean of Population 1",
                        min = 90,
                        max = 110,
                        value = 95),
            sliderInput("mu_2",
                        "Mean of Population 2",
                        min = 90,
                        max = 110,
                        value = 105),
            sliderInput("sample_size",
                        "Fixed Sample Size for Sampling Distributions",
                        min = 5,
                        max = 300,
                        value = 15),
            actionButton("get_samples","Sample from each population")
        ),
        
        mainPanel(
            h4("Raw Population Distribution"),
            plotOutput("pops",
                       height="300px"),
            h4("Compared Means"),
            div(tableOutput("sample_means"),
                style = "font-size: 150%; width: 150%")
        ) #end Main Panel
        
    )#end fluid page
    
) #end navbar
