install.packages("ggplot2movies")
library(ggplot2movies)
library(ggplot2)
library(dplyr)

#DATA AND AESTHETICS
 pl<-  movies %>%
        ggplot() +
        aes(x=rating)
 
#Geometry
# pl2<- pl + geom_histogram(binwidth = 0.1,color='red', fill = 'pink', alpha = 0.4)
 pl2<- pl + geom_histogram(binwidth = 0.1, aes(fill = ..count..))
                   
pl2

pl3<- pl2 + 
      xlab('Movie Rating') + 
      ylab('Count') +
      ggtitle("My plot")

pl3
