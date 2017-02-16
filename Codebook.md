# Code Book

# Overview
In order to generate a clean dataset, I first combine x_train, y_train and subject train together to create a train data set, and then do the same for the test data. Next I use rbind to merge the train and test data to create one data set. Next, I select all relevant variable names that contain mean or standard deviation for each x measurement, and update the column name accordingly. Then, I update the name for the y and subject measurement, narrowing the feature selection to about 70.

# Output
In the last step, I use dplyr package to calculate measurements' average values for each activity and each subject. I then save the data frame as a .txt file. 
