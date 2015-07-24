# CleanDataProject
Getting and Cleaning Data course project

Objectives : -
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To merge the 2 datasets first we combine columnwise (cbind) so that the Subject and Y values stay together.
The x value columns are subsetted to include only those columns ending in mean() or std().
The brackets are removed from the column headers.
Once the full dataset is merged the consolidated, tidy dataset is created by first melting the dataset to create a "narrow" table
then dcast to recombine to a "wide" table using the mean function to aggregate over the groupings of Subject and Activity.
