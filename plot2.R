
##Get the working directory and set working directory as needed.
getwd()
setwd("C:/Users/Mason/Desktop/ExploratoryDataAnalysisProject2")

##Unzip file.
unzipped <- unzip(zipfile="exdata_data_NEI_data.zip")

## Read and store RDS files into variables.
### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset and aggregated data for Baltimore on year(s) for png output graphs.
BaltimoreNEI <- subset(NEI, fips == "24510")
BaltimoreNEI <- aggregate(Emissions~year, BaltimoreNEI, sum)

png('plot2.png')
barplot(height = BaltimoreNEI$Emissions, names.arg = BaltimoreNEI$year, xlab = "Years", ylab = "Emissions", main = "Baltimore Emissions by Select Years", col = "blue")
dev.off()