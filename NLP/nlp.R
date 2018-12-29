install.packages("tm")
install.packages("twitteR")
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("class")
library(tm)
library(twitteR)
library(wordcloud)
library(RColorBrewer)
library(e1071)
library(class)


#connect to twitter
ckey<- "YGsfVzA9KoUgRfLZPXprmpJim"
skey<- "GtB2OTxLHaBxtXVOkcSydqubrLMDyfZfY0EQZx0QAsTflaGg5s"
token<- "193517110-bGlnh7kij0LBHDhviLAsqcnn0qrFEKhZM7mOaQbD"
secToken<- "jo1Koik8ugIkMHsdqA1yyUIzUjC6UDCIQivTVPZbepqsI"

setup_twitter_oauth(ckey,skey,token,secToken)

##searching twitter
soccerTweets<- searchTwitter("NFL",n=1000,lang = "en")

soccerText<- sapply(soccerTweets,function(x) x$getText())

##clean text data
soccerText<- iconv(soccerText,"UTF-8","ASCII")

soccerCorpus<- Corpus(VectorSource(soccerText))

#Document term matrix

termDocMatrix<- TermDocumentMatrix(soccerCorpus,
                                   control = list(removePunctuation=T,
                                                  stopwords=c("NFL",
                                                              "nfl",
                                                              stopwords("english")),
                                                  removeNumbers=T,
                                                  tolower=T))

#convert object into matri
termDocMatrix<- as.matrix(termDocMatrix)

#get word counts
wordFreq<- sort(rowSums(termDocMatrix),decreasing = T)
dm<- data.frame(word=names(wordFreq),freq=wordFreq)

#create the word cloud
wordcloud(dm$word,dm$freq,random.order = F,colors = brewer.pal(8,"Dark2"))
