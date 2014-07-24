# Getting and cleaning data project

setwd("C:/Users/David/Documents/Code/R/Projects/Coursera/UCI HAR Dataset/test")
X_test<-read.table("X_test.txt")
subject_test<-read.table("subject_test.txt")
y_test<-read.table("y_test.txt")

setwd("C:/Users/David/Documents/Code/R/Projects/Coursera/UCI HAR Dataset/test/Inertial Signals")

body_acc_y_test<-read.table("body_acc_y_test.txt")
body_acc_x_test<-read.table("body_acc_x_test.txt")
body_acc_z_test<-read.table("body_acc_z_test.txt")
body_gyro_x_test<-read.table("body_gyro_x_test.txt")
body_gyro_y_test<-read.table("body_gyro_y_test.txt")
body_gyro_z_test<-read.table("body_gyro_z_test.txt")
total_acc_y_test<-read.table("total_acc_y_test.txt")
total_acc_x_test<-read.table("total_acc_x_test.txt")
total_acc_z_test<-read.table("total_acc_z_test.txt")

# merge Subject and Y to each dataframe
dataFiles<- c(body_acc_y_test, body_acc_x_test, body_acc_z_test, body_gyro_x_test, 
              body_gyro_y_test, body_gyro_z_test, total_acc_x_test, total_acc_y_test, 
              total_acc_z_test )

tags<-cbind(subject_test, y_test)


for (i in 1:length(dataFiles)) {
  dataFiles[i]<-cbind(tags, dataFiles[i])
}