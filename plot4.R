### Script creates Plot1.png for Coursera Exploratory Data Analysis Assignment 1
library(readr)
library(dplyr)
library(lubridate)

## Step 1. Download Data
download.site <- "https://d396qusza40orc.cloudfront.net/"
download <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
save.file.as <- "household_power_consumption.zip"

if(!(save.file.as %in% list.files())){
  download.file(paste0(download.site, download), save.file.as, method = "curl")
  unzip(save.file.as)
}

# Step 2. Read in Data
if(!("power.readings" %in% ls())){
  power.readings <- read_csv2("household_power_consumption.txt",
                              col_types = "ccnnnnnnn", na = "?")
  names(power.readings) <- gsub("_", ".", tolower(names(power.readings)))

  start.date <- dmy_hms("01/02/2007 00:00:00")
  end.date <-  dmy_hms("02/02/2007 23:59:59")
  power.readings <- power.readings %>%
    mutate(date.time = dmy_hms(paste(date, time, sept = " "))) %>%
    filter(between(date.time, start.date, end.date)) %>%
    select(10, 3:9)
}

par(mfrow = c(2,2))
source("plot2.R")
with(power.readings, plot(date.time, voltage / 1000, ylab = "Voltage",
                          type = "l"))
source("plot3.R")
with(power.readings, plot(date.time, global.reactive.power, type = "l"))

dev.copy(png, "plot4.png", width = 1100, height = 1100)
dev.off()
