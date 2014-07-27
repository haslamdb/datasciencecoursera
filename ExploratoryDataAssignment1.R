
#Get the data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  #Using the base plotting system, make a plot showing the total PM2.5 
    #emission from all sources for each of the years 1999, 2002, 2005, and 2008.
  
  totalByYear<-aggregate(Emissions ~ year, data=NEI, sum)
  
  plot(totalByYear, type = "o", col="red", axes = FALSE, xlab="Year", ylab="Total Emissions", main="Total Emissions by Year")
  ticks<-seq(1999,2008, 3)
  axis(1, at=ticks, labels=ticks)
  axis(2)
  box()
  
