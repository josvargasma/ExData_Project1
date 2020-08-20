## Reading data

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
daysdata <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

## Transform date and time data
daysdata$Date <- as.Date(daysdata$Date, format = "%d/%m/%Y")
daysdata$Time <- strptime(daysdata$Time, format = "%H:%M:%S")
daysdata[1:1440, "Time"] <- format(daysdata[1:1440, "Time"], "2007-02-01 %H:%M:%S")
daysdata[1441:2880, "Time"] <- format(daysdata[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

## Plotting
png(filename = "Plot1.png",
    width = 480,
    height = 480,
    units = "px")
hist(as.numeric(daysdata$Global_active_power), 
     col = "red", 
     xlab = "Global active Power (Kilowatts)",
     main = "Global Active Power")
dev.off()

