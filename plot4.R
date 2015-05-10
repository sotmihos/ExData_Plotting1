#This script integrates the graphs for plot 2 and plot 3, among with the plots
#for Voltage and Gobal_reactive_power in a single image.

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
#POSIXlt format
dateTime <- with(consumption, paste(Date, Time))
dateTime <- strptime(dateTime, format = "%d/%m/%Y %H:%M:%S")
consumption <- consumption[, 2:9]
names(consumption)[1] <- "Date_time"
consumption$Date_time <- dateTime

#Create an 2x2 multi-plot graph, filling in collumn-wise with the appropriate
#plots. Draw this graph in file "plot4.png" using the PNG file device.
png("./plot4.png")
par(mfcol = c(2,2), bg = "transparent")

#Plot of Global_active_power
plot(consumption$Date_time, consumption$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

#Plot of the three sum-metering variables. Notice the legend border line type
#is set to "none" in accordance to the fourht figure of the assignment.
plot(consumption$Date_time, consumption$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering", col = "black")
lines(consumption$Date_time, consumption$Sub_metering_2, type = "l", col = "red")
lines(consumption$Date_time, consumption$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

#Plot of the Voltage.
plot(consumption$Date_time, consumption$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

#Plot of the Global_reactive_power.
plot(consumption$Date_time, consumption$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")
dev.off()