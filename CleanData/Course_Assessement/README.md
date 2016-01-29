## Motivation

One of the most exciting areas in all of data science right now is wearable computing - see for example this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Getting and Cleaning Data Course Project

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

In order to generate this tidy data, you will need to execute the `run_analysis.R` script located on this file.
This script will download the data from the mentioned link and generate a summary for all the measurements included under the tests and train.

This summary is the average of the observations for 64 variabes collected from smartphoes, grouped by the activity being performed on the time of the observation and the subject doing the activity.

(for more information related to the variables, look at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#### Data Analysis Explanation

 - __For 1st tiny data set__:
  - Set the environment
  - Check if the working directory has the required files to execute the analysis
  - Read the features and activity labels
  - Filter the features to use only means and standard deviations
  - Clean up the feature labels, removing the parentesis
  - Load the test data
  - Load the train data
  - Merge traing and test data
  - Rename data labels with activity name
  - Merge data, subjects, and labels to single tiny data set. This generate the first tiny dataset.

 - __For the 2nd tiny data set__:
  - Creates a summay with all the averages from the merged data set, grouped by subject and activity from first tiny data set.
  - Writes it down to a file, called `tidy.txt`


### Dependencies:
This script depends on the `plyr` package. In order to run it, you need to have it previously installed on your R environemnt. 

If you do not have this package installed, on your R console, run:

```R
install.packages("plyr")
```

#### Notice:
This script has only been only executed under a MacOS.
