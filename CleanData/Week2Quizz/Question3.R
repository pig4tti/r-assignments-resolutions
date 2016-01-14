library(sqldf)

# loads the csv
acs <- read.csv.sql("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")

# executes the queries proposed
query1 <- sqldf("select distinct AGEP from acs") # Results a dataframe
identical(query1[,1], unique(acs$AGEP)) ## the types should be the same to be compared

# other queries
# "select unique AGEP from acs" there is no unique operator on SQL
# "select AGEP where unique from acs" syntax failure
# "select distinct pwgtp1 from acs" is distict on the wrong field

