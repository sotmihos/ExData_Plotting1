#This script plots the histogram of the Global Active Power.

#Data preparation.
#Read the header.
firstLine <- read.table("./household_power_consumption.txt", header = TRUE,
                        sep = ";", na.strings = "?", nrows = 1)
#Read the data.
consumption <- read.table("./household_power_consumption.txt", header = FALSE,
                          sep = ";", na.strings = "?", skip = 66637, nrows = 2880)
#Assing the correct header to the data.
names(consumption) <- names(firstLine)

#Convert the first two columns to one containing both time and data in
#POSIXlt format and name it Date_Time.
dateTime <- with(consumption, paste(Date, Time))
dateTime <- strptime(dateTime, format = "%d/%m/%Y %H:%M:%S")
consumption <- consumption[, 2:9]
names(consumption)[1] <- "Date_time"
consumption$Date_time <- dateTime


#Draw the histograph of Global Active Power in "plot1.png" using the PNG file 
#device.
png("./plot1.png")
par(bg = "transparent")
hist(consumption$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()