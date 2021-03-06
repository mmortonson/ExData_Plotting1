# Create Plot 4: Four panels, each showing
# one or more variables vs. datetime

data.file <- "household_power_consumption.txt"
if(!file.exists(data.file)) stop("Couldn't find file: ",
                                 data.file)

# load data from rows for 2007-02-01 to 2007-02-02
data <- read.table(data.file, skip = 66637, nrows = 2880,
                   sep = ";", na.strings = "?", 
                   comment.char = "",
                   colClasses = c("character", "character", 
                                  replicate(7, "numeric")))
# get column names from the header
names(data) <- names(read.table(data.file, nrows = 1,
                                header = TRUE, sep = ";"))
# get time in POSIXlt class from Date and Time columns
time <- strptime(paste(data$Date, data$Time), 
                 format = "%d/%m/%Y %H:%M:%S")

# open PNG device
# - width and height are set to the default of 480 pixels as
#   instructed (even though the reference plot is 504x504)
# - set transparent background to match reference plot
png("plot4.png", bg = NA)

# set up 2x2 plot, filled column-wise
par(mfcol = c(2, 2))

# upper left panel
# plot global active power vs. time
plot(time, data$Global_active_power, type = "n",
     xlab = "", ylab = "Global Active Power")
lines(time, data$Global_active_power)

# lower left panel
# plot sub metering variables vs. time
plot(time, data$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering")
lines(time, data$Sub_metering_1, col = "black")
lines(time, data$Sub_metering_2, col = "red")
lines(time, data$Sub_metering_3, col = "blue")
# add a legend for the 3 lines (without a border)
legend('topright', legend = c("Sub_metering_1", 
                              "Sub_metering_2", 
                              "Sub_metering_3"), 
       lty = "solid", col = c("black", "red", "blue"),
       bty = "n")

# upper right panel
# plot voltage vs. time
plot(time, data$Voltage, type = "n",
     xlab = "datetime", ylab = "Voltage")
lines(time, data$Voltage)

# lower right panel
# plot global reactive power vs. time
plot(time, data$Global_reactive_power, type = "n",
     xlab = "datetime", ylab = "Global_reactive_power")
lines(time, data$Global_reactive_power)

# close PNG device
dev.off()
