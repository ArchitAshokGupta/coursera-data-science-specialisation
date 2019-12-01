library(dplyr)
library(ggplot2)

# Data Processing
download.file("http://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2", destfile="Storm Data.csv.bz2")
stormData <- read.csv("Storm Data.csv.bz2")

attach(stormData)
names(stormData)

stormData <- select(stormData, EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP)
head(stormData)

stormData$PROPDMGEXP <- gsub("[Hh]", "2", stormData$PROPDMGEXP)
stormData$PROPDMGEXP <- gsub("[Kk]", "3", stormData$PROPDMGEXP)
stormData$PROPDMGEXP <- gsub("[Mm]", "6", stormData$PROPDMGEXP)
stormData$PROPDMGEXP <- gsub("[Bb]", "9", stormData$PROPDMGEXP)
stormData$PROPDMGEXP <- gsub("\\+|\\-|\\?\\ ", "0", stormData$PROPDMGEXP)
stormData$PROPDMGEXP <- as.numeric(stormData$PROPDMGEXP)
stormData$PROPDMGEXP[is.na(stormData$PROPDMGEXP)] <- 0

stormData$CROPDMGEXP <- gsub("[Hh]", "2", stormData$CROPDMGEXP)
stormData$CROPDMGEXP <- gsub("[Kk]", "3", stormData$CROPDMGEXP)
stormData$CROPDMGEXP <- gsub("[Mm]", "6", stormData$CROPDMGEXP)
stormData$CROPDMGEXP <- gsub("[Bb]", "9", stormData$CROPDMGEXP)
stormData$CROPDMGEXP <- gsub("\\+|\\-|\\?\\ ", "0", stormData$CROPDMGEXP)
stormData$CROPDMGEXP <- as.numeric(stormData$CROPDMGEXP)
stormData$CROPDMGEXP[is.na(stormData$CROPDMGEXP)] <- 0

stormData <- mutate(stormData, PROPDMGVAR=PROPDMG*(10^PROPDMGEXP), CROPDMGVAR=CROPDMG*(10^CROPDMGEXP))

# Results
victims <- summarize(group_by(stormData,EVTYPE), TOTAL_FATALITIES=sum(FATALITIES), TOTAL_INJURIES=sum(INJURIES))
victims <- mutate(victims, TOTAL_LOSS=TOTAL_FATALITIES+TOTAL_INJURIES)

arrange(victims, desc(TOTAL_FATALITIES))[1:10, 1:2]
arrange(victims, desc(TOTAL_INJURIES))[1:10, c(1,3)]
arrange(victims, desc(TOTAL_LOSS))[1:10, c(1,4)]

top10_victims <- arrange(victims, desc(TOTAL_LOSS))[1:10, c(1,4)]
g <- ggplot(data=top10_victims, aes(x=factor(EVTYPE),y=TOTAL_LOSS))
g <- g + geom_bar(stat="identity", fill="#8B0000", colour="black")
g <- g + coord_flip()
g <- g + labs(title="Total Number of Victims due to Various Weather Events")
g <- g + labs(y="Total Number of Fatalities and Injuries", x="Type of Weather Event")
g <- g + theme_bw()
print(g)

ecoImpact <- summarize(group_by(stormData, EVTYPE), TOTAL_PROPDMG=sum(PROPDMGVAR), TOTAL_CROPDMG=sum(CROPDMGVAR))
ecoImpact <- mutate(ecoImpact, TOTAL_ECO_LOSS=TOTAL_PROPDMG+TOTAL_CROPDMG)

arrange(ecoImpact, desc(TOTAL_PROPDMG))[1:10, 1:2]
arrange(ecoImpact, desc(TOTAL_CROPDMG))[1:10, c(1,3)]
arrange(ecoImpact, desc(TOTAL_ECO_LOSS))[1:10, c(1,4)]

top10_ecoImpact <- arrange(ecoImpact, desc(TOTAL_ECO_LOSS))[1:10, c(1,4)]
g <- ggplot(data=top10_ecoImpact, aes(x=factor(EVTYPE),y=TOTAL_ECO_LOSS))
g <- g + geom_bar(stat="identity", fill="#8B0000", colour="black")
g <- g + coord_flip()
g <- g + labs(title="Total Economic Loss due to Various Weather Events")
g <- g + labs(y="Total Property and Crop Damage", x="Type of Weather Event")
g <- g + theme_bw()
print(g)