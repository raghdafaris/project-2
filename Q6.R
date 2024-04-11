## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get coal data from SCC
data_Motor <- SCC[grepl("Motorcycles ", SCC$SCC.Level.Three), ]

# find the coal code 
Motor_scc <- unique(data_Motor$SCC)

#  taking only the Baltimore City data 
Baltimore<- subset(NEI, fips == "24510")

LA<- subset(NEI, fips == "06037")


# get NEI data that have the coal code in Motor_scc
Motor_Baltimore <- Baltimore[Baltimore$SCC %in% Motor_scc, ]
Motor_LA <- LA[LA$SCC %in% Motor_scc, ]

# find the total sum of each year 
yearly_sum_Baltimore <- aggregate(Motor_Baltimore[, 4], by = list(Year = Motor_Baltimore[, 6]), FUN = sum)
yearly_sum_LA<- aggregate(Motor_LA[, 4], by = list(Year = Motor_LA[, 6]), FUN = sum)

# rename  column 2
colnames(yearly_sum_Baltimore)[2] <- "PM2.5 Value"
colnames(yearly_sum_LA)[2] <- "PM2.5 Value"

# Plotting
png(filename='plot6.png')


# Define the layout for two plots side by side
par(mfrow = c(1, 2))

# Plot the first barplot
barplot(yearly_sum_Baltimore[, 2], 
        main = "Baltimore",
        xlab = "Year",
        ylab = "PM2.5 emitted in tons",
        names.arg = yearly_sum_Baltimore[, 1],
        col = "steelblue",
        ylim = c(0,17))

# Plot the second barplot
barplot(yearly_sum_LA[, 2], 
        main = "LA",
        xlab = "Year",
        ylab = "PM2.5 emitted in tons",
        names.arg = yearly_sum_LA[, 1],
        col = "darkgreen",
        ylim = c(0,17))

# Reset the layout to default
par(mfrow = c(1, 1))

dev.off()

