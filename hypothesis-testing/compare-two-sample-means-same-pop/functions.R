pop1<-rnorm(1000, 100, 10)

get_samples<-function(n=15){
    df<-data.frame(samples= c(sample(pop1,n),sample(pop1,n)),
                   groups = c(rep("sample1",n),rep("sample2",n))
    )
    
    df
}

samples_st<-get_samples(15)


get_boxplot<-function(df){
    means<-tapply(df$samples, df$groups, mean)
    ggplot()+
        geom_hline(yintercept = 100, lty=2)+
        geom_boxplot(data = df,aes(x = groups, y= samples,
                                   fill=groups),
                     width =.3,
                     alpha = .3)+
        ylim(70,130)+
        scale_fill_manual(values=c("dodgerblue","coral3"))+
        geom_point(aes(x=c(1,2),y=means),pch=4, size=4)
}


get_stripchart<-function(df){
    means<-tapply(df$samples, df$groups, mean)
    ggplot(data = df, aes(x=groups, y=samples,col=groups))+
        geom_hline(yintercept = 100, lty=2)+
        geom_jitter(position=position_jitter(.1))+
        scale_colour_manual(values=c("dodgerblue","coral3"))+
        geom_segment(aes(x=.85,y=means[["sample1"]],
                         xend=1.15,yend=means[["sample1"]]),
                     size=1,
                     col='dodgerblue')+
        geom_segment(aes(x=1.85,y=means[["sample2"]],
                         xend=2.15,yend=means[["sample2"]]),
                     size=1,
                     col='coral3')+
        ylim(70,130)
    
}


