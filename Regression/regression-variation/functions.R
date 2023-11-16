
# Set up
x<-rnorm(500,250,30)
y<-2.13*x + 10 + rnorm(500,0,55)

#initial sample
s<-sample(1:500,35)

full.lm<-lm(y~x)
samp.lm<-lm(y[s]~x[s])
cff<-coef(full.lm)
pop_corr<-cor(x,y)


get_plot<-function(s,show){
    cfs<-coef(lm(y[s]~x[s]))
    if (show){
        ggplot()+geom_point(aes(x = x, y = y),
                            color='blue',
                            alpha = .15,size=2)+
            geom_abline(slope=cff["x"],
                        intercept = cff["(Intercept)"], color='blue',
                        alpha= .25,linewidth=2)+
            geom_point(aes(x= x[s], y = y[s]),
                       color='red',
                       pch =16,size=3)+
            geom_point(aes(x= x[s], y = y[s]),
                       color='black',
                       pch =4,size=3)+
            geom_abline(slope=cfs["x[s]"],
                        intercept = cfs["(Intercept)"], color='red',linewidth=1.5)+
            theme_bw()
    } else {
        ggplot()+geom_point(aes(x = x, y = y),
                            color='blue',alpha=.6,size=2)+
            geom_abline(slope=cff["x"],
                        intercept = cff["(Intercept)"], 
                        color='blue',alpha=.7,linewidth=2)+theme_bw()
            # geom_point(aes(x= x[s], y = y[s]),
            #            color='red',
            #            pch =16,size=3)+
            # geom_point(aes(x= x[s], y = y[s]),
            #            color='black',
            #            pch =4,size=3)+
            # geom_abline(slope=cfs["x[s]"],
            #             intercept = cfs["(Intercept)"], color='red',linewidth=1.5)
    }
}

init_plot<- ggplot()+geom_point(aes(x = x, y = y),
                                color='blue',alpha=.6, size=2)+
    geom_abline(slope=cff["x"],
                intercept = cff["(Intercept)"], color='blue',
                alpha=.7,
                linewidth=2)+ theme_bw()


# get_plot(sample(1:300,35))
get_sample_table_cor<-function(s){
    data.frame(population.correlation = pop_corr,
               sample.correlation = cor(x[s],y[s]))
    
}

get_sample_table_coef<-function(s){
    cfs<-coef(lm(y[s]~x[s]))
    sample_cor<-cor(x[s],y[s])
    df = data.frame(Type = c("Correlation", 
                             "Intercept",
                             "Slope"),
                    Population.Parameters = c(pop_corr,
                                              cff["(Intercept)"],
                                              cff["x"]),
                    Sample.Statistics = c(sample_cor,
                                          cfs['(Intercept)'],
                                          cfs['x[s]'])
    )
    
    df
}


