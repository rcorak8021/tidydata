## Load the data labels
MyLabels <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\features.txt")
## Load the Training Data using the Data Labels as the column labels
MyTrainingData <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\train\\X_train.txt", col.names=MyLabels[,c("V2")])
## Read in the activity indices for the training data
MyTrainingDataActivyList <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\train\\y_train.txt", col.names="Activity")
## Read in the subject list for the training data
MyTrainingDataSubjectList <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\train\\subject_train.txt", col.names="Subject")

## Load the Test Data using the Data Labels as the column labels (names each column using the measure name)
MyTestData <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\test\\X_test.txt", col.names=MyLabels[,c("V2")])
## Read in the activity indices for the test data
MyTestDataActivyList <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\test\\y_test.txt", col.names="Activity")
## Read in the subject list for the test data
MyTestDataSubjectList <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\test\\subject_test.txt", col.names="Subject")

## Append the two datasets together for the data, activity and subject
AllData <- rbind(MyTrainingData, MyTestData)
AllActivityList <- rbind(MyTrainingDataActivyList, MyTestDataActivyList)
AllSubjects <- rbind(MyTrainingDataSubjectList, MyTestDataSubjectList)

## Get the column name indices that calculate just the mean or std deviation
columns <- grep(".mean()|std()", MyLabels$V2)

## create a new data table that contains only the columns that are mean or standard deviation
LessData <- AllData[,columns]

## Combine the columns from the aactivity, subject and data tables into a single data table
LessDataWithActivity <- cbind(AllActivityList, AllSubjects, LessData)

## Update the Activity column with the actual activity name instead of the activity code
##ActivityLookup <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\activity_labels.txt", col.names=c("ID","Activity"))
## For now lets do a recode instead of doing a table lookup
LessDataWithActivity$Activity <- recode(LessDataWithActivity$Activity, "1 = 'WALKING'; 2 = 'WALKING_UPSTAIRS'; 3 = 'WALKING_DOWNSTAIRS'; 4 = 'SITTING'; 5 = 'STANDING'; 6 = 'LAYING'")

## create a new tidy set that does an average for each collection of activities by subject id
## first create a list of the grouping columns
groupColumns = c("Activity","Subject")

## Calculate the average for each activity/subject combination for all the columns in the table
averages = ddply(LessDataWithActivity, groupColumns, function(x) colMeans(x[3:ncol(LessDataWithActivity)]))

write.table(averages, file = "tidydata.csv", sep = ",", row.name=FALSE)