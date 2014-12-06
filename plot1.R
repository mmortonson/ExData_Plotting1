# Create Plot 1: histogram of Global Active Power

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

# plot histogram of global active power
# - use cex arguments to rescale font sizes to match the
#   example plot more closely
hist(data$Global_active_power, col = "red", 
     xlab = "Global active power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power",
     cex.axis = 0.75, cex.lab = 0.75, cex.main = 0.9)

# save plot in PNG file
# - width and height are set to the default of 480 pixels as
#   instructed (even though the example plot is 504x504)
# - set transparent background to match example plot
dev.copy(png, filename = "plot1.png", bg = NA)
dev.off()