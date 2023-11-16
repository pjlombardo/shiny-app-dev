

generate_null_distribution<-function(mu,sigma){
    data.frame(values=rnorm(5000,mu,sigma))
}

pop1<-generate_null_distribution(95,10)
pop2<-generate_null_distribution(97,10)
plot_paired_density<-function(data1,data2,color1,color2){
    ggplot()+ 
        geom_density(aes(x=data1$values, y=after_stat(density)),
                     fill=color1,
                     col='black',
                     alpha=.25)+
        geom_density(aes(x=data2$values, y=after_stat(density)),
                     fill=color2,
                     col='black',
                     alpha=.5)+
        labs(x="",y="Relative Frequency")+
        coord_cartesian(xlim=c(55,135))
}


plot_paired_density_samp<-function(data1,data2,color1,color2,cut_off){
    p1<-ggplot()+ 
        geom_density(aes(x=data1$values, y=after_stat(density)),
                     fill=color1,
                     col=color1,
                     linewidth=1.2,
                     alpha=.15)
    
    p2<-ggplot()+geom_density(aes(x=data2$values, y=after_stat(density)),
                              fill=color2,
                              col=color2,
                              linewidth=1.2,
                              alpha=.15)
    d1<-ggplot_build(p1)
    d2<-ggplot_build(p2)
    
    ggplot()+ 
        geom_density(aes(x=data1$values, y=after_stat(density)),
                     fill=color1,
                     col=color1,
                     linewidth=1.2,
                     alpha=.15)+
        geom_density(aes(x=data2$values, y=after_stat(density)),
                     fill=color2,
                     col=color2,
                     linewidth=1.2,
                     alpha=.15)+
        # scale_x_continuous(limits=c(75,105))+
        geom_area(aes(x=d2$data[[1]]$x[d2$data[[1]]$x>cut_off],
                      y=d2$data[[1]]$y[d2$data[[1]]$x>cut_off]),
                  fill='green',
                  alpha=.65
        )+
        geom_area(aes(x=d1$data[[1]]$x[d1$data[[1]]$x>cut_off],
                      y=d1$data[[1]]$y[d1$data[[1]]$x>cut_off]),
                  fill='red',
                  alpha=.6
        )+
        labs(x="",y="Relative Frequency")+
        geom_vline(xintercept = cut_off,color='red',linewidth=1.5)
}



get_sample_means<-function(pop1, n=20){
    sample_means<-numeric(3000)
    for (i in 1:3000){
        sample_means[i]<-mean(sample(pop1$values,n))
    }
    df<-data.frame(values=sample_means)
    df
}

null1_st<-get_sample_means(pop1, 15)
null2_st<-get_sample_means(pop2, 15)

