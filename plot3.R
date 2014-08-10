## This program reads household_power_consumption.txt file and produces a 
## line plots of Sub Metering

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
png(filename = "plot3.png",width = 480, height = 480, units = "px")

## Plot first plot
plot(selData$DateTime,selData$Sub_metering_1,ylab = "Energy sub metering",type = "l", xaxt = "n", xlab="",col="black")

# Add second and third plots
lines(selData$DateTime,selData$Sub_metering_2, col = "red")
lines(selData$DateTime,selData$Sub_metering_3,col="blue")  

# label x axis
r <- as.POSIXct(round(range(selData$DateTime), "days"))
axis.POSIXct(1, at=seq(r[1], r[2], by="days"), format="%a")

## Add legend
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=2, col = c("black","red","blue")) 

dev.off()
