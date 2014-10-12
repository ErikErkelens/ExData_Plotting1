require(sqldf)

#hh will contain the subset of data for the first two days in February 2007
hh=read.csv.sql("household_power_consumption.txt",
	 "select * from file where Date='1/2/2007' or Date='2/2/2007'",
	 sep=";")

#not yet needed here...
#hh<-transform(hh,TimeStamp=as.POSIXlt(paste(Date,Time), format="%d/%m/%Y %H:%M:%S"));

#Question mark is the symbol for NA; read.csv.sql doesn't support na.strings?
hh[hh=="?"]<-NA

#Create the plot
hist(hh$Global_active_power,
	main="Global Active Power", 
	xlab="Global Active Power (kilowatts)", 
	col="red")

#Create the PNG
dev.copy(png,filename="plot1.png")
dev.off()
