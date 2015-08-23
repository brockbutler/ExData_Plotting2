## Brock Butler
## Data Science Specialization
## Exploratory Data Analysis Course
## Project 2, Plot 3
## This R script reads course datasets and creates plots to answer the third of six project questions. 

# download URL, file, and working directory names
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
f <- file.path("NEIdata.zip") 
dirName <- "data"

# work in data folder
if (!dir.exists(dirName)){
    download.file(file.url, destfile = f, method = "curl")
    unzip(f, exdir = dirName)
    unlink(f)         
}

# reading the data
NEI <- readRDS(file.path(dirName, "summarySCC_PM25.rds"))
SCC <- readRDS(file.path(dirName, "Source_Classification_Code.rds"))

## use ggplot 2 package
install.packages("ggplot2")
library(ggplot2) 


# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999-2008 for 
# Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 
# plotting system to make a plot answer this question.

# Subset or filter dataset down to only include emissions from years 1999, 2002, 2005, and 2008.
# But there should not be needed but subset it just in case
NEI_subset <- subset(NEI, subset=(fips == "24510"))

# Create Plot 3
png("plot3.png", width=480, height=480, units="px", bg="transparent")
ggp <- ggplot(NEI_subset,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + 
    guides(fill=FALSE)+
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))
print(ggp)
dev.off()

# Point, nonpoint, and onroad sources have seen a decrease in emissions for Baltimore.
# Nonroad sources have seen a slight increase in emissions for Baltimore.