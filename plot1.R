### Script creates Plot1.png for Coursera Exploratory Data Analysis Assignment 1
library(readr)
library(dplyr)
library(lubridate)

## Step 1. Download Data
download.site <- "https://d396qusza40orc.cloudfront.net/"
download <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
save.file.as <- "household_power_consumption.zip"

download.file(paste0(download.site, download), save.file.as, method = "curl")
unzip(save.file.as)

# Step 2. Read in Data
power.readings <- read_csv2("household_power_consumption.txt",
                            col_types = "ccnnnnnnn", na = "?")
names(power.readings) <- gsub("_", ".", tolower(names(power.readings)))

start.date <- dmy_hms("01/02/2007 00:00:00")
end.date <-  dmy_hms("02/02/2007 23:59:59")
power.readings <- power.readings %>%
  mutate(date.time = dmy_hms(paste(date, time, sept = " "))) %>%
  filter(between(date.time, start.date, end.date)) %>%
  select(10, 3:9)

hist(power.readings$global.active.power / 1000, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (killowatts")

dev.copy(png, "plot1.png")
dev.off()