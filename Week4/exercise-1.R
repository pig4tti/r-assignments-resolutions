data <- read.csv("Week4/outcome-of-care-measures.csv", colClasses = "character")
heartAttackData <- as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
histogram <- hist(heartAttackData)