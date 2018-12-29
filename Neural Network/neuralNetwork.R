install.packages("neuralnet")
install.packages("MASS")
#mass package just to get the Boston dataframe
library(MASS)
library(caTools)
library(neuralnet)
library(ggplot2)

head(Boston)
str(Boston)

#checking NA values
any(is.na(Boston))

data<- Boston

#normalize the data using the scale function
#ALWAYS NORMALIZE THE DATA WHEN WORKING WITH NEURAL NET

#getting maximum value for each of the columns
maxs<- apply(data,MARGIN = 2,max)

#getting the minimum value for each of the columns
mins<- apply(data, MARGIN = 2,min)

#for every data point subtract the correspondent mins value and then divided by the scale
scaledData<- as.data.frame(scale(data,center=mins, scale = maxs-mins))

#split into training and test set
set.seed(101)

sample<- sample.split(scaledData$medv, SplitRatio = 0.7)
train<- subset(scaledData,sample=T)
test<- subset(scaledData,sample=F)

#the neural net does not accept the funciont format of y ~.

#creating the formula to use
n <- names(train)
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))

nn<- neuralnet(f,data=train,hidden = c(5,3),linear.output = T)

plot(nn)

#predictions, pass the test data without the label
predicted.nn.values<- compute(nn,test[1:13])

str(predicted.nn.values)

#undo the normalization to get the true predictions
true.predictions<- predicted.nn.values$net.result*(max(data$medv)-min(data$medv))+min(data$medv)

test.r <- (test$medv)*(max(data$medv)-min(data$medv))+min(data$medv)

MSE<- sum((test.r - true.predictions)^2/nrow(test))

error.df<- data.frame(test.r,true.predictions)
head(error.df)

ggplot(data=error.df,aes(x=test.r,y=true.predictions))+
  geom_point()+
  stat_smooth()
