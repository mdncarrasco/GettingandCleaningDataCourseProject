# GettingandCleaningDataCourseProject
The Getting and Cleaning Data Course Project

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project.You will be required to submit:
>
1. a tidy data set as described below
2. a link to a Github repository with your script for performing the analysis
3. codeBook.md that describes the variables, the data, and any work that you performed to clean up the data 
4. README.md that explains how all of the scripts work and how they are connected.  
>
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
> 
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

> Here are the data for the project: 

> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
> 
> You should create one R script called run_analysis.R that does the following. 
> 
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
> 
> Good luck!

# Replicate Study

To replicate CodeBook.md and TidyDataset.txt just execute in R
```R 
   source('./run_analysis.R')
   run_analysis()
```

# Code explanations

## Function getDataSet
1) Get the original Data set.
2) Unzip in the current working directory.

Here are the original Data set: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Function getFeature
1) Read features labels
2) Labeling the dataset with descriptive variable names using  tolower and sub.

## Function getActivities
1) Read activities labels 
2) Set descriptive activity names to name the activities in the data set using tolower and sub.

## Function getTest
1) Read the test data 
2) Column names is obtained from getFeature

## Function getTestActivities
1) Read the test activities 
2) Activity label is obtained from getActivities
3) Populate test activities with a descriptive activity label 

## Function getTestSubject
1) Read the test subject who performed the activity for each window sample. Its range is from 1 to 30.

## Function makeTidyTest
1) Get test data from getTest
2) Get test activities from getTestActivities
3) Get test subject from getTestSubject
4) Merge Subject with Activities and Test Data

## Function getTrain
1) Read the train data 
2) Column names is obtained from getFeature

## Function getTrainActivities
1) Read the train activities 
2) Activity label is obtained from getActivities
3) Populate train activities with a descriptive activity label

## Function getTrainSubject
1) Read the train subject who performed the activity for each window sample. Its range is from 1 to 30.

## Function makeTidyTrain
1) Get train data from getTrain
2) Get train activities from getTrainActivities
3) Get train subject from getTrainSubject
4) Merge Subject with Activities and train Data

## Function run_analysis
1) Get the train data merged with subject, activities and data.
2) Get the test data merged with subject, activities and data.
3) Merge train and test data.
4) Extracts only the measurements on the mean and standard deviation for each measurement.
5) Create a tidy data set with the average of each variable for each activity and each subject.
6) Create the CodeBook.

# Possible Improvements
Use the merge function to simplify the code.