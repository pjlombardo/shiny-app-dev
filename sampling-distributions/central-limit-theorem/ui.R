########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Generating a Sampling Distribution"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    sidebarLayout( position = 'left',
                   # Put slider and button in the sidebar
                   sidebarPanel(
                       #This creates a button for us.
                       selectInput("pop_type","Select your model:",
                                   c("Normal" = "norm_pop",
                                     "Right-skewed" = "chisq_pop",
                                     "Left_skewed" = "left_pop",
                                     "Uniform" = "unif_pop",
                                     "Bimodal" = "bimod_pop")),
                       #
                       sliderInput("sample_size",
                                   "Fixed Sample Size for a given sample",
                                   min = 1,
                                   max = 50,
                                   value = 1),
                       
                       actionButton("get_one_sample","Get one sample"),
                       
                       actionButton("get_one_hundred_samples","Get 100 samples"),
                       
                       actionButton("reset","Reset Sampling Distribution"),
                       
                       sliderInput("binsize",
                                   "Choose a bin size for the sampling distribution.",
                                   min = 0.25,
                                   max = 3,
                                   value = 2.5,
                                   step=0.25)
                       
                       
                       # This creates a checkbox
                       # checkboxInput('sampling',"Show Sampling Distribution",value=T),
                       # checkboxInput('pops',"Show Population Distribution",value=T)
                       # This creates a 
                   ),
                   
                   # Show a plot of the generated distribution
                   mainPanel(
                       plotOutput("histograms",
                                  width="500px",
                                  height="700px")
                   )
    )
)