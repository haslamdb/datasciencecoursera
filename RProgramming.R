  # commands
  
  add2<-function(x,y) {
    x + y
  }
  
  above<-function (x, n=10){
    use<-x > n
    x[use]
    
    
  }
  
  columnMeans<- function(df, naremove=TRUE) {
    
    nc<-ncol(df)
    means<-numeric(nc)
    for(i in 1:nc) {
      means[i]<-mean(df[ ,i], na.rm = naremove)
    }
    means
  }