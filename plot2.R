#### Data Plotting Exercise 1 ####

library(lubridate)

#### Downloading and Subsetting Data #### 
if(!file.exists('./household_power_consumption.zip')){ 
        download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', 
                      destfile = './household_eectric_consumption.zip', mode='wb') 
        unzip('./household_eectric_consumption.zip', exdir = getwd()) 
}

power_data <- read.table('./household_power_consumption.txt', sep=';', na.strings = '?', header = TRUE)
power_data <- power_data %>% mutate(Date = dmy_hms(paste(power_data$Date, power_data$Time, sep=' ') ) )
power_data <- power_data %>% select(-Time) %>% rename(DateTime = Date)

data_use <- subset(power_data, power_data$DateTime >= ymd("2007-02-01") & power_data$DateTime < ymd("2007-02-03"))

#### Plot 2 ####

png(filename = "plot2.png", width = 480, height = 480)

par(bg = 'transparent')
with(data_use, plot(DateTime, Global_active_power, type='l', ylab='',xlab=''))
title(ylab = 'Global Active Power (kilowatts)', line = 2.5)

dev.off()
