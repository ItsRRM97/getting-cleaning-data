# getting-cleaning-data
The Course Project for the Getting and Cleaning Data Course at Coursera

The R script, `run_analysis.R`, does the following:

Step 1. Load the activity and feature info
Step 2. Loads both the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation.
Step 3. Activity and subject data is loaded from each dataset, and merged the selected
   columns with the dataset
Step 4. Merges the two datasets
Step 5. Converts the coloumns `activity` and `subject` to factors
Step 6. Creates a cleaned dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.
Step 7. The cleaned dataset is exported in the file `cleaneddataset.txt`.
