state.x77
head(state.x77)
tail(state.x77)

days<- c('mon','tue','wed','thu','fri','sat','sun')
temp<- c(87,65,78,88,92,77,65)
rain<- c(T,F,T,T,F,F,T)

df<- data.frame(days,temp,rain)

df[1:4,c(1,3)]

df$days #return a vector format
df['days'] #return a data frame format

condition<- rain==T
tempCondition<- temp>80
subset(df,subset = condition)
subset(df,subset = tempCondition)

sortedTemp<- order(df$temp)
df[sortedTemp,]

any(is.na(df))
