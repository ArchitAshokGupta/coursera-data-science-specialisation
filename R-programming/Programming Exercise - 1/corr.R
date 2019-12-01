corr <- function(directory, threshold=0)
  {
  
  files <- list.files(directory, full.names=TRUE)
  data <- vector(mode="numeric", length=0)
  
  for (i in 1:length(files)) 
    {
      
      file <- read.csv(files[i])
      csum <- sum((!is.na(file$sulfate)) & (!is.na(file$nitrate)))
      
      if (csum > threshold) 
        {
          tmp <- file[which(!is.na(file$sulfate)), ]
          df <- tmp[which(!is.na(tmp$nitrate)), ]
          data <- c(data, cor(df$sulfate,df$nitrate))
        }
      
    }
  
  data
  
  }