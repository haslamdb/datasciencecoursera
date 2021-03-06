

# Question 6. Compare emissions from motor vehicle sources in Baltimore City with 
  # emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
  # Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)


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
  mvYearly$fips<-factor(mvYearly$fips)
  
  # Subset to Baltimore and LA then aggregate emissions by year
  mvBaltimore<-subset(mvYearly, mvYearly$fips=="24510")
  mvBaltByYear<-aggregate(Emissions ~ year, data=mvBaltimore, sum)
  #Subset to Los Angeles then aggregate by year
  mvLA<-subset(mvYearly, mvYearly$fips =="06037")
  mvLAByYear<-aggregate(Emissions ~ year, data=mvLA, sum)
  
  
  mvCities<-subset(mvYearly, mvYearly$fips %in% c("24510", "06037"))
  mvCitiesByYear<-aggregate(Emissions ~ year + fips, data=mvCities, sum)
  

# Make bar plot

  title="Total Emissions by Year \n Baltimore and Los Angeles"
  xlab="Emissions"
  ylab="Year"
  mvCitiesByYear$type <- factor(mvCitiesByYear$fips)
  
  plot6<- ggplot(data = mvCitiesByYear, aes(x=year, y=Emissions, fill=fips))

  plot6 + geom_bar(stat="identity", position="dodge") + scale_fill_discrete(name="City",labels=c("Los Angeles", "Baltimore")) + 
    scale_x_continuous(breaks=seq(1999, 2008, 3)) +
    labs(title=title) + xlab("Year") + ylab("Emissions") + 
    theme(axis.text.x= element_text(size= 14)) +
    theme(axis.text.y = element_text(size= 14)) +
    theme(plot.title = element_text(size= 22)) + 
    theme(axis.title.x = element_text(size=18),axis.title.y  = element_text(size=18)) +
    theme(legend.title = element_text(size=18)) +
    theme(legend.text = element_text(size = 14))

  
# Save the plot
  dev.copy(png,'plot6.png')
  dev.off()