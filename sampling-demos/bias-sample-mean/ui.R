ui<-navbarPage("Sampling Method Makes A Difference!",
               navbarMenu(
                   "Choose how to sample...",
                   tabPanel("Simple Random Sampling",
                            tabsetPanel(type = "tabs",
                                        tabPanel("Simple Random Sampling",
                                                 source('tab-ui-files/tab1a.R',local=TRUE)$value),
                                        tabPanel("A Record of Sample Means...",
                                                 source('tab-ui-files/tab1b.R',local=TRUE)$value)
                            )),
                   tabPanel("Biased Sampling",
                            source('tab-ui-files/tab2.R',local=TRUE)$value)
                    )
    # tabsetPanel(type = "tabs",
    #             tabPanel("Simple Random Sampling",
    #                      source('tab-ui-files/tab1a.R',local=TRUE)$value),
    #             tabPanel("Keeping a Record of Sample Means",
    #                      source('tab-ui-files/tab1b.R',local=TRUE)$value),
    #             tabPanel("Biased Sampling",
    #                      source('tab-ui-files/tab2.R',local=TRUE)$value)
)