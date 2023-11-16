ui<-fluidPage(
    h1("Sampling Method Makes A Difference!"),br(),br(),
    tabsetPanel(type = "tabs",
                tabPanel("Biased Sampling Method",
                         br(),
                         source('tab_ui_files/tab1.R',local=TRUE)$value),
                tabPanel("Simple Random Sampling Method",
                         br(),
                         source('tab_ui_files/tab2.R',local=TRUE)$value)
    )
)