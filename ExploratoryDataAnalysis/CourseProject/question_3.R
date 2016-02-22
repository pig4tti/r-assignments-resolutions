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

# Question 3:


NEI <- loadData("summarySCC_PM25.rds")

# Aggregate the emmissions by year, summing the emmisions values
SUMMARY = sqldf('select sum(Emissions) as emissions, type, year from NEI where fips = "24510" group by type, year')

# Put the emissions into scale of 10^6 tons (mega-tons)
SUMMARY$emissions = SUMMARY$emissions/10^6

print(ggplot(SUMMARY,aes(factor(year),emissions, fill=type)) + guides(fill=FALSE) +
    geom_bar(stat = "identity") +
    facet_grid( . ~ type) +
    xlab("Year") +
    ylab("Total PM2.5 emissions (mega-tons)") +
    labs(title="PM2.5 emissions in Baltimore City between 1999-2008 by source type"))

ggsave("cp2_q3.png", width=10, height=6, dpi = 100)

