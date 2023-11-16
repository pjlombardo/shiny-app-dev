
generate_null_distribution<-function(mu,sigma){
  data.frame(values=rnorm(5000,mu,sigma))
}

plot_paired_histograms<-function(data1,data2,dens_bool, col1='blue', col2='red'){
  if (dens_bool == T) {
    ggplot()+ 
    geom_density(aes(x=data1$values, y=after_stat(density)),
                   fill=col1,
                   alpha=.5)+
    geom_density(aes(x=data2$values, y=after_stat(density)),
                   fill=col2,
                   alpha=.5)+
      labs(x="",y="Relative Frequency")+theme_bw()
    }
  else {
    ggplot()+ 
      geom_histogram(aes(x=data1$values, y=after_stat(density)),
                     fill=col1,
                     col='gray60',
                     alpha=.35,
                     bins=20)+
      geom_histogram(aes(x=data2$values, y=after_stat(density)),
                     fill=col2,
                     col='gray20',
                     alpha=.5,
                     bins=20)+
      labs(x="",y="Relative Frequency")+theme_bw()
  }
}



# plot_paired_histograms(null1,null2)

get_sample_means<-function(population,m=5000,n=20){
  sample_means<-numeric(m)
  for (j in 1:m){
    sample_means[j]<-mean( sample( population[,1], n) )
  }
  
  df<-data.frame(values=sample_means)
  
  df
}


plot_hist_diff<-function(data1,data2,dens_bool,sample_num){
  new_data<-data.frame(values= data2[,1]-data1[,1])
  if (dens_bool==T){
  ggplot()+
    geom_density(aes(x=new_data$values[1:sample_num], y=after_stat(density)),
                   col='gray67',
                   fill='orange',
                   alpha=.5)+
    coord_cartesian(xlim=c(-40,40))+
      geom_hline(yintercept=0)+
      geom_vline(xintercept=0,color='red')+theme_bw()
  } else{
  ggplot()+
    geom_histogram(aes(x=new_data$values[1:sample_num], y=after_stat(density)),
                   col='gray67',
                   fill='orange',
                   alpha=.5,
                   bins=20)+
    coord_cartesian(xlim=c(-40,40))+
      labs(x="",y="Relative Frequency")+
      geom_hline(yintercept=0)+
          geom_vline(xintercept=0,color='red')+theme_bw()
  }

}