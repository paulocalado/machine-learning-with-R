library(ggplot2)
library(corrgram)
library(dplyr)
library(caTools)
head(bikeshare)

ggplot(data = bikeshare,aes(y=count,x=temp,alpha=0.3))+
  geom_point(aes(color=temp),size=5)+
  scale_color_gradient(low='blue',high = 'red')

bikeshare$datetime<- as.POSIXct(bikeshare$datetime)

ggplot(data=bikeshare,aes(x=datetime,y=count))+
  geom_point(aes(color=temp))+
  scale_color_gradient(low='blue',high='orange')

cor(bikeshare$temp,bikeshare$count)

ggplot(data=bikeshare, aes(x=season,y=count))+
  geom_boxplot(aes(fill=factor(season)))

bikeshare$hour<- format(bikeshare$datetime,"%H")

bikeshare%>%
  filter(workingday==1)%>%
  ggplot(aes(x=hour,y=count))+
  geom_point(aes(color=temp),position=position_jitter(w=1, h=0))+
  scale_color_gradientn(colors=rainbow(4))

bikeshare%>%
  filter(workingday==0)%>%
  ggplot(aes(x=hour,y=count))+
  geom_point(aes(color=temp),position=position_jitter(w=1, h=0))+
  scale_color_gradientn(colors=rainbow(4))

temp.model<- lm(count~temp, data = bikeshare)

summary(temp.model)

temp.test<- data.frame(temp=c(25))
predict(temp.model,temp.test)

bikeshare$hour<- as.numeric(bikeshare$hour)

temp.model<- lm(count~. -casual -registered -datetime -atemp,data=bikeshare)

summary(temp.model)
bikesample<- sample.split(bikeshare$count,SplitRatio = 0.7)

train.bike<- bikeshare[bikesample==TRUE,]
test.bike<- bikeshare[bikesample==FALSE,]


temp.model<- lm(count~. -casual -registered -datetime -atemp,data=train.bike)

count.predictions<- predict(temp.model,test.bike)

results.count<- cbind(count.predictions, test.bike$count)
colnames(results.count)<- c('predicted','actual')
results.count<- as.data.frame(results.count)
results.count