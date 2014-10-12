require(sqldf)

#hh will contain the subset of data for the first two days in February 2007
hh=read.csv.sql("household_power_consumption.txt",
	 "select * from file where Date='1/2/2007' or Date='2/2/2007'",
	 sep=";")

#Create a TimeStamp column in a POSIX DateTime format by combining Date and Time
hh<-transform(hh,TimeStamp=as.POSIXlt(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"));

#Question mark is the symbol for NA; read.csv.sql doesn't support na.strings
hh[hh=="?"]<-NA

#Create the plot
par(mfrow=c(2,2))
with(hh,{
	plot(TimeStamp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

	plot(TimeStamp, Voltage, type="l", xlab="datetime")

	plot(TimeStamp, Sub_metering_1,type="l",xlab="", ylab="Energy sub metering")
		lines(TimeStamp, Sub_metering_2,col="red")
		lines(TimeStamp, Sub_metering_3,col="blue")
		legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
			col=c("black","red","blue"),lwd=1)

	plot(TimeStamp, Global_reactive_power, type="l", xlab="datetime")

	})


#Create the PNG
dev.copy(png,filename="plot4.png")
dev.off()