library(ggplot2)
library(dplyr)

df<- mtcars


df %>%
  ggplot(aes(x=wt,y=mpg)) +
  geom_point(aes(shape=factor(cyl),color = factor(cyl)),size=3)


df %>%
  ggplot(aes(x=wt,y=mpg)) +
  geom_point(aes(color=hp),size=5) +
  scale_color_gradient(low = 'blue',high = 'red')
