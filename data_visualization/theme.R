install.packages("ggthemes")
library(ggplot2)
library(ggthemes)

ggplot(mtcars,aes(x=wt,y=mpg))+
  geom_point()+
  theme_dark()

ggplot(mtcars,aes(x=wt, y=mpg))+
  geom_point()+
  theme_wsj()
