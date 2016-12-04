## Construct the plot 1 histogram "Global Active Power (kilowatts)"
## and save it to a PNG file: "plot1.png"

plot1 <- function() {
	library(data.table) # data table are more efficient

	print("Loading the dataset into R ... ") 
	DT <- fread("household_power_consumption.txt", colClasses = c("character",
							"character","character","character", "character",
							"character","character","character","character"))

	print("convert the Date variable to Date/Time classes in R") 

	#DT[ , Date := strptime( DT[, Date], "%d/%m/%Y" ) ]
	DT[ , Date := as.Date( DT[, Date], "%d/%m/%Y" ) ]

	print("filtering: only be using data from the dates 2007-02-01 and 2007-02-02 ...")

	obs <- DT[Date=="2007/02/01" | Date=="2007/02/02"]
	obs <- obs[, Global_active_power := as.numeric(obs[, Global_active_power])]

	print("Construct the plot and save it to a PNG file ...")

	png(filename = "plot1.png", width = 480, height = 480)
	hist(obs$Global_active_power, col ="red", main = "Global Active Power",
		 xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
	dev.off()
}