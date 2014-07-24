## Coursera worksheets and data

setwd("C:/Users/David/Documents/Code/R/Projects/Coursera")
install.packages("XML")
library(XML)
install.packages("xlsx")
library(xlsx)
install.packages("data.table")
library(data.table)

if(!file.exists("data")){dir.create("data")}
fileUrl<-"https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?acessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.xlsx", method= "curl")

colIndex<-7:15
rowIndex<-18:23
dat<-read.xlsx("getdata_data_DATA.gov_NGAP.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T) 

FileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 


doc<-xmlTreeParse("getdata_data_restaurants.xml", useInternal=TRUE)
rootNode<-xmlRoot(doc)

zip<-xpathSApply(doc,"//li@class='zipcode']", xmlValue)

xmlName(rootNode)
xpathSApply(rootNode, "//zip", xmlValue)
zip<-xpathSApply(rootNode,"//zip", xmlValue)

url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
destfile<- "DT"
download.file(url,destfile)
DT<-fread("DT")
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
proc.time(DT[,mean(pwgtp15),by=SEX])


