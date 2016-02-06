source("Utils.R")

fileName <- "ex3_gdp.csv"
ensureFileExists(fileName, "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")

gdp <- read.csv(file.path("./data/", fileName), skip = 5, nrows = 190, header = FALSE)
colnames(gdp) <- c(c("CountryCode"), 2:10)
 

fileName <- "ex3_edu.csv"
ensureFileExists(fileName, "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")

edu <- read.csv(file.path("./data/", fileName))

## Merge data by country codes
matchedData <- merge(gdp, edu, by.x = "CountryCode", by.y = "CountryCode")

## How many of the IDs match?
length(match(gdp$CountryCode, edu$CountryCode, nomatch=0))