# create an actual population

actual_population<-rnorm(1000,100,10)


# wrapper function to plot populations
create_pop_plot<-function(data,plot_color){
  ggplot()+geom_point(aes(x = 1:length(data), y = data),
                      color=plot_color,
                      alpha = .4)+
    geom_hline(aes(yintercept = mean(data)),
               lwd=1)+
    ylim(50,160)
}

pop_sample_plot<-function(df, n){
  
}

# function to create matrix of sample positions and mean value of
# those measurements from population of data
#  mean value always sits in position n+1
# matrix is m by (n+1)
get_sampling_distribution_mtx<-function(data,n,m){
  test_mtx<-matrix(numeric((n+1)*m), nrow = m)
  for (j in 1:m){
    sampled_positions<-sample(1:length(data),n)
    test_mtx[j,]<-c(sampled_positions, mean(data[sampled_positions]))
  }

  test_mtx  
}

get_samp_dist_means<-function(data,n,m){
  means<-numeric(m)
  for (j in 1:m){
    means[j]<-mean(sample(data,n))
  }
  means
}

# get_samp_dist_means(actual_population,15,5000)

# dim(test_mtx)[2]

# test_mtx<-get_sampling_distribution_mtx(actual_population,15,5000)
  
sampling_plot<-function(population, test_mtx, round){
  pop_len<-length(population)
  dims<-dim(test_mtx)
  indices<- test_mtx[round,1:(dims[2]-1)]
  ggplot()+geom_point(aes(x = 1:pop_len, y = population),
                      color='red',
                      alpha = .4)+
    geom_point(aes(x = indices, y = population[indices]),
               color='black', pch=21, size =2, stroke=2)+
    geom_hline(aes(yintercept = mean(population)),
               color='red')+
    geom_hline(aes(yintercept = mean(population[indices])),
               color='black',
               lwd=1,lty=2)+
    ylim(50,160)
}

hist_samp_dist<-function(test_mtx, round){
  pop_len<-dim(test_mtx)[1]
  dims<-dim(test_mtx)
  mean_index<- dims[2]
  ggplot()+geom_histogram(aes(x = test_mtx[1:round,mean_index],
                              y=..density..),
                          color='gray28', alpha = .4,
                          fill = 'red',
                          bins = 50)
}

hist_samp_dist_both<-function(test_mtx,round){
  null_pop_len<-dim(test_mtx)[1]
  dims<-dim(test_mtx)
  
  mean_index<- dims[2]
  samp_dist_2<-get_samp_dist_means(actual_population,
                                   mean_index-1, 5000)
  ggplot()+
    geom_histogram(aes(x = samp_dist_2,
                       y=..density..,
                       fill='actual'),
                   alpha = .3,
                   colour='gray28',
                   bins = 50)+
    geom_histogram(aes(x = test_mtx[1:round,mean_index],
                              y=..density..,
                       fill = "null"),
                          alpha = .4,
                          colour='gray28',
                          bins = 50)+
    scale_fill_manual("Sampling Distributions:",
                        values = c("seagreen3", 'red'))
}

hist_plots<-function(test_mtx,round,bool){
  if (bool == FALSE){
    hist_samp_dist(test_mtx,round)
  } else {
    hist_samp_dist_both(test_mtx,round)
  }
}
# hist_samp_dist(test_mtx,100)
# hist_samp_dist_both(test_mtx,90)
# hist_plots(test_mtx,10,TRUE)
# hist_plots(test_mtx,1100,FALSE)
