##complete data sets


complete <- function(directory, id) {
  z<-as.numeric(length(id))
  nobs<-0
  sites<-0
  siteobs<-data.frame(sites, nobs)
  names(siteobs)<- c("nobs", "id")
  for (i in 1:z) {
    site<-sprintf("%03d", id[i])
    filepath<-paste(directory, site, sep="/")
    filename<-paste(filepath, ".csv", sep="")
    file<-read.csv(filename)
    file<-na.omit(file)
    nobs[[i]]<-length(file[ ,1])
    sites[[i]] <-id[[i]]
    siteobs[i,]<-data.frame(nobs[[i]],sites[[i]])
  }

  siteobs<- siteobs[,c("id", "nobs")]
  siteobs
}


complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)