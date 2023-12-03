
ui<-fluidPage(
    h1("Comparing Means From Two Populations"),br(),br(),
    tabsetPanel(type = "tabs",
                tabPanel("Separate Sample Mean Sampling Distributions",
                         source('tab-ui-files/tab1.R',local=TRUE)$value),
                tabPanel("A Sampling Distribution for the Difference of Means",
                         source('tab-ui-files/tab2.R',local=TRUE)$value)
    )
)
