

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
head(hpc)

#convert data into the right format for plots
hpc$Global_active_power <- as.numeric(gsub(",", "", hpc$Global_active_power))

#draw plot and save in png
png("plot1.png", height=480, width=480)
hist(hpc$Global_active_power, col="red", 
    xlab = "Global Active Power (kilowatts)",
    main="Global Active Power")
dev.off()
