## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get coal data from SCC
data_Motor <- SCC[grepl("Motorcycles ", SCC$SCC.Level.Three), ]

# find the coal code 
Motor_scc <- unique(data_Motor$SCC)

#  taking only the Baltimore City data 
Baltimore<- subset(NEI, fips == "24510")

# get NEI data that have the coal code in Motor_scc
Motor_data <- Baltimore[Baltimore$SCC %in% Motor_scc, ]

# find the total sum of each year 
yearly_sum <- aggregate(Motor_data[, 4], by = list(Year = Motor_data[, 6]), FUN = sum)

# rename  column 2
colnames(yearly_sum)[2] <- "PM2.5 Value"

# Plotting
png(filename='plot5.png')

# Define colors for bars
bar_colors <- rainbow(nrow(yearly_sum))

barplot(yearly_sum[, 2], 
        main = " Total PM2.5 emission motor vehicle", 
        xlab = "Year", 
        ylab = "PM2.5 emitted in tons", 
        names.arg = yearly_sum[, 1],
        col = bar_colors)
               


dev.off()

