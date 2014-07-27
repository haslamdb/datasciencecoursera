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
  
# Plot.1
  Plot1 <-hist(Data$Global_active_power, main="Global Active Power", ylab="Frequency",
               xlab="Global Active Power (kilowats)", col="red")
  
  
  dev.copy(png,'Plot1.png')
  dev.off()
  
# Plot.2
  Plot2<-plot(Data$DateTime, Data$Global_active_power, type = "l", xlab= "", 
              ylab="Global Active Power (kilowats)")
  
  dev.copy(png, "Plot2.png")
  dev.off()
  

  # Plot.3
  Plot3<-with(Data, plot(DateTime, Sub_metering_1, type = "l", col="black", xlab= "",
              ylab="Energy Sub Metering"))
  lines(Data$DateTime, Data$Sub_metering_2,col="red")
  lines(Data$DateTime, Data$Sub_metering_3,col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty=1, lwd=2, col=c("black", "red", "blue"), cex=0.7 )

  dev.copy(png, "Plot3.png")
  dev.off()
  
# Plot.4  
  par(mfrow = c(2,2))
  PlotA <-plot(Data$DateTime, Data$Global_active_power, type = "l", xlab= "", 
               ylab="Global Active Power")
  
  PlotB <- with(Data, plot(DateTime, Voltage, type="l", xlab="datetime"))
  
  PlotC <- with(Data, plot(Data$DateTime, Data$Sub_metering_1, type = "l", col="black", xlab= "",
                ylab="Energy Sub Metering"))
  lines(Data$DateTime, Data$Sub_metering_2,col="red")
  lines(Data$DateTime, Data$Sub_metering_3,col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         lty=1, lwd=2, col=c("black", "red", "blue"), cex=0.7, bty="n" )
  
  PlotD <- with(Data, plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))
  
  dev.copy(png, "Plot4.png")
  dev.off()
  
  
