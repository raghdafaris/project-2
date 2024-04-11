## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

#  taking only the Baltimore City data 
Baltimore<- subset(NEI, fips == "24510")

# Group data by category and year, and calculate the sum of column 4
summed_data <- aggregate(Baltimore[, 4], by = list(Category  = Baltimore[, 5], Year = Baltimore[, 6]), FUN = sum)

# Create plot
p <- ggplot(summed_data, aes(x = Year, y = x)) +
  geom_bar(stat = "identity", fill = "darkgreen" ) +
  labs(title = "Total PM2.5 emission",
       x = "Year",
       y = "PM2.5 emitted in tons") +
  facet_wrap(~ Category, scales = "free_y", labeller = labeller(Category = function(x) paste(unique(summed_data$Category)))) +
  scale_x_continuous(breaks = seq(1999, 2008, by = 3), labels = c("1999", "2002", "2005", "2008")) +
  theme_minimal() +
  theme(
    plot.background = element_rect(fill = "white"),
    panel.background = element_rect(fill = "white")
  )  # Change background color to white for entire plot
# Save the plot
ggsave("plot3.png", plot = p)

