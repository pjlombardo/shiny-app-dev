
pop<-rnorm(5000, 100, 20)
pop_mean<-mean(pop)

xseq<-seq(40,180,.1)
s1<-sample(pop,1)
mid1<-20*qnorm(.025) + 100
mid2<-20*qnorm(.975) + 100

bool_test<- function(xbar){
  if (xbar< mid1 | xbar > mid2){
    FALSE
  } else {
    TRUE
  }
}

density_curve<-function(x){
  dnorm(x,100,20)
}


picture1<-function(xbar,ci){
  se<-qnorm(.975)*20
  if (ci==T){
    ggplot()+
      geom_histogram(aes(x=pop, y=after_stat(density)),
                     bins=20,
                     alpha=.2, color='gray',
                     fill="violetred3")+
      stat_function(fun = density_curve,
                    color='violetred3',lwd = 1)+
      stat_function(fun = density_curve, 
                    xlim = c(mid1,mid2),
                    geom = "area",
                    fill='blue',alpha=.4)+
      geom_segment(aes(x=100,xend=100,y=0,yend=.02125),color='green2',lwd=1)+
      geom_hline(yintercept=0)+
      geom_line(aes(x=c(xbar - se,xbar+se),y=c(0,0)),color='blue',lwd=3,alpha=.5)+
      geom_segment(aes(x = xbar, xend = xbar, y = -.0008, yend =0.0008),
                   color='blue', lwd = 1)+
      ylab("")+xlab("Sampling Distribution")
  } else {
    ggplot()+
      geom_histogram(aes(x=pop, y=after_stat(density)),
                     bins=20,
                     alpha=.2, color='gray',
                     fill="violetred3")+
      stat_function(fun = density_curve,
                    color='violetred3',lwd = 1)+
      stat_function(fun = density_curve, 
                    xlim = c(mid1,mid2),
                    geom = "area",
                    fill='blue',alpha=.4)+
      geom_segment(aes(x=100,xend=100,y=0,yend=.02125),color='green2',lwd=1)+
      geom_hline(yintercept=0)+
      geom_segment(aes(x = xbar, xend = xbar, y = -.0008, yend =0.0008),
                   color='blue',lwd =1)+
      ylab("")+xlab("Sampling Distribution")
  }
}

picture2<-function(xbar,ci){
  se<-qnorm(.975)*20
  if (ci==T){
    ggplot()+
      geom_histogram(aes(x=pop, y=after_stat(density)),
                     bins=20,
                     alpha=.2, color='gray',
                     fill="violetred3")+
      stat_function(fun = density_curve,
                    color='violetred3',lwd = 1)+
      stat_function(fun = density_curve, 
                    xlim = c(mid1,mid2),
                    geom = "area",
                    fill='blue',alpha=.4)+
      geom_segment(aes(x=100,xend=100,y=0,yend=.02125),color='green2',lwd=1)+
      geom_hline(yintercept=0)+
      geom_line(aes(x=c(xbar - se,xbar+se),y=c(0,0)),color='red',lwd=3,alpha=.5)+
      geom_segment(aes(x = xbar, xend = xbar, y = -.0008, yend =0.0008),
                   color='red',lwd = 1)+
      ylab("")+xlab("Sampling Distribution")
  } else {
    ggplot()+
      geom_histogram(aes(x=pop, y=after_stat(density)),
                     bins=20,
                     alpha=.2, color='gray',
                     fill="violetred3")+
      stat_function(fun = density_curve,
                    color='violetred3',lwd = 1)+
      stat_function(fun = density_curve, 
                    xlim = c(mid1,mid2),
                    geom = "area",
                    fill='blue',alpha=.4)+
      geom_segment(aes(x=100,xend=100,y=0,yend=.02125),color='green2',lwd=1)+
      geom_hline(yintercept=0)+
      geom_segment(aes(x = xbar, xend = xbar, y = -.0008, yend =0.0008),
                   color='red',lwd = 1)+
      ylab("")+xlab("Sampling Distribution")
  }
}

picture<-function(xbar,ci){
  bool<-bool_test(xbar)
  if (bool==T){
    picture1(xbar,ci)
  } else {
    picture2(xbar,ci)
  }
}


# picture1(55,T)
