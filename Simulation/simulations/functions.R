
# Tab 1
# Set up stuff
set.seed(1001)
coin_flip<-function(n=500){
    if (n>8000){
        print("Pick an n-value below 8000.")
        return(NA)
    } else {
        coin<-c(0,1)
        rel_freq <-numeric(n)
        flips<-numeric(0)
        for (i in 1:n){
            flips<-c(flips,sample(coin,1,replace=TRUE))
            rel_freq[i]<-sum(flips)/length(flips)
        }
    }
    rel_freq
}


coin<-coin_flip(n=5000)

generate_plot<-function(data,n){
    ggplot()+geom_line(aes(x=1:n,y=data[1:n]))+
        geom_hline(yintercept = 0.5,color='red',linewidth=1.2)+
        ggtitle("Coin Flip Simulation")+
        coord_cartesian(ylim=c(0,1))+
        labs(x="Number of Flips",y="Relative Frequency of Heads")+
        theme_bw()
}

# Tab 2
set.seed(3030)
coin2<-c(0,1)
three_flip<-function(){
    three<-sample(coin2,3,replace=T)
    return(sum(three))
}


three_flip_sim<-function(n=500){
    if (n>8000){
        print("Pick an n-value below 8000.")
        return(NA)
    } else {
        rel_freq <-numeric(n)
        flips<-numeric(0)
        for (i in 1:n){
            flips<-c(flips,three_flip())
            rel_freq[i]<-sum(flips==3)/length(flips)
        }
    }
    rel_freq
}

triple_heads<-three_flip_sim(n=5000)

generate_plot_HHH<-function(data,n){
    ggplot()+geom_line(aes(x=1:n,y=data[1:n]))+
        geom_hline(yintercept = 0.125,color='red',
                   linewidth=1.2)+
        coord_cartesian(ylim=c(0,.5))+
        ggtitle("Triple Flip Simulation")+
        labs(x="Number of Simulations",
             y="Relative Frequency of Triple Heads (HHH)")+
        theme_bw()
}


# Tab 3

set.seed(2020)
# Set up stuff
die_roll<-function(n=1000,roll_num=1){
    die<-c(1, 2, 3, 4, 5, 6)
    if (roll_num %in% die){
        if (n>8000){
            print("Pick an n-value below 8000.")
            return(NA)
        } else {
            rel_freq <-numeric(n)
            rolls<-sample(die,3,replace=TRUE)
            for (i in 1:n){
                rolls<-c(rolls,sample(die,1,replace=TRUE))
                rel_freq[i]<-sum(rolls==roll_num)/length(rolls)
            }
            
        }
    } else{
        print("Please enter 1, 2, ..., 5, or 6 for the face of the die.")
        return(NA)
    }
    rel_freq
}


die_results<-die_roll(n=5000,roll_num=1)

generate_plot_dice<-function(data,n,roll_num=1){
    ggplot()+geom_line(aes(x=1:n,y=data[1:n]))+
        geom_hline(yintercept = 1/6,color='red',linewidth=1.2)+
        ggtitle("Die Roll Simulation")+
        coord_cartesian(ylim=c(0,0.75))+
        labs(x="Number of Rolls",
             y=paste("Relative Frequency of ",
                     roll_num,"Rolled"))+
        theme_bw()
}