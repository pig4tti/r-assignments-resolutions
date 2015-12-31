getFileName <- function (id, directory) {
    paste(c(file.path(directory, sep=""), padLeft(id), ".csv"), collapse="")
}

padLeft <- function(string) {
    sprintf("%03d", string);
}

readFile <- function (fileName) {
    read.csv(fileName);
}

stringEndsWith <- function (string, char) {
    char == substr(string, nchar(string), nchar(string))
}

getFileNames <- function (id, directory) {
    lapply(id, getFileName, directory = directory)
}