install.packages("e1071")
library(ISLR)
library(e1071)
library(caTools)

head(iris)

model<- svm(Species ~., data=iris)
summary(model)

#predicting
sample<- sample.split(iris$Species, SplitRatio = 0.7)

train<- subset(iris,sample==T)
test<- subset(iris, sample==F)

model<- svm(Species ~., data=train)
summary(model)

predicted<- predict(model, test)
table(predicted,test$Species)

#tuning the parameters
tuneResults<- tune(svm,train.x = train[,1:4],train.y = train[,5],kernel='radial',
                   ranges = list(cost=c(0.1,1,10),
                                 gamma=c(0.5,1,2)))

summary(tuneResults)

#let's work around the best values for cost and gamma (1 and 0.5)
tuneResults<- tune(svm,train.x = train[,1:4],train.y = train[,5],kernel='radial',
                   ranges = list(cost=c(0.5,1,1.5),
                                 gamma=c(0.1,0.5,0.7)))
summary(tuneResults)


#using the best values for cost and gamma
tunedModel<- svm(Species~., data=train,kernel='radial',cost=1,gamma=0.1)
summary(tunedModel)
