histogram_explore<-function(n,shape,bins){
    x <-rnorm(n,100,10)
    y <-rchisq(n,3)
    z <-runif(n,50,100)
    w <- 800 - rchisq(n,2)
    b <- c(rnorm(round(n/2,0),30,10), rnorm(n-round(n/2,0),85,15))
    shapes<-data.frame(
        normal=x,
        positive_skew = y,
        uniform = z,
        negative_skew = w,
        bimodal= b)
    
    # print(shapes)
    # print(shape)

    data_vec = shapes[[shape]]
    ggplot()+
       geom_histogram(aes(x= data_vec),
                      bins=bins,
                      color='gray4',
                      fill='dodgerblue',
                      alpha=.3)+
        labs(title="Histogram",x="Data")+
       theme_bw()
}

# histogram_explore(30,"positive_skew")


normal_qp_explore<-function(n,shape){
    x <-rnorm(n,100,10)
    y <-rchisq(n,3)
    z <-runif(n,50,100)
    w <- 800 - rchisq(n,2)
    b <- c(rnorm(round(n/2,0),30,10), rnorm(n-round(n/2,0),85,15))
    shapes<-data.frame(
        normal=x,
        positive_skew = y,
        uniform = z,
        negative_skew = w,
        bimodal= b)
    data_vec = shapes[[shape]]
    
    ggplot()+
        stat_qq(aes(sample=data_vec),color='blue')+
        stat_qq_line(aes(sample=data_vec),color='red')+
        labs(title="QQ-plot",
             x="Theoretical Quantiles",
             y="Data")+
        theme_bw()
}

# normal_qp_explore(30,"normal")

