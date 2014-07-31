




outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

makeCaps <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = ".")}

rankall <- function(measure, num ="best") {
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
 measures<-as.list(colnames(outcome))
 measure<-makeCaps(measure)
 measure<-paste("Hospital.30.Day.Death..Mortality..Rates.from.", measure, sep="")
  ## Check that state and outcome are valid
 if(! measure %in% measures) {
    stop("invalid outcome")}
  column <-which(measures==measure)
  rank=num
 if(num=="best"){rank <-1}
  outcome[column]<-suppressWarnings(as.numeric(unlist(outcome[column])))
  outcome<-suppressWarnings(outcome[order(as.numeric(unlist(outcome[column])), outcome[2]),])
  States<-outcome$State
  States<-subset(States, ! duplicated(States))
  States<-sort(States)
  outcomes<-outcome[,c(2,7)]
  hospList<-outcomes[1,]
 for(i in 1:length(States)) {
   state<-States[i]
   x<-subset(outcomes, outcomes$State==state)
   x<-na.omit(x)
   if(num=="worst"){rank <- nrow(Outcomes$State)}
   hospList<-rbind(hospList, x[rank,])
 }
   hospList<-hospList[-1,]
  names(hospList)<-c("hospital", "state")
   hospList
 }
 
 
 



