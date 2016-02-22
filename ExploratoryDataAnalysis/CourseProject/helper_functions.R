loadData <- function (fileName) {
    # Defines the path to the file being loaded
    fullFileName <- paste0("./data/PM25_course_project/", fileName);
    
    # This will download an extract the zip file containing the dataset to a kwnon location under your current
    # working directory and then delete the zip file
    if (!file.exists(fullFileName)) {
        tmp_file <- "./temp.zip"
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip" ,tmp_file, method="curl")
        unzip(tmp_file, exdir="./data/PM25_course_project/")
        unlink(tmp_file)
    }

    dataFrame <- readRDS(fullFileName)
    
    dataFrame
}