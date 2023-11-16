fluidPage(
    h3("Comparing Sampling Distribution for a Difference in Means"),
    # Application title
    sidebarPanel(
        sliderInput("mu_1B",
                    "Mean of Population X",
                    min = 90,
                    max = 110,
                    value = 95),
        sliderInput("mu_2B",
                    "Mean of Population Y",
                    min = 90,
                    max = 110,
                    value = 105),
        sliderInput("sample_sizeB",
                    "Fixed Sample Size for Sampling Distributions",
                    min = 5,
                    max = 300,
                    value = 15),
        checkboxInput("dens_boolB","Density Plot:"),
        actionButton("get_one_sampleB","Get one sample"),
        
        actionButton("get_one_hundred_samplesB","Get 100 samples"),
        
        actionButton("resetB","Reset Sampling Distribution")
    ),
    
    mainPanel(
        h4("Populations Histograms"),
        plotOutput("samp_distsB",
                   height="300px"),
        h4("Distribution of Difference Between Sample Means, (Ybar - Xbar)"),
        plotOutput("diff_distB", 
                   height="300px")
    ) #end Main Panel
    
)#end fluid page