


# create an actual population
data<-rchisq(500, 4.7)

gen_pdf<-function(d,show){
  space <- seq(0, 30, .01)
  pdf <- dchisq(space,d)
  maxval<-max(pdf)
  # min_max<-c(mu-2*sigma, mu+2*sigma)
  
  if (show==FALSE){
    ggplot()+
      geom_line(aes(x=space, y=pdf),
                color='dodgerblue3',lwd=1)+
      ylab("Density")+
      # xlab(paste("X, Binomial\nn=",n,", p = ",p))+
      geom_hline(yintercept=0,lwd=.8)+
      # geom_vline(xintercept=mu, color='red3',lwd=.7, lty=2)+
      xlim(0,30)+ylim(0,.5)
  } else {
    ggplot()+
      geom_histogram(aes(x=data, y=after_stat(density)),color='gray',
                     fill='gray', alpha=.7,
                     breaks = 1.5*(0:20))+
      geom_line(aes(x=space, y=pdf),
                color='dodgerblue3',lwd=1)+
      ylab("Density")+
      # xlab(paste("X, Binomial\nn=",n,", p = ",p))+
      geom_hline(yintercept=0,lwd=.8)+
      # geom_vline(xintercept=mu, color='red3',lwd=.7,lty=2)+
      xlim(0,30)+ylim(0,.5)  }
}

# gen_pdf(10,2,FALSE)
# ?geom_bar

# gen_text_mean<-function(n,p){
#   paste("\\(\\mu\\) = ",
#         round(n*p,2))
# }
# 
# gen_text_sd<-function(n,p){
#   paste("\\(\\sigma\\) = ",
#         round(sqrt(n*p*(1-p)),2))
# }
# 
# gen_text(10,.3)
