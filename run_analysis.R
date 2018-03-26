##downloading the file
if (!file.exists("courseProjectData.zip"))
  {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, destfile = "./courseProjectData.zip") ##include (, method="curl") in case of MacBook
  }  
##unzipping the file
if (!file.exists("UCI HAR Dataset")) 
  { 
  unzip("courseProjectData.zip") 
  }


##1. Merging the training and the test sets to create one data set.
install.packages("plyr")
library(plyr)
##reading train data
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
sub_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

##reading test data
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
sub_Test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

##Combine X_Data
xData <- rbind(xTrain, xTest)
##Combine Y_Data
yData <- rbind(yTrain, yTest)
##Combine Sub_Data
sub_Data <- rbind(sub_Train, sub_Test)


##2. Extract only the measurements on the mean and standard deviation.

#reading features data
fet <- read.table("./UCI HAR Dataset/features.txt")

#getting cols with mean or std in their bnames only
m_St_Fet <- grep("-(mean|std)\\(\\)", fet[, 2])

#subset needed cols
xData <- xData[, m_St_Fet]

#define new names to xData
names(xData) <- fet[m_St_Fet, 2]


##3. Uses descriptive activity names to name the activities in the data set

#reading activity_labels.txt
actv <- read.table("./UCI HAR Dataset/activity_labels.txt")

#assining activity names to the values
yData[, 1] <- actv[yData[, 1], 2]

#assing new col name
names(yData) <- "activity"


##4. Appropriately labels the data set with descriptive variable names.
#new col name
names(sub_Data) <- "subject"

#combinig a asingle data set
wholeData <- cbind(xData, yData, sub_Data)


##5. From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject.

#using ddply to return results into a new data frame
avg_Data <- ddply(wholeData, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(avg_Data, "AverageData.txt", row.names = FALSE, quote = FALSE)