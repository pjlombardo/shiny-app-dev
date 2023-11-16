library(shiny)
library(ggplot2)
library(knitr)
library(kableExtra)

source('functions.R')

server <- function(input, output) {
    ## Biased sampling stuff
    output$samples1<-renderPlot({truth})
    output$pop_table1<-function(){
       popul_table %>%
            knitr::kable("html",
                                col.names = c("Political Party",
                                              "Pop. Count",
                                              "Pop. Percentage"),
                                row.names = FALSE) %>%
            kable_styling()%>%
            row_spec(1, color = "black",
                     background = "#bdc3fc"#,
                     #popover = paste("am:", mtcars$am[1:8])
            )%>%
            row_spec(2, color = "black",
                     background = "#fabbc0"#,
                     #popover = paste("am:", mtcars$am[1:8])
            )
    }
    #Observe event connects the utton to the commands inside. Each time we click the
    # button, we will re=run the inside part.
    observeEvent(input$get_random_sample1, {
        #renderPlot connects the plotOutput with an actual plot. In our case, we 
        # create the plot in a function from earlier in the app.
        index1<-get_bias_sample_indices(n=input$sample_size1)
        
        output$pop_table1<-function(){
            #code goes here for table.
            get_bias_sample_table(index1)%>%
                knitr::kable("html",
                             col.names = c("Political Party",
                                           "Pop. Count",
                                           "Pop. Percentage",
                                           "Sample Count",
                                           "Sample Percentage"),
                             row.names = FALSE) %>%
                kable_styling() %>%
                row_spec(1, color = "black",
                         background = "#bdc3fc"#,
                         #popover = paste("am:", mtcars$am[1:8])
                )%>%
                row_spec(2, color = "black",
                         background = "#fabbc0"#,
                         #popover = paste("am:", mtcars$am[1:8])
                )%>%
                column_spec(2, border_left=TRUE
                            #background = "#dcfcd9"#,
                            #popover = paste("am:", mtcars$am[1:8])
                ) %>%
                column_spec(4, border_left=TRUE, bold=TRUE
                            #popover = paste("am:", mtcars$am[1:8])
                )  %>%
                column_spec(5, bold=TRUE
                            #popover = paste("am:", mtcars$am[1:8])
                )
        }
        
        output$samples1<-renderPlot({
            get_bias_sample_plot(index1)
        })
    })

############################################################
    
    ## Random sample stuff
    output$samples2<-renderPlot({truth})
    output$pop_table2<-function(){
        popul_table %>%
            knitr::kable("html",
                         col.names = c("Political Party",
                                       "Pop. Count",
                                       "Pop. Percentage"),
                         row.names = FALSE) %>%
            kable_styling("striped", full_width = T)%>%
            row_spec(1, color = "black",
                     background = "#bdc3fc"#,
                     #popover = paste("am:", mtcars$am[1:8])
            )%>%
            row_spec(2, color = "black",
                     background = "#fabbc0"#,
                     #popover = paste("am:", mtcars$am[1:8])
            )
    }
    #Observe event connects the utton to the commands inside. Each time we click the
    # button, we will re=run the inside part.
    observeEvent(input$get_random_sample2, {
        #renderPlot connects the plotOutput with an actual plot. In our case, we 
        # create the plot in a function from earlier in the app.
        index2<-get_rand_sample_indices(n=input$sample_size2)
        
        output$pop_table2<-function(){
            #code goes here for table.
            get_rand_sample_table(index2) %>%
                knitr::kable("html",
                             col.names = c("Political Party",
                                           "Pop. Count",
                                           "Pop. Percentage",
                                           "Sample Count",
                                           "Sample Percentage"),
                             row.names = FALSE) %>%
                kable_styling() %>%
                row_spec(1, color = "black",
                            background = "#bdc3fc"#,
                            #popover = paste("am:", mtcars$am[1:8])
                )%>%
                row_spec(2, color = "black",
                         background = "#fabbc0"#,
                         #popover = paste("am:", mtcars$am[1:8])
                )%>%
                column_spec(2, border_left=TRUE
                            #background = "#dcfcd9"#,
                            #popover = paste("am:", mtcars$am[1:8])
                            ) %>%
                column_spec(4, border_left=TRUE, bold=TRUE
                            #popover = paste("am:", mtcars$am[1:8])
                )  %>%
                column_spec(5, bold=TRUE
                            #popover = paste("am:", mtcars$am[1:8])
                )
                # add_header_above(c(" "=1,"Population"=2,
                #                    "Sample"=2))
        }
        
        output$samples2<-renderPlot({
            get_rand_sample_plot(index2)
        })
    })
    
    
    
}