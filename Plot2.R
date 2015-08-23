## Brock Butler
## Data Science Specialization
## Exploratory Data Analysis Course
## Project 2, Plot 2
## This R script reads course datasets and creates plots to answer the second of six project questions. 

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

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
# plot answering this question.

# Subset or filter dataset down to only include emissions from years 1999, 2002, 2005, and 2008.
# But there should not be needed but subset it just in case
NEI_subset <- subset(NEI, subset=(fips == "24510"))

# Aggregate the data that will be plotted
NEI_plot_data <- aggregate(NEI_subset[c("Emissions")], list(year = NEI_subset$year), sum) 

# Create Plot 2a (line)
png(filename="plot2a.png", width = 480, height = 480, bg = "transparent")
plot(NEI_plot_data$year,
     NEI_plot_data$Emissions, 
     type="l", 
     main = expression(paste("Total Emissions from ", "PM"["2.5"], " in Baltimore per Year")), 
     ylab = expression(paste("Total ", "PM"["2.5"], " Emissions (tons)")), 
     xlab="Year")
dev.off()

# Create Plot 2b (bar)
png(filename="plot2b.png", width = 480, height = 480, bg = "transparent")
barplot(tapply(X=NEI_plot_data$Emissions, 
               INDEX=NEI_plot_data$year, 
               FUN=sum), 
        col = "#A4DCD1",
        main = expression(paste("Total Emissions from ", "PM"["2.5"], " in Baltimore per Year")), 
        ylab = expression(paste("Total ", "PM"["2.5"], " Emissions (tons)")), 
        xlab="Year")
dev.off()

# Yes, total emissions from PM2.5 have decreased in Baltimore from 1999 to 2008.