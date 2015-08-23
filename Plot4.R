## Brock Butler
## Data Science Specialization
## Exploratory Data Analysis Course
## Project 2, Plot 4
## This R script reads course datasets and creates plots to answer the fourth of six project questions. 

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

# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

## use ggplot 2 package
install.packages("ggplot2")
library(ggplot2) 

# Create Dataset 
# Coal combustion related sources 
SCC.coal = SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),] 
merge <- merge(x=NEI, y=SCC.coal, by="SCC") 
merge.sum <- aggregate(merge[, "Emissions"], by=list(merge$year), sum) 
colnames(merge.sum) <- c("Year", "Emissions") 

# Create Plot 4
png("plot4.png", width=480, height=480, units="px", bg="transparent") 
ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) +  
    geom_bar(stat="identity", fill="#A4DCD1", width=0.75) +
    theme_bw() +  
    guides(fill=FALSE) + 
    labs(x="Year", y=expression("Total PM"[2.5]*" Emissions (kilotons)")) + 
    labs(title=expression("Total Coal Combustion Emissions of PM"[2.5])) + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))
dev.off()

# Coal combustion emissions have decreased from 1999 - 2008.