

#Across the United States, which types of events (as indicated in the EVTYPE variable) 
# are most harmful with respect to population health?

  library(R.utils)
  library(reshape2)
  library(ggplot2)
  library(grid)
  library(gridExtra)
  
# Uncompress and get data
  bunzip2("repdata_data_StormData.csv.bz2")
  Data<-read.csv("repdata_data_StormData.csv")
  Data$EVTYPE<- gsub("THUNDERSTORM WIND", "THUNDERSTORM",Data$EVTYPE)
  Data$EVTYPE<- gsub("THUNDERSTORM WINDS", "THUNDERSTORM",Data$EVTYPE)

#Aggregate inuries and fatalities by event type
  healthEffects<- melt(Data[,c(8,23,24)], id.var="EVTYPE")
  healthEffects<-aggregate(value ~ EVTYPE + variable, data=healthEffects, sum, na.rm=TRUE)
  healthEffects<-healthEffects[order(-healthEffects$value),]
  healthEffects<-dcast(healthEffects, EVTYPE ~ variable, sum)
  healthEffects<-healthEffects[order(-healthEffects$FATALITIES, -healthEffects$INJURIES),]
  healthEffects$TOTAL<- apply(healthEffects[, c("FATALITIES","INJURIES")], 1,sum)
  names(healthEffects)<-c("Event", "Fatalities", "Injuries", "Total")
  
# Get top causes of fatalities, injuries, and combined
  Fatalities<-healthEffects[,c(1,2)]
  Fatalities<-Fatalities[order(-Fatalities$Fatalities),]
  Fatalities<-Fatalities[1:10,]
  Injuries<-  Injuries<-healthEffects[,c(1,3)]
  Injuries<-Injuries[order(-Injuries$Injuries),]
  Injuries<-Injuries[1:10,]
  Total <-  Total<-healthEffects[,c(1,4)]
  Total <-Total [order(-Total$Total),]
  Total<-Total[1:20,]
  
# Get ordered list of events to arrange data on graph  
  fatalLevels <-Fatalities$Event
  injurLevels<-Injuries$Event
  totalLevels<- Total$Event
  
  params<- function(x){theme(axis.text.x= element_text(size= 12, , angle=45, vjust = 1, hjust= 1, color="black")) +
    theme(axis.text.y = element_text(size= 14, color="black")) +
    theme(plot.title = element_text(size= 22, color="black")) + 
    theme(axis.title.x = element_text(size=20),axis.title.y  = element_text(size=18)) +
    theme(legend.title = element_text(size=18)) +
    theme(legend.text = element_text(size = 14))
  }
  

# Plot number of fatalities by event type
  plotFatalities <- ggplot(data=Fatalities, aes(x=factor(Event, levels = paste(fatalLevels)), y=Fatalities)) +                 
  geom_bar(stat="identity", fill= "#990066", colour="black")  + ggtitle("Fatalities by Weather Event") +
    xlab(NULL) + ylab("Number of Fatalities") + params(plotFatalities)

# Plot number of injuries by event type  
  plotInjuries <- ggplot(data=Injuries, aes(x=factor(Event, levels = paste(injurLevels)), y=Injuries)) +                  
  geom_bar(stat="identity", fill= "#336699", color="black")  + ggtitle("Injuries by Weather Event") +
    xlab(NULL) + ylab("Number of Injuries") + params(plotInjuries)
  
# Plot total number of effects by event type  
  plotTotal <- ggplot(data=Total, aes(x=factor(Event, levels = paste(totalLevels)), y=Total)) +              
  geom_bar(stat="identity", fill= "#006633", color="black")  + ggtitle("Total Health Effects by Weather Event") +
    xlab(NULL) + ylab("Number of Health Effects") + params(plotTotal)

  
  
 # Across the United States, which types of events have the greatest economic consequences?
  
#Aggregate property damage and crop damage by event type
  econCons<- melt(Data[,c(8,25,27)], id.var="EVTYPE")
  econCons<-aggregate(value ~ EVTYPE + variable, data=econCons, sum)
  econCons<-econCons[order(-econCons$value),]
  econCons<-dcast(econCons, EVTYPE ~ variable, sum)
  econCons<-econCons[order(-econCons$PROPDMG, -econCons$CROPDMG),]
  econCons$TOTAL<- apply(econCons[, c("PROPDMG","CROPDMG")], 1,sum)
  names(econCons)<-c("Event", "Property", "Crop", "Both")
  
  # Get top 10 causes of Property, Crop, and combined
  Property<-econCons[,c(1,2)]
  Property<-Property[order(-Property$Property),]
  Property<-Property[1:10,]
  Crop<-  Crop<-econCons[,c(1,3)]
  Crop<-Crop[order(-Crop$Crop),]
  Crop<-Crop[1:10,]
  Both <-  Both<-econCons[,c(1,4)]
  Both <-Both [order(-Both$Both),]
  Both<-Both[1:20,]
  
  # Get ordered list of events to arrange data on graph  
  propLevels <-Property$Event
  cropLevels<-Crop$Event
  bothLevels<- Both$Event
  
  
  # Plot amount of property damage by event type
  plotProperty <- ggplot(data=Property, aes(x=factor(Event, levels = paste(propLevels)), y=Property)) +                 
  geom_bar(stat="identity", fill= "#993333", colour="black")  + ggtitle("Property Damage by Weather Event") +
    xlab(NULL) + ylab("Amount of Property Damage") + params(plotProperty)
  
  # Plot amount of Crop damage by event type
  plotCrop <- ggplot(data=Crop, aes(x=factor(Event, levels = paste(cropLevels)), y=Crop)) +                
  geom_bar(stat="identity", fill= "#CC9900", colour="black")  + ggtitle("Crop Damage by Weather Event") +
  xlab(NULL) + ylab("Amount of Crop Damage") + params(plotCrop)
  
  plotBoth<-ggplot(data=Both, aes(x=factor(Event, levels= paste(bothLevels)), y= Both))+
    geom_bar(stat="identity", fill= "#669933", colour="black")  + ggtitle("Total Economic Consequences by Weather Event") +
    xlab(NULL) + ylab("Amount of  Damage") + params(plotCrop)
  
  

  # arrange Health Effects plots using grid.arrange package
  grid.arrange(arrangeGrob(plotFatalities, plotInjuries, nrow=1),
                 arrangeGrob(plotTotal, nrow=1),
                 nrow=2)
               
  
  # arrange Properties Damage plots
  grid.arrange(arrangeGrob(plotProperty, plotCrop, nrow=1),
               arrangeGrob(plotBoth, nrow=1),
               nrow=2)
  
               

  