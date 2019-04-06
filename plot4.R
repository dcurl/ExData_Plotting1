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

## Save to file
png("plot4.png")

## Format plot to be square in shape, with grid for 4 graphs
par(pty="s", mfcol = c(2,2), mar = c(4,3,2,1))

################################### PLOT 1 ###################################
# Designate x and y coordinates and plot graph
x <- data_subset$Date_Time
y <- data_subset$Global_active_power

plot(y ~ x, type="n", xlab = "", ylab = "Global Active Power (kilowats)")
lines(y ~ x)

################################### PLOT 2 ###################################
## Designate x and y coordinates and plot graph
y2 <- as.numeric(data_subset$Sub_metering_1)
y3 <- as.numeric(data_subset$Sub_metering_2)
y4 <- as.numeric(data_subset$Sub_metering_3)

## Plot Sub Metering 1
plot(y2 ~ x, type="n", yaxt="n", xlab="", ylab="Energy sub metering")
lines(y2 ~ x)
axis(side=2, at=seq(0, 35, by=10))

## Plot Sub Metering 2
points(y3, type ="n")
lines(y3 ~ x, col = 'red')

## Plot Sub Metering 3
points(y4, type = "n")
lines(y4 ~ x, col = 'blue')

## Add Legend
legend("topright", legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), lty = c(1,1,1), col = c("black", "red", "blue"), cex = .50)

################################### PLOT 3 ###################################

# Designate x and y coordinates and plot graph
y5 <- as.numeric(data_subset$Voltage)

plot(y5 ~ x, type="n", xlab = "datetime", ylab = "Voltage")
lines(y5 ~ x)

################################### PLOT 4 ###################################

# Designate x and y coordinates and plot graph
y6 <- as.numeric(data_subset$Global_reactive_power)

plot(y6 ~ x, type="n", xlab = "datetime", ylab = "global_reactive_power")
lines(y6 ~ x)

## Finish file
dev.off()
