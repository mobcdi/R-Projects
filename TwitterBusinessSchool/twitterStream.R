
api_key <- "DRpic1VCPPKaus47iH76IO1sY"
api_secret <- "1OGCdLEsVul8QbFdt4ISaddn2ZRuSgFDfwin5XhNeKAmSURC8g"
access_token <- "3350763981-2WQuYaElknBvLMco2VDbeP37AFT6bo0WBjMotbh"
access_secret <- "AugUsNliEBAdYhkRqdQ4G0fQTHYZLzcRJi6wOT2QJfByV"

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- api_key
consumerSecret <- api_secret
my_oauth <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret, requestURL=requestURL,
                             accessURL=accessURL, authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
save(my_oauth, file="Authentication/my_oauth")


#set working directory to where the object my_oauth is saved i.e. along with the other files in project folder
setwd("~/R Working Directory/Twitter")
#smappR is not in cran but https://github.com/SMAPPNYU/ has instructions for installing it from github
library(smappR)
library(streamR)
#Get all the tweets sent by KBS (max 3200) and store it in a JSON
temp <-getTimeline(screen_name = "BusinessAtUL",filename = "UL_tweets.json",n=3200,oauth_folder="~/R Working Directory/Twitter/Authentication")
#Parse it into a dataframe
KBSDF <- parseTweets("UL_tweets.json")

#Get all the tweets sent by DCU (max 3200) and store it in a JSON
getTimeline(screen_name = "dcubs",filename = "DCU_tweet.json",n=3200,oauth_folder="~/R Working Directory/Twitter/Authentication")
#Parse it into a dataframe
DCUDF <- parseTweets("DCU_tweet.json")

#Get all the tweets sent by SmurfitSchool (max 3200) and store it in a JSON
getTimeline(screen_name = "SmurfitSchool",filename = "SmurfitSchool_tweet.json",n=3200,oauth_folder="~/R Working Directory/Twitter/Authentication")
#Parse it into a dataframe
SmurfitDF <- parseTweets("SmurfitSchool_tweet.json")

#Get all the tweets sent by CBLUCC (max 3200) and store it in a JSON
getTimeline(screen_name = "CBLUCC",filename = "CBLUCC_tweet.json",n=3200,oauth_folder="~/R Working Directory/Twitter/Authentication")
#Parse it into a dataframe
UCCDF <- parseTweets("CBLUCC_tweet.json")

#Get all the tweets sent by NUIG (max 3200) and store it in a JSON
getTimeline(screen_name = "NUIGCairnes",filename = "NUIG_tweet.json",n=3200,oauth_folder="~/R Working Directory/Twitter/Authentication")
#Parse it into a dataframe
NUIGDF <- parseTweets("NUIG_tweet.json")

hashtags <-rm_hash(KBSDF$text, extract=TRUE, clean=TRUE, trim=TRUE)


KBSDF <- mutate(KBSDF,created_dow = weekdays(created_at))


#Playing with time series
temp <- select(KBSDF,id_str,created_at)
temp.zoo <-zoo(temp)
# aggregate to monthly averages
yearmon <- format(time(temp$created_at), "%Y-%m") # create a vector of months
co2.mon <- aggregate(temp.zoo, by=list("created_at"), FUN=sum, na.rm=TRUE)
