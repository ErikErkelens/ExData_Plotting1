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
plot(hh$TimeStamp, hh$Global_active_power,
	type="l",
	xlab="",
	ylab="Global Active Power (kilowatts)")


#Create the PNG
dev.copy(png,filename="plot2.png")
dev.off()