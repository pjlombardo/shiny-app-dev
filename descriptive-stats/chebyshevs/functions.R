# Set up stuff
set.seed(123)
#normal
population_norm<-2*rnorm(2000, 98.7,2.7)+runif(2000,-15,20)
# bimodal
population_bimod<-c(rnorm(1000,185,6), rnorm(1000,280,10))
#skewed
population_skew<-20*rchisq(2000,df=2)
# uniform
population_unif<-runif(2000,165,350)

get_population<-function(shape){
    if (shape == "Bimodal"){
        return(population_bimod)
    } else if (shape =="Positive Skew") {
        return(population_skew)
    } else if (shape =="Normal") {
        return(population_norm)
    } else {
        return(population_unif)
    }
}

pop_list<-list(population_norm, population_bimod,
               population_skew, population_unif)

get_pop_number<-function(shape){
    if (shape == "Normal"){
        return(1)
    } else if (shape =="Bimodal") {
        return(2)
    } else if (shape =="Positive Skew") {
        return(3)
    } else {
        return(4)
    }
}

get_min_max<-function(data,crit=2){
    m<-mean(data)
    s<-sd(data)
    return(c(m-crit*s,m+crit*s))
}


# get_min_max(population_unif)

# count_pct_within(population_unif,1.96)

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



details<-c()
for (item in pop_list){
    details<-rbind(details,c(mean(item),sd(item)))
}

pop_details<-data.frame(mean = details[,1],
                        standard.deviation = details[,2])

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
            geom_histogram(aes(x=data), 
                           bins=30,
                           colour='black',
                           fill='red',
                           alpha=.5)+
            geom_vline(xintercept=mean(data),col='blue',linewidth=1.5)
        
        
    } else {
        ggplot()+geom_histogram(aes(x=data), 
                                bins=30,
                                colour='black',
                                fill='red',
                                alpha=.5)
        
    }
}