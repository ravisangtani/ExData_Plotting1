#############################
# Plot 2 including data pull
#############################

#downloading data from the link provided

data<- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                     destfile = "zippy", method = "auto")


## Reading the data from the zipped file
power<- read.csv(unz("zippy", "household_power_consumption.txt"), header=T,
                 sep=";", stringsAsFactors=F, na.strings="?")

# head(power)
# str(power)
# names(power)

# converting the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
str(power$Date)

#subsetting data for dates between 2007-02-01 and 2007-02-02
DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")

sub.power <- power[power$Date >= DATE1 & power$Date <= DATE2,]

# Merging date and time attributes in the subset to create a plottable continous variable
sub.power$day.time<-as.POSIXct(paste(sub.power$Date, sub.power$Time), format="%Y-%m-%d %H:%M:%S")


#plot 2
plot(sub.power$day.time, sub.power$Global_active_power, type="l",
     xlab="", ylab="Global Active Power (Kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()


