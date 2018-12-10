library(ggplot2)
library(ggthemes)
library(dplyr)
library(corrgram)
library(corrplot)
library(plotly)

any(is.na(student.mat))

#Num.only
num.cols<- sapply(student.mat, is.numeric)

cor.data<- cor(student.mat[,num.cols])

corrplot(cor.data,method = "color")

corrgram(student.mat)

corrgram(student.mat,order = T,lower.panel = panel.shade,
         upper.panel = panel.pie, text.panel = panel.txt)

 ggplot(student.mat,aes(x=G3)) +
  geom_histogram(bins=20, alpha=0.5, fill='blue')

ggplotly()

#####split data into train and test sets
install.packages("caTools")
library(caTools)

#Set a Seed (just in order to have the same results as the video)
set.seed(101)

#split up sample
#this function can take any column but by convention we're going
#to use the one we're trying to predict
#SplitRatio in this case will use 70% as training data and 30% as testing
sample<- sample.split(student.mat$G3,SplitRatio = 0.7)

#Two ways of doing the same thing
train<- student.mat[sample==TRUE,]

test<- subset(student.mat,sample==FALSE)

#Train and build model
model<- lm(G3 ~., data=train)


#interpret the model
summary(model)

#checking the residuals
res<- residuals(model)
res<- as.data.frame(res)
ggplot(res,aes(res))+geom_histogram(fill="blue",alpha=0.5)
