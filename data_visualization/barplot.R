df<- mpg

df %>%
  ggplot(aes(x=class)) +
  geom_bar(aes(fill=drv), position = "dodge")
