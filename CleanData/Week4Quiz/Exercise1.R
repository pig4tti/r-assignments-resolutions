source("Utils.R")

fileName <- "ex1.csv"
ensureFileExists(fileName, "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

# loads the csv
csv <- read.csv(file.path("./data/", fileName))

strsplit(names(csv), "wgtp")[123] # [1] ""   "15"