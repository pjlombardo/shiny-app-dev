fluidPage(
    
    # Application title
    h3("A Record of Means from Simple Random Samples"),
    plotOutput("scatter_with_means1b",
               height="400px",
               width ="700px"),
    
    fluidRow(
        column(11,
               br(),
               HTML("
                <p>The population plot above is the same as the previous tab,
                and the \"get one\" and \"get one hundred\" sample buttons still
                collect sample means from the population and display them.</p>
                <p><i><b>However</i></b>, the visual above will keep a record of the 
                sample means so that we can better visualize the variation that 
                arises from this simple random sampling process.<p>   
                    "),
               br()
               ),
        column(6,
               sliderInput("sample_size1b",
                           "Sample Size",
                           min = 1,
                           max = 100,
                           value = 5),
               actionButton("get_one_sample1b","Get one sample"),
               
               actionButton("get_one_hundred_samples1b","Get 100 samples")
               ),
        column(6,
               br(),
               # br(),
               # br(),
               actionButton("reset1b","Reset Visualization")),
        column(12,
               br())
    )
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    # sidebarLayout(
        # Put slider and button in the sidebar
        # sidebarPanel(
        #     # This creates a 
        #     sliderInput("sample_size1b",
        #                 "Sample Size",
        #                 min = 1,
        #                 max = 100,
        #                 value = 5),
        #     actionButton("get_one_sample1b","Get one sample"),
        #     
        #     actionButton("get_one_hundred_samples1b","Get 100 samples"),
        #     
        #     hr(),
        #     
        #     actionButton("reset1b","Reset Visualization")
        # ),
        
        # Show a plot of the generated distribution
        # mainPanel(
        #     plotOutput("scatter_with_means1b",
        #                height="450px",
        #                width = "600px")
        # )
    # )
)