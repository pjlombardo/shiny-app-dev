generate_null_distribution<-function(mu,sigma){
    data.frame(values=rnorm(5000,mu,sigma))
}

pop1<-generate_null_distribution(100,10)
pop2<-generate_null_distribution(110,10)
plot_paired_histograms<-function(data1,data2){
    ggplot()+ 
        geom_histogram(aes(x=data1$values, y=..density..),
                       fill='blue',
                       col='gray60',
                       alpha=.25,
                       bins=20)+
        geom_histogram(aes(x=data2$values, y=..density..),
                       fill='red',
                       col='gray20',
                       alpha=.5,
                       bins=20)+
        labs(x="",y="Relative Frequency")
}



# plot_paired_histograms(null1,null2)

get_sample_means<-function(pop1, pop2, n=20){
    sample_means<-numeric(3)
    sample_means[1]<-mean(sample(pop1$values,n))
    sample_means[2]<-mean(sample(pop2$values,n))
    sample_means[3]<-sample_means[2]-sample_means[1]
    df<-data.frame(values=sample_means,population = c("Sample Mean, Population 1", 
                                                      "Sample Mean, Population 2",
                                                      "Difference in Sample Means"))
    df
}

sm<-get_sample_means(pop1,pop2,n=20)


# plot_hist_diff<-function(data1,data2){
#   new_data<-data.frame(values= data2[,1]-data1[,1])
#   ggplot()+ 
#     geom_histogram(aes(x=new_data$values, y=..density../100),
#                    col='gray67',
#                    fill='orange',
#                    alpha=.5,
#                    bins=20)+
#     coord_cartesian(xlim=c(-20,20))
#   
# }
# 
# plot_density_diff<-function(data1,data2){
#   new_data<-data.frame(values= data2[,1]-data1[,1])
#   ggplot()+ 
#     geom_density(aes(x=new_data$values, y=..density../100),
#                    col='gray67',
#                    fill='orange',
#                    alpha=.5,
#                    bins=20)+
#     coord_cartesian(xlim=c(-20,20))
#   
# }

