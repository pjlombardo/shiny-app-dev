
# Set up stuff
set.seed(123)
norm_pop<-2*rnorm(2000, 98.7,2.7)+runif(2000,-15,20)
chisq_pop<-5*rchisq(2000,3)+170
left_pop<-228-5*rchisq(2000,3)
unif_pop<-runif(2000,160,230)
bimod_pop<-c(rnorm(800,185,8),rnorm(1200,220,5))

populations<-data.frame(
    "norm_pop" = norm_pop,
    "chisq_pop" = chisq_pop,
    "left_pop" = left_pop,
    "unif_pop" = unif_pop,
    "bimod_pop"= bimod_pop
)

sample_num <- 1

show_population<-function(data){
    ggplot()+geom_histogram(aes(x=data), 
                            breaks = 160 + 2.5*0:32,
                            colour='black',
                            fill='green3',
                            alpha=.25)+
        coord_cartesian(xlim=c(160,240))+
        # xlim(160,240)+
        geom_vline(aes(xintercept = mean(data)),
                   color='green4',lwd=2)+ylab("")+
        labs(title="Histogram of Population Data",
             x="Individual Measurements")+
        theme_bw()+
        theme(axis.text.y=element_blank(),
              plot.title = element_text(size=18),
              axis.title.x = element_text(size=14))
}

boot_fxn<-function(data,index){
    return(mean(data[index]))
}

collect<-function(data,n=50) { 
    boot_data<-numeric(2000)
    for (i in 1:2000){
        boot_data[i]<-boot_fxn(data,sample(1:2000,n))
    }
    boot_data
}

# show_sampling_dist<-function(data,n=50){
#   data_temp<-collect(data,n)
#   ggplot()+geom_histogram(aes(x=data_temp), 
#                                         bins=50,
#                                         colour='black',
#                                         fill='blue2',
#                                         alpha=.25)+
#     xlim(160,240)
# }


update_sampling_dist<-function(data,sample_num,binsize,n){
    data_temp<-data[1:sample_num]
    ggplot()+geom_histogram(aes(x=data_temp), 
                            breaks = 160 + binsize*(0:(80/binsize)),
                            colour='black',
                            fill='blue2',
                            alpha=.25)+
        coord_cartesian(xlim=c(160,240))+
        # xlim(160,240)+
        geom_vline(aes(xintercept=mean(data_temp)),
                   color='blue',lwd = 1.3)+ylab("")+
        labs(title="Histogram Of Sample Means Drawn From The Population",
             x=paste("Sample Means (based on a sample size of ",n,")",sep=""))+
        theme_bw()+
        theme(axis.text.y=element_blank(),
              plot.title = element_text(size=18),
              axis.title.x = element_text(size=14))
}


get_segs<-function(plot,sample,sample_num){
    m1<-max(ggplot_build(plot)$data[[1]]$ymax)
    yend<-rep(.1*m1,sample_num)
    y<- rep(-.05*m1,sample_num)
    x<-sample[1:sample_num]
    xend<-sample[1:sample_num]
    plot<-plot+geom_segment(aes(
        x=x, y=y, xend=xend, yend=yend
    ),color='red',alpha=.35*(1+1/sample_num))
    
    plot
}

layout_d<-"
AAA
AAA
AAA
AAA
###
BBB
BBB
BBB
BBB
"
