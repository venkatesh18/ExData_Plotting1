## This program reads household_power_consumption.txt file and produces a 
## histogram plot of Global Active Power

## Read all data
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                       na.strings = "?", nrows = 5)
classes <- sapply(tab5rows, class)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                   na.strings = "?",colClasses = classes)

## Convert to date
data$Date <- as.Date(data$Date,"%d/%m/%Y")

## Select data corresponding to relevant dates
sec1 <- subset(data,data$Date=="2007-02-01")
sec2 <- subset(data,data$Date=="2007-02-02") 
selData <- rbind(sec1,sec2)
selData$DateTime <- strptime(paste(selData$Date,selData$Time), format = "%Y-%m-%d %H:%M:%S")

## Create PNG file
png(filename = "plot1.png",width = 480, height = 480, units = "px")
## plot histogram
hist(selData[,"Global_active_power"],xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")
dev.off()
