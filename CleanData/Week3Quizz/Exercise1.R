source("Utils.R")

fileName <- "ex1.csv"
ensureFileExists(fileName, "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

# loads the csv
csv <- read.csv(file.path("./data/", fileName))

# logical vector for households on greater than 10 acres & sold more than $10,000 worth of agriculture products
agricultureLogical <- csv$ACR == 3 & csv$AGS == 6

# applies the which function and retrieve the first 3 elements
which(agricultureLogical)[1:3]