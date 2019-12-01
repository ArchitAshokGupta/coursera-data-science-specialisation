library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI, SCC, by="SCC")

head(NEI)
head(SCC)
head(NEISCC)

coal <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC<- NEISCC[coal,]
years <- group_by(subsetNEISCC, year) %>% summarize(pm25=sum(Emissions))

par(mfrow=c(1,1))
png('plot4.png')
plot(years$year, years$pm25, type='b', col='red', lwd=2, xlab='years', ylab=expression('total PM'[2.5]*' emissions'), main=expression('Total PM'[2.5]*' Emissions from Coal Combustion Related Sources from 1999 to 2008'))
dev.off()
