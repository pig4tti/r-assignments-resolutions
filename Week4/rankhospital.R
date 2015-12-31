rankhospital <- function (state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    if (!(state %in% data$State)) {
        stop("invalid state");
    }
    
    index <- switch(outcome, "heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    if (is.null(index)) {
        stop("invalid outcome");
    }
    
    ## Return hospital name in that state with the given rank
    
    ## filter by state
    stateData <- data[data$State == state, ]
    
    ## get best outcome
    orderedData <- stateData[order(suppressWarnings(as.numeric(stateData[,index])), stateData$Hospital.Name, na.last = NA), ]
    
    ## get best hospital name
    
    if (num == "best") {
        num <- 1
    } else if(num == "worst") {
        num <- nrow(orderedData)
    }
    
    orderedData$Hospital.Name[num]
}