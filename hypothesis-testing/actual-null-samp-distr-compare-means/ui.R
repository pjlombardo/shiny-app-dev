# Define UI for application that draws a histogram
ui <- navbarPage("Hypothesis Testing Idea for Means",
  tabsetPanel(type = "tabs",
      tabPanel("Setting a Null Hypothesis Mean",
               withMathJax(),
               fluidRow(
                 column(3,
                        # while this says to select the null, the return value is
                        # for the alternative hypothesis!
                        sliderInput("mu_0","Select Null Hypothesis Mean:",
                                    min=80, max=120,step=1, value=100)
                 )
               ),

               fluidRow(
                 column(6, plotOutput("null_pop_plot")
                 ),
                 column(6, plotOutput("actual_pop_plot")
                 )
               )
               
      ),

####################
### TAB PANEL 2 ####
####################
      
      tabPanel("Sampling distribution of the Null Population",
               fluidRow(
                 column(4,
                     br(),br(),br(),br(),br(),
                     sliderInput("samp_size", "Choose the size of the samples:",
                                    min = 5, max = 80, step = 5, value = 10),
                 
                     actionButton("get_one_sample","Get one sample"),
                     
                     actionButton("get_one_hundred_samples","Get 100 samples"),
                     
                     actionButton("reset","Reset Sampling Distribution"),
                     br(),br(),
                     h4(textOutput("sample_counter"))
                 
               ),
                 column(8,
                        plotOutput("sample_from_null")
                 )
      ),
      fluidRow(
        column(4,
               checkboxInput('pops',
                             "Show Actual Population Sampling Distribution",
                             value=F)
               ),
        column(8,
               plotOutput("null_samp_dist")
               )
      )
      )

    )
)
