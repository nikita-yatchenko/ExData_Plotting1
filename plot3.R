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

#### Plot 3 ####

png(filename = "plot3.png", width = 480, height = 480)

par(ps=9, mar = c(4,4,3,1), bg = 'transparent')
with(data_use, plot(DateTime, Sub_metering_1, type='n', ylab='Energy sub metering',xlab=''))
axis(side=2, at=seq(0,30,by=10))
with(data_use, lines(DateTime, Sub_metering_1, col = 'black'))
with(data_use, lines(DateTime, Sub_metering_2, col = 'red'))
with(data_use, lines(DateTime, Sub_metering_3, col = 'blue'))
legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lty = 1, col = c('black', 'red', 'blue'), cex = 0.9)

dev.off()