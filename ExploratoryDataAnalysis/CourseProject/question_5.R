library(ggplot2)
library(sqldf)

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

# Question 5:
# How have emissions from motor vehicle sources changed from 1999 to 2008 in Baltimore City?

NEI <- loadData("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter the emissions to vehicle related sources in Baltimore
VEHICLE_RELATED_EMISSIONS_IN_BALTIMORE <- sqldf(
    "select NEI.* from SCC inner join NEI on NEI.SCC = SCC.SCC where NEI.fips = '24510' and SCC.`SCC.Level.Two` like '%vehicle%'"
)

# Aggregate the emmissions by year, summing the emmisions values
SUMMARY = sqldf('select sum(Emissions) as emissions, year from VEHICLE_RELATED_EMISSIONS_IN_BALTIMORE group by year')

ggplot(SUMMARY, aes(factor(year),emissions)) +
    geom_bar(stat = "identity") +
    labs(x ="Year", y = "Total PM2.5 emissions (tons)") +
    labs(title="PM2.5 Emissions in Baltimore City from motor vehicle sources between 1999 and 2008")
ggsave("cp2_q5.png", width=10, height=6, dpi = 100)

