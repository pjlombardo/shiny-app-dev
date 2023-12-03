# F-distr approx
x_range<-seq(from=0,to=5,length.out=1000)

#### Finish this!!!
get_f_scores<-function(num_grps, sample_sizes){
    df(x_range,num_grps-1, num_grps*sample_sizes - num_grps)
}


f_scores_st<-get_f_scores(4,30)

