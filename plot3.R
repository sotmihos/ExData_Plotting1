#This script plots the three sub-metering variables with respect to date and 
#time.

#Data preparation
#Read the header
firstLine <- read.table("./household_power_consumption.txt", header = TRUE,
                        sep = ";", na.strings = "?", nrows = 1)
#Read the data
consumption <- read.table("./household_power_consumption.txt", header = FALSE,
                          sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
#Assing the correct header to the data
names(consumption) <- names(firstLine)

#Convert the first two columns to one containing both time and data in
#POSIXlt format and name it Date_Time.
dateTime <- with(consumption, paste(Date, Time))
dateTime <- strptime(dateTime, format = "%d/%m/%Y %H:%M:%S")
consumption <- consumption[, 2:9]
names(consumption)[1] <- "Date_time"
consumption$Date_time <- dateTime


#Draw the three sub-metering readings in "plot3.png" using the PNG file device.
png("./plot3.png")
par(bg = "transparent")
plot(consumption$Date_time, consumption$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering", col = "black")
lines(consumption$Date_time, consumption$Sub_metering_2, type = "l", col = "red")
lines(consumption$Date_time, consumption$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
