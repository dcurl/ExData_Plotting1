## Read in data
data <- read.table("/Users/danicurl/Desktop/household_power_consumption.txt", sep = ';', header=TRUE)

## Convert Date column from factor to dates
## Note: this reformats them as yyyy-mm-dd
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Divide all Global Active Power labels by 500, this will give
## give us the single-number x-axis labels later
data$Global_active_power = as.numeric(data$Global_active_power)/500

## Subset Dates to 2007-02-01 and 2007-02-02 (yyyy-mm-dd)
data_subset <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

## Draw Histogram
hist(as.numeric(data_subset$Global_active_power), col='red', breaks = 15, main = "Global Active Power", xlab="Global Active Power (kilowats)", ylim=c(0,1200), las=2)
