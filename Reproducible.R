# Reproducible Research : Assignment 1

  library(ggplot2); library(knitr); library(markdown)
  setwd("C:/Users/David/Documents/Code/R/Projects/Coursera")
  
  data<-read.csv("activity.csv", header = TRUE, stringsAsFactor=FALSE)
  data$date<-as.Date(data$date, format="%Y-%m-%d")

# What is mean total number of steps taken per day?

  aggDate <- aggregate(steps ~ date, data, FUN = mean, na.rm = TRUE)
  
  datePlot <- ggplot(aggDate, aes(x=steps)) 
  datePlot + geom_histogram(binwidth=10)
  
  meanSteps<-mean(aggDate$steps)
  meanSteps
  medianSteps<-median(aggDate$steps)
  medianSteps

# What is the average daily activity pattern?

  aggInterval<-aggregate(steps ~ interval, data, FUN=mean, na.rm = TRUE)
  
  intervalPlot<- ggplot(aggInterval, aes(interval, steps))
  intervalPlot + geom_point() + geom_line()
  
  maxSteps<-max(aggInterval$steps)
  maxInterval<-subset(aggInterval, aggInterval$steps==max(aggInterval$steps))
  maxInterval$interval
  
# Imputing missing values
  
  missingIntervals<-sum(is.na(data$steps))
  missingIntervals
  
  dataNew<-merge(data, aggInterval, by=c("interval"), all.x=TRUE)
  
  for (i in 1:nrow(dataNew)) {
    if (is.na(dataNew$steps.x[i])) {
      dataNew$steps.x[i]<-dataNew$steps.y[i]
    }
  }
  
  dataImpute<-dataNew[,c(2,3,1)]
  names(dataImpute)<- c("steps", "date", "interval")
  
  aggImpute <- aggregate(steps ~ date, dataImpute, FUN = mean, na.rm = TRUE)
  
  
  imputePlot <- ggplot(aggImpute, aes(x=steps)) 
  imputePlot + geom_histogram(binwidth=10)
  
  meanImpute<-mean(aggImpute$steps)
  meanImpute
  medianImpute<-median(aggImpute$steps)
  medianImpute
  
# Are there differences in activity patterns between weekdays and weekends?
  weekdays<-c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
  weekends<- c("Saturday", "Sunday")
  dataImpute$weekday<-ifelse(weekdays(dataImpute$date) %in% weekdays, "weekday", "weekend" )
  
  
  weekdayData<-aggregate(steps ~ interval + weekday, dataImpute, FUN=mean, na.rm = TRUE)
  
  weekdayPlot<- ggplot(weekdayData, aes(interval, steps))
  weekdayPlot + geom_point() + geom_line() + facet_grid(weekday ~ .)
  
  
