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

# plot 3 energy sub meterings by hour
plot(hpc1$DateTime, hpc1$Sub_metering_1 ,type="l",ylab = "Energy Sub Metering", xlab="")
lines(hpc1$DateTime, hpc1$Sub_metering_2 ,col = "red")
lines(hpc1$DateTime, hpc1$Sub_metering_3 ,col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"),lty=1)

# save as png file
dev.copy(png,file = "plot_3.png")
dev.off()



