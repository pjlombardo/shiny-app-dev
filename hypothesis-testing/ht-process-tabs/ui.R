

########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
    ui <- navbarPage("Hypothesis Testing for One Variable",
                     navbarMenu("Steps for testing:",
                                tabPanel("1. Set Null Hypothesis",
                                         withMathJax(),
                                         fluidRow(
                                             
                                             column(12, 
                                                    h2("Step 1: Setting the null hypothesis."),
                                                    h3("Instructions:"),
                                                    p("Using the drop-down menu and the slider, ",
                                                      "select the type of null hypothesis (less,",
                                                      "greater, equal to), and the mean for the ",
                                                      "null hypothesis. Then click the button to ",
                                                      "generate the null distribution.",
                                                      "A random sample from the actual population is automatically taken",
                                                      "and the sample mean is plotted with a red vertial line over the ",
                                                      "histogram associated to the null hypothesis.")
                                             ),
                                             column(4,
                                                    # while this says to select the null, the return value is
                                                    # for the alternative hypothesis!
                                                    selectInput("h_type","Select Null Hypothesis",
                                                                c(
                                                                    "Less than" = "greater",
                                                                    "Greater than" = "less",
                                                                    "Equal to" = "two.sided"
                                                                )
                                                    ),
                                                    h4(uiOutput("null_hyp1")),
                                                    h4(uiOutput("alt_hyp1")),
                                                    sliderInput("mu_0","Select Null Hypothesis Mean:", 
                                                                min=90, max=110,step=1, value=95),
                                                    br(),
                                                    sliderInput("sample_size","Select the sample size:",
                                                                min=5, max=100,step=1, value=15),
                                                    
                                                    actionButton("get_sample","Collect an experimental sample")
                                             ),
                                             column(8,
                                                    plotOutput("step1"),
                                                    h4(uiOutput("sample_info"))
                                             )
                                         )
                                         
                                ),
                                
                                tabPanel("2. Scale and shift",
                                         fluidRow(
                                             column(8,
                                                    plotOutput("step2a",height="250px")
                                             ),
                                             column(3,
                                                    h4("Scale and shift by... $$t = \\frac{\\bar x - \\mu}{\\left(\\frac{s}{\\sqrt{n}}\\right)}$$"))
                                         ),
                                         column(8,
                                                plotOutput("step2b",height="250px")
                                         )
                                         
                                ),
                                
                                tabPanel("3. Probability Approximation (t-distribution)",
                                         fluidRow(
                                             column(8,
                                                    plotOutput("step3a",height="250px"),
                                                    plotOutput("step3b",height="250px")
                                             )
                                         )
                                         
                                ),
                                
                                tabPanel("4. Compare with t.test() results",
                                         fluidRow(
                                             column(8,
                                                    h4(uiOutput("null_hyp2")),
                                                    h4(uiOutput("alt_hyp2")), 
                                                    plotOutput("prob_approx"),
                                                    h4("Output of the t.test() command:"),
                                                    div(uiOutput("test_results_stat"),
                                                        style = "font-size: 150%; width: 150%"),
                                                    div(uiOutput("test_results_Pval"),
                                                        style = "font-size: 150%; width: 150%")
                                             )
                                         )
                                         
                                )
                     )
    )

