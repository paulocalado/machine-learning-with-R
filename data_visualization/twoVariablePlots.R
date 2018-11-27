library(ggplot2)
install.packages("ggplot2movies")
library(ggplot2movies)
library(dplyr)


ggplot(movies,aes(x=year, y=rating))+
  geom_bin2d()+scale_fill_gradient(high = "red",low = "green")

ggplot(movies,aes(x=year, y=rating))+
  geom_density2d()
