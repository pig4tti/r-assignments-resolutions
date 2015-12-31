rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings = "Not Available")
    
    index <- switch(outcome, "heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)
    if (is.null(index)) {
        stop("invalid outcome");
    }
    
    states <- sort(unique(data$State))
    
    rankedHospital <- sapply(states, rank, data = data, num = num, index = index)
    
    data.frame(hospital=rankedHospital, state=states)
}

rank <- function (state, num, data, index) {
    stateData <- subset(data, State == state)
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