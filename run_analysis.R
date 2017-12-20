library(reshape2)

#loading labels and feat from data

actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actLabels[,2] <- as.character(actLabels[,2])
feat <- read.table("UCI HAR Dataset/features.txt")
feat[,2] <- as.character(feat[,2])

# Extracts only the measurements on the mean and standard deviation for each measurement

featReq <- grep(".*mean.*|.*std.*", feat[,2])
featReq.names <- feat[featReq,2]
featReq.names = gsub('-mean', 'Mean', featReq.names)
featReq.names = gsub('-std', 'Std', featReq.names)
featReq.names <- gsub('[-()]', '', featReq.names)


# Load the required datasets

train <- read.table("UCI HAR Dataset/train/X_train.txt")[featReq]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featReq]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels

allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featReq.names)

# turn activities & subjects into factors

allData$activity <- factor(allData$activity, levels = actLabels[,1], labels = actLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

#export the dataset

write.table(allData.mean, "cleaneddataset.txt", row.names = FALSE, quote = FALSE)