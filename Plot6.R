## Brock Butler
## Data Science Specialization
## Exploratory Data Analysis Course
## Project 2, Plot 6
## This R script reads course datasets and creates plots to answer the sixth of six project questions. 

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

# 6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen 
# greater changes over time in motor vehicle emissions?

## use ggplot 2 package
install.packages("ggplot2")
library(ggplot2) 

# Years
NEI$year <- factor(NEI$year, levels=c("1999", "2002", "2005", "2008")) 

# Baltimore City, Maryland 
Baltimore.onroad <- subset(NEI, fips == "24510" & type == "ON-ROAD") 

# Los Angeles County, California 
LA.onroad <- subset(NEI, fips == "06037" & type == "ON-ROAD") 

# Aggregate 
Baltimore.DF <- aggregate(Baltimore.onroad[, "Emissions"], by=list(Baltimore.onroad$year), sum) 
colnames(Baltimore.DF) <- c("Year", "Emissions") 
Baltimore.DF$City <- paste(rep("Baltimore, MD", 4)) 

LA.DF <- aggregate(LA.onroad[, "Emissions"], by=list(LA.onroad$year), sum) 
colnames(LA.DF) <- c("Year", "Emissions") 
LA.DF$City <- paste(rep("Los Angeles, CA", 4)) 

plot_data <- as.data.frame(rbind(Baltimore.DF, LA.DF)) 

# Plot 6
png("plot6.png", width=480, height=480, units="px", bg="transparent")  
ggplot(data=plot_data, aes(x=factor(Year), y=Emissions, fill=City)) +
    geom_bar(aes(fill=Year),stat="identity", fill="#A4DCD1", width=0.75) +
    facet_grid(scales="free", space="free", .~City) +
    theme_bw() +  
    guides(fill=FALSE) +
    labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (tons)")) + 
    labs(title=expression("Total PM"[2.5]*" Motor Vehicle Source Emissions\n Los Angeles County, CA vs. Baltimore City, MD"))+
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))
dev.off() 

# Baltimore, MD has seen a greater change in motor vehicle emissions between 1998 and 2009.