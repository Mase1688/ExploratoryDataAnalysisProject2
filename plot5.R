
##Get the working directory and set working directory as needed.
getwd()
setwd("C:/Users/Mason/Desktop/ExploratoryDataAnalysisProject2")

##Unzip file.
unzipped <- unzip(zipfile="exdata_data_NEI_data.zip")

##Load ggplot2 package.
library(ggplot2)

## Read and store RDS files into variables and merge/combine..
### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
MergedFiles <- merge(NEI, SCC, by = "SCC")

##Subset and aggregated data for Baltimore on year(s) for png output graphs.
BaltimoreNEI <- subset(NEI, fips == "24510" & type =="ON-ROAD")
BaltimoreNEI <- aggregate(Emissions~year, BaltimoreNEI, sum)

png('plot5.png', width = 480, height = 640)
Baltimore <- ggplot(data = BaltimoreNEI, aes(factor(year), Emissions))
Baltimore <- Baltimore + geom_bar(stat = "identity") + xlab("Years") + ylab("Emissions") + ggtitle("Baltimore Vehicle Emissions by Select Years")
print(Baltimore)
dev.off()