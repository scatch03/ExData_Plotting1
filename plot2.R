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
png(filename = "plot2.png", width = 480, height = 480)

# graph appears to be simple Global_active_power ~ Date + Time scatterplot
with(data, plot(Date+Time, Global_active_power, type="l", xlab = "", ylab="Global Active Power (kilowatts)"))

# close png device
dev.off()