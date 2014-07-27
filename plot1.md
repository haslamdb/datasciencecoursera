---
title: "plot1"
output: html_document
---


## Question 1: Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

###Get the data
```{r}
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
```

### Aggregate emissions by year
```{r}
  totalByYear<-aggregate(Emissions ~ year, data=NEI, sum)
```
  
### Plot the data
```{r echo = FALSE}
  plot(totalByYear, type = "o", col="red", axes = FALSE, xlab="Year", ylab="Total Emissions", 
       main="Total Emissions by Year")
  ticks<-seq(1999,2008, 3)
  axis(1, at=ticks, labels=ticks)
  axis(2)
  box()
```  

### Save the plot
```{r}
  dev.copy(png,'plot1.png')
  dev.off()
```