# tidydata
Tidy Data Programming Assignment
# Description of R Script

## 1) Load the data labels
MyLabels <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\features.txt")
## 2) Load the Training Data using the Data Labels as the column labels
MyTrainingData <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\train\\X_train.txt", col.names=MyLabels[,c("V2")])
## 3) Read in the activity indices for the training data
MyTrainingDataActivyList <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\train\\y_train.txt", col.names="Activity")
## 4) Read in the subject list for the training data
MyTrainingDataSubjectList <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\train\\subject_train.txt", col.names="Subject")

## 5) Load the Test Data using the Data Labels as the column labels (names each column using the measure name)
MyTestData <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\test\\X_test.txt", col.names=MyLabels[,c("V2")])
## 6) Read in the activity indices for the test data
MyTestDataActivyList <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\test\\y_test.txt", col.names="Activity")
## 7) Read in the subject list for the test data
MyTestDataSubjectList <- read.table("C:\\Users\\rcorak\\Documents\\MyRStuff\\UCI HAR Dataset\\test\\subject_test.txt", col.names="Subject")

## 8) Append the two datasets together for the data, activity and subject
AllData <- rbind(MyTrainingData, MyTestData)
AllActivityList <- rbind(MyTrainingDataActivyList, MyTestDataActivyList)
AllSubjects <- rbind(MyTrainingDataSubjectList, MyTestDataSubjectList)

## 9) Get the column name indices that calculate just the mean or std deviation
columns <- grep(".mean()|std()", MyLabels$V2)

## 10) create a new data table that contains only the columns that are mean or standard deviation
LessData <- AllData[,columns]

## 11) Combine the columns from the aactivity, subject and data tables into a single data table
LessDataWithActivity <- cbind(AllActivityList, AllSubjects, LessData)

## 12) Update the Activity column with the actual activity name instead of the activity code
LessDataWithActivity$Activity <- recode(LessDataWithActivity$Activity, "1 = 'WALKING'; 2 = 'WALKING_UPSTAIRS'; 3 = 'WALKING_DOWNSTAIRS'; 4 = 'SITTING'; 5 = 'STANDING'; 6 = 'LAYING'")

## 13) create a new tidy set that does an average for each collection of activities by subject id
## first create a list of the grouping columns
groupColumns = c("Activity","Subject")

## 14) Calculate the average for each activity/subject combination for all the columns in the table
averages = ddply(LessDataWithActivity, groupColumns, function(x) colMeans(x[3:ncol(LessDataWithActivity)]))

## 15) Write the table into a data file
write.table(averages, file = "tidydata.csv", sep = ",", row.name=FALSE)

