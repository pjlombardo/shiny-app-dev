# Set up stuff
set.seed(123)
#normal

max(dnorm(450:550/10,50,10))


get_population<-function(mu,sigma){
    rnorm(2000,mu,sigma)
}

get_min_max<-function(data,crit=2){
    m<-mean(data)
    s<-sd(data)
    return(c(m-crit*s,m+crit*s))
}


text_pct_within<-function(data,crit=2,show_range){
    if (show_range) {
        m_m<-get_min_max(data,crit)
        s1<-sum(data<=m_m[2]) - sum(data<m_m[1])
        paste("Percent of data within blue region = ",
              s1/length(data))
    } else {
        NULL
    }
}



show_population<-function(data, show_range){
    if (show_range){
        min_max<-get_min_max(data)
        ggplot()+ geom_rect(aes(xmin=min_max[1], 
                                xmax=min_max[2], 
                                ymin=0, 
                                ymax=Inf),
                            col='blue',
                            fill='dodgerblue',
                            alpha=.5)+
            geom_histogram(aes(x=data,y=..density..), 
                           bins=30,
                           colour='black',
                           fill='red',
                           alpha=.5)+
            geom_vline(xintercept=mean(data),col='blue',linewidth=1.5)+
            coord_cartesian(xlim=c(-25,200),
                            ylim=c(0,0.1))
        
        
    } else {
        ggplot()+geom_histogram(aes(x=data,y=..density..), 
                                bins=30,
                                colour='black',
                                fill='red',
                                alpha=.5)+
            coord_cartesian(xlim=c(-25,200),
                            ylim=c(0,0.1))
        
    }
}
