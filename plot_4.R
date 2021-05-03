#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","data/hpc.zip")
# load packages
library(sqldf)
library(dplyr)
library(lubridate)

# read and subset data
hpc <- read.csv("data/household_power_consumption.txt", colClasses = c("character","character", rep("numeric",7)), 
                na.strings = "?",sep=";", header = TRUE)

# convert to tibble and use dplyr to subset data and convert to appropriate classes
hpc <- as_tibble(hpc)
hpc1 <- hpc %>%
   mutate(DateTime = strptime(paste(Date, Time),"%d/%m/%Y %H:%M:%S")) %>%
   filter(DateTime >= "2007-02-01" & DateTime <= "2007-02-03") %>%
   print

# plotting
# set columns and rows for display screen
par(mfrow=c(2,2))

# plot 1st graph
with(hpc1, plot(DateTime, Global_active_power,type="l",
                ylab = "Global Active Power", xlab=""))

# plot 2nd graph
with(hpc1, plot(DateTime, Voltage,type="l",
                ylab = "Voltage", xlab="datetime"))

# plot 3rd graph
plot(hpc1$DateTime, hpc1$Sub_metering_1 ,type="l",ylab = "Energy Sub Metering", xlab="")
lines(hpc1$DateTime, hpc1$Sub_metering_2 ,col = "red")
lines(hpc1$DateTime, hpc1$Sub_metering_3 ,col = "blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"),lty=1, cex=0.5)

# plot 4th graph
with(hpc1, plot(DateTime, Global_reactive_power,type="l",
                ylab = "Global reactive power", xlab="datetime"))

# save to png file
dev.copy(png,file = "plot_4.png")
dev.off()
