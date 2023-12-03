fluidPage(
    h3("Sampling Distributions for Each Populations"),
    # Application title
    sidebarPanel(
        sliderInput("mu_1A",
                    "Mean of Population 1",
                    min = 90,
                    max = 110,
                    value = 95),
        sliderInput("mu_2A",
                    "Mean of Population 2",
                    min = 90,
                    max = 110,
                    value = 105),
        sliderInput("sample_sizeA",
                    "Fixed Sample Size for Sampling Distributions",
                    min = 5,
                    max = 300,
                    value = 15),
        checkboxInput("dens_boolA","Density Plot:")
    ),
    
    mainPanel(
        h4("Raw Population Distributions"),
        plotOutput("popsA",
                   height="300px"),
        h4("Sampling Distributions Of The Mean For Each Population"),
        plotOutput("samp_distsA", 
                   height="300px")
    ) #end Main Panel
    
)#end fluid page