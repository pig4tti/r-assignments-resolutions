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

# Question 4:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008

NEI <- loadData("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter the emissions to coal related sources
COAL_RELATED_EMISSIONS <- sqldf("select NEI.* from SCC inner join NEI on NEI.SCC = SCC.SCC where SCC.`EI.Sector` like '%coal%'")


# Aggregate the emmissions by year, summing the emmisions values
SUMMARY = sqldf('select sum(Emissions) as emissions, year from COAL_RELATED_EMISSIONS group by year')

# Put the emissions into scale of 10^6 tons (mega-tons)
SUMMARY$emissions = SUMMARY$emissions/10^6

ggplot(SUMMARY, aes(factor(year),emissions)) +
    geom_bar(stat = "identity") +
    xlab("Year") +
    ylab("Total PM2.5 emissions (mega-tons)") + 
    labs(title="PM2.5 Coal Combustion-Related Emissions Across US from 1999-2008")
ggsave("cp2_q4.png", width=10, height=6, dpi = 100)

