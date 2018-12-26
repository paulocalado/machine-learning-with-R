install.packages("ISLR")
library(ISLR)
library(class)
library(ggplot2)
library(plotly)

str(Caravan)
summary(Caravan$Purchase)

any(is.na(Caravan))

var(Caravan[,1])
var(Caravan[,2])

purchase<- Caravan$Purchase

#Standardize variables
standardize.Caravan<- scale(Caravan[,-86])

var(standardize.Caravan[,1])
var(standardize.Caravan[,2])

#Train/test split not using CaTools on this one
test.index<- 1:1000
test.data<- standardize.Caravan[test.index,]
test.purchase<- purchase[test.index]

train.data<- standardize.Caravan[-test.index,]
train.purchase<- purchase[-test.index]

#KNN MODEL
set.seed(101) #just to get the same results as the video

#the order is the training data, the test data than the training labels
predicted.purchase<- knn(train.data,test.data,train.purchase,k=3)
head(predicted.purchase)

#evaluate the model
misclass.error<- mean(test.purchase != predicted.purchase)
misclass.error

#When I changed the value of k from 1 to 3, the miss classification error reduced about 4%

#CHOOSING A K VALUE
predicted.purchase<- NULL
error.rate<- NULL

for(i in 1:20){
  set.seed(101)
  predicted.purchase<- knn(train.data,test.data,train.purchase,k=i)
  error.rate[i]<- mean(test.purchase != predicted.purchase)
}

error.rate

### Visualize K elbow method
k.values <- 1:20
error.df<- data.frame(error.rate,k.values)
error.df

ggplot(error.df,aes(x=k.values,y=error.rate))+
  geom_point()+
  geom_line(lty="dotted",color="red")
ggplotly()

#after visualizing it we would choose  as equal 9 for our model