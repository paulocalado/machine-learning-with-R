#install.packages("Amelia")
library(Amelia)
library(ggplot2)
library(plotly)
library(dplyr)

#check missing data
missmap(titanic_train,main = "missing map", col = c('yellow','black'),
        legend = FALSE)

#visualizing data
ggplot(titanic_train,aes(Survived)) + geom_bar()
ggplotly()

ggplot(titanic_train,aes(Pclass)) + geom_bar(aes(fill=factor(Pclass)))
ggplotly()

ggplot(titanic_train,aes(Sex)) + geom_bar(aes(fill=factor(Sex)))
ggplotly()

ggplot(titanic_train,aes(Age))+geom_histogram(bins = 20,alpha=0.5,fill='blue')
ggplotly()

ggplot(titanic_train,aes(SibSp)) + geom_bar()
ggplotly()

ggplot(titanic_train,aes(Fare)) + geom_histogram(fill='green',color='black',
                                                 alpha=0.5)
ggplotly()

#filling missing data
ggplot(titanic_train,aes(x=Pclass,y=Age))+
  geom_boxplot(aes(group=Pclass,fill=factor(Pclass),alpha=0.4))+
  scale_y_continuous(breaks = seq(min(0),max(80),by=2))+
  theme_bw()
ggplotly()

#imputation of age based on class
impute_age <- function(age,class){
  out <- age
  for (i in 1:length(age)){
    
    if (is.na(age[i])){
      
      if (class[i] == 1){
        out[i] <- 37
        
      }else if (class[i] == 2){
        out[i] <- 29
        
      }else{
        out[i] <- 24
      }
    }else{
      out[i]<-age[i]
    }
  }
  return(out)
}

fixed.ages<- impute_age(titanic_train$Age,titanic_train$Pclass)

titanic_train$Age<- fixed.ages

missmap(titanic_train,main="Check", col = c("yellow","black"),legend = F)

titanic_train<- select(titanic_train,-PassengerId,-Name,-Ticket,-Cabin)

#titanic_train$Survived<- factor(titanic_train$Survived)
#titanic_train$Pclass<- factor(titanic_train$Pclass)
#titanic_train$Parch<- factor(titanic_train$Parch)
#titanic_train$SibSp<- factor(titanic_train$SibSp)

log.model<- glm(Survived~.,data = titanic_train,
                family = binomial(link = "logit"))
summary(log.model)

missmap(titanic_test,main = "teste",legend = F,col = c("yellow","black"))
fixed.ages<- impute_age(titanic_test$Age,titanic_test$Pclass)
titanic_test$Age<- fixed.ages
titanic_test<- select(titanic_test,-PassengerId,-Name,-Ticket,-Cabin)
#titanic_test$Pclass<- factor(titanic_test$Pclass)
#titanic_test$Parch<- factor(titanic_test$Parch)
#titanic_test$SibSp<- factor(titanic_test$SibSp)

fitted.probabilites<- predict(log.model,titanic_test,type = 'response')
#instead of having to write a whole function we just use this ifelse
titanic_test$Survived<- ifelse(fitted.probabilites>0.5,1,0)

