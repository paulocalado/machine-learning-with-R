v<- c(1,2,3)
matriz<- matrix(1:10, nrow = 2)
df<- mtcars

myList<- list(v, matriz, df)
myList

myList[[1]][2]

myList<- list(vetor = v, matriz = matriz, data.frame = df)

myList$matriz[2,4]
myList$data.frame$mpg
