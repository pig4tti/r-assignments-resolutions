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

# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

NEI <- loadData("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter the emissions to vehicle related sources in Baltimore and Los Angeles
VEHICLE_EMISSIONS_SUMMARY <- sqldf(
    "select 
        sum(Emissions) as emissions,
        case
            when NEI.fips = '24510' then 'Baltimore City'
            else 'Los Angeles'
        end city,
        year
    from 
        SCC
    inner join
        NEI
        on NEI.SCC = SCC.SCC
    where
        NEI.fips = '24510'
        or NEI.fips = '06037'
        and SCC.`SCC.Level.Two` like '%vehicle%'
    GROUP BY
        year, NEI.fips"
)

ggplot(VEHICLE_RELATED_EMISSIONS, aes(x = factor(year), y = emissions / 10^3, fill = city)) +
    geom_bar(stat="identity", position = "dodge") +
    labs(x ="Year", y = "Total PM2.5 emissions (kilo-tons)") +
    labs(title="PM2.5 Emissions in Baltimore City and Los Angeles from motor vehicle sources between 1999 and 2008") +
    scale_fill_brewer(palette="Paired")
ggsave("cp2_q6.png", width=10, height=6, dpi = 100)

