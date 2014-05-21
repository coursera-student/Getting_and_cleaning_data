CodeBook
===

The purpose of this code book is to describe:

1. the data
2. the variables
3. transformations or work that I performed to clean up the data

1- The data
---

The data represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist. The activities were:

1. Walking
2. Walking upstairs
3. Walking downstairs
4. Sitting
5. Standing
6. Laying    
 
Using its embedded accelerometer and gyroscope, the 3-axial linear acceleration and 3-axial angular velocity was captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 


The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

   
The data as well as a detailed description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

2- The variables
---
There was over 500 variables in th emain dataset. Each variable is a combination of different words concatenated by a dot in an abreviated form. Only a subset of the variables were used to conduct this study. 

The variables include the following:

 mean    : mean value
 std     : standard diviation
 acc     : acceleration from accelerometer signal
 gyr     : gyroscope signal
 mag     : magnitude
 freq    : frequency
 t       : prefix for time
 f       : prefix for fast Fourier transformation

Additionally, the six levels of activity are:

1. Walking
2. Walking upstairs
3. Walking downstairs
4. Sitting
5. Standing
6. Laying                

The columns used for this study are the following (note that justification for using these variables is explained below as well as in the "run_analysis.R" document):

```
 [1] "activity"                             "subject"                             
 [3] "tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                   
 [5] "tBodyAcc-mean()-Z"                    "tGravityAcc-mean()-X"                
 [7] "tGravityAcc-mean()-Y"                 "tGravityAcc-mean()-Z"                
 [9] "tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"               
[11] "tBodyAccJerk-mean()-Z"                "tBodyGyro-mean()-X"                  
[13] "tBodyGyro-mean()-Y"                   "tBodyGyro-mean()-Z"                  
[15] "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"              
[17] "tBodyGyroJerk-mean()-Z"               "tBodyAccMag-mean()"                  
[19] "tGravityAccMag-mean()"                "tBodyAccJerkMag-mean()"              
[21] "tBodyGyroMag-mean()"                  "tBodyGyroJerkMag-mean()"             
[23] "fBodyAcc-mean()-X"                    "fBodyAcc-mean()-Y"                   
[25] "fBodyAcc-mean()-Z"                    "fBodyAcc-meanFreq()-X"               
[27] "fBodyAcc-meanFreq()-Y"                "fBodyAcc-meanFreq()-Z"               
[29] "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"               
[31] "fBodyAccJerk-mean()-Z"                "fBodyAccJerk-meanFreq()-X"           
[33] "fBodyAccJerk-meanFreq()-Y"            "fBodyAccJerk-meanFreq()-Z"           
[35] "fBodyGyro-mean()-X"                   "fBodyGyro-mean()-Y"                  
[37] "fBodyGyro-mean()-Z"                   "fBodyGyro-meanFreq()-X"              
[39] "fBodyGyro-meanFreq()-Y"               "fBodyGyro-meanFreq()-Z"              
[41] "fBodyAccMag-mean()"                   "fBodyAccMag-meanFreq()"              
[43] "fBodyBodyAccJerkMag-mean()"           "fBodyBodyAccJerkMag-meanFreq()"      
[45] "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-meanFreq()"         
[47] "fBodyBodyGyroJerkMag-mean()"          "fBodyBodyGyroJerkMag-meanFreq()"     
[49] "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)"
[51] "angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)"
[53] "angle(X,gravityMean)"                 "angle(Y,gravityMean)"                
[55] "angle(Z,gravityMean)"                 "tBodyAcc-std()-X"                    
[57] "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                    
[59] "tGravityAcc-std()-X"                  "tGravityAcc-std()-Y"                 
[61] "tGravityAcc-std()-Z"                  "tBodyAccJerk-std()-X"                
[63] "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                
[65] "tBodyGyro-std()-X"                    "tBodyGyro-std()-Y"                   
[67] "tBodyGyro-std()-Z"                    "tBodyGyroJerk-std()-X"               
[69] "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"               
[71] "tBodyAccMag-std()"                    "tGravityAccMag-std()"                
[73] "tBodyAccJerkMag-std()"                "tBodyGyroMag-std()"                  
[75] "tBodyGyroJerkMag-std()"               "fBodyAcc-std()-X"                    
[77] "fBodyAcc-std()-Y"                     "fBodyAcc-std()-Z"                    
[79] "fBodyAccJerk-std()-X"                 "fBodyAccJerk-std()-Y"                
[81] "fBodyAccJerk-std()-Z"                 "fBodyGyro-std()-X"                   
[83] "fBodyGyro-std()-Y"                    "fBodyGyro-std()-Z"                   
[85] "fBodyAccMag-std()"                    "fBodyBodyAccJerkMag-std()"           
[87] "fBodyBodyGyroMag-std()"               "fBodyBodyGyroJerkMag-std()"          
[89] "descriptive.activity"
```

3- transformations or work that I performed to clean up the data
---

The following steps explain the transformations and work that I performed to create the tidy dataset:

1. Merge the training and the test sets to create one data set
2. Extract only the measurements on the mean and standard deviation for each measurement. I ended up with a total of 89 columns (listed above) because I included the following:
    - According to the "features_info.txt" file, the columns including calculations of the mean include "mean" or "Mean" in the name variable. Those include:  
        - mean()
        - meanFreq()
        - gravityMean
        - tBodyAccMean
        - tBodyAccJerkMean
        - tBodyGyroMean
        - tBodyGyroJerkMean
    - The columns corresponding to the standard deviation include std() in the name variable
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive activity names
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
6. Save the tidy data set as "tidy.data.txt"