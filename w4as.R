# Manually download the zip package in to your working directory before 
# sourcing this script. You don't have to upzip it. This sctipt begain
# with checking if the zip file exist, if any error, check the file name
# or use "setwd()" to reset direcroty.

fileName <- "getdata%2Fprojectfiles%2FUCI HAR Dataset.zip"
if (!file.exists(fileName)) stop("No such zip in working directory!") 

# Incase of unexpected error at last step, the script load "reshape2"
# package in advanced. If error, install the "reshape2" properly.

if (!require("reshape2")==TRUE) stop("Unable to load reshape2")
unzip(fileName)

# Read x_test.txt into dataframe. Remove the prefix row unmbers in
# "features" with gsub() then assign the vector to colnames of x_test

x_test <- read.table("UCI HAR Dataset/test/x_test.txt")
features <- readLines("UCI HAR Dataset/features.txt")
features <- gsub("^\\d+ ","",features)
colnames(x_test) <- features

# Collect subject id, factorized y_test and convert action id into labels.
# Add subject, action, group total 3 colums to test data set.

subject_test <- readLines("UCI HAR Dataset/test/subject_test.txt")
act_labels <- readLines("UCI HAR Dataset/activity_labels.txt")
act_labels <- gsub("^\\d+ ","",act_labels)
y_test <- readLines("UCI HAR Dataset/test/y_test.txt")
y_test <- factor(y_test,labels=act_labels)

x_test$subject <- subject_test
x_test$action <- y_test
x_test$group <- "Test"

# Repeat the same process on train data, some values is common used.

x_train <- read.table("UCI HAR Dataset/train/x_train.txt")
colnames(x_train) <- features
subject_train <- readLines("UCI HAR Dataset/train/subject_train.txt")
y_train <- readLines("UCI HAR Dataset/train/y_train.txt")
y_train <- factor(y_train,labels=act_labels)

x_train$subject <- subject_train
x_train$action <- y_train
x_train$group <- "Train"

# Now both dataset has same colname, merge them into "merge0" data
# set by row, then use grep() to find column index, extract the mean 
# and std value into a sub data set called "merge1" by indecies.

merge0 <- rbind(x_test,x_train)
idx0 <- grep("mean\\(\\)|std\\(\\)",colnames(merge0),value=T) 
merge1 <- merge0[,c(idx0,"subject","action")]

# Use reshape2 package to melt the sub dataset then cast it, then outputs
# "merge4" as requested.

merge3 <- melt(merge1,id.var=c("subject","action"))
merge4 <- dcast(merge3,subject+action~...,mean)
write.table(merge4,"dataset.txt",row.name=F)
