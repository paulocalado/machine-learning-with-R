library(ggplot2)

df1$label<- "red"
df2$label<- "white"

wine<- rbind(df1,df2)

ggplot(data=wine,aes(residual.sugar))+
  geom_histogram(aes(fill=label),color="black",alpha=0.7)+
  scale_fill_manual(values = c('#ae4554','#faf7ea')) + 
  theme_bw()

ggplot(data=wine,aes(citric.acid))+
  geom_histogram(aes(fill=label),color="black",alpha=0.7)+
  scale_fill_manual(values = c('#ae4554','#faf7ea')) + 
  theme_bw()

ggplot(data=wine,aes(alcohol))+
  geom_histogram(aes(fill=label),color="black", alpha=0.7)+
  scale_fill_manual(values = c('#ae4554','#faf7ea')) + 
  theme_bw()

ggplot(data=wine,aes(x=citric.acid,y=residual.sugar))+
  geom_point(aes(color=label),alpha=0.3)+
  scale_color_manual(values = c('#ae4554','#faf7ea')) + 
  theme_dark()

ggplot(data=wine,aes(x=volatile.acidity,y=residual.sugar))+
  geom_point(aes(color=label),alpha=0.3)+
  scale_color_manual(values = c('#ae4554','#faf7ea')) + 
  theme_dark()

clusData<- wine[,1:12]

wineCluster<- kmeans(clusData,centers = 2)
print(wineCluster$centers)

#evaluating (most of the cases we can't because of the unlabeled data)
table(wine$label,wineCluster$cluster)
  