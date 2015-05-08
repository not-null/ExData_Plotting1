library("data.table")
# Read the data 
# Data is huge and it takes approx 150 MB memory. Optimise the read of data as below

epc.data <- read.table("household_power_consumption.txt", header=TRUE, nrows = 100, sep=";")
epc.col.classes <- sapply(epc.data, class)

# we can calculate the total number of rows. Unix command : wc -l household_power_consumption.txt
# fread is much faster then read.table
epc.data <- fread("household_power_consumption.txt",nrows=2075260, header=TRUE, sep = ";", na.strings = "?",colClasses = epc.col.classes)

# subset the data on the dates of interest
epc.data.filter <- subset(epc.data, as.Date(epc.data$Date, format = "%d/%m/%Y") >= as.Date("2007-02-01") & as.Date(epc.data$Date, format = "%d/%m/%Y") <= as.Date("2007-02-02"))

# epc.data is big so remove it immediately
rm(epc.data)

epc.data.filter$DateTime <- as.POSIXct(strptime(paste(epc.data.filter$Date,epc.data.filter$Time), "%d/%m/%Y %H:%M:%S"))

# draw the plot
png(file = "plot2.png", width=480, height=480)
plot(epc.data.filter$DateTime,epc.data.filter$Global_active_power, ylab="Global Active Power (kilowatts)", xlab ="", type = "l")
dev.off()
rm(list = ls())
