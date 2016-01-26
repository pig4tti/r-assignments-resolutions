source("Utils.R")

fileName <- "clean_data_w4_ex2.csv"
ensureFileExists(fileName, "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")

# loads the csv
colClasses = c("character", rep("NULL", 2), rep("character", 2), rep("NULL", 5)) # read only the columns that matters
gdp <- read.csv(file.path("./data/", fileName), skip = 5, nrows = 190, blank.lines.skip = TRUE, header = FALSE, colClasses = colClasses)
colnames(gdp) <- c("CountryCode", "Economy", "GDP2012")

educationalDataFileName <- "clean_data_w4_ex4.csv"
ensureFileExists(educationalDataFileName, "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
educationalData <- read.csv(file.path("./data/", educationalDataFileName))

mergedData <- merge(gdp, educationalData, by.x = "CountryCode", by.y = "CountryCode")

nrow(mergedData[grepl("^Fiscal year end: June", mergedData$Special.Notes) , ]) # 13