fluidPage(
    
    # Application title
    titlePanel("Flipping A Single Coin"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    sidebarLayout(
        # Put slider and button in the sidebar
        sidebarPanel(
            #This creates a button for us.
            # actionButton("reload_plot","Update Plot Simulation"),
            # This creates a slider to update the number of simulations
            sliderInput("num_sims",
                        "Number of Simulations",
                        min = 5,
                        max = 5000,
                        value = 5,
                        step=4,
                        animate=animationOptions(interval = 400,
                                                 loop = TRUE)),
            hr(),hr(),
            actionButton("new_sim1","Generate a new simulation")
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("line_with_rel_freq")
        )
    )
)