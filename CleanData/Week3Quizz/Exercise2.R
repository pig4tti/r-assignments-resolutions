source("Utils.R")
library(jpeg)

fileName <- "exercise2Image.jpg"
ensureFileExists(fileName, "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg")

img <- readJPEG(file.path("./data", fileName), native = TRUE)

quantile(img, probs = c(.3, .8))