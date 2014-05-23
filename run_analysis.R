### Getting and Cleaning Data: Final Course Project
### Jorien van den Bergh

### Data acknowledgment: [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
### This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
### Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

##############################################################################
#### 1. Merge the training and the test sets to create one data set###########
##############################################################################

# Load data sets
features <- read.table("UCI HAR Dataset/features.txt", sep=" ")
activities <- read.table("UCI HAR Dataset/activity_labels.txt", sep=" ")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", sep=" ")
testData <- read.delim("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testLabels <- read.table("UCI HAR Dataset/test/Y_test.txt", sep="\t", fill=TRUE)
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", sep=" ")
trainData <- read.delim("UCI HAR Dataset/train/X_train.txt", sep="",header=FALSE)
trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt", sep="\t", fill=TRUE)

# Merge data sets
testData2 <- cbind(testSubjects, testLabels,testData)
trainData2 <- cbind(trainSubjects, trainLabels,trainData)
allData <- rbind(testData2,trainData2)

# Name columns
colnames(features)<- c("featurenumber","featurename")
colnames(activities)<- c("activitynumber","activity")
colnames(allData)<- c("subject","activity", features$featurenumber)


####################################################################################################
#### 2. Extract only the measurements on the mean and standard deviation for each measurement#######
####################################################################################################

finalData <- allData

# Identify features with mean or std
subfeatures <- subset(features,grepl("-mean()",features$featurename, fixed=TRUE) |grepl("-std()",features$featurename, fixed=TRUE))

# Remove columns of other features
i=3
while(i <= ncol(finalData)) {
  if(!is.element(colnames(finalData)[i],subfeatures$featurenumber)) {
    finalData[,i]<- NULL
  } else {i<- i+1}
}

################################################################################
#### 3. Assign descriptive activity names to the activities in the data set#####
################################################################################

# Label the Activity column with its original activity names
finalData$activity <- factor(finalData$activity,
                           levels = c(1:6),
                           labels = activities$activity)


###############################################################
#### 4. Label the data set with descriptive feature names#####
###############################################################

# Adjust the feature names to be allowed as column names using regular expressions
subfeatures$featurename <- as.character(subfeatures$featurename) # Change factor to string
subfeatures[,2]<- gsub("\\(\\)","",subfeatures[,2]) # Remove parentheses
subfeatures[,2]<- tolower(subfeatures[,2]) # Change upper case to lower case
subfeatures[,2]<- gsub("^t","time",subfeatures[,2])  # t for time
subfeatures[,2]<- gsub("^f","frequency",subfeatures[,2])  # f for frequency
subfeatures[,2]<- gsub("acc","acceleration",subfeatures[,2]) # acc for acceleration
subfeatures[,2]<- gsub("gyro","angularvelocity",subfeatures[,2]) # gyro for angular velocity
subfeatures[,2]<- gsub("mag","magnitude",subfeatures[,2]) # mag for magnitude
subfeatures[,2]<- gsub("std","standarddeviation",subfeatures[,2]) # std for standard deviation
subfeatures[,2]<- gsub("-x","-inxdirection",subfeatures[,2]) # x for x direction
subfeatures[,2]<- gsub("-y","-inydirection",subfeatures[,2]) # y for y direction
subfeatures[,2]<- gsub("-z","-inzdirection",subfeatures[,2]) # z for z direction
subfeatures[,2]<- gsub("-","",subfeatures[,2]) # remove dashes

# Label the columns
colnames(finalData)<- c("subject","activity", subfeatures$featurename)


###########################################################################################################################
#### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.###
###########################################################################################################################

# Set number of subjects
nsubs <- 30

# Create a new data table with a row for each Subject and Activity
adjData <- matrix(NA,nrow(activities)*nsubs,ncol(finalData))
adjData <- data.frame(adjData)

# Calculate averages of variables for each activity and each subject
for(i in 1:nsubs){
  for(j in 1:nrow(activities))  {
    extract_data <- subset(finalData, finalData$subject == i & finalData$activity==activities[j,2])
    extract_data[,2]<- NULL
    extract_data[,1]<- NULL
    adjData[6*(i-1)+j,]<- c(i,as.character(activities[j,2]),as.double(colMeans(extract_data)))
  }
}

# Label columns with correct names
colnames(adjData)<- c("subject","activity", paste0(subfeatures$featurename,"average"))

########################################################
#### Export tidy data table. ##########################
########################################################

# write txt file for the tidy data set without row names
write.table(adjData, "tidyData.txt", row.names=FALSE)


######################################################
####### Jorien van den Bergh - May 2014 ##############
######################################################
