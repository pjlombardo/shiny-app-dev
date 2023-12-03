###### set up for Outliers tab

set.seed(123)

pop1<-runif(300,45,65)
create_stats_tbl<-function(data,test_val){
    #pop1 means etc
    p1<-mean(pop1)
    p2<-median(pop1)
    p3<-sd(pop1)
    p4<-IQR(pop1)
    nd1<-mean(data)
    nd2<-median(data)
    nd3<-sd(data)
    nd4<-IQR(data)
    if (test_val==0){
        tbl<-data.frame(mean=p1,median=p2, std.dev = p3, IQR=p4)
        row.names(tbl)<-"Original Population"
    } else {
        tbl<-data.frame(mean=c(p1,nd1),
                        median=c(p2,nd2),
                        std.dev = c(p3,nd3),
                        IQR=c(p4,nd4))
        row.names(tbl)<-c("Original population","Population with added data")
        
    }
    
    tbl
    
}

#### Set up for bimodal example:
get_data<-function(mean1,mean2){
    set.seed(202002)
    bimod_data<-c(rnorm(1000,mean1,1.5),rnorm(1000,mean2,1.5))
    bimod_data
}



# Set up for Skew tab
set.seed(101001)
raw_data<-rnorm(200,0,1)
skew_data<-function(raw_data,eps){
    return(sinh(asinh(raw_data)-1.5*eps) +1.5*eps)
}


truth<-ggplot()+geom_histogram(aes(x=raw_data),
                               bins = 30,
                               color='black',
                               fill='blue',
                               alpha=.5)+
    labs(x="Bins")+
    xlim(-8,8)+ylim(-1,50)

plot_skew<-function(eps,show_var){
    new_data<-skew_data(raw_data,-eps)
    m<-mean(new_data)
    med<-median(new_data)
    base_plot<-ggplot()+geom_histogram(aes(x=new_data),
                                       bins = 20,
                                       color='black',
                                       fill='blue',
                                       alpha=.5)+
        labs(x="Bins")+
        xlim(-12,12)+
        ylim(c(-1,100))
    
    if (show_var==""){
        show_plot<-base_plot
    } else if (show_var=="mean"){
        show_plot<-base_plot+
            geom_point(aes(x=m,y=-.5),pch=17,size=5,col='green3')+
            geom_segment(aes(x=m,y=-.2,xend=m,yend=7),linewidth=1,col='green3')
    } else if (show_var=="median"){
        show_plot<-base_plot+
            geom_point(aes(x=med,y=-.45),pch=18,size=6,col='red')+
            geom_segment(aes(x=med,y=-.2,xend=med,yend=7),linewidth=1,col='red')
    } else {
        show_plot<-base_plot+
            geom_point(aes(x=m,y=-.5),pch=17,size=5,col='green3')+
            geom_segment(aes(x=m,y=-.2,xend=m,yend=7),linewidth=1,col='green3')+
            geom_point(aes(x=med,y=-.45),pch=18,size=6,col='red')+
            geom_segment(aes(x=med,y=-.2,xend=med,yend=7),linewidth=1,col='red')
    }
    
    show_plot
}
