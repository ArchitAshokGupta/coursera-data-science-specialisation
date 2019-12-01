library(reshape2)

# Loading Activity Labels and Features
activityLabels <- read.table("C:/Users/Admin/Desktop/Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/activity_labels.txt")
activityLabels[, 2] <- as.character(activityLabels[, 2])
features <- read.table("C:/Users/Admin/Desktop/Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/features.txt")
features[, 2] <- as.character(features[, 2])

# Extracting only the Data on Mean and Standard Deviation
featuresNeeded <- grep(".*mean.*|.*std.*", features[,2])
featuresNeeded.names <- features[featuresNeeded, 2]
featuresNeeded.names <- gsub('-mean', 'Mean', featuresNeeded.names)
featuresNeeded.names <- gsub('-std', 'Std', featuresNeeded.names)
featuresNeeded.names <- gsub('[-()]', '', featuresNeeded.names)

# Loading Datasets
trainX <- read.table("C:/Users/Admin/Desktop/Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train/X_train.txt")[featuresNeeded]
trainY <- read.table("C:/Users/Admin/Desktop/Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("C:/Users/Admin/Desktop/Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainY, trainX)

testX <- read.table("C:/Users/Admin/Desktop/Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test/X_test.txt")[featuresNeeded]
testY <- read.table("C:/Users/Admin/Desktop/Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("C:/Users/Admin/Desktop/Courses/Getting and Cleaning Data/Course Project/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testY, testX)

# Merging Datasets and Adding Labels
data <- rbind(train, test)
colnames(data) <- c("Subject", "Activity", featuresNeeded.names)

# Turning Activities and Subjects into Factors
data$Activity <- factor(data$Activity, levels=activityLabels[,1], labels=activityLabels[,2])
data$Subject <- as.factor(data$Subject)

data.melted <- melt(data, id=c("Subject","Activity"))
data.mean <- dcast(data.melted, Subject+Activity~variable, mean)

write.table(data.mean, "tidy.txt", row.names=FALSE, quote=FALSE)
