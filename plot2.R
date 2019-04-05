## Read in data
data <- read.table("/Users/danicurl/Desktop/household_power_consumption.txt", sep = ';', header=TRUE)

## Convert Date column from factor to dates
## Note: this reformats them as yyyy-mm-dd
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")


## Convert Time column from factor to time
## Note: Must have lubridate package installed
library(lubridate)
data$Time <- hms(data$Time)

## Divide all Global Active Power labels by 500, this will give
## give us the single-number x-axis labels later
data$Global_active_power = as.numeric(data$Global_active_power)/500

## Create new column with day of week and to combine Date and Time for plotting
data$Day <- weekdays(data$Date)
data$Date_Time <- ymd_hms(paste(data$Date, data$Time))

## Subset Dates to 2007-02-01 and 2007-02-02 (yyyy-mm-dd)
data_subset <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]

## Format plot to be square in shape
par(pty="s")

# Designate x and y coordinates and plot graph
x <- data_subset$Date_Time
y <- data_subset$Global_active_power

plot(y ~ x, type="n", xlab = "", ylab = "Global Active Power (kilowats)")
lines(y ~ x)
