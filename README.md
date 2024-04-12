# Course3Assignment

This repo has the run_analysis.R script, codebook.md, and README.md.

The script performs the tasks required by the assignment.

First, the xtest, xtrain, ytest, and ytrain tables were read in. Then, the feature names (features.txt), subject test ID (subject_test.txt), subject train ID (subject_train.txt), and activity name labels (activity_labels.txt) were read in.

I renamed the y test column (there is only one column) to ACTIVITY and renamed the subject test column (only one) to ID. I then column binded these two datasets together. I performed the same actions for yTrain and subjectTrain.

I row binded xtest and xtrain to create xData, then replaced its undescriptive column names using the features table.

I then row binded ytest and ytrain, and column binded that result to xData to create fullData.

I then extracted the data (extractedData) to just include all columns (features) that has "mean" or "std" in its name using grep. I also made sure ID and ACTIVITY were still included.

At this point, the ACTIVITY column was still numerical, so I used lapply to replace those numbers with their corresponding actual label using the activity_labels.txt I already read in.

Finally, I made the last dataset called averages. I used the dplyr library and group_by to get the average for every feature by ID and ACTIVITY.




