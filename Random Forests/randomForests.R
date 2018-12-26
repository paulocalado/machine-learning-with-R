install.packages("rpart")
install.packages("rpart.plot")
install.packages("randomForest")
library(rpart)
library(rpart.plot)
library(randomForest)

str(kyphosis)
head(kyphosis)

#building a tree model (everything is correct with this data, no need to clean it)
#pass as method 'class' because it's a classification

tree<- rpart(Kyphosis ~ .,method = "class",data=kyphosis)

#examin the model
printcp(tree)

plot(tree,uniform = TRUE,main="Decision Tree")
text(tree, use.n = TRUE, all=TRUE)

#better plot
prp(tree)


#Random Forests 
rfModel<- randomForest(Kyphosis ~ ., data = kyphosis)
rfModel$predicted
rfModel$ntree
#500 is the default value of trees, a good way to know how many trees to use is doing it
# a plot of number of trees x miss classification error, just like KNN

rfModel$confusion
