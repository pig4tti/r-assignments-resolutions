library(plyr)
library(dplyr)

download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile = "q3_1.csv", 
              method = "curl")
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
              destfile = "q3_2.csv", 
              method = "curl")

# load the datasets
q3_1 <- read.csv("q3_1.csv", header = TRUE, skip = 3, sep = ",")
q3_2 <- read.csv("q3_2.csv", header = TRUE)

# reshaping data
q3_1 <- q3_1[2:191, c(1,2,4,5)]
rownames(q3_1) <- NULL
q3_1 <- rename(q3_1, CountryCode = X)

# merge two datasets
q3_merge <- join(q3_1, q3_2)

# show the number of matches
sum(!is.na(unique(q3_merge$Ranking))) #189

# convert the data type of Ranking
q3_merge$Ranking <- as.numeric(as.character(q3_merge$Ranking))

# show the 13th country after sort decending
q3_merge <- arrange(q3_merge, desc(Ranking))
q3_merge[13,3] #  St. Kitts and Nevis


income_group <- group_by(q3_merge, Income.Group)
summarise(income_group, avg = mean(Ranking, na.rm = TRUE))


# Question 5
# cut Ranking into 5 quantile groups
q3_merge$RankingGroup <- cut(q3_merge$Ranking, breaks = 5)

# make a table vs Income.Group
table(q3_merge$RankingGroup, q3_merge$Income.Group)