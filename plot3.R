#download and unzip data into working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "power_consumption.zip")
unzip("power_consumption.zip")

#read data and keep only records needed
hpc <- read.csv("household_power_consumption.txt", sep = ";")
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
select_date <- hpc$Date == as.Date("2/1/2007", format="%m/%d/%Y") | 
    hpc$Date == as.Date("2/2/2007", format="%m/%d/%Y")
hpc <- hpc[select_date,]

#convert data into the right format for plots
hpc$Time <- strptime(paste(hpc$Date, hpc$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")
hpc$Global_active_power <- as.numeric(gsub(",", "", hpc$Global_active_power))
hpc$Sub_metering_1 <- as.numeric(gsub(",", "", hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(gsub(",", "", hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(gsub(",", "", hpc$Sub_metering_3))
# test to see if the convertions are done correctly
head(hpc, 100)


#draw plot and save in png
png("plot3.png", height=480, width=480)

plot(hpc$Time, hpc$Sub_metering_1, xlab = "", 
     ylab="Energy sub metering", 
     type="n")
lines(hpc$Time, hpc$Sub_metering_1, col="black")
lines(hpc$Time, hpc$Sub_metering_2, col="red")
lines(hpc$Time, hpc$Sub_metering_3, col="blue")
legend("topright", lwd=1, col=c("black", "red", "blue"),
       legend = c("sub_metering_1", "sub_metering_2", "sub_metering_3"))

dev.off()
