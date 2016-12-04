## Construct the plot 2 "Global Active Power"
## and save it to a PNG file: "plot2.png"

plot2 <- function() {
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
	
	print("Construct the plot and save it to a PNG file ...")

	png(filename = "plot2.png", width = 480, height = 480)
	plot(obs$Global_active_power, type = "l", xaxt = "n", xlab = " ",
		 ylab = "Global Active Power (kilowatts)")
	axis(1, at = c(0, 1500, 2800), labels = c("Thu", "Fri", "Sat"), las = 0)
	dev.off()
}