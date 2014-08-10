## This program reads household_power_consumption.txt file and produces a 
## line plot of Global Active Power

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

## Create file
png(filename = "plot2.png",width = 480, height = 480, units = "px")
## plot data
plot(selData$DateTime,selData$Global_active_power,ylab = "Global Active Power (kilowatts)",
     type = "l", xaxt = "n",xlab="")
## Set axis
r <- as.POSIXct(round(range(selData$DateTime), "days"))
axis.POSIXct(1, at=seq(r[1], r[2], by="days"), format="%a")
dev.off()