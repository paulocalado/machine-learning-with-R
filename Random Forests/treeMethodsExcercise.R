library(ISLR)
library(ggplot2)
library(plotly)
library(caTools)

head(College)

df<- College

#explolatory data analysis
ggplot(data=df,aes(x=Grad.Rate,y=Room.Board))+geom_point(aes(color=Private))

ggplot(data=df,aes(F.Undergrad))+
  geom_histogram(aes(fill=Private),alpha=0.8)+
  theme_bw()

ggplot(data=df,aes(Grad.Rate))+
  geom_histogram(aes(fill=Private),color="black",bins=50,alpha=0.5)+
  theme_bw()
ggplotly()

#college with graduation rate above 100%
df$Grad.Rate[df$Grad.Rate>100]<- 100


#checking if it's all ok now
ggplot(data=df,aes(Grad.Rate))+
  geom_histogram(aes(fill=Private),color="black",bins=50,alpha=0.5)+
  theme_bw()
ggplotly()

#Train and test split
