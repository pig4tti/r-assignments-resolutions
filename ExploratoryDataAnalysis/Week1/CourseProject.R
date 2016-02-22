# Defines the data directory
fileName <- "household_power_consumption.txt"

# This will download an extract the zip file containing the dataset to a kwnon location under your current
# working directory and then delete the zip file
if (!file.exists(fileName)) {
    tmp_file <- "./temp.zip"
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ,tmp_file, method="curl")
    unzip(tmp_file, exdir="./")
    unlink(tmp_file)
}

# The column names
columnNames <- c('Date', 'Time', 'Global_active_power','Global_reactive_power','Voltage','Global_intensity', 'Sub_metering_1','Sub_metering_2', 'Sub_metering_3')
columnClasses <- c('Date', 'character', rep('decimal', 7))

# reads the file, restricting the data loaded to the period between 2007-02-01 and 2007-02-02. 
data <- read.csv2(fileName, sep = ';', skip = 66637, nrows = 2880, header = FALSE, col.names = columnNames, colClasses = columnClasses)