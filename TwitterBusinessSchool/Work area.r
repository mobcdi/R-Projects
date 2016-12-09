


#Delete a dataframe
rm(SmurfitCount)


df2 <- data.frame("Account",strftime(KBSDF$created_at, format = "%Y-%m"))
colnames(df2) <- c("Tweeter","TimePeriod")
KBSresult <- aggregate(df2$Tweeter, by = list(df2$TimePeriod), FUN = length)
KBSresult <- mutate(KBSresult,Account ="KBS")
colnames(KBSresult) <- c("TimePeriod","Tweets","Tweeter")

#Delete the temp dataframe so its safe to reuse
rm(df2)

UCCDF <- mutate(UCCDF,created_at = as.POSIXct(created_at, format="%a %b %d %H:%M:%S %z %Y"))
df2 <- data.frame("Account",strftime(UCCDF$created_at, format = "%Y-%m"))
colnames(df2) <- c("Tweeter","TimePeriod")
UCCresult <- aggregate(df2$Tweeter, by = list(df2$TimePeriod), FUN = length)
UCCresult <- mutate(UCCresult,Account =unique("UCC"))
colnames(UCCresult) <- c("TimePeriod","Tweets","Tweeter")

#Delete the temp dataframe so its safe to reuse
rm(df2)

DCUDF <- mutate(DCUDF,created_at = as.POSIXct(created_at, format="%a %b %d %H:%M:%S %z %Y"))
df2 <- data.frame("Account",strftime(DCUDF$created_at, format = "%Y-%m"))
colnames(df2) <- c("Tweeter","TimePeriod")
DCUCount <- aggregate(df2$Tweeter, by = list(df2$TimePeriod), FUN = length)
DCUCount <- mutate(DCUCount,Account =unique("DCU"))
colnames(DCUCount) <- c("TimePeriod","Tweets","Tweeter")

#Delete the temp dataframe so its safe to reuse
rm(df2)
#SmurfitSchool
SmurfitDF <- mutate(SmurfitDF,created_at = as.POSIXct(created_at, format="%a %b %d %H:%M:%S %z %Y"))
df2 <- data.frame("Account",strftime(SmurfitDF$created_at, format = "%Y-%m"))
colnames(df2) <- c("Tweeter","TimePeriod")
SmurfitCount <- aggregate(df2$Tweeter, by = list(df2$TimePeriod), FUN = length)
SmurfitCount <- mutate(SmurfitCount,Account =unique("Smurfit"))
colnames(SmurfitCount) <- c("TimePeriod","Tweets","Tweeter")

#Delete the temp dataframe so its safe to reuse
rm(df2)
#NUIGSchool
NUIGDF <- mutate(NUIGDF,created_at = as.POSIXct(created_at, format="%a %b %d %H:%M:%S %z %Y"))
df2 <- data.frame("Account",strftime(NUIGDF$created_at, format = "%Y-%m"))
colnames(df2) <- c("Tweeter","TimePeriod")
NUIGCount <- aggregate(df2$Tweeter, by = list(df2$TimePeriod), FUN = length)
NUIGCount <- mutate(NUIGCount,Account =unique("NUIG"))
colnames(NUIGCount) <- c("TimePeriod","Tweets","Tweeter")

ggplot(KBSresult, aes(x = TimePeriod, y = Tweets, group = Tweeter, color = Tweeter)) + 
  geom_line(size = 1) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

#Try merging datasets together
rm(combined)
combined <- bind_rows(UCCresult, KBSresult,DCUCount,SmurfitCount,NUIGCount)

#Colours
MyColours
names(MyColours)<- c("UCC", "Smurfit","DCU","KBS","NUIG")
unique(combined$Tweeter)
ggplot(combined, aes(x = TimePeriod, y = Tweets, group = Tweeter, color = scale_fill_manual(values = MyColours))) + 
  geom_line(size = 1) + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))

#TEMP Dataset
MyColour <- c("#FF0000", "#00FF00", "#0000FF") 
names(MyColour) <- c("Mazda RX4", "Toyota Corolla", "Fiat 128")

Account <- c('Mazda RX4','Toyota Corolla','Mazda RX4','Toyota Corolla')
CountOfItems <- c(14, 120, 23,345)
TimePeriod <- c('2010-12','2011-01','2011-01','2011-02')
MyData <- data.frame(Account, CountOfItems, TimePeriod)
ggplot(MyData, aes(x = TimePeriod, y = CountOfItems, group = Account, color = Account)) + geom_line(size = 1) + scale_color_manual(values = MyColours)
