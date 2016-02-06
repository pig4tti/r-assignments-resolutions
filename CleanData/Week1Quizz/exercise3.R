library(xlsx)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "data.xlsx", method = "curl")


# rowIndex = 18 : 23
# colIndex = 7 : 15
# dat <- read.xlsx("data.xlsx", sheetIndex = 1, rowIndex = rowIndex, colIndex = colIndex, header = TRUE)
# sum(dat$Zip * dat$Ext, na.rm=T)