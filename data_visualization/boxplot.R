df<- mtcars

df%>%
  ggplot(aes(x=factor(cyl),y=mpg)) + 
  geom_boxplot(aes(fill=factor(cyl))) +
  theme_dark()
