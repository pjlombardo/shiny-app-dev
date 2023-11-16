# Set up stuff
get_samples<-function(n=15, mu1, mu2, mu3){
    df<-data.frame(samples= c(rnorm(n, mu1, 10),
                              rnorm(n, mu2, 10),
                              rnorm(n, mu3, 10)),
                   groups = c(rep("sample1",n),
                              rep("sample2",n),
                              rep("sample3",n))
    )
    
    df
}

get_anova<-function(df){
    aov_obj<-summary(aov(samples~groups, data = df))
    aov_obj
}

get_F_scores<-function(n=15, m=500,mu1, mu2, mu3){
    f_scores<-numeric(m)
    for (i in 1:m){
        temp_samp<-get_samples(n, mu1, mu2, mu3)
        temp_aov<-summary(aov(samples~groups, data = temp_samp))
        f_scores[i]<-temp_aov[[1]][,"F value"][1]
    }
    
    f_scores<-c(0,f_scores)
    f_scores
}

f_scores_st<-get_F_scores(15,m=500,100,100,100)
f_scores_st


# F-distr approx
x_range<-seq(from=0,to=10,length.out=100)
f_range<-df(x_range, 2, 3*15-3)


