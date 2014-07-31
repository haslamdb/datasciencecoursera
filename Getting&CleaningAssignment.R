# Getting and cleaning quiz 4

idaho<-read.csv("getdata_data_ss06hid.csv")
listnames<-strsplit(names(idaho), "wgtp")

gdp<-read.csv("getdata_data_GDP.csv", skip=5, header=FALSE)
gdp$V5<-gsub(",", "", gdp$V5)
coldata<-summary(gdp$V5, na.rm=TRUE)
gdp$V5<-as.numeric(gdp$V5)
gdp<-gdp[1:190,]
names(gdp$V4)<- "countryNames"

EDSAT<-read.csv("getdata_data_EDSTATS_Country.csv")

gdp2<-merge(gdp, EDSAT, by.x="V1", by.y="CountryCode", all=TRUE)

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

ts <- as.xts(sampleTimes, FUN=as.POSIXlt)
ts.2012 <- ts["2012-01-01::2012-12-31"]
ts.Mondays<-ts.2012[wday==1,]

#note that xts allows subsetting on weekday or day of the week (Mondays are wday==1)