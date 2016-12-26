##--------------------Author Abas----------------

## The following script loads the dataset into R, he dataset has 2,075,259 rows and 9 columns. First calculate a 
#rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your
# computer has enough memory (most modern computers should be fine).
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from 
# just those dates rather than reading in the entire dataset and subsetting to those dates.

#So let's start first by reading the data, I have already downloaded and ziped the zip file in my local repo

housedata <- read.table("household_power_consumption.txt", header = T, sep = ";" , na.strings ="?", )


#To know the data size 
print(object.size(datasubset), units = "Mb")

dim(housedata) ## this will return the number of variables and observations
# this makes the subset of housedata$Date as a Date format with the order of the date type
housedata$Date <- as.Date(housedata$Date, format ="%d/%m/%Y")

# here is simply to examine how household energy usage varies over a 2-day period in February, 2007.

datasubset <- housedata[(housedata$Date=="2007-02-01") | (housedata$Date=="2007-02-02"),]

housedata$Global_active_power <- as.numeric(as.character(housedata$Global_active_power))
datasubset$Global_reactive_power <- as.numeric(as.character(datasubset$Global_reactive_power))
datasubset$Voltage <- as.numeric(as.character(datasubset$Voltage))
datasubset$Sub_metering_1 <- as.numeric(as.character(datasubset$Sub_metering_1))
datasubset$Sub_metering_2 <- as.numeric(as.character(datasubset$Sub_metering_2))
datasubset$Sub_metering_3 <- as.numeric(as.character(datasubset$Sub_metering_3))

#  convert the Date and Time variables to Date/Time classes
datasubset <- transform(datasubset, timestamp = as.POSIXct(paste(Date,Time)))

#Now we creat a function which creates the second png

plot3 <- function() {
        plot(datasubset$timestamp,datasubset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(datasubset$timestamp,datasubset$Sub_metering_2,col="red")
        lines(datasubset$timestamp,datasubset$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
        dev.copy(png, file="plot3.png", width=480, height=480)
        dev.off()
        
}


# Call the function plot1 to see the graphic

plot3()

## Thanks for the View 