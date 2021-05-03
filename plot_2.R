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

# plot Global Active Power histogram by hour
with(hpc1, plot(DateTime, Global_active_power,type="l",
                ylab = "Global Active Power (kilowatts)", xlab=""))

# save as png file
dev.copy(png,file = "plot_2.png")
dev.off()

