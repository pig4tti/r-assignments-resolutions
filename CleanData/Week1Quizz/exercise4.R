## Question 4:

# Method 1: remove the letter "s" from "https", and use the "http" instead
library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE)
rootNode <- xmlRoot(doc)

sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")

# Method 2: download the XML file first, and then load it into R
if (!file.exists("data")) {
        dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl, destfile = "./data/restaurants.xml", method = "curl")
dateDownloaded <- date()

library(XML)
doc <- xmlTreeParse("./data/restaurants.xml", useInternal = TRUE)
rootNode <- xmlRoot(doc)

sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")
