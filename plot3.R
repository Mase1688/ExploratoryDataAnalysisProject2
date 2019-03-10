
##Get the working directory and set working directory as needed.
getwd()
setwd("C:/Users/Mason/Desktop/ExploratoryDataAnalysisProject2")

##Unzip file.
unzipped <- unzip(zipfile="exdata_data_NEI_data.zip")

##Load ggplot2 package.
library(ggplot2)

## Read and store RDS files into variables.
### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Subset and aggregated data for Baltimore on year(s) for png output graphs.
BaltimoreNEI <- subset(NEI, fips == "24510")
BaltimoreNEI <- aggregate(Emissions~year+type, BaltimoreNEI, sum)

png('plot3.png', width = 480, height = 480)
Baltimore <- ggplot(data = BaltimoreNEI, aes(year, Emissions, color = type))
Baltimore <- Baltimore + geom_line() + xlab("Years") + ylab("Emissions") + ggtitle("Baltimore Emissions by Select Years & Type")
print(Baltimore)
dev.off()