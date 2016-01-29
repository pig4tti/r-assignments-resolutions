library(plyr)
# Clears objects from the workspace
rm(list = ls())

# Defines the data directory
dataDirectory <- "UCI HAR Dataset"

#' Function to load a data set for the assessement
#'
#' @param test The path to be read 
#' @param activityLabels The activity labels
#' @param features The features list
#' @param filteredFeatures The filtered features
#'
loadDataSet <- function (path, activityLabels, features, filteredFeatures) {
    # Load path subjects
    pathSubjects <- read.table(paste0(dataDirectory, "/", path, "/subject_", path, ".txt"), col.names = c("SubjectID"))
    
    # Load path activities
    pathActivities <- read.table(paste0(dataDirectory, "/", path, "/y_", path, ".txt"), col.names = c("ActivityID"))
    
    # Replace the activities IDs by their labels
    ActivityName <- join(pathActivities, activityLabels)$Label
    
    # Load path activities
    message(paste("Loading data file under:", path))
    pathData <- read.table(paste0(dataDirectory, "/", path, "/x_", path, ".txt"), col.names = features$FeatureLabel)[filteredFeatures]
    message("File loaded, continuing...")
    
    joinedData <- cbind(pathSubjects, ActivityName, pathData)
    
    joinedData
}

runAnalisys <- function () {
    
    
    
    # This will download an extract the zip file containing the dataset to a kwnon location under your current
    # working directory and then delete the zip file
    if (!file.exists(dataDirectory)) {
        tmp_file <- "./temp.zip"
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" ,tmp_file, method="curl")
        unzip(tmp_file, exdir="./")
        unlink(tmp_file)
    }
    
    # Load features and activity labels as tables
    activityLabels <- read.table(paste0(dataDirectory, "/activity_labels.txt"), col.names = c("ActivityID", "Label"), colClasses = c("integer", "character"))
    features <- read.table(paste0(dataDirectory, "/features.txt"), col.names = c("id", "FeatureLabel"), colClasses = c("NULL", "character"))
    
    # Filter the features to use only means and standard deviations
    filteredFeatures <- sort(union(grep("mean\\(\\)", features$FeatureLabel), grep("std\\(\\)", features$FeatureLabel)))
    
    # Clean up the feature labels, removing the parentesis
    features$FeatureLabel <- sapply(features, function (item) { gsub("\\(\\)", "", item) })
    
    # Loads the test data
    testDataSet <- loadDataSet("test", activityLabels, features, filteredFeatures)
    
    # Loads the train data
    trainDataSet <- loadDataSet("train", activityLabels, features, filteredFeatures)
    
    # Merging traing and test data
    completeDataSet <- rbind(testDataSet, trainDataSet)
    
    # Creates a summay with all the averages from the merged data set, grouped by subject and activity
    tidyData <- aggregate( .  ~ SubjectID + ActivityName, completeDataSet, mean )
    
    tidyData
}

data <- runAnalisys()

write.table(data, file="tidy.txt", row.name=FALSE)