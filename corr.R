# Part 3


corr <- function(directory, threshold = 0) {
  cr<-vector()
  for (i in 1:332) {
    id<-1:332
    site<-sprintf("%03d", id[i])
    filepath<-paste(directory, site, sep="/")
    filename<-paste(filepath, ".csv", sep="")
    file<-read.csv(filename)
    file<-na.omit(file)
    if (length(file[ ,1]) > threshold) {cr[[i]]<-cor(file$nitrate, file$sulfate)}
  }
  cr<-na.omit(cr)
 
 
}
  
corr("specdata", 150)
corr("specdata", 400)
corr("specdata", 5000)