library(dplyr) 
library(lubridate)

# Rough estimate of the amount of memory the dataset will require
# 2,075,259 * 9 * (8 bytes/numeric) = 149418648 / ((2 ^ 20) bytes/MB) = 142.4967 MB

# Reading in the data subset directly
data_subset <- read.table("C:/Users/Admin/Desktop/Courses/Exploratory Data Analysis/Course Project 1/household power consumption/household_power_consumption - subset.txt", sep=";", header=TRUE, na.strings="?")
attach(data_subset)

head(data_subset) # Checking the top six rows to see if the data is properly loaded
tail(data_subset) # Checking the bottom six rows to see if the data is properly loaded

data_subset <- mutate(data_subset, Date=as.Date(Date), Time=hms(Time)) # Converting the class of Date column to Date class and Time column using lubridate package 
class(data_subset$Date); class(data_subset$Time) # Checking to see whether the conversion happened properly 
# data_subset <- mutate(data_subset, Date=as.Date(Date), Time=as.POSIXct(strptime(Time, "%Y:%M:%S"))) A second method to convert the class of Time column without using the lubridate package

png("plot2.png", width=480, height=480) # For saving the plot to a PNG file with a width of 480 pixels and a height of 480 pixels
hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power") # Generating the histogram
dev.off()

 
