#####################
### Set up stuff ####
#####################
v1<-.35
p1<-data.frame(x=rnorm(1000,3,v1),y=rnorm(1000,3,v1),
               pol=c(rep("R",940),rep("D",60)),
               grp = rep("p1",1000))
p2<-data.frame(x=rnorm(1000,5,v1),y=rnorm(1000,3,v1),
               pol=c(rep("R",220),rep("D",780)),
               grp = rep("p2",1000))
p3<-data.frame(x=rnorm(1000,1,v1),y=rnorm(1000,1,v1),
               pol=c(rep("R",440),rep("D",560)),
               grp = rep("p3",1000))
p4<-data.frame(x=rnorm(1000,1,v1),y=rnorm(1000,5,v1),
               pol=c(rep("R",700),rep("D",300)),
               grp = rep("p4",1000))
p5<-data.frame(x=rnorm(1000,5,v1),y=rnorm(1000,1,v1),
               pol=c(rep("R",390),rep("D",610)),
               grp = rep("p5",1000))

center<-c(mean(p2$x), mean(p2$y))

df_all<-rbind(p1,p2,p3,p4,p5)
df_all[1:1001,]

# df_all %>% mutate(distance_center = sqrt((x-center[1])^2 + (y-center[2])^2),
#                   prob = 1-distance_center/max(distance_center)+.0001)->df_all2
# 
# sample(1:5000,50,prob = df_all$prob)

# population table, will add to this?
popul_table<-data.frame(pol_party = c("Democrat","Republican"),
                        population_counts = as.integer(c(2310,2690)),
                        population_proportions = c(2310,2690)/(5000))
popul_table$population_counts<-round(popul_table$population_counts,0)
# row.names(popul_table)<-c("Democrat","Republican")

# base plot
truth<-ggplot()+geom_point(aes(x=df_all$x,
                               y=df_all$y,
                               color=df_all$pol),
                           alpha=.3)+
    scale_color_manual('',labels=c('Democ.','Repub.'),
                       values=c('dodgerblue','red'))+theme_bw()

#################
### Sampling ####
#################

# biased sample indices
get_bias_sample_indices<-function(n=50){
    some<-c(floor(n/50),floor(n/15),floor(n/25),floor(n/25))
    samp_indices<-c(sample(1:1000,some[1]),
                    sample(1001:2000,n-sum(some)),
                    sample(2001:3000,some[2]),
                    sample(3001:4000,some[3]),
                    sample(4001:5000,some[4]))
    samp_indices
}


# biased sample table
get_bias_sample_table<-function(index){
    n<-length(index)
    samp<-df_all[index,]
    samp_rep<-samp$pol == "R"
    counts <- c(n-sum(samp_rep),sum(samp_rep))
    prop_inf<-sum(samp_rep)/n
    
    df_table<-data.frame(pol_party = c("Democrat","Republican"),
                         population_counts = as.integer(c(2310,2690)),
                         population_proportions = c(2310,2690)/(5000),
                         sample_counts = counts,
                         sample_proportions = counts/n
    )
    df_table
}

#unbiased, completely random selection
get_rand_sample_indices<-function(n=50){
    samp_indices<-sample(1:5000,n,replace=F)
    samp_indices
}

#unbiased sample taable
get_rand_sample_table<-function(index){
    n<-length(index)
    samp<-df_all[index,]
    samp_rep<-samp$pol == "R"
    counts <- c(n-sum(samp_rep),sum(samp_rep))
    prop_inf<-sum(samp_rep)/n
    
    df_table<-data.frame(pol_party = c("Democrat","Republican"),
                         population_counts = c(2310,2690),
                         population_proportions = round(c(2310,2690)/(5000),3),
                         sample_counts = counts,
                         sample_proportions = round(counts/n,3)
    )
    df_table
}


get_bias_sample_plot<-function(index){
    df_sample<-df_all[index,]
    
    truth+
        geom_point(aes(x=df_sample$x,
                       y=df_sample$y),
                   shape=1,size=2,stroke=1.25)+
        labs(x='',y='')+
        theme(axis.text.x=element_blank(),
              axis.text.y=element_blank())
    
}

get_rand_sample_plot<-function(index){
    df_sample<-df_all[index,]
    
    truth+
        geom_point(aes(x=df_sample$x,
                       y=df_sample$y),
                   shape=1,size=2,stroke=1.25)+
        labs(x='',y='')+
        theme(axis.text.x=element_blank(),
              axis.text.y=element_blank())
    
}