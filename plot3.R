## Construct the plot 3 "Energy sub metering"
## and save it to a PNG file: "plot3.png"

plot3 <- function() {
	library(data.table) # data table are more efficient
	
	print("Loading the dataset into R ... ") 

	DT <- fread("household_power_consumption.txt", colClasses = c("character",
				"character","character","character","character","character",
				"character","character","character"))
	
	print("convert the Date variable to Date/Time classes in R ... ") 

	#DT[ , Date := strptime( DT[, Date], "%d/%m/%Y" ) ]
	DT[ , Date := as.Date( DT[, Date], "%d/%m/%Y" ) ]
	
	print("filtering: only be using data from the dates 2007-02-01 and 2007-02-02 ...")

	obs <- DT[Date=="2007/02/01" | Date=="2007/02/02"]
	obs <- obs[, Sub_metering_1 := as.numeric(obs[, Sub_metering_1])]
	obs <- obs[, Sub_metering_2 := as.numeric(obs[, Sub_metering_2])]
	obs <- obs[, Sub_metering_3 := as.numeric(obs[, Sub_metering_3])]

	print("Construct the plot and save it to a PNG file ... ")

	png(filename = "plot3.png", width = 480, height = 480)
	plot(obs$Sub_metering_1, type = "l", xaxt = "n", xlab = " ",
		 ylab = "Energy sub metering")
	points(obs$Sub_metering_2, col = 'red',  type = 'l')
	points(obs$Sub_metering_3, col = 'blue', type = 'l')
	axis(1, at = c(0, 1500, 2800), labels = c("Thu", "Fri", "Sat"), las = 0)
	legend ( "topright", lty = 1, col = c("black", "red", "blue"),
			legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_1") )
	dev.off()
}