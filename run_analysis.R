library(dplyr)

# 1. Merges the training and the test sets to create one data set.
x_train <- read.table("./Data/train/X_train.txt")
y_train <- read.table("./Data/train/y_train.txt")
subject_train <- read.table("./Data/train/subject_train.txt")

x_test <- read.table("./Data/test/X_test.txt")
y_test <- read.table("./Data/test/y_test.txt")
subject_test <- read.table("./Data/test/subject_test.txt")

train_data <- cbind(x_train,y_train,subject_train)
test_data <- cbind(x_test,y_test,subject_test)
merged_data <- rbind(train_data,test_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./Data/features.txt")
features_sub <- grep("-(mean|std)\\(\\)", features[, 2])
x_train_sub <- x_train[,features_sub]
x_test_sub <- x_test[,features_sub]
names(x_train_sub) <- features[features_sub, 2]
names(x_test_sub) <- features[features_sub, 2]


# 3. Uses descriptive activity names to name the activities in the data set
activities <- read.table("./Data/activity_labels.txt")
y_train_named <- y_train
y_train_named[, 1] <- activities[y_train_named[, 1], 2]
y_test_named <- y_test
y_test_named[, 1] <- activities[y_test_named[, 1], 2]
names(y_train_named) <- "Activity"
names(y_test_named) <- "Activity"

# 4. Appropriately labels the data set with descriptive variable names.
names(subject_train) <- "Subject"
names(subject_test) <- "Subject"

# 5. From the data set in step 4, creates a second, independent
# tidy data set with the average of each variable for each activity and each subject.

tidy_train <- cbind(x_train_sub,y_train_named,subject_train)
tidy_test <- cbind(x_test_sub,y_test_named,subject_test)
tidy_all <- rbind(tidy_train,tidy_test)

grouped <- tidy_all %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(grouped, "tidy_data.txt", row.name=FALSE)
