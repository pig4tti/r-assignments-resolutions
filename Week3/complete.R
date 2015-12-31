source("read_files.R")

complete <- function(directory, id = 1:332) {
    return (data.frame(id=id, nobs=sapply(id, nobs, directory = directory)))
}

nobs <- function(id, directory) {
    path <- getFileName(id, directory)
    return (sum(complete.cases(readFile(path))))
}