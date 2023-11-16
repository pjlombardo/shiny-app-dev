# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Comparing the t-distribution with the z-distribution"),
    
                 # Show a plot of the generated distribution
                 column(12,
                   plotOutput("picture",
                              width="700px",
                              height="450px")
                 ),
  column(4,
         #This creates a button for us.
         # actionButton("get_one_sample","Get one sample"),
         sliderInput("sample_size","Set the fixed sample size, n",
                     min=2, max = 50, step=1, value=5)
         # This creates a checkbox
         # checkboxInput('ci',"Show Confidence Interval",value=F)
         # checkboxInput('pops',"Show Population Distribution",value=T)
         # This creates a 
  )
)

