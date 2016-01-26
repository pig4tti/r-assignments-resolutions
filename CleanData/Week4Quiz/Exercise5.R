library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

Records_in_2012 <- sapply(sampleTimes, function (item) { grepl("^2012-", item) })
print(length(Records_in_2012[Records_in_2012 == TRUE])) # 250

Records_on_Mondays <- sapply(sampleTimes, function (item) { grepl("Mon2012", format(item, "%a%Y")) })
print(length(Records_on_Mondays[Records_on_Mondays == TRUE])) # 47