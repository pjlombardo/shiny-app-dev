# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Generating a Sampling Distribution"),
  
  # Sidebar with a slider for sample size and action button to get a new sample.
  sidebarLayout( position = 'left',
                 # Put slider and button in the sidebar
                 sidebarPanel(
                   #This creates a button for us.
                   actionButton("get_one_sample","Get one sample"),
                   
                   # This creates a checkbox
                   checkboxInput('ci',"Show Confidence Interval",value=F)
                   # checkboxInput('pops',"Show Population Distribution",value=T)
                   # This creates a 
                 ),
                 
                 # Show a plot of the generated distribution
                 mainPanel(
                   plotOutput("picture",
                              width="700px",
                              height="600px")
                 )
  )
)
