
##Get the working directory and set working directory as needed.
getwd()
setwd("C:/Users/Mason/Desktop/ExploratoryDataAnalysisProject2")

##Unzip file.
unzipped <- unzip(zipfile="exdata_data_NEI_data.zip")

##Load ggplot2 package.
library(ggplot2)

## Read and store RDS files into variables and merge/combine.
### This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
MergedFiles <- merge(NEI, SCC, by = "SCC")

##Match, subset and aggregated data for U.S. coal on year(s) for png output graphs.
USCoalMatch <- grepl("coal", MergedFiles$Short.Name, ignore.case = TRUE)
USCoal <- MergedFiles[USCoalMatch, ]
AggregatedUSCoal <- aggregate(Emissions~year, USCoal, sum)

##Png output graph.
png('plot4.png', width = 480, height = 480)
Coal <- ggplot(AggregatedUSCoal, aes(factor(year), Emissions))
Coal <- Coal + geom_bar(stat = "identity") + xlab("Years") + ylab("Emissions") + ggtitle("Emissions from Coal Sources for Select Years")
print(Coal)
dev.off()