best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    if (!(state %in% data$State)) {
        stop("invalid state");
    }
    
    index <- switch(outcome, "heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    if (is.null(index)) {
        stop("invalid outcome");
    }
    
    ## filter by state
    stateData <- data[data$State == state, ]
    
    ## get best outcome
    minIndicatorValue <- min(suppressWarnings(as.numeric(stateData[,index])), na.rm = TRUE)
    
    ## get best hospital name
    stateData$Hospital.Name[stateData[ ,index] == minIndicatorValue]
}