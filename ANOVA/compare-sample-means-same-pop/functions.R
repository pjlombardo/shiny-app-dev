
pop1<-rnorm(1000, 100, 10)

get_samples<-function(n=15){
    df<-data.frame(samples= c(sample(pop1,n),sample(pop1,n),sample(pop1,n)),
                   groups = c(rep("sample1",n),rep("sample2",n),rep("sample3",n))
    )
    
    df
}

samples_st<-get_samples(15)


get_boxplot<-function(df){
    ggplot(data = df)+
        geom_hline(yintercept = 100, lty=2)+
        geom_boxplot(aes(x = groups, y= samples,
                         fill=groups),
                     width =.3,
                     alpha = .3)+
        ylim(70,130)
}


get_stripchart<-function(df){
    means<-tapply(df$samples, df$groups, mean)
    ggplot(data = df, aes(x=groups, y=samples,col=groups))+
        geom_hline(yintercept = 100, lty=2)+
        geom_jitter(position=position_jitter(.15))+
        geom_segment(aes(x=.75,y=means[["sample1"]],
                         xend=1.25,yend=means[["sample1"]]),
                     size=1,
                     col='red')+
        geom_segment(aes(x=1.75,y=means[["sample2"]],
                         xend=2.25,yend=means[["sample2"]]),
                     size=1,
                     col='green')+
        geom_segment(aes(x=2.75,y=means[["sample3"]],
                         xend=3.25,yend=means[["sample3"]]),
                     size=1,
                     col='blue')+
        ylim(70,130)
    
    
}
