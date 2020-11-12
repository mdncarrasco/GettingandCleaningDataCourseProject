getDataSet <- function() {
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  destfile <- "Dataset.zip"
  
  if(!file.exists(destfile)){
    download.file(url,destfile,method = "curl")
    dataDownloaded <- date()
  }
  
  unzip(destfile)
}

getFeature <- function() {
  destfile <- "./UCI HAR Dataset/features.txt"
  
  if(!file.exists(destfile)){
    print("Downsload an unzip UCI HAR Dataset")
    getDataSet()
  }
  cnames <- c("id","feature")
  
  features <- read.delim2(destfile, header = FALSE, sep = "", col.names = cnames)
  
  features$feature <- tolower(features$feature)
  features$feature <- gsub("-"," ",features$feature)
  features$feature <- gsub("[()]","",features$feature)
  features$feature <- gsub("tbody","time body ",features$feature)
  features$feature <- gsub("fbody","frequency body ",features$feature)
  features$feature <- gsub("tgravity","time gravity ",features$feature)
  features$feature <- gsub("gyro"," gyroscope ",features$feature)
  features$feature <- gsub("acc","acceleration ",features$feature)
  features$feature <- gsub("mag"," magnitude ",features$feature)
  features$feature <- gsub("  "," ",features$feature)
  features
}

getActivities <- function() {
  destfile <- "./UCI HAR Dataset/activity_labels.txt"
  
  if(!file.exists(destfile)){
    print("Downsload an unzip UCI HAR Dataset")
    getDataSet()
  }
  cnames <- c("id","activity")
  
  activity <- read.delim2(destfile, header = FALSE, sep = "", col.names = cnames)
  activity$activity <- tolower(activity$activity)
  activity$activity <- gsub("_"," ",activity$activity)
  activity
}

getTest <- function() {
  destfile <- "./UCI HAR Dataset/test/X_test.txt"
  
  if(!file.exists(destfile)){
    print("Downsload an unzip UCI HAR Dataset")
    getDataSet()
  }
  features <- getFeature()
  cnames <- features$feature

  test <- read.delim2(destfile, header = FALSE, sep = "", col.names = cnames)
  test
}

getTestActivities <- function() {
  destfile <- "./UCI HAR Dataset/test/y_test.txt"
  
  if(!file.exists(destfile)){
    print("Downsload an unzip UCI HAR Dataset")
    getDataSet()
  }
  cnames <- c("id")

  testActivities <- read.delim2(destfile, header = FALSE, sep = "", col.names = cnames)
  
  activities <- getActivities()
  getActivity <- function(x) { activities$activity[x]}
  
  testActivities$Activity <- sapply(testActivities,getActivity)
  dim(testActivities$Activity) <- c(length(testActivities$Activity))
  testActivities
}

getTestSubject <- function() {
  destfile <- "./UCI HAR Dataset/test/subject_test.txt"
  
  if(!file.exists(destfile)){
    print("Downsload an unzip UCI HAR Dataset")
    getDataSet()
  }
  cnames <- c("subject")
  
  testSubject <- read.delim2(destfile, header = FALSE, sep = "", col.names = cnames)
  testSubject
}

makeTidyTest <- function() {
  tests <- getTest()
  testactivities <- getTestActivities()
  testsubject <- getTestSubject()
  
  tests <- cbind(subject = testsubject$subject,activity = testactivities$Activity,tests)
  
  tests
}

getTrain <- function() {
  destfile <- "./UCI HAR Dataset/train/X_train.txt"
  
  if(!file.exists(destfile)){
    print("Downsload an unzip UCI HAR Dataset")
    getDataSet()
  }
  features <- getFeature()
  cnames <- features$feature

  test <- read.delim2(destfile, header = FALSE, sep = "", col.names = cnames)
  test
}

getTrainActivities <- function() {
  destfile <- "./UCI HAR Dataset/train/y_train.txt"
  
  if(!file.exists(destfile)){
    print("Download an unzip UCI HAR Dataset")
    getDataSet()
  }
  cnames <- c("id")
  
  testActivities <- read.delim2(destfile, header = FALSE, sep = "", col.names = cnames)
  
  activities <- getActivities()
  
  getActivity <- function(x) { activities$activity[x]}
  
  testActivities$Activity <- sapply(testActivities,getActivity)
  dim(testActivities$Activity) <- c(length(testActivities$Activity))
  testActivities
}

getTrainSubject <- function() {
  destfile <- "./UCI HAR Dataset/train/subject_train.txt"
  
  if(!file.exists(destfile)){
    print("Download an unzip UCI HAR Dataset")
    getDataSet()
  }
  cnames <- c("subject")
  
  testSubject <- read.delim2(destfile, header = FALSE, sep = "", col.names = cnames)
  testSubject
}

makeTidyTrain <- function() {
  train <- getTrain()
  trainactivities <- getTrainActivities()
  trainsubject <- getTrainSubject()
  train <- cbind(subject = trainsubject$subject,activity = trainactivities$Activity,train)

  train
}

run_analysis <- function() {
  train <- makeTidyTrain()
  test <- makeTidyTest()
  todos <- rbind(test,train)
  
  inicial <- select(todos,subject,activity)
  means <- select(todos,contains("mean"))
  stds <- select(todos,contains("std"))
  final <- cbind(inicial,means,stds)
  final[, c(3:88)] <- sapply(final[, c(3:88)], as.numeric)
  
  ig <- group_by(final,subject,activity)
  tidydata <- ig %>% summarise_all(list(mean = mean))
  
  write.table(tidydata,file="TidyDataset.txt",row.names = FALSE)
  makeCodebook(tidydata,file="CodeBook.md")
}