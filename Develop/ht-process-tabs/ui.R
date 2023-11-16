

########################
# Create Shiny Page ####
########################

# Define UI for application that draws a histogram
ui <- fluidPage("Hypothesis Testing for One Variable",
        sidebarLayout(
        sidebarPanel(
            widths = c(12, 12), "Set Null Hypothesis:",
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
                        min=90, max=110,step=1, value=100),
            width=3
        ),
        mainPanel(
            source('ui_main.R'),
            width=9
        )
    )
)