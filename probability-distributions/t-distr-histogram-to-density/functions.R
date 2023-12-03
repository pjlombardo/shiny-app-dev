# Set up stuff

generate_null_distribution<-function(mu,sigma){
    data.frame(values=rnorm(5000,mu,sigma))
}

dens_hist<-function(data1){
    ggplot()+ 
        geom_density(aes(x=data1$values, y=after_stat(density)),
                     fill='red',
                     col='gray20',
                     alpha=.7,
                     size=1.3)+
        geom_histogram(aes(x=data1$values, y=after_stat(density)),
                       fill='blue',
                       col='gray20',
                       alpha=.3,
                       breaks=75:125)+
        labs(x="",y="Relative Frequency")+
        coord_cartesian(xlim=c(75,125),
                        ylim=c(0,.5))
}

all_plots<-function(data1,mu,n){
    x<-seq(75,125,length=500)
    y<-dt((x-mu)/(10/sqrt(n)),df=n-1)*sqrt(n)/10
    ggplot()+ 
        geom_density(aes(x=data1$values, y=after_stat(density)),
                     fill='red',
                     col='gray20',
                     alpha=.7,
                     size=1.3)+
        geom_histogram(aes(x=data1$values, y=after_stat(density)),
                       fill='blue',
                       col='gray20',
                       alpha=.6,
                       breaks=75:125)+
        geom_line(aes(x=x,y=y),col='red',size=1.2)+
        labs(x="",y="Relative Frequency")+
        coord_cartesian(xlim=c(75,125),
                        ylim=c(0,.5))+
        labs(x="",y="Relative Frequency")+
        coord_cartesian(xlim=c(75,125),
                        ylim=c(0,.5))
}

just_hist<-function(data1){
    ggplot()+ 
        geom_histogram(aes(x=data1$values, y=after_stat(density)),
                       fill='blue',
                       col='gray20',
                       alpha=.6,
                       breaks=75:125)+
        labs(x="",y="Relative Frequency")+
        coord_cartesian(xlim=c(75,125),
                        ylim=c(0,.5))
}

hist_v_t<-function(data1,mu,n){
    # need to create t-distribution values here based
    # on sample size, mean input, and mean of std devs for sample
    
    x<-seq(75,125,length=500)
    y<-dt((x-mu)/(10/sqrt(n)),df=n-1)*sqrt(n)/10
    
    just_hist(data1)+
        geom_line(aes(x=x,y=y),col='red',size=1.2)+
        labs(x="",y="Relative Frequency")+
        coord_cartesian(xlim=c(75,125),
                        ylim=c(0,.5))
}

dens_v_t<-function(data1,mu,n){
    # need to create t-distribution values here based
    # on sample size, mean input, and mean of std devs for sample
    
    x<-seq(75,125,length=500)
    y<-dt((x-mu)/(10/sqrt(n)),df=n-1)*sqrt(n)/10
    
    ggplot()+ 
        geom_density(aes(x=data1$values, y=after_stat(density)),
                     fill='red',
                     col='gray20',
                     alpha=.3)+
        labs(x="",y="Relative Frequency")+
        coord_cartesian(xlim=c(75,125),
                        ylim=c(0,.5))+
        geom_line(aes(x=x,y=y),col='dodgerblue2',size=1.4,lty=5)+
        labs(x="",y="Relative Frequency")+
        coord_cartesian(xlim=c(75,125),
                        ylim=c(0,.5))
}


plot_sample_histograms<-function(data1,dens_bool,t_bool,mu,n){
    if (dens_bool == T) {
        if (t_bool ==T){
            dens_v_t(data1,mu,n)
        } else {
            dens_hist(data1)
        }
    } else {
        if (t_bool==T){
            hist_v_t(data1,mu,n)
        }else {
            just_hist(data1)
        }
    }
    
}



# plot_paired_histograms(null1,null2)

get_sample_means<-function(population,m=5000,n=20){
    sample_means<-numeric(m)
    for (j in 1:m){
        sample_means[j]<-mean( sample( population[,1], n) )
    }
    
    df<-data.frame(values=sample_means)
    
    df
}


# dry run
pop1<-generate_null_distribution(100,10)
samps<-get_sample_means(pop1,m=5000,n=30)
# just_hist(samps)
# plot_sample_histograms(samps,T,T,100,30)
