ensureFileExists <- function(fileName, url) {
    defaultDataDir <- "./data";
    if (!file.exists(defaultDataDir)) {
        dir.create(defaultDataDir)
    }
    fullFileName <- file.path(defaultDataDir, fileName)
    if (!file.exists(fullFileName)) {
        download.file(url, fullFileName)
    }
}

