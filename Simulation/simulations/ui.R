ui<-fluidPage(
    h1("Law of Large Numbers Simulations"),br(),br(),
    tabsetPanel(type = "tabs",
                tabPanel("Coin Flip",
                         br(),
                         source('tab-ui-files/tab1.R',local=TRUE)$value),
                tabPanel("Three Heads",
                         br(),
                         source('tab-ui-files/tab2.R',local=TRUE)$value),
                tabPanel("Dice Roll",
                         br(),
                         source('tab-ui-files/tab3.R',local=TRUE)$value)
    )
)