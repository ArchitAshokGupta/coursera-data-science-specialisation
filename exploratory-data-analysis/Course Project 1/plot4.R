# Rough estimate of the amount of memory the dataset will require
# 2,075,259 * 9 * (8 bytes/numeric) = 149418648 / ((2 ^ 20) bytes/MB) = 142.4967 MB

# Reading in the data subset directly
data_subset <- read.table("C:/Users/Admin/Desktop/Courses/Exploratory Data Analysis/Course Project 1/household power consumption/household_power_consumption - subset.txt", sep=";", header=TRUE, na.strings="?")
attach(data_subset)

head(data_subset) # Checking the top six rows to see if the data is properly loaded
tail(data_subset) # Checking the bottom six rows to see if the data is properly loaded 

date_time <- strptime(paste(Date, Time, sep=" "),"%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height=480) # For saving the plot to a PNG file with a width of 480 pixels and a height of 480 pixels
par(mfrow=c(2, 2)) # Creating a 2x2 display grid

plot(date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power")

plot(date_time, Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(date_time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(date_time, Sub_metering_2, type="l", col="red")
lines(date_time, Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

plot(date_time, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
