# 1. Loading and preprocessing the data
activity <- read.csv("D:/Users/archigup/Downloads/activity.csv")
sapply(activity, class)

# 2. What is mean total number of steps taken per day?
totSteps <- tapply(activity$steps, activity$date, sum, na.rm=TRUE)
hist(totSteps, xlab="Total Number of Steps by Date", main="Histogram of Total Number of Steps by Date", col="black")

mean(totSteps)

median(totSteps)

# 3. What is the average daily activity pattern?
meanInterval <- tapply(activity$steps, activity$interval, mean, na.rm=TRUE)
plot(row.names(meanInterval), meanInterval, type="l", xlab="Time Interval (in minutes)", ylab="Mean Total Number of Steps", main="Mean Total Number of Steps in a Day")

maximum <- max(meanInterval)
meanInterval[match(maximum, meanInterval)]

# 4. Imputing missing values
sum(is.na(activity))

activityNA <- activity[is.na(activity),]
activityNoNA <- activity[complete.cases(activity),]
activityNA$steps <- as.numeric(meanInterval)
activityNew <- rbind(activityNA, activityNoNA)
activityNew <- activityNew[order(activityNew[,2], activityNew[,3]),]

totStepsNew <- tapply(activityNew$steps, activityNew$date, sum)
hist(totStepsNew, xlab="Total Number of Steps by Date", main="Histogram of Total Number of Steps by Date (no missing values)", col="black")

mean(totStepsNew)

median(totStepsNew)

# 5. Are there differences in activity patterns between weekdays and weekends?
weekdays <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
activityNew$DOW = as.factor(ifelse(is.element(weekdays(as.Date(activityNew$date)),weekdays), "Weekdays", "Weekends"))
meanIntervalNew <- aggregate(steps~interval+DOW, activityNew, mean)

library(lattice)
xyplot(meanIntervalNew$steps~meanIntervalNew$interval|meanIntervalNew$DOW, main="Mean Total Number of Steps (weekdays vs. weekends)", xlab="Time Interval (in minutes)", ylab="Mean Total Number of Steps", layout=c(1,2), type="l")

