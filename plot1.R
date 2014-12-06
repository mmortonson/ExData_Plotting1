# Create Plot 1: Histogram of global active power

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

# open PNG device
# - width and height are set to the default of 480 pixels as
#   instructed (even though the reference plot is 504x504)
# - set transparent background to match reference plot
png("plot1.png", bg = NA)

# plot histogram of global active power
hist(data$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power")

# close PNG device
dev.off()
