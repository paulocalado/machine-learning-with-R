library(dplyr)
library(Amelia)
library(ggplot2)
library(plotly)
library(caTools)
adult_sal<-adult_sal[,-1]

table(adult_sal$type_employer)
#After seeing the table, we should combine Never-worked and without-pay as unemployed
#let's create a function to do that

unemp<- function(job){
  job<- as.character(job)
  
  if(job=="Never-worked" | job=="Without-pay"){
    return("Unemployed")
  }else if(job=="State-gov" | job=="Local-gov"){
    return("SL-gov")
  }else if(job=="Self-emp-inc" | job=="Self-emp-not-inc"){
    return("self-emp")
  }else{
    return(job)
  }
}

adult_sal$type_employer<- sapply(adult_sal$type_employer,unemp)
table(adult_sal$type_employer)

#we can combine Self-emp-inc and Self-emp-not-inc into self employed peope
#as well as we can combine State-gov and Local-gov as one factor so we can have a more simple
#dataset. I`m going to update the unemp in order to do that

adult_sal$type_employer<- sapply(adult_sal$type_employer,unemp)
table(adult_sal$type_employer)

#Checking marital status
table(adult_sal$marital)

#Let`s reduce the marital status to 3 single groups: Married, Not-Married, Never-married
marital_status<- function(status){
  status<- as.character(status)
  if(status=="Divorced"|status=="Separated"|status=="Widowed"){
    return("Not-Married")
  }else if(status=="Never-married"){
    return(status)
  }else {
    return("Married")
  }
}

adult_sal$marital<- sapply(adult_sal$marital,marital_status)
table(adult_sal$marital)

###LET`S CHECK THE COUNTRY COLUMN
table(adult_sal$country)

##Let`s group as continents
Asia <- c('China','Hong','India','Iran','Cambodia','Japan', 'Laos' ,
          'Philippines' ,'Vietnam' ,'Taiwan', 'Thailand')

North.America <- c('Canada','United-States','Puerto-Rico' )

Europe <- c('England' ,'France', 'Germany' ,'Greece','Holand-Netherlands','Hungary',
            'Ireland','Italy','Poland','Portugal','Scotland','Yugoslavia')

Latin.and.South.America <- c('Columbia','Cuba','Dominican-Republic','Ecuador',
                             'El-Salvador','Guatemala','Haiti','Honduras',
                             'Mexico','Nicaragua','Outlying-US(Guam-USVI-etc)','Peru',
                             'Jamaica','Trinadad&Tobago')
Other <- c('South')

group_country <- function(ctry){
  if (ctry %in% Asia){
    return('Asia')
  }else if (ctry %in% North.America){
    return('North.America')
  }else if (ctry %in% Europe){
    return('Europe')
  }else if (ctry %in% Latin.and.South.America){
    return('Latin.and.South.America')
  }else{
    return('Other')      
  }
}

adult_sal$country <- sapply(adult_sal$country,group_country)
table(adult_sal$country)

#Refactor the columns that we changed
adult_sal$country<- factor(adult_sal$country)
adult_sal$type_employer<- factor(adult_sal$type_employer)
adult_sal$marital<- factor(adult_sal$marital)

#Missing Data
adult_sal[adult_sal=="?"]<- NA

table(adult_sal$type_employer)
#Just to get rid of the ? factor

adult_sal$country<- factor(adult_sal$country)
adult_sal$type_employer<- factor(adult_sal$type_employer)
adult_sal$marital<- factor(adult_sal$marital)

missmap(adult_sal,y.at = c(1),y.labels = c(''),col = c("yellow","black"))

#drop NA data since there are just a few
adult_sal<- na.omit(adult_sal)

###explore data with visualization
ggplot(adult_sal,aes(age)) + geom_histogram(aes(fill=income),color='black',binwidth=1)+
  theme_bw()

ggplot(adult_sal,aes(hr_per_week)) + geom_histogram()+theme_bw()

#rename country to region
adult_sal<- rename(adult_sal,region=country)

ggplot(adult_sal,aes(region)) + geom_bar(aes(fill=income),color='black')+
  theme_bw()

#LOGISTIC REGRESSION MODEL

#TRAIN TEST SPLIT
set.seed(101) #just so the split can look like the video ones

#can pass any column but is good to use the one you're trying to predict
sample<- sample.split(adult_sal$income, SplitRatio = 0.7) 

train<- subset(adult_sal,sample==T)
test<- subset(adult_sal,sample==F)

model<- glm(income ~ .,family = binomial("logit"),data=train)

summary(model)

#step function tries to remove predictive variables from the model, to delete variables that do not
#signifincally add to the fit

new.step.model<- step(model)

#shows which variables to keep, in this case it chosen all the previous one
summary(new.step.model)

#predicting variables
test$predicted.income<- predict(model, newdata = test,type = 'response')

#confusion matrix
table(test$income,test$predicted.income >0.5)

#accuracy of the model
acc<- (6394+1429)/(6394+526+966+1429)

#recall
recall<- 6394/(6394+526)

#precision
precision<- 6394/(6394+866)

#we do not have a good opinion wether or not this was a good model
