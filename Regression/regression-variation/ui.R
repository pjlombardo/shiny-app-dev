
########################
# Create Shiny Page ####
########################

ui<-fluidPage(
    h1("Sampling Variation with Regression"),br(),br(),
    tabsetPanel(type = "tabs",
        tabPanel("Visualizing Sampling Variation",
                 source('tab-ui-files/tab1.R',local=TRUE)$value),
        tabPanel("Sampling Variation for Correlation",
                 source('tab-ui-files/tab2.R',local=TRUE)$value),
        tabPanel("Sampling Variation for Regression Coefficients",
                 source('tab-ui-files/tab3.R',local=TRUE)$value)
    )
)