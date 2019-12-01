library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
head(SCC)

totBC <- filter(NEI, fips=="24510") %>% group_by(year, type) %>% summarize(pm25=sum(Emissions))

png('plot3.png')
gg <- ggplot(totBC, aes(year,pm25,color=type))
gg <- gg + geom_line() + xlab('years') + ylab(expression('total PM'[2.5]*' emissions')) +
      ggtitle(expression('Total PM'[2.5]*' Emissions in Baltimore City, Maryland from 1999 to 2008'))
print(gg)
dev.off()
