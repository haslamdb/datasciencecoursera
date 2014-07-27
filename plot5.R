

# Question 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

#Get the data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

# Find the records that include motor vehicles
  motor<-which(grepl("Motor", SCC$Short.Name))
  vehicle<-which(grepl("Vehi", SCC$EI.Sector))
  mv<-union(motor, vehicle)
  mvKey<-SCC[mv,1]
  
  #Subset NEI dataframe by ccKey
  mvYearly<-subset(NEI, NEI$SCC %in% mvKey)
  
  # Aggregate emissions by year
  coalByYear<-aggregate(Emissions ~ year, data=ccYearly, sum)
  
  
  
# Plot the data
  plot(coalByYear, type = "o", col="red", axes = FALSE, xlab="Year", ylab="Total Emissions", 
       main="Total Emissions due to Coal Combustion \n (1999 to 2008, United States)")
  ticks<-seq(1999,2008, 3)
  axis(1, at=ticks, labels=ticks)
  axis(2)
  box()
  
  
# Save the plot
  dev.copy(png,'plot4.png')
  dev.off()