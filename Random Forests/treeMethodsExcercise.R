library(ISLR)
library(ggplot2)
library(plotly)
library(caTools)
library(rpart)
library(rpart.plot)
library(randomForest)

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
set.seed(101)
sample<- sample.split(df$Private, SplitRatio = 0.7)

train.data<- subset(df,sample==T)
test.data<- subset(df,sample==F)

#building decision tree
tree<- rpart(Private ~.,method = "class",data = train.data)

predictedPrivate<- predict(tree,test.data)
head(predictedPrivate)

predictedPrivate<- as.data.frame(predictedPrivate)
joinColumns<- function(column){
  if(column>0.5){
    return("Yes")
  }else{
    return("No")
  }
}

predictedPrivate$Private<- sapply(predictedPrivate$Yes,joinColumns)

#confusion matrix
table(test.data$Private,predictedPrivate$Private)

prp(tree)

#random Forest
randomForestPrivate<- randomForest(Private ~.,data = train.data,importance=T)

#confusion matrix
randomForestPrivate$confusion
randomForestPrivate$importance

#predict
rfPredicted<- predict(randomForestPrivate,test.data)
table(rfPredicted,test.data$Private)
