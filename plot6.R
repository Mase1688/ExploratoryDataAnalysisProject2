
##Get the working directory and set working directory as needed.
getwd()
setwd("C:/Users/Mason/Desktop/ExploratoryDataAnalysisProject2")

##Unzip file.
unzipped <- unzip(zipfile="exdata_data_NEI_data.zip")

##Load ggplot2 package.
library(ggplot2)

## Read and store RDS files into variables.
### This first line will likely take a few seconds. Be patient!
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

##Match, subset and aggregated data for Baltimore and LA vehicles on year(s) for png output graphs.
vehicle <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case = TRUE)
vehicleSCC <- SCC[vehicle, SCC]
vehicleNEI <- NEI[NEI[, SCC] %in% vehicleSCC,]

vehicleBaltNEI <- vehicleNEI[fips == "24510",]
vehicleBaltNEI[, city := c("Baltimore City")]

vehicleLANEI <- vehicleNEI[fips == "06037",]
vehicleLANEI[, city := c("Los Angeles")]

MergedFiles <- rbind(vehicleBaltNEI,vehicleLANEI)

##Png output graph.
png('plot6.png', width = 640, height = 760)
ggplot(MergedFiles, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="Years", y="Emissions") + 
  labs(title="Vehicle Emissions in Baltimore & LA for Select Years")
dev.off()