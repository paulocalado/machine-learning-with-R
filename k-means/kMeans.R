library(ISLR)
library(ggplot2)
library(cluster)

#we're going to use the iris dataset but we won't let the algorithm see the labels

#we'll only use the labels later to evaluate the algorithm
#usually we don't have label data when we are using unsupervised learning

head(iris)

ggplot(data=iris,aes(x=Petal.Length,y=Petal.Width,color=Species))+
  geom_point()

#implementing k-means
#setting seed just to get the same results as the video
set.seed(101)

#just passing the features to simulate an unlabeled data, since we're using unsupervised learning

irisCluster<- kmeans(iris[,1:4],centers = 3,nstart = 20)

#evaluate the model
table(irisCluster$cluster,iris$Species)

#visualize the clusters
clusplot(iris,irisCluster$cluster,color=T,shade=T,labels=0,lines=0)
