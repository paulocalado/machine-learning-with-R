library(ggplot2)
library(plotly)

head(Batting$AB)
head(Batting$`2B`)

Batting$BA<- Batting$H / Batting$AB
tail(Batting$BA)

Batting$OBP<- (Batting$H + Batting$BB + Batting$HBP)/(Batting$AB + Batting$BB +Batting$HBP
                                                      + Batting$SF)
Batting$X1B<- Batting$H - Batting$`2B` - Batting$`3B` - Batting$HR

Batting$SLG<- (Batting$X1B + (2*Batting$`2B`) + (3*Batting$`3B`) + (4*Batting$HR))/(Batting$AB)

Batting<- subset(Batting, yearID >=1985)

combo<- merge(Batting, salaries, by=c("playerID","yearID"))

lost_players<- subset(combo,playerID %in% c("giambja01","damonjo01","saenzol01"))

lost_players<- subset(lost_players, yearID == 2001)

lost_players<- lost_players[,c("playerID","H","2B","3B","HR","OBP","SLG","BA","AB")]

combo<- subset(combo, yearID == 2001)

pl<-ggplot(combo,aes(x=OBP,y=salary)) + geom_point()
ggplotly(pl)

combo<- subset(combo,salary<8000000 & OBP>0)

combo<- subset(combo, AB >= 450)

options<- head(arrange(combo,desc(OBP)),10)

options[,c("playerID","AB","salary","OBP")]
