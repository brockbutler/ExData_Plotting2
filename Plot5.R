## Brock Butler
## Data Science Specialization
## Exploratory Data Analysis Course
## Project 2, Plot 5
## This R script reads course datasets and creates plots to answer the fifth of six project questions. 

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

# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

## use ggplot 2 package
install.packages("ggplot2")
library(ggplot2) 

# Years
NEI$year <- factor(NEI$year, levels=c("1999", "2002", "2005", "2008")) 

# Baltimore City On-Road 
Baltimore.onroad <- subset(NEI, fips == 24510 & type == "ON-ROAD") 

# Aggregate
Baltimore.df <- aggregate(Baltimore.onroad[, "Emissions"], by=list(Baltimore.onroad$year), sum) 
colnames(Baltimore.df) <- c("Year", "Emissions") 

# Plot 5 
png("plot5.png", width=480, height=480, units="px", bg="transparent") 
ggplot(data=Baltimore.df, aes(factor(Year),Emissions)) +
    geom_bar(stat="identity", fill="#A4DCD1", width=0.75) +
    theme_bw() +  
    guides(fill=FALSE) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008")) +
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))
dev.off() 

# Motor Vehicle emissions have decreased from 1999 - 2008.