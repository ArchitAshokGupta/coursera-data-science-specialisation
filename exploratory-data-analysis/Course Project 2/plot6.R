library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI, SCC, by="SCC")

head(NEI)
head(SCC)
head(NEISCC)

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

totBC <- filter(vehiclesNEI, fips=="24510")
totBC <- group_by(totBC, year) %>% summarize(pm25=sum(Emissions))
totLA <- filter(vehiclesNEI, fips=="06037")
totLA <- group_by(totLA, year) %>% summarize(pm25=sum(Emissions))

par(mfrow=c(1,1))
png('plot6.png')
plot(totLA$year, totLA$pm25, type='b', col='dark red', lwd=2, ylim=c(0,8000), xlab='years', ylab=expression('total PM'[2.5]*' emissions'), main=expression('Total PM'[2.5]*' Emissions from Motor Vehicle Sources in Baltimore City, Maryland and Los Angeles from 1999 to 2008'))
lines(totBC$year, totBC$pm25, type='b', col='black', lwd=2)
dev.off()
