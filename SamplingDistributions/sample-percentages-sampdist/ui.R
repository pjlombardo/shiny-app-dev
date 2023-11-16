ui<-fluidPage(
    h1("Sampling Distribution of Sample Percentages"),br(),br(),
    tabsetPanel(type = "tabs",
                tabPanel("Generating a Sampling Distribution",
                         source('tab-ui-files/tab1.R',local=TRUE)$value),
                tabPanel("Exploring the Sampling Distribution",
                         source('tab-ui-files/tab2.R',local=TRUE)$value)
    )
)
