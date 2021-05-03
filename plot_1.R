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
hpc <- hpc %>%
   mutate(Date = dmy(Date), Time = hms(Time)) %>%
   filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
   print

# plot Global Active Power histogram
with(hpc, hist(Global_active_power, col="red", main = "Global Active Power", 
               xlab = "Global Active Power (kilowatts)", cex.lab = 0.9))
# save as png file
dev.copy(png,file = "plot_1.png")
dev.off()
