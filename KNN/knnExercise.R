library(ISLR)
library(class)
library(ggplot2)
library(plotly)
library(caTools)

head(iris)
str(iris)

var(iris$Sepal.Length)
var(iris$Sepal.Width)

#standardize
standardize.iris<- scale(iris[,-5])

var(standardize.iris[,1])
var(standardize.iris[,2])

standardize.iris<- cbind(standardize.iris,iris[,5])
finalData<- cbind(standardize.iris,iris[5])
species<- finalData$Species

sample<- sample.split(finalData$Species,SplitRatio = 0.7)
train.data<- subset(finalData,sample==T)

test.data<- subset(finalData,sample==F)

predictedSpecies<- knn(train.data[,1:4],test.data[,1:4],train.data$Species,k=1)

missclassError<- mean(test.data$Species != predictedSpecies)

predictedSpecies<- NULL
error.rate<- NULL

for(i in 1:10){
  set.seed(101)
  predictedSpecies<- knn(train.data[,1:4],test.data[,1:4],train.data$Species,k=i)
  error.rate[i]<-  mean(test.data$Species != predictedSpecies)
}

error.rate

k.values <- 1:10
error.df<- data.frame(error.rate,k.values)
error.df

ggplot(error.df,aes(x=k.values,y=error.rate))+
  geom_point()+
  geom_line(lty="dotted",color="red")
ggplotly()