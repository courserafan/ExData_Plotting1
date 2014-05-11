### Assume that the data has been downloaded and unzipped in the current
### folder 
powerData <-
  read.table("./data/household_power_consumption.txt", sep=";",
             header=TRUE,
             na.strings = "?")
### clean and transform data columns to appropriate classes
powerData <- transform(powerData,
                       Date=as.POSIXct(paste(Date, Time),
                           format="%d/%m/%Y %H:%M:%S"),
                       Time=Time,
                       Global_active_power=as.numeric(Global_active_power),
                       Global_reactive_power=as.double(Global_reactive_power),
                       Voltage=as.double(Voltage),
                       Global_intensity=as.double(Global_intensity),
                       Sub_metering_1=as.double(Sub_metering_1),
                       Sub_metering_2=as.double(Sub_metering_2),
                       Sub_metering_3=as.double(Sub_metering_3))
### time and date column have been combined so Time is reduntant
powerData <- subset(powerData, select=c(-Time))
### Remove dates which are na
powerData <-  subset(powerData, !is.na(Date))
### subset data for the time period given
startDate <- as.POSIXct("2007-02-01")
endDate <- as.POSIXct("2007-02-03")
### Finally subset the data to the required time period
powerData <- subset(powerData, Date >= startDate & Date < endDate)


### Draw plot 1

png("figure/plot1.png")
hist(powerData$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     ylab = "Fequency",
     main = "Global Active Power",
     col='red')
dev.off()
### End
