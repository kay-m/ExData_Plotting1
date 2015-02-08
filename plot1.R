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

# Plot 1 - Histogram plot of Global Active Power
# Setting the mfrow attribute. This helps to set it to correct value when 
# a previous plot in a session has changed it. Also Setting the margins to
# accomodate the labels. 
png(filename="plot1.png")
par(mfrow = c(1,1),oma=c(1,1,1,1));
with(subsetData,hist(Global_active_power,col=c("red"),main="Global Active Power",xlab="Global Active Power(kilowatts)"))
dev.off()
