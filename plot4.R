

# Question 3:Across the United States, how have emissions from coal combustion-related 
  #sources changed from 1999–2008?

#Get the data
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

# Find the records that include coal and combustion
  combustion<-which(grepl("Comb", SCC$Short.Name))
  coal <-which(grepl("coal", SCC$Short.Name))
  Coal<-which(grepl("Coal", SCC$Short.Name))
  coal<-union(coal, Coal)
  coalComb<-intersect(coal, combustion)
  sccKey<-SCC[coalComb,1]
  sccKey<-SCC$SCC[coalComb]
  
  #Subset NEI dataframe by ccKey
  ccYearly<-subset(NEI, NEI$SCC %in% sccKey)
  
  
  
  
# Plot the data
  library(ggplot2)
  BaltByYear$type <- factor(BaltByYear$type,levels = c("ON-ROAD", "NON-ROAD", "POINT", "NONPOINT"))
  plot3<- qplot(x=year, y=Emissions, data=BaltByYear, stat="identity", geom="bar", fill= type, xlab="Year", ylab="Total Emissions",
        main="Total Emissions by Year and Type \n Baltimore, Maryland") 
  plot3 + facet_grid(type ~ ., ) + scale_x_continuous(breaks=seq(1999, 2008, 3)) + 
    theme(axis.title.x = element_text(size=16),axis.title.y  = element_text(size=16),
          plot.title =element_text(face="bold", size = 18)) + scale_fill_hue(l=40)
  
  
  
# Save the plot
  dev.copy(png,'plot3.png')
  dev.off()