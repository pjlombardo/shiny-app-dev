# Define UI for application that draws a histogram
ui <- navbarPage("Hypothesis Testing Idea for Proportions",
  tabsetPanel(type = "tabs",
      tabPanel("Setting a Null Hypothesis Population Percentage",
               withMathJax(),
               fluidRow(
                 column(3,
                        # while this says to select the null, the return value is
                        # for the alternative hypothesis!
                        sliderInput("p_0","Select Null Hypothesis Percentage:",
                                    min=.2, max=.8,step=.01, value=.45)
                 ),
                 column(9, plotOutput("null_pop_plot",
                                      height="250px")
                 ),column(3),
                 column(9, plotOutput("actual_pop_plot",
                                      height="250px")
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
                                    min = 20, max = 100, step = 1, value = 30),
                 
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
                             value=F),
               sliderInput("bin_count","Select bins for Sampling Distribution:",
                           min=10, max=40,step=1, value=20)
               ),
        column(8,
               plotOutput("null_samp_dist")
               )
      )
      )

    )
)
