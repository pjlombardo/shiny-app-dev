########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    fluidPage(
        titlePanel("Exploring the Power of a Test, Right tailed test"),
        # Application title
        sidebarPanel(
            sliderInput("mu_2",
                        "Difference in means, mu1 - mu2",
                        min = 0,
                        max = 10,
                        value = 2),
            sliderInput("sample_size",
                        "Fixed Sample Size for Sampling Distributions",
                        min = 5,
                        max = 300,
                        value = 15),
            sliderInput("alpha",
                        "Significance level",
                        min = 0.01,
                        max = .1,
                        value = .05,
                        step = .01),
            h3("The region highlighted in green is the power of the test."),
            h3("The region highlighted in red is the significance level of the test."),
            h3(textOutput("power"))
        ),
        
        mainPanel(
            h4("Null and Alternative Population Distributions"),
            plotOutput("pops",
                       height="300px"),
            h4("Null and Alternative **Sampling Distributions**"),
            plotOutput("sampdists",
                       height = "300px")
        ) #end Main Panel
        
    )#end fluid page
    
) #end navbar
