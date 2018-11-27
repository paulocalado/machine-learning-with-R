df<- Economist_Assignment_Data[,2:6]
 

pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

ggplot(df,aes(x=CPI,y=HDI,color=Region))+
  geom_point(size=4, shape=1)+
  geom_smooth(aes(group=1),method = "lm",formula = y~log(x),se=F,color="red")+
  geom_text(aes(label=Country),color="gray20", 
            data=subset(df, Country %in% pointsToLabel),check_overlap = T)+
  theme_economist_white()+
  scale_x_continuous(limits = c(.9,10.5),breaks = 1:10)
