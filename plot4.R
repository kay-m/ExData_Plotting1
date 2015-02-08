# Coursera Project 1 - "Exploratory Data Analysis" (Feb - Mar 2015)
# The dataset for this project has been taken from the UC Irvine Machine 
# Learning Repository (http://archive.ics.uci.edu/ml/)
# Source of data : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Read in the full data set.

df <- read.csv("household_power_consumption.txt",na.strings=c('?'),sep=";")

# We need to merge the date and time fields in order to get the continuous  
# range of values as seen in plots 2,3 and 4

df$dateTime <- strptime(paste(df$Date,df$Time,sep=":",tz=""),"%d/%m/%Y:%H:%M:%S",tz="GMT")

# By default, the class for the date and time columns will be "factor". Change
# this to date and datetime fields. Though the Time is not used, I am converting
# it anyway. 
df$Date <- as.Date.character(df$Date,"%d/%m/%Y")
df$Time <- strptime(df$Time,format="%H:%M:%S",tz="GMT")


# Extract the subset of data corresponding to the 1st and 2nd of February 2007
date1 <- as.Date.character("2007-02-01","%Y-%m-%d")
date2 <- as.Date.character("2007-02-02","%Y-%m-%d")
subsetData <- df[(df$Date == date1 | df$Date == date2),]
rm(df) # to conserve memory

# Plot 4 - A combination of plot 1 and plot 3 along with plots of the voltage
# and global reactive power over the two days.
# Setting the mfrow attribute. This helps to set it to correct value when 
# a previous plot in a session has changed it. Also Setting the margins to
# accomodate the labels. 
png(filename="plot4.png")
par(mfrow = c(1,1),oma=c(1,1,1,1));
par(mfrow = c(2,2))

# Top Left
with(subsetData,plot(subsetData$dateTime,subsetData$Global_active_power,type="l",ylab="Global Active Power",xlab=""))

# Top Right
with(subsetData,plot(subsetData$dateTime,subsetData$Voltage,type="l",ylab="Voltage",xlab="datetime"))

# Bottom Left
with(subsetData,plot(subsetData$dateTime,subsetData$Sub_metering_1,type="n",ylab="Enerygy sub metering",xlab=""))
with(subsetData,points(subsetData$dateTime,subsetData$Sub_metering_1,type = "l"))
with(subsetData,points(subsetData$dateTime,subsetData$Sub_metering_2,col="red",type = "l"))
with(subsetData,points(subsetData$dateTime,subsetData$Sub_metering_3,col="blue",type = "l"))
legend("topright", lty = c(1,1,1), col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


#Bottom Right
with(subsetData,plot(subsetData$dateTime,subsetData$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime"))
dev.off() 

