## This is an outline of how the script in week 4 assignment works:

1. Check if zip file exists, reshape2 package loaded before kick off
2. Read train data into R, add subject, action, group colunms to form a completed dataset
3. Repeat the process on test data.
4. Merge both train and test into a large dataset
5. Extract all mean and std colums from the large dataset
6. Use reshape2 to calculate every average variables for each subject-action pair
7. Output step 6 dataset as txt file

## Detail operation and transformation in "w4as.R" script
## Codebook specify variables in "dataset.txt"
