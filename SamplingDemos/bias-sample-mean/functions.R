

### Tab 1

# Set up stuff
set.seed(101001)
temperatures1<-rnorm(2000, 80,7)
df_temp1<-as.data.frame(cbind(1:2000,temperatures1))

truth1<-ggplot(data = df_temp1)+geom_point(aes(x=V1,
                                               y=temperatures1), 
                                           colour='green3',
                                           alpha=.25,size=2.3) +
    geom_hline(yintercept = mean(temperatures1),
               color='green4',linewidth=1)+
    labs(x="Patient ID",
         y="Diastolic BP")+theme_bw()


run_sample1<-function(n=20){
    ind1<-sample(1:2000,n, replace=FALSE)
    observed1<-df_temp1[ind1,]
    m1<-mean(observed1[,2])
    
    ggplot()+geom_point(aes(x=1:length(temperatures1),
                            y=temperatures1), 
                        colour='green3',
                        alpha=.3,size=2.3) +
        geom_point(aes(x=observed1[,1],
                       y=observed1[,2]), 
                   colour='blue',
                   alpha=.5,size=2.3)+
        geom_hline(yintercept = m1,color='blue',size=2)+
        geom_hline(yintercept = mean(temperatures1),color='green4',linewidth=1.25)+
        theme_bw()+
        labs(x="Patient ID",
             y="Diastolic BP")
}

## Tab 1b:

run_sample1b<-function(n=20){
    ind1<-sample(1:2000,n, replace=FALSE)
    observed1<-df_temp1[ind1,]
    mean(observed1[,2])
    
}

alpha_fxn<-function(num_sims){
    if (num_sims<=10) {
        alpha<-.8
    } else if (num_sims <=100) {
        alpha<-.6
    } else {
        alpha<-0.5 + -0.055454*log(num_sims+1)
    }
    alpha
}

collect<-function(n=20,m=50){
    samples<-numeric(m)
    for (j in 1:m){
        samples[j]<-run_sample1b(n)
    }
    samples
}

add_bars<-function(plt,samples, strt, stp){
    alpha_adj<-alpha_fxn(stp)
    for (j in strt:stp){
        plt<-plt+geom_hline(yintercept=samples[j],
                            color='blue', alpha=alpha_adj,size=.8)
    }
    plt+geom_hline(yintercept = mean(temperatures1),color='red',size=.9)
}


### TAB 2:

# Set up stuff
set.seed(102003)
heights<-rnorm(2000, 68,8)
taller<-heights>=72
smaller<-heights<72
bball<-sample(1:629, 350)
df_temp2<-data.frame(heights=heights[taller])
df_temp2$bball<-c(rep(T,350),rep(F,279))
d2<-data.frame(heights=heights[smaller],
               bball = rep(F,sum(smaller==T)))
df_all<-rbind(df_temp2,d2)
df_all<-df_all[sample(1:2000,2000),]
truth2<-ggplot(data = df_all)+geom_point(aes(x=1:2000,
                                            y=heights,
                                            color=bball,
                                            alpha=bball),
                                        size=2.5) +
    geom_hline(yintercept = mean(heights),color='black',linewidth=1)+
    scale_color_manual(name="",
                       labels=c("TRUE"="Basketball","FALSE" = "Not Basketball"),
                       values=c("red","dodgerblue3"))+
    scale_alpha_manual(values=c(.3,.6),guide="none")+
    theme_bw()+
    labs(y="Heights",x="")+
    theme(axis.text.x=element_blank())

run_sample2<-function(n=20){
    df_temp<-data.frame(pos=which((df_all$bball==T)==T),
                        heights=df_all[df_all$bball,1])
    ind1<-sample(1:350,n, replace=FALSE)
    m1<-mean(df_temp[ind1,"heights"])
    
    ggplot()+geom_point(aes(x=1:2000,
                            y=df_all$heights,
                            color=df_all$bball,
                            alpha=df_all$bball),
                        size=2.5) +
        scale_color_manual(name="",
                           labels=c("TRUE"="Basketball","FALSE" = "Not Basketball"),
                           values=c("red","dodgerblue3"))+
        scale_alpha_manual(values=c(.3,.6),guide="none")+
        labs(x="Population ID") +
        geom_point(aes(x=df_temp[ind1,"pos"],
                       y=df_temp[ind1,"heights"]),
                   shape=1,size=2.5,stroke=1.75)+
        geom_hline(yintercept = mean(heights),color='black',linewidth=1.75)+
        geom_hline(yintercept = m1,color='blue',linewidth=1.75)+
        theme_bw()+
        labs(y="Heights",x="")+
        theme(axis.text.x=element_blank())
}
