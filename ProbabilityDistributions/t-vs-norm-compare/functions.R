
x<-seq(-4,4,by = .001)

picture<-function(n){
  x<-data.frame(val=seq(-4,4,by = .001))
  ggplot(data = x)+
    stat_function(aes(x=val,color='t-distribution'),
                  fun=function(x){
                    dt(x,n)
                  },
                  lwd =1)+
    stat_function(aes(x=val,
                      color='z-distribution'),
                  fun = function(x){
                    dnorm(x,0,1)
                  },
                  lty = 4, lwd = .6)+
    scale_colour_manual("Distributions:", 
                        values = c("red", "black"))+
    geom_hline(yintercept =0,color='black')+
    ylab("")+xlab("Scores")+ggtitle("Comparing t and z distributions")
}
picture(3)

?stat_function
