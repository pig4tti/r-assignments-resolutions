#auxiliary function to load the RDS file
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

# Question 3:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

#load the dataset
NEI <- loadData("summarySCC_PM25.rds")

# Aggregate the emmissions by year, summing the emmisions values
aggreagations <- aggregate(type ~ year, NEI, sum)

# Converts the agregation values into the kilo scale (10^3)
aggreagations$Emissions <- aggreagations$Emissions / 10^3

#png(file='cp2_q2.png', width = 480, height = 480, units = 'px')
mainPlot <- barplot(
    aggreagations$type,
    names.arg=aggreagations$year,
    xlab="Year",
    ylab="Total PM2.5 emissions (kilo-tons)",
    main="Total PM2.5 emissions by year in Baltimore City, Maryland"
)
lines(mainPlot, aggreagations$Emissions/2, col='blue',lwd=2)
points(mainPlot, aggreagations$Emissions/2)
#dev.off()