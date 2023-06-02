# load libraries
library(sqldf)

# remove all the objects in the env
rm(list = ls())

# downloaded and unzipped file name in the local file system
file <- "household_power_consumption.txt"

# read file selectively with just those two dates that are needed, 
# so no need for reading the entire file and then sub setting
data <- read.csv.sql(file,
                     sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' and Global_active_power != '?'",
                     header = TRUE, sep = ";")

# Convert dates and times
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

# plot 2
attach(data)
plot(Global_active_power ~ datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
detach(data)