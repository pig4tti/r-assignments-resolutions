corr <- function(directory, threshold = 0) {
    tcorr <- function(fname) {
        data <- read.csv(file.path(directory, fname))
        nobs <- sum(complete.cases(data))
        if (nobs > threshold) {
            return (cor(data$nitrate, data$sulfate, use="complete.obs"))
        }
    }
    tcorrs <- sapply(list.files(directory), tcorr) #get all correlations + NULLs
    tcorrs <- unlist(tcorrs[!sapply(tcorrs, is.null)]) #remove NULLs
    return (tcorrs)
}