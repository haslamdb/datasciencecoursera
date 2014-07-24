# Getting and cleaning data project

library(reshape2)

# Get the feature names and activity lables
  setwd("C:/Users/HASI9S/Documents/Code/R/Projects/Coursera/UCI HAR Dataset")
  activity_labels<-read.table("activity_labels.txt")
  names(activity_labels)<-c("Label", "Activity")
  features<-read.table("features.txt")
  features<-as.character(features[,2])
  feature_names<-as.character(t(features))

# Get X_test and name the columns and rows
  setwd("C:/Users/HASI9S/Documents/Code/R/Projects/Coursera/UCI HAR Dataset/test")
  X_test<-read.table("X_test.txt")
  subject_test<-read.table("subject_test.txt")
  y_test<-read.table("y_test.txt")
  names(X_test)<- feature_names
# Add rownames
  test_tags<-cbind(subject_test, y_test)
  names(test_tags)<-c("Subject", "Label")
  X_test<-cbind(test_tags, X_test)
  X_test_labeled<-merge(activity_labels, X_test, by="Label")

# Get X_train and name the columns and rows 
  setwd("C:/Users/HASI9S/Documents/Code/R/Projects/Coursera/UCI HAR Dataset/train")
  X_train<-read.table("X_train.txt")
  subject_train<-read.table("subject_train.txt")
  y_train<-read.table("y_train.txt")
  names(X_train)<- feature_names
  # Add rownames
  train_tags<-cbind(subject_train, y_train)
  names(train_tags)<-c("Subject", "Label")
  X_train<-cbind(train_tags, X_train)
  X_train_labeled<-merge(activity_labels, X_train, by="Label")

# combine train and test data into a dataframe called AllX
  AllX<-rbind(X_train_labeled, X_test_labeled)
  AllX<-AllX[,-1]





# setwd("C:/Users/HASI9S/Documents/Code/R/Projects/Coursera/UCI HAR Dataset/test/Inertial Signals")
# 
# body_acc_y_test<-read.table("body_acc_y_test.txt")
# body_acc_x_test<-read.table("body_acc_x_test.txt")
# body_acc_z_test<-read.table("body_acc_z_test.txt")
# body_gyro_x_test<-read.table("body_gyro_x_test.txt")
# body_gyro_y_test<-read.table("body_gyro_y_test.txt")
# body_gyro_z_test<-read.table("body_gyro_z_test.txt")
# total_acc_y_test<-read.table("total_acc_y_test.txt")
# total_acc_x_test<-read.table("total_acc_x_test.txt")
# total_acc_z_test<-read.table("total_acc_z_test.txt")
# 
# 
# setwd("C:/Users/HASI9S/Documents/Code/R/Projects/Coursera/UCI HAR Dataset/train/Inertial Signals")
# body_acc_y_train<-read.table("body_acc_y_train.txt")
# body_acc_x_train<-read.table("body_acc_x_train.txt")
# body_acc_z_train<-read.table("body_acc_z_train.txt")
# body_gyro_x_train<-read.table("body_gyro_x_train.txt")
# body_gyro_y_train<-read.table("body_gyro_y_train.txt")
# body_gyro_z_train<-read.table("body_gyro_z_train.txt")
# total_acc_y_train<-read.table("total_acc_y_train.txt")
# total_acc_x_train<-read.table("total_acc_x_train.txt")
# total_acc_z_train<-read.table("total_acc_z_train.txt")


