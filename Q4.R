## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get coal data from SCC
data_coal <- SCC[grepl("Comb.*Coal", SCC$EI.Sector), ]

# find the coal code 
coal_scc <- unique(data_coal$SCC)

# get NEI data that have the coal code in coal_scc
Coal_data <- NEI[NEI$SCC %in% coal_scc, ]

# find the total sum of each year 
yearly_sum <- aggregate(Coal_data[, 4], by = list(Year = Coal_data[, 6]), FUN = sum)
# rename  column 2
colnames(yearly_sum)[2] <- "PM2.5 Value"

# Plotting
png(filename='plot4.png')

# Define colors for bars
bar_colors <- rainbow(nrow(yearly_sum))

plot1<- barplot(yearly_sum$`PM2.5 Value`/1000, 
        main = "Total PM2.5 Emissions of Coal", 
        xlab = "Year",
        ylab = "PM2.5 Emissions in Kilotons", 
        names.arg = yearly_sum[,1],
        col = bar_colors,
        ylim = c(0,700))


dev.off()