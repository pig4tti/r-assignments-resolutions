source("Utils.R")

fileName <- "clean_data_w4_ex2.csv"
ensureFileExists(fileName, "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")

# loads the csv
colClasses = c("character", rep("NULL", 2), rep("character", 2), rep("NULL", 5)) # read only the columns that matters
gdp <- read.csv(file.path("./data/", fileName), skip = 5, nrows = 190, blank.lines.skip = TRUE, header = FALSE, colClasses = colClasses)
colnames(gdp) <- c("CountryCode", "Economy", "GDP2012")

numericGdp = sapply(gdp$GDP2012, function (item) { as.integer(gsub(",", "", item)) })

mean(numericGdp)
# [1] 377652.4

# Exercise 3:
grep("^United",gdp$Economy, value = TRUE)
# OR
grep("United*",gdp$Economy, value = TRUE)