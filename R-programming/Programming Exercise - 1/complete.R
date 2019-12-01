complete <- function(directory, id=1:332) 
  {
  
    files <- list.files(directory, full.names=TRUE)
    data <- data.frame()
  
    for (i in id) 
      {
        file <- read.csv(files[i])
        nobs <- sum(complete.cases(file))
        tmp <- data.frame(i, nobs)
        data <- rbind(data, tmp)
      }
    
    colnames(data) <- c("id", "nobs")
    data
    
  }