
# create an actual population
gen_pmf_hist<-function(n,p,show){
  space <- 1:(n+1)-1
  pmf <- dbinom(space,n,p)
  mu <-n*p
  sigma<- sqrt(n*p*(1-p))
  min_max<-c(mu-2*sigma, mu+2*sigma)
  
  if (show==FALSE){
    ggplot()+
      geom_col(aes(x=space, y = pmf),
               color='blue3',
               fill = 'dodgerblue3',alpha=.6,
               width=1)+
      scale_x_continuous(breaks = seq(0,n,1))+
      ylab("Probability")+
      xlab(paste("X, Binomial\nn=",n,", p = ",p))+
      geom_hline(yintercept=0,lwd=.8)+
      geom_vline(xintercept=mu, color='red3',lwd=1)
  } else {
    ggplot()+
      geom_rect(aes(xmin=min_max[1], 
                    xmax=min_max[2], 
                    ymin=0, 
                    ymax=Inf),
                col='gray2',
                fill='green4',
                alpha=.4)+
      geom_col(aes(x=space, y = pmf),
               color='blue3',
               fill = 'dodgerblue3',alpha=.6,
               width=1)+
      scale_x_continuous(breaks = seq(0,n,1))+
      ylab("Probability")+
      xlab(paste("X, Binomial\nn=",n,", p = ",p))+
      geom_hline(yintercept=0,lwd=.8)+
      geom_vline(xintercept=mu, color='red3',lwd=1)
  }
  
}


gen_text_mean<-function(n,p){
  paste("Mean = ",
        round(n*p,2))
}

gen_text_sd<-function(n,p){
  paste("Std. Deviation = ",
        round(sqrt(n*p*(1-p)),2))
}

