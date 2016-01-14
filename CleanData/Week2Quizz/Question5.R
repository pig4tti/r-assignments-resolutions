# define the columns width on the document
widths <- c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4) #negative numbers will skip the column
# read the document according to the spec
cleanDatframe <- read.fwf("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", widths, skip=4)
result <- sum(cleanDatframe[, 4])