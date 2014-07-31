




# Function to capitalize first letter of text
makeCaps <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = ".")}

rankhospital <- function(state, measure, num ="best") {
  outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
 states<-as.list(outcome$State)
 measures<-as.list(colnames(outcome))
 measure<-makeCaps(measure)
 measure<-paste("Hospital.30.Day.Death..Mortality..Rates.from.", measure, sep="")
  ## Check that state and outcome are valid
 if(! as.character(state) %in% states) { 
   stop("invalid state")}
 if(! measure %in% measures) {
    stop("invalid outcome")}
  ## Return hospital name in that state with given rank
  column <-which(measures==measure)
  rank=num
  State<-subset(outcome,outcome$State==state)
  State<-na.omit(State)
 if(num=="best"){rank <-1}
 if(num=="worst"){rank <-nrow(State)}
  State[column]<-suppressWarnings(as.numeric(unlist(State[column])))
  State<-suppressWarnings(State[order(as.numeric(unlist(State[column])), State[2]),])
  Hospital<-State[rank,2]
  Hospital
}





