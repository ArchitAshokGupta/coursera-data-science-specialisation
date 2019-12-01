# Rough estimate of the amount of memory the dataset will require
# 2,075,259 * 9 * (8 bytes/numeric) = 149418648 / ((2 ^ 20) bytes/MB) = 142.4967 MB

# Reading in the data subset directly
data_subset <- read.table("C:/Users/Admin/Desktop/Courses/Exploratory Data Analysis/Course Project 1/household power consumption/household_power_consumption - subset.txt", sep=";", header=TRUE, na.strings="?")
attach(data_subset)

head(data_subset) # Checking the top six rows to see if the data is properly loaded
tail(data_subset) # Checking the bottom six rows to see if the data is properly loaded 

# plot(Global_active_power, type="l", axis=FALSE, xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
# axis(1, at=c(1,1441,2880), labels=c("Thu","Fri","Sat"))

date_time <- strptime(paste(Date, Time, sep=" "),"%d/%m/%Y %H:%M:%S") 

png("plot2.png", width=480, height=480) # For saving the plot to a PNG file with a width of 480 pixels and a height of 480 pixels
plot(date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
