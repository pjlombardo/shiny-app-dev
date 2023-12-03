
# create an actual population
set.seed(123)

ys<-runif(5000,0,1)
# make population:
gen_pop<-function(p){
  n1<-round(p*5000,0)
  data.frame(x = 1:5000,
             y= ys,
             type=c(rep("Yes",n1),
                    rep("No", 5000-n1))
  )
}

actual_population<-gen_pop(0.45)
initial_null_pop<-gen_pop(0.45)


# wrapper function to plot populations
create_pop_plot<-function(data,act_pop){
  if (act_pop==F){
    ggplot()+geom_point(data = data,
                        aes(x=x,y=y,
                            color=type)
    )+
      scale_color_manual(values=c("red","dodgerblue"))+
      ggtitle("Null Population")
  } else {
    ggplot()+geom_point(data = data,
                        aes(x=x,y=y,
                            color=type)
    )+
      scale_color_manual(values=c("coral3","deepskyblue4"))+
      ggtitle("Actual Population")
  }
}

# create_pop_plot(actual_population,F)
# pop_sample_plot<-function(df, n){
#   
# }

get_p_hat<-function(sample_df,n){
  table(sample_df[,"type"])[2]/n
}

# function to create matrix of sample positions and mean value of
# those measurements from population of data
#  mean value always sits in position n+1
# matrix is m by (n+1)
get_sampling_distribution_mtx<-function(data,n){
  mtx<-matrix(data =0, nrow=2000,ncol=n+1)
  for (i in 1:2000){
    indices<-sample(1:5000,n)
    mtx[i,1:n]<-indices
    mtx[i,n+1]<-get_p_hat(data[indices,],n)
  }
  
  mtx  
}

# null_pop1<-gen_pop(.4)
# actual<-get_sampling_distribution_mtx(actual_population,30)
# actual_ps<-actual[,31]
# nullp<-get_sampling_distribution_mtx(null_pop1,30)
# get_samp_dist_means<-function(data,n,m){
#   means<-numeric(m)
#   for (j in 1:m){
#     means[j]<-mean(sample(data,n))
#   }
#   means
# }

# get_samp_dist_means(actual_population,15,5000)

# dim(test_mtx)[2]

# test_mtx<-get_sampling_distribution_mtx(actual_population,15,5000)
  
sampling_plot<-function(data, indices, round){
  n<-dim(indices)[2]-1
  index<-indices[round,]
  ggplot()+
    geom_point(data = data,
               aes(x=x,
                   y=y,
                   color=type))+
    scale_color_manual(values=c("red","dodgerblue"))+
    geom_point(aes(x = data$x[index],
                   y = data$y[index]),
               shape=1,
               size=2,
               stroke=1.75)
}

# sampling_plot(actual_population, actual, 5)
# actual[5,31]
# 
# sampling_plot(null_pop1, nullp, 5)
# nullp[5,31]

hist_samp_dist<-function(index, round, bin_count){
  n<-dim(index)[2]-1
  data_temp<-index[1:round,n+1]
  ggplot()+geom_histogram(aes(x=data_temp,y=..density..), 
                          bins=bin_count,
                          colour='black',
                          fill='dodgerblue',
                          alpha=.25)+
    xlim(0,1)
}

# hist_samp_dist(nullp, 100, 30)

hist_samp_dist_both<-function(index,round,actual_ps,bin_count){
  null_pop_len<-dim(index)[1]
  dims<-dim(index)
  
  prop_index<- dims[2]
  samp_dist_2<-actual_ps[,prop_index]
    
  ggplot()+
    geom_histogram(aes(x = index[1:round,prop_index],
                              y=..density..),
                          alpha = .5,
                          fill = 'dodgerblue',
                          colour='gray28',
                          bins = bin_count)+
    geom_histogram(aes(x = samp_dist_2,
                       y=..density..),
                   fill='deepskyblue4',
                   alpha = .2,
                   colour='gray28',
                   bins = bin_count)
}

# hist_samp_dist_both(nullp, 500,15)

hist_plots<-function(index,round,actual_ps,bin_count, bool){
  if (bool == FALSE){
    hist_samp_dist(index,round,bin_count)
  } else {
    hist_samp_dist_both(index,round,actual_ps, bin_count)
  }
}


# hist_samp_dist(test_mtx,100)
# hist_samp_dist_both(test_mtx,90)
# hist_plots(test_mtx,10,TRUE)
# hist_plots(test_mtx,1100,FALSE)
