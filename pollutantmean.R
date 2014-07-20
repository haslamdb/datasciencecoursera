## Assignment 1 Part 1:

pollutantmean <- function(directory, pollutant, id = 1:332) {
  z<-as.numeric(length(id))
  sumTotal <-0
  obsTotal <-0
  site<-0
  sumPollutant<-0
  meanPollutant<-0
  p<-ifelse(pollutant=="sulfate", 2,
            (ifelse(pollutant=="nitrate", 3, "Error")))
  for (i in 1:z) {
    site<-sprintf("%03d", id[i])
    filepath<-paste(directory, site, sep="/")
    filename<-paste(filepath, ".csv", sep="")
    files<-read.csv(filename)
    sumPollutant<- as.numeric(colSums(files[p], na.rm=TRUE))
    sumTotal<-sumTotal+ sumPollutant
    obs<-as.numeric(length(files[,p][! is.na(files[,p])]))
    obsTotal<-obsTotal + obs
  }
  options(digits=4)
  meanPollutant<-sumTotal/obsTotal
  meanPollutant
}

pollutantmean_1_output<- pollutantmean("specdata", "sulfate", 1:10)
write(pollutantmean_1_output,file="pollutantmean-1-output.txt")
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "nitrate", 23)