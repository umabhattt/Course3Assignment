xTest = read.table("/Users/rose/Documents/Course 3/UCI HAR Dataset/test/X_test.txt")
yTest = read.table("/Users/rose/Documents/Course 3/UCI HAR Dataset/test/Y_test.txt")
xTrain = read.table("/Users/rose/Documents/Course 3/UCI HAR Dataset/train/X_train.txt")
yTrain = read.table("/Users/rose/Documents/Course 3/UCI HAR Dataset/train/Y_train.txt")

features = read.table("/Users/rose/Documents/Course 3/UCI HAR Dataset/features.txt")
subjectTest = read.table("/Users/rose/Documents/Course 3/UCI HAR Dataset/test/subject_test.txt")
subjectTrain = read.table("/Users/rose/Documents/Course 3/UCI HAR Dataset/train/subject_train.txt")
activityName = read.table("/Users/rose/Documents/Course 3/UCI HAR Dataset/activity_labels.txt")

library(dplyr)


#adding subject ids to the test and train datasets (using the y data)
colnames(subjectTest)[1] <- 'ID'
colnames(yTest)[1] <- 'ACTIVITY'

yTest = cbind(yTest, subjectTest)

colnames(subjectTrain)[1] <- 'ID'
colnames(yTrain)[1] <- 'ACTIVITY'

yTrain = cbind(yTrain, subjectTrain)

#combining the x test and x train together by rows
xData = rbind(xTest,xTrain)

#replacing the "v1, v2" column names with the activity feature names
newnames <- data.frame(names = c(features$V2))
new_column_names <- newnames$names
colnames(xData) <- c(new_column_names)


#combining the y test and y train together by rows
yData = rbind(yTest,yTrain)

#combining both datasets, by column
fullData = cbind(xData,yData)

#extracted for mean and std columns only
extractedData <- fullData[, grep("mean|std|ID|ACTIVITY", names(fullData), ignore.case = TRUE)]

#Replaces the activity numbers with the actual name of the activity
activityNameMapper = function(x) {
  activityName$V2[x]
}

extractedData$ACTIVITY = lapply(extractedData$ACTIVITY, activityNameMapper)

#create a second, independent tidy data set with the average of each variable for each activity and 
#each subject.

averages <- extractedData %>%
  group_by(ID, ACTIVITY) %>%
  summarise(across(where(is.numeric), mean, na.rm = TRUE))

