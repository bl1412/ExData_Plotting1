#open data file, unzip, and read extract - 2/1/07 to 2/2/07
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power.data <- read.table(unzip(temp),sep=';',na.strings='?',nrows=2880,header=TRUE,skip=66636)
unlink(temp)

#read in data variable names from same zip file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power.names <- read.table(unzip(temp),sep=';',na.strings='?',header=TRUE,nrows=1)
unlink(temp)
names(power.data)<-names(power.names)

#convert to date object, added POSIXct object variable named 'timeobject'
power.data[,1]<-as.Date(power.data[,1],'%d/%m/%Y')
timeobject<-strptime(paste(power.data[,1],power.data[,2]),'%Y-%m-%d  %H:%M:%S')
power.data<-cbind(power.data,timeobject)

#create plots, save it in png file
png(file='plot1.png')
hist(power.data$Global_active_power,col='red',main='Global Active Power',xlab='Global Active Power (kilowatts)', ylab='Frequency')
dev.off()

