
# x<-seq(-4,4,by = .001)

pop<-rnorm(10000,100,15)

run_HT_pval<-function(n=15,null_mu=100,pop){
  p_vals<-numeric(5000)
  for (i in 1:5000){
    samp<-sample(pop,n)
    p_vals[i]<-t.test(samp,mu = null_mu)$p.value
  }
  
  p_vals
}
  
reject_rate<-function(p_vals){
  sum(p_vals<0.05)/5000
}
  

# run_HT_pval(30,110)

picture<-function(p_vals){
  ggplot()+
    geom_histogram(aes(x=p_vals, y= after_stat(density)),
                   fill='dodgerblue',
                   color='gray50',
                   alpha = .5,
                   binwidth=0.025)+
    geom_vline(xintercept=.05,color='red',
               lwd=1.3,lty=1)+
    ylab("density")+ xlab("Simulated P-values")+
    ggtitle("Histogram of P-values for a Hypothesis Test")
}

# picture(run_HT_pval(15,100,pop))
