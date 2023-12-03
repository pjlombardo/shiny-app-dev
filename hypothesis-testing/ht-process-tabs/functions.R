# Set up stuff
true_pop<-rnorm(3000,102,10)
get_sample<-function(n){
    temp<-sample(true_pop,n)
    
    list(mean(temp),sd(temp),temp)
}
get_sample(30)

get_null_population<-function(mu,sigma){
    data.frame(values=rnorm(5000,mu,sigma))
}


get_null_sampling_means<-function(population,m=5000,n=20){
    sample_means<-numeric(m)
    for (j in 1:m){
        sample_means[j]<-mean( sample( population[,1], n) )
    }
    
    df<-data.frame(values=sample_means)
    
    df
}

start_null<-get_null_population(95,10)
start_null_dist<-get_null_sampling_means(start_null,m=3000,n=15)

generate_hypotheses<-function(h_type, m){
    if (h_type == "less") {
        return("test")
    } else if (h_type == "greater") {
        return(TeX("greater $>0$"))
    } else {
        return("two.sided")
    }
}

get_p_value<-function(t,n,h_type){
    if (h_type == "greater"){
        return(1-pt(t,n-1))
    } else if (h_type == "less"){
        return(pt(t,n-1))
    } else {
        return(2*(1-pt(abs(t),n-1)))
    }
}

# shading code
shade_stop<-function(h_type){
    if (h_type=="greater"){
        4
    } else if (h_type=="less"){
        -4
    } else {
        NULL
    }
}
