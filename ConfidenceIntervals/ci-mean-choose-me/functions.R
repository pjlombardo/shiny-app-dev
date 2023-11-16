pop1<-data.frame(plant_heights = round(rnorm(1000,12,3.7),2))
PS<-sd(pop1$plant_heights)
PM<-mean(pop1$plant_heights)

get_index_and_bars<-function(n,me){
    index_list<-list()
    ms<-numeric(2000)
    ymins<-numeric(2000)
    ymaxes<-numeric(2000)
    flag<-character(2000)
    for (j in 1:2000){
        samp_index<-sample(1:1000,n)
        ms[j]<-mean(pop1[samp_index,1])
        ymins[j]<-ms[j]-me
        ymaxes[j]<-ms[j]+me
        if (ymins[j]>PM | ymaxes[j]<PM) {
            flag[j]<-"red"
        } else {flag[j]<-"blue"}
        index_list[[j]]<-samp_index
    }
    df_errorbars<-data.frame(m=ms,
                             x=1:2000,
                             ymin=ymins,
                             ymax=ymaxes,
                             flag=flag)
    
    return(list(index_list,df_errorbars))
}

in_ci<-function(low,high){
    temp_log<-(low < PM)&(PM <high)
    ifelse(temp_log,"blue","red")
}



update_margin_error<-function(rlist,me){
    temp_df<-rlist[[2]]
    temp_df$ymin<- temp_df$m-me
    temp_df$ymax<- temp_df$m+me
    temp_df$flag<-mapply(in_ci, 
                         temp_df$ymin, 
                         temp_df$ymax)
    
    return(list(rlist[[1]],temp_df))
}


truth<-ggplot()+geom_point(aes(x=1:1000,
                               y=pop1$plant_heights),
                           col='green',
                           alpha=.4)+
    scale_y_continuous(limits=c(0,25))+
    geom_hline(yintercept=PM,col='green4',size=1.25)+
    labs(x="Plant ID Number",
         y="Plant Height (inches)",
         title="Population of Plant Heights One Month After Germination")

plot_with_sample<-function(plot,record_num,
                           index_list, 
                           df_errorbars){
    
    plot +
        geom_point(aes(x=index_list[[record_num]],
                       y=pop1[index_list[[record_num]],1]),
                   col='blue',alpha=.6)+
        geom_hline(yintercept=df_errorbars$m[record_num],
                   col='blue',size=1,lty=2)+
        geom_hline(yintercept=PM,col='green4',size=1.25,
                   alpha=.75)+
        labs(x="Plant ID Number",
             y="Plant Height (inches)",
             title="Population of Plant Heights One Month After Germination")
}

#create CI tracker
ci_record<-ggplot()+geom_hline(yintercept=PM,col='green4',size=1.25,
                               alpha=.75)+
    labs(y="",
         title="Record of Confidence Intervals")+
    geom_hline(yintercept=0)+geom_vline(xintercept=0)+
    scale_y_continuous(limits=c(0,25))+
    scale_x_continuous(limits=c(0,10))


add_ci<-function(record_num,df_errorbars,show_eb){
    if (show_eb){
        ci_record+ geom_errorbar(data=df_errorbars[1:record_num,],
                                 aes(x =x, 
                                     ymin = ymin,
                                     ymax = ymax,
                                     col=flag),
                                 size=1,
                                 width=.1+.2*(record_num/(record_num+10)))+
            geom_point(data=df_errorbars[1:record_num,],
                       aes(x = x,
                           y = m,
                           col=flag))+
            scale_color_manual("",values=c("blue","red"),guide="none")+
            scale_x_continuous(limits=c(0,max(10,record_num+3)))
    } else {
        ci_record+
            geom_point(data=df_errorbars[1:record_num,],
                       aes(x = x,
                           y = m,
                           col=flag))+
            scale_color_manual("",values=c("blue","red"),guide="none")+
            scale_x_continuous(limits=c(0,max(10,record_num+3)))
    }
    
}
