## Construct the plot 4 "Global Active Power" and "Energy sub metering" 
## and save it to a PNG file: "plot4.png"

plot4 <- function() {
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
	obs <- obs[, Global_active_power := as.numeric(obs[, Global_active_power])]
	obs <- obs[, Global_reactive_power:=as.numeric(obs[,Global_reactive_power])]
	obs <- obs[, Voltage        := as.numeric(obs[, Voltage])]
	obs <- obs[, Sub_metering_1 := as.numeric(obs[, Sub_metering_1])]
	obs <- obs[, Sub_metering_2 := as.numeric(obs[, Sub_metering_2])]
	obs <- obs[, Sub_metering_3 := as.numeric(obs[, Sub_metering_3])]

	print("Construct the plot and save it to a PNG file ... ")

	png(filename = "plot4.png", width = 480, height = 480)
	par( mfrow = c(2, 2) ) # Four plots
# Plot 1
	plot(obs$Global_active_power, type = "l", xaxt = "n", xlab = " ",
		 ylab = "Global Active Power")
	axis(1, at = c(0, 1500, 2800), labels = c("Thu", "Fri", "Sat"), las = 0)
# Plot 2
	plot(obs$Voltage, type = "l", xaxt = "n", xlab = "datetime",
		 ylab = "Voltage")
	axis(1, at = c(0, 1500, 2800), labels = c("Thu", "Fri", "Sat"), las = 0)
# Plot 3
	plot(obs$Sub_metering_1, type = "l", xaxt = "n", xlab = " ",
		 ylab = "Energy sub metering")
	points(obs$Sub_metering_2, col = 'red',  type = 'l')
	points(obs$Sub_metering_3, col = 'blue', type = 'l')
	axis(1, at = c(0, 1500, 2800), labels = c("Thu", "Fri", "Sat"), las = 0)
	legend ( "topright", lty = 1, col = c("black", "red", "blue"),
			legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_1") )
# Plot 4
	plot(obs$Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime",
		 ylab = "Global Active Power")
	axis(1, at = c(0, 1500, 2800), labels = c("Thu", "Fri", "Sat"), las = 0)
	dev.off()

}