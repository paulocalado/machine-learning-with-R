library(ggplot2)
library(plotly)
library(caTools)
library(e1071)

str(loans)
summary(loans)

loans$inq.last.6mths<- factor(loans$inq.last.6mths)
loans$delinq.2yrs<- factor(loans$delinq.2yrs)
loans$pub.rec<- factor(loans$pub.rec)
loans$not.fully.paid<- factor(loans$not.fully.paid)
loans$credit.policy<- factor(loans$credit.policy)

#visualize data
ggplot(data=loans,aes(fico))+
  geom_histogram(aes(fill=not.fully.paid),color="white",alpha=0.8)+
  theme_dark()
ggplotly()

ggplot(data=loans,aes(purpose))+
  geom_bar(aes(fill=not.fully.paid),position = "dodge")+
  theme_bw()

ggplot(data=loans, aes(x=int.rate,y=fico))+
  geom_point(aes(color=not.fully.paid))

#building the model
set.seed(101)
sample<- sample.split(loans$not.fully.paid, SplitRatio = 0.7)

train<- subset(loans,sample==T)
test<- subset(loans,sample==F)

model<- svm(not.fully.paid~., data=train)

summary(model)

predictedValues<- predict(model,test)

table(predictedValues,test$not.fully.paid)

#tuning method
tuneResults<- tune(svm,train.x = not.fully.paid~., data = train, kernel="radial",
                   ranges = list(cost=c(100,200),
                                 gamma=c(0.1)))

tunedModel<- svm(not.fully.paid~.,data=train,cost=100,gamma=0.1)

tunedPredictions<- predict(tunedModel,test[1:13])
table(tunedPredictions,test$not.fully.paid)
