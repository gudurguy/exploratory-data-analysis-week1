#load libraries
library(sqldf)

# remove all the objects in the env
rm(list = ls())

#file name in the local file system
file <- "household_power_consumption.txt"

#read file selectively with just those dates that are needed, 
#so no need for reading the entire file and then sub setting
data <- read.csv.sql(file,
                     sql = "select * from file where Date = '02/1/2007' or Date = '2/2/2007' and Global_active_power != '?'",
                     header = TRUE, sep = ";")

# Plot 1
attach(data)
hist(Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

# Save file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
detach(data)