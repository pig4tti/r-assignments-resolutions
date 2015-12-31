source("read_files.R")

pollutantmean <- function(directory, pollutant, id = 1:332) {
    dataset <- do.call(
        "rbind",
        lapply(
            getFileNames(id, directory),
            readFile
        )
    );
    
    signif(mean(dataset[, pollutant], na.rm = TRUE), digits = 4);
}
