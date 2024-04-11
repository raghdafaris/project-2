## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# find the total sum of each year 
yearly_sum <- aggregate(NEI[, 4], by = list(Year = NEI[, 6]), FUN = sum)

# rename  column 2
colnames(yearly_sum)[2] <- "PM2.5 Value"

# ploting 
png(filename='plot1.png')

# Define colors for bars
bar_colors <- rainbow(nrow(yearly_sum))

barplot(yearly_sum[, 2], 
        main = " Total PM2.5 emission", 
        xlab = "Year", 
        ylab = "PM2.5 emitted in tons", 
        names.arg = yearly_sum[, 1],
        col = bar_colors)

dev.off()