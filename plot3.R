# Read in the full data set.
df <- read.csv("household_power_consumption.txt",na.strings=c('?'),sep=";")
df$dateTime <- strptime(paste(df$Date,df$Time,sep=":",tz=""),"%d/%m/%Y:%H:%M:%S",tz="GMT")
df$Date <- as.Date.character(df$Date,"%d/%m/%Y")
df$Time <- strptime(df$Time,format="%H:%M:%S",tz="GMT")

# Extract the subset of data corresponding to the 1st and 2nd of February 2007
date1 <- as.Date.character("2007-02-01","%Y-%m-%d")
date2 <- as.Date.character("2007-02-02","%Y-%m-%d")
subsetData <- df[(df$Date == date1 | df$Date == date2),]
rm(df)

#Plot 3 - Energy submetering across different regions of the home for the 2 days
# Setting the mfrow attribute. This helps to set it to correct value when 
# a previous plot in a session has changed it. Also Setting the margins to
# accomodate the labels. 

png(filename = "plot3.png")
par(mfrow = c(1,1),oma=c(1,1,1,1));

with(subsetData,plot(subsetData$dateTime,subsetData$Sub_metering_1,type="n",ylab="Enerygy sub metering",xlab=""))
with(subsetData,points(subsetData$dateTime,subsetData$Sub_metering_1,type = "l"))
with(subsetData,points(subsetData$dateTime,subsetData$Sub_metering_2,col="red",type = "l"))
with(subsetData,points(subsetData$dateTime,subsetData$Sub_metering_3,col="blue",type = "l"))

# Adding the legend
legend("topright", lty = c(1,1,1), col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()


