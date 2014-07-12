# Explorator Data Analysis
# Project 1

# get the data
  Data<-read.csv("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)

# convert numeric columns to numbers
  for (i in 3:9){
    
    Data[,i]<-as.numeric(Data[,i], digits=4)
  }

# convert Date and Time and paste to new column
  Data$DateTime<-as.POSIXct(paste(Data$Date, Data$Time), format="%d/%m/%Y %H:%M:%S")

# subset the dataset
  Data <-subset(Data, Data$DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                  Data$DateTime <= as.POSIXct("2007-02-02 23:59:59"))


# Plot.2
  Plot2<-plot(Data$DateTime, Data$Global_active_power, type = "l", xlab= "", 
              ylab="Global Active Power (kilowats)")
  
  dev.copy(png, "Plot2.png")
  dev.off()