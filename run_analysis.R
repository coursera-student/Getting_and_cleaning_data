# 1 - Merge the training and the test sets to create one data set

    ## merge training data
    subject_train <- read.table("./Data/train/subject_train.txt") #subject id
    X_train <- read.table("./Data/train/X_train.txt") # measurements
    y_train <- read.table("./Data/train/y_train.txt") # activity id
    train <- cbind(subject_train, y_train, X_train)
    dim(train) # 7352 x 563
    
    ## merge test data
    subject_test <- read.table("./Data/test/subject_test.txt") # subject id
    X_test <- read.table("./Data/test/X_test.txt") # measurements
    y_test <- read.table("./Data/test/y_test.txt") # activity id
    test <- cbind(subject_test, y_test, X_test)
    dim(test) # 2947 x 563
    
    ## merge training and test data
    data <- rbind(train, test)
    dim(data) # 10299 x 563
    
    # assign column labels
    features <- read.table("./Data/features.txt") # column label data
    class(features$V2) # factor
    features[, 2] <- as.character(features[, 2]) # change to character
    colnames(data) <- c("subject", "activity", features[, 2])
    names(data[1:10])

# 2 - Extract only the measurements on the mean and standard deviation 
# for each measurement
    ## According to the "features_info.txt" file, the columns including
    ## calculations of the mean include "mean" or "Mean" in the name variable. 
    ## Therefore, I will use variables that include:  
    ## mean()
    ## meanFreq()
    ## gravityMean
    ## tBodyAccMean
    ## tBodyAccJerkMean
    ## tBodyGyroMean
    ## tBodyGyroJerkMean
    
    col.mean <- grep("[Mm]ean", colnames(data))
    col.mean # returns the column numbers
    names(data[col.mean]) # returns the column names
    length(col.mean) # 53 variables
    
    ## The columns corresponding to the standard deviation include std()
    ## in the name variable.
    col.std <- grep("std()", colnames(data), fixed=TRUE)
    col.std # returns the column numbers
    names(data[col.std]) # returns the column names
    length(col.std) # 33 variables 
    
    ## combine column ids containing mean or standard deviation
    col.mean.std <- c(col.mean, col.std) 
    sort(col.mean.std) # returns the column numbers in increaasing order
    length(col.mean.std) # 86 variables
    
    # create a new data set ("data.mean.std") with the "subject", "activity", and the 
    # corresponding mean and standard deviations measurements
    data.mean.std <- data[, c(1:2, col.mean.std)]  
    dim(data.mean.std) # 10299 x 88
    names(data.mean.std) # returns the column names
    
# 3 - Use descriptive activity names to name the activities in the data set
    # get the descriptive activity names
    activity_labels <- read.table("./Data/activity_labels.txt")
    activity_labels
    
# 4 - Appropriately label the data set with descriptive activity names
    ## update "data.mean.std" with descriptive activity names
    data.mean.std <- merge(data.mean.std, activity_labels, 
                           by.x="activity", by.y="V1", all=TRUE)
    dim(data.mean.std) # 10299 x 89
    View(data.mean.std[, c(1:2,87:89)]) # first two columns and last one
    colnames(data.mean.std)[grepl("V2", colnames(data.mean.std))] <- "descriptive.activity"
    #colnames(data.mean.std)[colnames(data.mean.std) == "V2"] <- "descriptive.activity" # does the same as above
    
    # re-order the columns to have "descriptive activity" as the 2nd column
    data.mean.std <- data.mean.std[, c(1, 89, 2, 3:88)]
    names(data.mean.std[1:10]) # first 10 column names
    View(data.mean.std[, c(1:5, 89)]) # first five columns and last one

    # re-order dataframe by 1st and second column (optional)
    View(data.mean.std[order(data.mean.std$activity, data.mean.std$subject),])
    
# 5 - Create a second, independent tidy data set with the average 
# of each variable for each activity and each subject
    # melt data
    library(reshape2)
    molten <- melt(data.mean.std, id=c("activity", "descriptive.activity", "subject"))
    dim(molten) # 896013 x 5
    head(molten)
    tail(molten)    
    
    # reshape the data with averages of each variable
    tidy.data <- dcast(molten, 
                        activity + descriptive.activity + subject ~ variable, mean)
    dim(tidy.data) # 180 x 89
    tidy.data[1:15, 1:5] # first 15 rows, first 5 columns 
    write.table(tidy.data, "tidy.data.txt", sep="\t")
