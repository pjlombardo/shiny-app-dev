
# Set up stuff
set.seed(123)

ys1<-runif(5000,0,1)
# make population:
gen_pop<-function(p){
  n1<-round(p*5000,0)
  data.frame(x = 1:5000,
             y= ys1,
             type=c(rep("Yes",n1),
                 rep("No", 5000-n1))
             )
}

initial_pop1<-gen_pop(.5)

# create matrix of random sample indices
# n<-30

get_p_hat1<-function(sample_df,n){
    # print(sum(sample_df[,"type"]=="Yes")/n)
  sum(sample_df[,"type"]=="Yes")/n
}

get_indices1<-function(data,n){
  mtx<-matrix(data =0, nrow=4000,ncol=n+1)
  for (i in 1:4000){
    indices<-sample(1:5000,n)
    mtx[i,1:n]<-indices
    mtx[i,n+1]<-get_p_hat1(data[indices,],n)
  }
  
  mtx
}


initial_indices1<-get_indices1(initial_pop1,30)

show_pop_sample1<-function(data, indices, sample_num,p=.5){
  n<-dim(indices)[2]-1
  index<-indices[sample_num,]
  ggplot()+
    geom_point(data = data,
               aes(x=x,
                   y=y,
                   color=type))+
    scale_color_manual(values=c("red","dodgerblue"),guide = "none")+
    geom_point(aes(x = data$x[index],
                   y = data$y[index]),
                   shape=1,
                   size=2,
                  stroke=1.75)+
      geom_vline(xintercept=p*5000,linewidth=1.5,color='black')+
      scale_x_continuous(breaks = 250*0:20,
                         labels = label_number(scale=1/5000))+
      theme_bw()+
      labs(y="",x="",title="Population Plot")+
      theme(axis.text.y=element_blank())
}

update_sampling_dist1<-function(index,sample_num,bin_count){
scaleFUN <- function(x) sprintf("%.2f", x)
  n<-dim(index)[2]-1
  data_temp<-index[1:sample_num,n+1]
  # print(data_temp)
  ggplot()+geom_histogram(aes(x=data_temp,y=after_stat(density)), 
                          bins=bin_count,
                          colour='black',
                          fill='blue2',
                          alpha=.25)+
      # Use coord_cartesian to set axis limits, this prevents warning
      # messages
      coord_cartesian(xlim=c(0,1))+
    scale_x_continuous(breaks = seq(0,1,by=.05))+
      geom_vline(xintercept=mean(data_temp),
                 color='dodgerblue',
                 linewidth=1.3)+
      geom_hline(yintercept=0)+
      scale_y_continuous(labels=scales::number_format(accuracy = 0.01,
                                                      decimal.mark = '.'))+
      labs(y="",x="Sample Percentages",title="Histogram of sample percentages")+
      theme_bw()+
      theme(axis.text.y=element_blank())
}

###############################################################

    # Tab 2

start_pop<-data.frame(values = c(rep("Crow",.45*5100),
                                 rep("Other",(1-.45)*5100)),
                      m=10000,
                      n=10)

get_sampling_distribution2<-function(pop, m=10000, n=20){
    sample_means<-numeric(m)
    for (j in 1:m){
        sample_means[j]<-sum(pop[sample(1:5100,n),1]=="Crow")/n
    }
    data.frame(values = sample_means)
}

bin_fxn2<-function(n){
    round(2+4.5*log(n),0)
}

m2<-5000

plot_tab_2<-function(data, n=10, p, show_pop){
    if (show_pop){
        p1<-ggplot(data = data, aes(x=values))+
            geom_histogram(aes(y=after_stat(density)/100),
                           color='gray3',
                           fill='deepskyblue3',
                           alpha=.4,
                           bins=bin_fxn2(n))+
            coord_cartesian(xlim=c(0,1),
                            ylim=c(-.02,.25))+
            geom_hline(yintercept=0)+
            geom_vline(xintercept=p,color='green4',linewidth=1.5)+
            labs(y="density",title="Sampling Distribution for Sample Percents (\"p-hat\")",
                 x="Sample Percentages From Repeated Sampling")+
            theme_bw()+
            theme(plot.title=element_text(size=18),
                  axis.text.y=element_blank())
        
        M1<-max(ggplot_build(p1)$data[[1]]$ymax)
        
        p1 +
            geom_segment(aes(x=values,xend = values, y=rep(-.1*M1,5000),
                             yend = rep(.25*M1,5000)),
                         color='red',linewidth=1,
                         alpha = .01)
    } else {
        p1<-ggplot(data = data, aes(x=values))+
            geom_histogram(aes(y=after_stat(density)/100),
                           color='gray3',
                           fill='deepskyblue3',
                           alpha=.4,
                           bins=bin_fxn2(n))+
            coord_cartesian(xlim=c(0,1),
                            ylim=c(-.02,.25))+
            geom_hline(yintercept=0)+
            # geom_vline(xintercept=p,color='green4',linewidth=1.5)+
            labs(y="density",title="Sampling Distribution for Sample Percents (\"p-hat\")",
                 x="Sample Percentages From Repeated Sampling")+
            theme_bw()+
            theme(plot.title=element_text(size=18),
                  axis.text.y=element_blank())
        
        M1<-max(ggplot_build(p1)$data[[1]]$ymax)
        
        p1 +
            geom_segment(aes(x=values,xend = values, y=rep(-.1*M1,5000),
                             yend = rep(.25*M1,5000)),
                         color='red',linewidth=1,
                         alpha = .01)
    }
}


