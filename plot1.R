setwd("E:\\Projects\\coursera\\Data Science\\4 Exploratory Data Analysis with R\\Projects\\ExData_Plotting1")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "power_consumption.zip")
unzip("power_consumption.zip")

hpc <- read.csv("household_power_consumption.txt", sep = ";")
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
select_date <- hpc$Date == as.Date("2/1/2007", format="%m/%d/%Y") | 
    hpc$Date == as.Date("2/2/2007", format="%m/%d/%Y")

hpc <- hpc[select_date,]
head(hpc)

hpc$Global_active_power <- as.numeric(gsub(",", "", hpc$Global_active_power))

png("plot1.png", height=480, width=480)
hist(hpc$Global_active_power, col="red", 
    xlab = "Global Active Power (kilowatts)",
    main="Global Active Power")
dev.off()
