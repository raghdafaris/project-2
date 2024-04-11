## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#  taking only the Baltimore City data 
Baltimore<- subset(NEI, fips == "24510")

# find the total sum of each year 
yearly_sum <- aggregate(Baltimore[, 4], by = list(Year = Baltimore[, 6]), FUN = sum)
# rename  column 2
colnames(yearly_sum)[2] <- "PM2.5 Value"

# ploting 
png(filename='plot2.png')

# Define colors for bars
bar_colors <- rainbow(nrow(yearly_sum))

barplot(yearly_sum[, 2], 
        main = " Total PM2.5 emission of Baltimore City", 
        xlab = "Year", 
        ylab = "PM2.5 emitted in tons", 
        names.arg = yearly_sum[, 1],
        col = bar_colors)

dev.off()