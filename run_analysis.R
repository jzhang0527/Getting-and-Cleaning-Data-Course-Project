#Set working directory
setwd("D:\\Git\\repository\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset")
#1.Merges the training and the testing sets to create one data set.
##a.Load training set
###Main training data set
x_train<-read.table("train\\X_train.txt",header = F)
###Activity label for training set
y_train<-read.delim("train\\y_train.txt", sep = ' ', header = F, col.names = "ActivityID")
###Subject Id for training set
subjects_train<-read.table("train\\subject_train.txt", col.names = "SubjectID")
##b.Load testing set
###Main testing data set
x_test<-read.table("test\\X_test.txt", header = F)
###Activity label for testing set
y_test<-read.delim("test\\y_test.txt", sep = ' ', header = F, col.names = "ActivityID")
###Subject Id for testing set
subjects_test<-read.table("test\\subject_test.txt", col.names = "SubjectID")
##c.Assign column names for main training and testing data sets
###Load column names
features<-read.table("features.txt", header = F)
###Assign column names
colnames(x_train)<-features[,2]
colnames(x_test)<-features[,2]

##b.Bind tables for training set together
train<-cbind(subjects_train,x_train,y_train)

##c.Bind tables for testing set together
test<-cbind(subjects_test,x_test,y_test)

##d.Merge training and testing data sets together to create one data set
combined<-rbind(train,test)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
filtered<- combined[,grep("ActivityID|SubjectID|.*mean\\(\\).*|.*std\\(\\).*",names(combined))]

#3.Uses descriptive activity names to name the activities in the data set
##a.Load activity label table
activity<-read.table("activity_labels.txt", header = F, col.names = c("ActivityID","ActivityLabel"))
##b.Merge combined data set with activity table to get activity label for each record
combined2<-merge(filtered,activity,by.x = "ActivityID", by.y = "ActivityID", all.x = T)
combined2<-combined2[,-1]

#4.Appropriately labels the data set with descriptive variable names.
names(combined2)<-gsub("Acc", "Accelerometer", names(combined2))
names(combined2)<-gsub("Gyro", "Gyroscope", names(combined2))
names(combined2)<-gsub("BodyBody", "Body", names(combined2))
names(combined2)<-gsub("Mag", "Magnitude", names(combined2))
names(combined2)<-gsub("^t", "Time", names(combined2))
names(combined2)<-gsub("^f", "Frequency", names(combined2))
names(combined2)<-gsub("tBody", "TimeBody", names(combined2))
names(combined2)<-gsub("\\(|\\)", "", names(combined2))

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
final<-combined2%>%group_by(ActivityLabel, SubjectID)%>%summarise_all(mean)

#Change working directory to save the final data set
setwd("D:\\Git\\repository\\Getting-and-Cleaning-Data-Course-Project")
write.csv(final, "HARSubset.csv")
