
##Get the working directory and set working directory as needed.
getwd()
setwd("C:/Users/Mason/Desktop/ExploratoryDataAnalysisProject2")

##Unzip file.
unzipped <- unzip(zipfile="exdata_data_NEI_data.zip")

## Read and store RDS files into variables.
### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Aggregated data on year(s) for png output graphs.
AggregatedNEI <- aggregate(Emissions~year, NEI, sum)

png('plot1.png')
barplot(height = AggregatedNEI$Emissions, names.arg = AggregatedNEI$year, xlab = "Years", ylab = "Emissions", main = "Emissions by Select Years", col = "blue")
dev.off()