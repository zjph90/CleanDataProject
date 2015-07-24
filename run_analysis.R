# Assumed that this is run from the root directory ( UCI HAR Dataset ) of the data

require("reshape2")
require("dplyr")

# Process activity data
activities <- read.table("activity_labels.txt")[,2]

# Load features data
features <- read.table("./features.txt", stringsAsFactors = FALSE)
names(features) <- c("id", "desc")

# We only need mean() and std() features so determine which these are
col_numbers <-  c( grep("mean\\(\\)",features$desc ) , grep("std\\(\\)",features$desc) )
feat_names <- features[col_numbers, "desc"]
# Remove the brackets for slightly friendlier names:
feat_names <- gsub("\\(\\)","", feat_names)

# Read training data
x_train <- read.table("./train/x_train.txt")
# Subset the columns of the X values with the required column_numbers: -
x_train <- x_train[, col_numbers]


subject_train <- read.table("./train/subject_train.txt")

y_train <- read.table("./train/y_train.txt")
# Use activities vector to lookup Activity name - uses the fact that the order is 1-6
y_train <- activities[y_train[,1]]

# Bind columns together
train_data <- cbind(subject_train, y_train, x_train)
names(train_data) <- c("Subject", "Activity", feat_names)


# Read test data
x_test <- read.table("./test/x_test.txt")
# Subset the columns of the X values with the required column_numbers: -
x_test <- x_test[, col_numbers]


subject_test <- read.table("./test/subject_test.txt")

y_test <- read.table("./test/y_test.txt")
# Use activities vector to lookup Activity name - uses the fact that the order is 1-6
y_test <- activities[y_test[,1]]

# Bind columns together
test_data <- cbind(subject_test, y_test, x_test)
names(test_data) <- c("Subject", "Activity", feat_names)


# Objective 1 - Merge data 
full_data <- rbind(train_data, test_data)

melted <- melt(full_data, id.vars = c("Subject", "Activity"))

tidy_data <- dcast(melted, Subject + Activity ~ variable, mean )

write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)


