


outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

# Function to capitalize first letter of text
makeCaps <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1, 1)), substring(s, 2),
        sep = "", collapse = ".")}

best <- function(state, measure) {
 states<-as.list(outcome$State)
 measures<-as.list(colnames(outcome))
 measure<-makeCaps(measure)
 measure<-paste("Hospital.30.Day.Death..Mortality..Rates.from.", measure, sep="")
  ## Check that state and outcome are valid
 if(! as.character(state) %in% states) { 
   stop("invalid state")}
 if(! measure %in% measures) {
    stop("invalid outcome")}
  ## Return hospital name in that state with lowest 30-day death rate
  column <-which(measures==measure)
  State<-subset(outcome,outcome$State==state)
  State<-suppressWarnings(State[order(as.numeric(unlist(State[column])), State[2]),])
  Hospital<-State[1,2]
  Hospital
}

best("HI", "heart failmre")