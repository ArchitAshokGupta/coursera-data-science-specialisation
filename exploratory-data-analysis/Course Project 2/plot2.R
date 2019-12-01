library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

totBC <- filter(NEI, fips=="24510") %>% group_by(year) %>% summarize(pm25=sum(Emissions))

par(mfrow=c(1,1))
png('plot2.png')
plot(totBC$year, totBC$pm25, type='b', col='red', lwd=2, xlab='years', ylab=expression('total PM'[2.5]*' emissions'), main=expression('Total PM'[2.5]*' Emissions in Baltimore City, Maryland from 1999 to 2008'))
dev.off()
