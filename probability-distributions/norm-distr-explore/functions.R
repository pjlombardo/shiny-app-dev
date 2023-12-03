


# create an actual population
data<-rnorm(150, 5, 2)

gen_pdf<-function(mu,sigma,show){
  space <- seq(mu-4*sigma, mu+4*sigma, .01)
  pdf <- dnorm(space,mu,sigma)
  min_max<-c(mu-2*sigma, mu+2*sigma)
  
  if (show==FALSE){
    ggplot()+
      geom_line(aes(x=space, y=pdf),
                color='dodgerblue3',lwd=1)+
      ylab("Density")+
      # xlab(paste("X, Binomial\nn=",n,", p = ",p))+
      geom_hline(yintercept=0,lwd=.8)+
      geom_vline(xintercept=mu, color='red3',lwd=.7, lty=2)+
      xlim(-20,30)+ylim(0,.5)
  } else {
    ggplot()+
      geom_histogram(aes(x=data, y=..density..),color='gray',
                     fill='gray', alpha=.7,
                     bins = 50)+
      geom_line(aes(x=space, y=pdf),
                color='dodgerblue3',lwd=1)+
      ylab("Density")+
      # xlab(paste("X, Binomial\nn=",n,", p = ",p))+
      geom_hline(yintercept=0,lwd=.8)+
      geom_vline(xintercept=mu, color='red3',lwd=.7,lty=2)+
      xlim(-20,30)+ylim(0,.5)
  }
  
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
