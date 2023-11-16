fluidPage(
    
    # Application title
    titlePanel("Generating a Sampling Distribution of Sample Percentages"),
    
    # Sidebar with a slider for sample size and action button to get a new sample.
    sidebarLayout( position = 'left',
                   # Put slider and button in the sidebar
                   sidebarPanel(
                       #This creates a button for us.
                       sliderInput("p_pop1",
                                   "Choose the population percentage",
                                   min = 0.2,
                                   max = 0.8,
                                   value = .5),
                       
                       sliderInput("sample_size1",
                                   "Fixed Sample Size for a given sample",
                                   min = 20,
                                   max = 80,
                                   value =30),
                       
                       
                       actionButton("get_one_sample1","Get one sample"),
                       
                       actionButton("get_one_hundred_samples1","Get 100 samples"),
                       
                       actionButton("reset1","Reset Sampling Distribution"),
                       br(),
                       br(),
                       sliderInput("bin_count1",
                                   "Choose number of bins for sampling distribution.",
                                   min = 5,
                                   max = 50,
                                   value =10)
                       
                       # This creates a checkbox
                       # checkboxInput('sampling',"Show Sampling Distribution",value=T),
                       # checkboxInput('pops',"Show Population Distribution",value=T)
                       # This creates a 
                   ),
                   
                   # Show a plot of the generated distribution
                   mainPanel(
                       plotOutput("plots1",
                                  width="600px",
                                  height="800px")
                   )
    )
)