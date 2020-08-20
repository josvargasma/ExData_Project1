## Reading data

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
daysdata <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

## Transform date and time data
daysdata$Date <- as.Date(daysdata$Date, format = "%d/%m/%Y")
daysdata$Time <- strptime(daysdata$Time, format = "%H:%M:%S")
daysdata[1:1440, "Time"] <- format(daysdata[1:1440, "Time"], "2007-02-01 %H:%M:%S")
daysdata[1441:2880, "Time"] <- format(daysdata[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

## Plotting par
png(filename = "Plot4.png",
    width = 480,
    height = 480,
    units = "px")
par(mfrow = c(2,2))

##Plot 4.1
plot(daysdata$Time,
     as.numeric(daysdata$Global_active_power),
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

##Plot 4.2
plot(daysdata$Time,
     as.numeric(daysdata$Voltage),
     type = "l",
     xlab = "date time",
     ylab = "Voltage")

##Plot 4.3
plot(daysdata$Time,
     as.numeric(daysdata$Sub_metering_1),
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     main = "")
with(daysdata,
     lines(Time,
           as.numeric(Sub_metering_2),
           col = "red"))
with(daysdata,
     lines(Time,
           as.numeric(Sub_metering_3),
           col = "blue"))
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Plot 4.4
plot(daysdata$Time,
     as.numeric(daysdata$Global_reactive_power),
     type = "l",
     xlab = "date time",
     ylab = "Global Reactive Power")


dev.off()