## Tidy Data Field Definition 
|Field                                   |Description                                     |Type    |
|----------------------------------------|------------------------------------------------|--------|
|Activity                                | Activity Subject is Performing                 | String |
|Subject                                 | ID of Subject                                  | String |
| tBodyAcc.mean...X                      | Body Accelerator Mean - X Axis                 | float  |
| tBodyAcc.mean...Y                      | Body Accelerator Mean - Y Axis                 | float  |
| tBodyAcc.mean...Z                      | Body Accelerator Mean - Z Axis                 | float  |
| tBodyAcc.std...X                       | Body Accelerator Std Deviation - X Axis        | float  |
| tBodyAcc.std...Y                       | Body Accelerator Std Deviation - Y Axis        | float  |
| tBodyAcc.std...Z                       | Body Accelerator Std Deviation - Z Axis        | float  |
| tGravityAcc.mean...X                   | Gravity Accelerator Mean - X Axis              | float  |
| tGravityAcc.mean...Y                   | Gravity Accelerator Mean - Y Axis              | float  |
| tGravityAcc.mean...Z                   | Gravity Accelerator Mean - Z Axis              | float  |
| tGravityAcc.std...X                    | Gravity Accelerator Std Deviation - X Axis     | float  |
| tGravityAcc.std...Y                    | Gravity Accelerator Std Deviation - Y Axis     | float  |
| tGravityAcc.std...Z                    | Gravity Accelerator Std Deviation - Z Axis     | float  |
| tBodyAccJerk.mean...X                  | Body Accelerator Jerk Mean - X Axis            | float  |
| tBodyAccJerk.mean...Y                  | Body Accelerator Jerk Mean - Y Axis            | float  |
| tBodyAccJerk.mean...Z                  | Body Accelerator Jerk Mean - Z Axis            | float  |
| tBodyAccJerk.std...X                   | Body Accelerator Jerk Std Deviation - X Axis   | float  |
| tBodyAccJerk.std...Y                   | Body Accelerator Jerk Std Deviation - Y Axis   | float  |
| tBodyAccJerk.std...Z                   | Body Accelerator Jerk Std Deviation - Z Axis   | float  |
| tBodyGyro.mean...X                     | Body Gyro Mean - X Axis                        | float  |
| tBodyGyro.mean...Y                     | Body Gyro Mean - Y Axis                        | float  |
| tBodyGyro.mean...Z                     | Body Gyro Mean - Z Axis                        | float  |
| tBodyGyro.std...X                      | Body Gyro Std Deviation - X Axis               | float  |
| tBodyGyro.std...Y                      | Body Gyro Std Deviation - Y Axis               | float  |
| tBodyGyro.std...Z                      | Body Gyro Std Deviation - Z Axis               | float  |
| tBodyGyroJerk.mean...X                 | Body Gyro Jerk Mean - X Axis                   | float  |
| tBodyGyroJerk.mean...Y                 | Body Gyro Jerk Mean - Y Axis                   | float  |
| tBodyGyroJerk.mean...Z                 | Body Gyro Jerk Mean - Z Axis                   | float  |
| tBodyGyroJerk.std...X                  | Body Gyro Jerk Std Deviation - X Axis          | float  |
| tBodyGyroJerk.std...Y                  | Body Gyro Jerk Std Deviation - Y Axis          | float  |
| tBodyGyroJerk.std...Z                  | Body Gyro Jerk Std Deviation - Z Axis          | float  |
| tBodyAccMag.mean..                     | Body Accelerator Mag Mean                      | float  |
| tBodyAccMag.std..                      | Body Accelerator Mag Std Deviation             | float  |
| tGravityAccMag.mean..                  | Gravity Accelerator Mag Mean                   | float  |
| tGravityAccMag.std..                   | Gravity Accelerator Mag Std Deviation          | float  |
| tBodyAccJerkMag.mean..                 | Body Accelerator Jerk Mag Mean                 | float  |
| tBodyAccJerkMag.std..                  | Body Accelerator Jerk Mag Std Deviation        | float  |
| tBodyGyroMag.mean..                    | Body Gyro Mag Mean                             | float  |
| tBodyGyroMag.std..                     | Body Gyro Mag Std Deviation                    | float  |
| tBodyGyroJerkMag.mean..                | Body Gyro Jerk Mag Mean                        | float  |
| tBodyGyroJerkMag.std..                 | Body Gyro Jerk Mag Std Deviation               | float  |
| fBodyAcc.mean...X                      | Body Accelerator Mean - X Axis                 | float  |
| fBodyAcc.mean...Y                      | Body Accelerator Mean - Y Axis                 | float  |
| fBodyAcc.mean...Z                      | Body Accelerator Mean - Z Axis                 | float  |
| fBodyAcc.std...X                       | Body Accelerator Std Deviation - X Axis        | float  |
| fBodyAcc.std...Y                       | Body Accelerator Std Deviation - Y Axis        | float  |
| fBodyAcc.std...Z                       | Body Accelerator Std Deviation - Z Axis        | float  |
| fBodyAcc.meanFreq...X                  | Body Accelerator Mean Frequency - X Axis       | float  |
| fBodyAcc.meanFreq...Y                  | Body Accelerator Mean Frequency- Y Axis        | float  |
| fBodyAcc.meanFreq...Z                  | Body Accelerator Mean Frequency - Z Axis       | float  |
| fBodyAccJerk.mean...X                  | Body Accelerator Jerk Mean - X Axis            | float  |
| fBodyAccJerk.mean...Y                  | Body Accelerator  Jerk Mean - Y Axis           | float  |
| fBodyAccJerk.mean...Z                  | Body Accelerator  Jerk Mean - Z Axis           | float  |
| fBodyAccJerk.std...X                   | Body Accelerator Jerk Std Deviation - X Axis   | float  |
| fBodyAccJerk.std...Y                   | Body Accelerator  Jerk  Std Deviation  - Y Axis| float  |
| fBodyAccJerk.std...Z                   | Body Accelerator  Jerk  Std Deviation  - Z Axis| float  |
| fBodyAccJerk.meanFreq...X              | Body Accelerator Jerk Mean Frequency - X Axis  | float  |
| fBodyAccJerk.meanFreq...Y              | Body Accelerator Jerk Mean Frequency- Y Axis   | float  |
| fBodyAccJerk.meanFreq...Z              | Body Accelerator Jerk Mean Frequency - Z Axis  | float  |
| fBodyGyro.mean...X                     | Body Gyro Mean - X Axis                        | float  |
| fBodyGyro.mean...Y                     | Body Gyro Mean - Y Axis                        | float  |
| fBodyGyro.mean...Z                     | Body Gyro Mean - Z Axis                        | float  |
| fBodyGyro.std...X                      | Body Gyro Std Deviation - X Axis               | float  |
| fBodyGyro.std...Y                      | Body Gyro Std Deviation - Y Axis               | float  |
| fBodyGyro.std...Z                      | Body Gyro Std Deviation - Z Axis               | float  |
| fBodyGyro.meanFreq...X                 | Body Gyro Mean Frequency - X Axis              | float  |
| fBodyGyro.meanFreq...Y                 | Body Gyro Mean Frequency - Y Axis              | float  |
| fBodyGyro.meanFreq...Z                 | Body Gyro Mean Frequency - Z Axis              | float  |
| fBodyAccMag.mean..                     | Body Accelerator Mean                          | float  |
| fBodyAccMag.std..                      | Body Accelerator Std Deviation                 | float  |
| fBodyAccMag.meanFreq..                 | Body Accelerator Mean Frequency                | float  |
| fBodyBodyAccJerkMag.mean..             | Body Accelerator Jerk Mag Mean                 | float  |
| fBodyBodyAccJerkMag.std..              | Body Accelerator Jerk Mag Std Deviation        | float  |
| fBodyBodyAccJerkMag.meanFreq..         | Body Accelerator Jerk Mag Mean Frequency       | float  |
| fBodyBodyGyroMag.mean..                | Body Gyro Mag Mean                             | float  |
| fBodyBodyGyroMag.std..                 | Body Gyro Mag Std Deviation                    | float  |
| fBodyBodyGyroMag.meanFreq..            | Body Gyro Mag Mean Frequency                   | float  |
| fBodyBodyGyroJerkMag.mean..            | Body Gyro Jerk Mag Mean                        | float  |
| fBodyBodyGyroJerkMag.std..             | Body Gyro Jerk Mag Std Deviation               | float  |
| fBodyBodyGyroJerkMag.meanFreq..        | Body Gyro Jerk Mag Mean Frequency              | float  |

