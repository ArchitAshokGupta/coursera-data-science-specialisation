library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

years <- group_by(NEI, year) %>% summarize(pm25=sum(Emissions))

par(mfrow=c(1,1))
png('plot1.png')
plot(years$year, years$pm25, type='b', col='red', lwd=2, xlab='years', ylab=expression('total PM'[2.5]*' emissions'), main=expression('Total PM'[2.5]*' Emissions from 1999 to 2008'))
dev.off()
