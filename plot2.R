library(data.table)

# Download dataset if not present
if (!file.exists("exdata-data-household_power_consumption.zip")) {
  download.file ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","exdata-data-household_power_consumption.zip",method="curl",quiet=TRUE)
}

# read from ZIP directly
zip<-unz("exdata-data-household_power_consumption.zip",filename="household_power_consumption.txt")

# read data
cl=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
nas=c("","","?","?","?","?","?","?","?")
data<-read.table(zip,header=TRUE, sep=";",na.strings=nas,colClasses=cl)

# subset data to save memory
data<-subset(data,Date=="1/2/2007"|Date=="2/2/2007")

# create POSIX time
data$ct<-as.POSIXct(strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S"))

# create plot
png("plot2.png",width=504,height=504)

with(data, plot(ct,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

dev.off()


