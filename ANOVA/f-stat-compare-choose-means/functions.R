# Set up stuff
get_samples<-function(n=15, mu1, mu2, mu3){
    df<-data.frame(samples= c(rnorm(n, mu1, 10),
                              rnorm(n, mu2, 10),
                              rnorm(n, mu3, 10)),
                   groups = c(rep("sample1",n),
                              rep("sample2",n),
                              rep("sample3",n))
    )
    
    df
}

get_anova<-function(df){
    aov_obj<-summary(aov(samples~groups, data = df))
    aov_obj
}

samples_st<-get_samples(15,100,100,100)
aov_st<-get_anova(samples_st)
aov_st[[1]][,"F value"][1]
aov_st
# test_info<-summary(aov(samples~groups, data = samples_st))
# # test_info[[1]][,"Mean Sq"]
# str(summary(aov(samples~groups, data = samples_st)))
# class(test_info)


get_boxplot<-function(df){
    ggplot(data = df)+
        geom_hline(yintercept = 100, lty=2)+
        geom_boxplot(aes(x = groups, y= samples,
                         fill=groups),
                     width =.3,
                     alpha = .3)+
        ylim(50,150)
}


get_stripchart<-function(df){
    means<-tapply(df$samples, df$groups, mean)
    ggplot(data = df, aes(x=groups, y=samples,col=groups))+
        geom_hline(yintercept = mean(df$samples), lty=2,size=1)+
        geom_jitter(position=position_jitter(.15),size=2.2)+
        geom_segment(aes(x=.75,y=means[["sample1"]],
                         xend=1.25,yend=means[["sample1"]]),
                     size=1.7,
                     col='red')+
        geom_segment(aes(x=1.75,y=means[["sample2"]],
                         xend=2.25,yend=means[["sample2"]]),
                     size=1.7,
                     col='green')+
        geom_segment(aes(x=2.75,y=means[["sample3"]],
                         xend=3.25,yend=means[["sample3"]]),
                     size=1.7,
                     col='blue')+
        ylim(65,135)
    
    
}