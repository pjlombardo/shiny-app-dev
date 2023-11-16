# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("P-values, Significance Levels, and Power"),
    
                 # Show a plot of the generated distribution
                 column(12,
                   plotOutput("picture",
                              width="700px",
                              height="450px")
                 ),
  column(4,
         sliderInput("null_mu", "Set mu for the null hypothesis",
                     min=85,max = 115, step = 1, value = 100)
         ),
  column(4,
         #This creates a button for us.
         # actionButton("get_one_sample","Get one sample"),
         sliderInput("pop_sd","Set the population Standard Deviation, sigma",
                     min=5, max = 50, step = 5, value= 15),
         sliderInput("sample_size","Set the fixed sample size, n",
                     min=2, max = 50, step=1, value=5)
         # This creates a checkbox
         # checkboxInput('ci',"Show Confidence Interval",value=F)
         # checkboxInput('pops',"Show Population Distribution",value=T)
         # This creates a 
  )
)

