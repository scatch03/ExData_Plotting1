# set up workspace
setwd("/Users/grim/Downloads")

# load lubridate for time conversions
library(lubridate)
# load dplyr for data frame transformations
library(dplyr)

# load data
data <-read.csv("household_power_consumption.txt", sep=";", header = T, na.strings = c("?"),
                colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
# convert date and time
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

# subset to a given dates: 2007-02-01 and 2007-02-02
data <- data %>%
  filter(year(Date)==2007 & month(Date) == 2 & (day(Date) == 1 | day(Date) == 2))

# open png device
png(filename = "plot3.png", width = 480, height = 480)

# graph appears to be series of simple Sub_metering_X ~ Date + Time scatterplot
# prepare plotting device
with(data, plot(Date+Time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))

# plot sub metering graphs
with(data, points(Date+Time, Sub_metering_1, col="black", type="l"))
with(data, points(Date+Time, Sub_metering_2, col="red", type="l"))
with(data, points(Date+Time, Sub_metering_3, col="blue", type="l"))

# add legend
legend("topright", col=c("black", "red", "blue"), lty=c(1, 1, 1), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close png device
dev.off()