library(shiny)
library(ggplot2)
library(latex2exp)

source('functions.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    null_pop<-reactiveValues(data = start_null)
    null_dist<-reactiveValues(data = start_null_dist)
    sm<-reactiveValues(data=get_sample(15))
    test_res<-reactiveValues(data = NULL)
    p_value<-reactiveValues(data=NULL)
    samp_dist_plot<-reactiveValues(
        data=ggplot()+ geom_histogram(aes(x=start_null_dist$values,y=..density..),
                                      bins=20)+
            coord_cartesian(xlim=c(75,125),ylim=c(0,.45))+
            labs(title="Null distribution")
    )
    
    # RenderHypotheses
    # lapply(1:2, function(nr){
    #   output[[paste0("plot", nr)]] <- renderPlot({hist(mtcars$mpg)})      
    # })
    
    observeEvent(input$h_type,{
        lapply(1:2, function(nr){
            output[[paste0("null_hyp", nr)]] <- renderUI( {
                if (input$h_type=="greater"){
                    return(withMathJax(
                        sprintf("\\(H_0: \\ \\mu \\leq %.00f \\)",input$mu_0)
                    ))
                } else if (input$h_type =="less") {
                    return(withMathJax(
                        sprintf("\\(H_0: \\ \\mu \\geq %.00f \\)",input$mu_0)
                    ))
                } else{
                    return(withMathJax(
                        sprintf("\\(H_0: \\ \\mu = %.00f \\)",input$mu_0)
                    ))
                }
                
            })      
        })
        
        lapply(1:2, function(nr){
            output[[paste0("alt_hyp", nr)]] <- renderUI({
                if (input$h_type=="greater"){
                    return(withMathJax(
                        sprintf("\\(H_1: \\ \\mu > %.00f \\)",input$mu_0)
                    ))
                } else if (input$h_type =="less") {
                    return(withMathJax(
                        sprintf("\\(H_1: \\ \\mu < %.00f \\)",input$mu_0)
                    ))
                } else{
                    return(withMathJax(
                        sprintf("\\(H_1: \\ \\mu \\neq %.00f \\)",input$mu_0)
                    ))
                }
            })
        })
        
    })
    
    
    # Get Population
    observeEvent(c(input$mu_0, input$sample_size), {
        null_pop$data<-get_null_population(input$mu_0,10)
        
        null_dist$data<- get_null_sampling_means(null_pop$data,m=3000,n=input$sample_size)
        
        samp_dist_plot$data<-ggplot() + geom_histogram(aes(x=(null_dist$data)$values,y=..density..),
                                                       bins=20,
                                                       fill=rgb(0,0,1,.5),
                                                       color='gray20')+
            coord_cartesian(xlim=c(75,125),ylim=c(0,.45))+
            labs(title="Null distribution")
        output$step1<-renderPlot({
            samp_dist_plot$data
        })
    })
    
    #get test results and p-value
    observeEvent(input$h_type,{
        test_res$data<-t.test(sm$data[[3]], mu=input$mu_0,
                              var.equal=T,
                              alternative = input$h_type)
        
        p_value$data<-round(get_p_value((sm$data[[1]] - input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size)),
                                        input$sample_size -1, input$h_type),3)
        
    })
    
    
    observeEvent(input$get_sample,{
        sm$data<-get_sample(input$sample_size)
        
        test_res$data<-t.test(sm$data[[3]], mu=input$mu_0,
                              var.equal=T,
                              alternative = input$h_type)
        
        p_value$data<-round(get_p_value((sm$data[[1]] - input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size)),
                                        input$sample_size -1, input$h_type),3)
        
        output$step1<-renderPlot({
            samp_dist_plot$data+
                geom_vline(xintercept=sm$data[[1]], col='red',size=2 )+
                labs(title="Null distribution and Experimental Sample Mean")+
                annotate("text",x=(sm$data[[1]]+3),y=0.4, 
                         col='red', size=5,
                         label=as.character(round(sm$data[[1]],3))
                )
        })           
        
        output$sample_info<-renderUI({
            withMathJax(
                sprintf("\\(\\bar x = %.03f, \\  \\ s =  %.03f \\)",sm$data[1],sm$data[2])
            )
        })
        
    })
    
    
    ## Step 2a 2b
    output$step2a<-renderPlot({
        samp_dist_plot$data+
            geom_vline(xintercept=sm$data[[1]], col='red',size=2 )+
            labs(title="Null distribution and Experimental Sample Mean")+
            annotate("text",x=(sm$data[[1]]+3),y=0.4, 
                     col='red', size=5,
                     label=as.character(round(sm$data[[1]],3))
            )
    })
    
    observeEvent(c(input$h_type, input$get_sample), {
        newvalues<- ((null_dist$data)$values - input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size))
        new_mean<-(sm$data[[1]]-input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size))
        x_strt<-min(-abs(new_mean)-.5,-4)
        x_stop<-max(abs(new_mean)+.5,4)
        t_in<-seq(x_strt,x_stop,length=500)
        t_val<-dt(t_in,df=input$sample_size-1)
        
        p_value$data<-round(get_p_value(new_mean,input$sample_size -1, input$h_type),3)
        
        output$step2b<-renderPlot({
            ggplot() +
                geom_histogram(aes(x=newvalues,
                                   y=..density..),
                               bins=20,
                               fill='dodgerblue',alpha=.4)+
                coord_cartesian(xlim=c(x_strt,x_stop))+
                geom_vline(xintercept=new_mean, col='red',size=2 )+
                labs(title="Scaled null distribution with t-score")+
                geom_line(aes(x=t_in,y=t_val),col='dodgerblue2',size=1.4,lty=5)+
                annotate("text",x=(new_mean+.5),y=0.4, 
                         col='red', size=5,
                         label=as.character(round(new_mean,3))
                )
        })
        
    })
    
    
    # Step 3a 3b
    output$step3a<-renderPlot({
        newvalues<- ((null_dist$data)$values - input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size))
        new_mean<-(sm$data[[1]]-input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size))
        x_strt<-min(-abs(new_mean)-.5,-4)
        x_stop<-max(abs(new_mean)+.5,4)
        t_in<-seq(x_strt,x_stop,length=500)
        t_val<-dt(t_in,df=input$sample_size-1)
        ggplot() +
            geom_histogram(aes(x=newvalues,y=..density..),bins=20,
                           fill='dodgerblue',alpha=.4)+
            coord_cartesian(xlim=c(x_strt,x_stop),ylim=c(0,.45))+
            geom_vline(xintercept=new_mean, col='red',size=2 )+
            labs(title="Scaled null distribution with t-score")+
            geom_line(aes(x=t_in,y=t_val),col='dodgerblue2',size=1.4,lty=5)+
            annotate("text",x=(new_mean+.5),y=.4, 
                     col='red', size=5,
                     label=as.character(round(new_mean,3))
            )
    })
    
    output$step3b<-renderPlot({
        newvalues<- ((null_dist$data)$values - input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size))
        new_mean<-(sm$data[[1]]-input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size))
        x_strt<-min(-abs(new_mean)-.5,-4)
        x_stop<-max(abs(new_mean)+.5,4)
        t_in<-seq(x_strt,x_stop,length=500)
        t_val<-dt(t_in,df=input$sample_size-1)
        
        if (input$h_type=="two.sided"){
            shade_x1<-seq(abs(new_mean),4,length=500)
            shade_y1<-dt(shade_x1, df= input$sample_size -1)
            shade_x2<-seq(-4,-abs(new_mean),length=500)
            shade_y2<-dt(shade_x2, df= input$sample_size -1)
            ggplot() +
                geom_histogram(aes(x=newvalues,y=..density..),bins=20,alpha=.1)+
                coord_cartesian(xlim=c(x_strt,x_stop),ylim=c(-.15,.45))+
                geom_line(aes(x = c(new_mean, new_mean),y=c(0,.45)), col='red',size=2 )+
                geom_line(aes(x = c(-new_mean, -new_mean),y=c(0,.45)), col='red',size=1,lty=5 )+
                labs(title="Scaled null distribution with t-score")+
                geom_line(aes(x=t_in,y=t_val),col='dodgerblue2',size=1.4)+
                annotate("text",x=(new_mean+.5),y=.4, 
                         col='red', size=5,
                         label=as.character(round(new_mean,3)))+
                annotate("text",x=0,y=-.05, 
                         col='red', size=5,
                         label=paste("P-value: = ", as.character(round(p_value$data,3)))
                )+
                geom_hline(yintercept=0)+
                geom_area(aes(x=shade_x1, y=shade_y1),fill='red',alpha=.3)+
                geom_area(aes(x=shade_x2, y=shade_y2),fill='red',alpha=.3)
            
        } else {
            shade_x<-seq(new_mean,shade_stop(input$h_type),length=500)
            shade_y<-dt(shade_x, df= input$sample_size -1)
            
            ggplot() +
                geom_histogram(aes(x=newvalues,y=..density..),bins=20,alpha=.1)+
                coord_cartesian(xlim=c(x_strt,x_stop),ylim=c(-.15,.45))+
                geom_line(aes(x = c(new_mean,new_mean),y=c(0,.45)), col='red',size=2 )+
                labs(title="Scaled null distribution with t-score")+
                geom_line(aes(x=t_in,y=t_val),col='dodgerblue2',size=1.4)+
                annotate("text",x=(new_mean+.5),y=.4, 
                         col='red', size=5,
                         label=as.character(round(new_mean,3)))+
                annotate("text",x=0,y=-.05, 
                         col='red', size=5,
                         label=paste("P-value: = ", as.character(round(p_value$data,3)))
                )+
                geom_hline(yintercept=0)+
                geom_area(aes(x=shade_x, y=shade_y),fill='red',alpha=.3)
        }
    })
    
    
    # Last page
    output$test_results_stat<-renderUI({
        withMathJax(sprintf("\\(\\hat t = \\) %.03f",(test_res$data)$statistic))
    })
    output$test_results_Pval<-renderUI({
        ## fix this!!!
        withMathJax(sprintf("\\(P\\)-value =  %.03f",(test_res$data)$p.value))
    })
    
    
    output$prob_approx<-renderPlot({
        newvalues<- ((null_dist$data)$values - input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size))
        new_mean<-(sm$data[[1]]-input$mu_0)/(sm$data[[2]]/sqrt(input$sample_size))
        x_strt<-min(-abs(new_mean)-.5,-4)
        x_stop<-max(abs(new_mean)+.5,4)
        t_in<-seq(x_strt,x_stop,length=500)
        t_val<-dt(t_in,df=input$sample_size-1)
        
        if (input$h_type=="two.sided"){
            shade_x1<-seq(abs(new_mean),4,length=500)
            shade_y1<-dt(shade_x1, df= input$sample_size -1)
            shade_x2<-seq(-4,-abs(new_mean),length=500)
            shade_y2<-dt(shade_x2, df= input$sample_size -1)
            ggplot() +
                geom_histogram(aes(x=newvalues,y=..density..),bins=20,alpha=.1)+
                coord_cartesian(xlim=c(x_strt,x_stop),ylim=c(-.15,.45))+
                geom_line(aes(x = c(new_mean, new_mean),y=c(0,.45)), col='red',size=2 )+
                geom_line(aes(x = c(-new_mean, -new_mean),y=c(0,.45)), col='red',size=1,lty=5 )+
                labs(title="Scaled null distribution with t-score")+
                geom_line(aes(x=t_in,y=t_val),col='dodgerblue2',size=1.4)+
                annotate("text",x=(new_mean+.5),y=.4, 
                         col='red', size=5,
                         label=as.character(round(new_mean,3)))+
                annotate("text",x=0,y=-.05, 
                         col='red', size=5,
                         label=paste("P-value: = ", as.character(round(p_value$data,3)))
                )+
                geom_hline(yintercept=0)+
                geom_area(aes(x=shade_x1, y=shade_y1),fill='red',alpha=.3)+
                geom_area(aes(x=shade_x2, y=shade_y2),fill='red',alpha=.3)
            
        } else {
            shade_x<-seq(new_mean,shade_stop(input$h_type),length=500)
            shade_y<-dt(shade_x, df= input$sample_size -1)
            
            ggplot() +
                geom_histogram(aes(x=newvalues,y=..density..),bins=20,alpha=.1)+
                coord_cartesian(xlim=c(x_strt,x_stop),ylim=c(-.15,.45))+
                geom_line(aes(x = c(new_mean,new_mean),y=c(0,.45)), col='red',size=2 )+
                labs(title="Scaled null distribution with t-score")+
                geom_line(aes(x=t_in,y=t_val),col='dodgerblue2',size=1.4)+
                annotate("text",x=(new_mean+.5),y=.4, 
                         col='red', size=5,
                         label=as.character(round(new_mean,3)))+
                annotate("text",x=0,y=-.05, 
                         col='red', size=5,
                         label=paste("P-value: = ", as.character(round(p_value$data,3)))
                )+
                geom_hline(yintercept=0)+
                geom_area(aes(x=shade_x, y=shade_y),fill='red',alpha=.3)
        }
    })
    
}