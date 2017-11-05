library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)
# Declaramos las credenciales de la API de Twitter, por privacidad se han omitido las credenciales del autor
api_key <- "API KEY" # From dev.twitter.com
api_secret <- "API Secret" # From dev.twitter.com
token <- "Access token" # From dev.twitter.com
token_secret <- "Access token secret" # From dev.twitter.com
# Procedemos al web scrappin
setup_twitter_oauth(api_key, api_secret, token, token_secret)
tweetsR1 <- searchTwitter("#rod1 -from:rodalia1",n=100)
tweetsR1 <- c(tweetsR1,searchTwitter("gencat from:rodalia1",n=100))
tweetsR1.df <- twListToDF(tweetsR1)
tweetsR2 <- searchTwitter("#rod2 -from:rodalia2",n=100)
tweetsR2 <- c(tweetsR2,searchTwitter("gencat from:rodalia2",n=100))
tweetsR2.df <- twListToDF(tweetsR2)
tweetsR3 <- searchTwitter("#rod3 -from:rodalia3",n=100)
tweetsR3 <- c(tweetsR3,searchTwitter("gencat from:rodalia3",n=100))
tweetsR3.df <- twListToDF(tweetsR3)
tweetsR4 <- searchTwitter("#rod4 -from:rodalia4",n=100)
tweetsR4 <- c(tweetsR4,searchTwitter("gencat from:rodalia4",n=100))
tweetsR4.df <- twListToDF(tweetsR4)
tweetsR7 <- searchTwitter("#rod7 -from:rodalia7",n=100)
tweetsR7 <- c(tweetsR7,searchTwitter("gencat from:rodalia7",n=100))
tweetsR7.df <- twListToDF(tweetsR7)
tweetsR8 <- searchTwitter("#rod8 -from:rodalia8",n=100)
tweetsR8 <- c(tweetsR8,searchTwitter("gencat from:rodalia8",n=100))
tweetsR8.df <- twListToDF(tweetsR8)
tweetsFGCVALL <- searchTwitter("#FGCVALL -from:fgcvall",n=100)
tweetsFGCVALL <- c(tweetsFGCVALL,searchTwitter("gencat from:fgcvall",n=100))
tweetsFGCVALL.df <- twListToDF(tweetsFGCVALL)
tweetsFGCLLO <- searchTwitter("#FGCLLO -from:fgcllo",n=100)
tweetsFGCLLO <- c(tweetsFGCLLO,searchTwitter("gencat from:fgcllo",n=100))
tweetsFGCLLO.df <- twListToDF(tweetsFGCLLO)
# Contamos cantidad de tweets, si alguno de los data frames anteriores no existe escribimos directamente un 0
ntwR1 <- length(tweetsR1.df[,1])
ntwR2 <- length(tweetsR2.df[,1])
ntwR3 <- length(tweetsR3.df[,1])
ntwR4 <- length(tweetsR4.df[,1])
ntwR7 <- length(tweetsR7.df[,1])
ntwR8 <- length(tweetsR8.df[,1])
ntwFGCLLO <- length(tweetsFGCLLO.df[,1])
ntwFGCVALL <- length(tweetsFGCVALL.df[,1])
numero_tweets <- c(ntwR1, ntwR2,ntwR3,ntwR4,ntwR7,ntwR8,ntwFGCLLO,ntwFGCVALL)
# Contamos para cada linea cuantos pertenecen a avisos del organismo oficial. Todos los avisos oficiales provienen 
# de la misma cuenta, asi que filtramos por cuenta.
oficialR1 = 0
for (i in 1:length(tweetsR1.df[,1])) {
    if (tweetsR1.df[i,11] == "rodalia1") { oficialR1 = oficialR1+1 }
}
oficialR2 = 0
for (i in 1:length(tweetsR2.df[,1])) {
  if (tweetsR2.df[i,11] == "rodalia2") { oficialR1 = oficialR2+1 }
}
oficialR3 = 0
for (i in 1:length(tweetsR3.df[,1])) {
  if (tweetsR3.df[i,11] == "rodalia3") { oficialR3 = oficialR3+1 }
}
oficialR4 = 0
for (i in 1:length(tweetsR4.df[,1])) {
  if (tweetsR4.df[i,11] == "rodalia4") { oficialR4 = oficialR4+1 }
}
oficialR7 = 0
for (i in 1:length(tweetsR7.df[,1])) {
  if (tweetsR7.df[i,11] == "rodalia7") { oficialR7 = oficialR7+1 }
}
oficialR8 = 0
for (i in 1:length(tweetsR8.df[,1])) {
  if (tweetsR8.df[i,11] == "rodalia8") { oficialR8 = oficialR8+1 }
}
oficialFGCLLO = 0
for (i in 1:length(tweetsR1.df[,1])) {
  if (tweetsFGCLLO.df[i,11] == "fgcllo") { oficialFGCLLO = oficialFGCLLO+1 }
}
oficialFGCVALL = 0
for (i in 1:length(tweetsFGCVALL.df[,1])) {
  if (tweetsFGCVALL.df[i,11] == "fgcvall") { oficialFGCVALL = oficialFGCVALL+1 }
}
numero_tweets_oficial <- c(oficialR1,oficialR2,oficialR3,oficialR4,oficialR7,oficialR8,oficialFGCLLO,oficialFGCVALL)
# Creamos finalmente un data frame para luego crear el csv
linea <- c('R1','R2','R3','R4','R7','R8','FGCLLO','FGCVALL')
rodaliesBarcelona.df <- data.frame(linea,numero_tweets,numero_tweets_oficial)
write.csv(rodaliesBarcelona.df, file = "rodaliesBarcelona.csv",row.names = FALSE)