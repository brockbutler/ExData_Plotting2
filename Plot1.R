## Brock Butler
## Data Science Specialization
## Exploratory Data Analysis Course
## Project 2, Plot 1
## This R script reads course datasets and creates plots to answer the first of six project questions. 

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

# 1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all 
# sources for each of the years 1999, 2002, 2005, and 2008.

# Subset or filter dataset down to only include emissions from years 1999, 2002, 2005, and 2008.
NEI_subset <- subset(NEI, subset=(year == "1999" | year == "2002" | year == "2005" | year == "2008"))

# Aggregate the data that will be plotted
NEI_plot_data <- aggregate(NEI_subset[c("Emissions")], list(year = NEI_subset$year), sum) 

# Create Plot 1a (line)
png(filename="plot1a.png", width = 480, height = 480, bg = "transparent")
plot(NEI_plot_data$year,
     NEI_plot_data$Emissions, 
     type="l", 
     xlab="Year",
     ylab = expression(paste("Total ", "PM"["2.5"], " Emissions (tons)")),
     main = expression(paste("Total Emissions from ", "PM"["2.5"], " in US per Year")))
dev.off()

# Create Plot 1b (bar)
png(filename="plot1b.png", width = 480, height = 480, bg = "transparent")
barplot(tapply(X=NEI_plot_data$Emissions, 
               INDEX=NEI_plot_data$year, 
               FUN=sum),
        names.arg=NEI_plot_data$Group.1, 
        col = "#A4DCD1",
        xlab = "Year",
        ylab = expression(paste("Total ", "PM"["2.5"], " Emissions (tons)")),
        main = expression(paste("Total Emissions from ", "PM"["2.5"], " in US per Year")),
        ylim = c(0e+00, 8e+06))
dev.off()

# Yes, total emissions from PM2.5 have decreased in the United States from 1999 to 2008.