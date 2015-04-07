#open data file, unzip, and read extract - 2/1/07 to 2/2/07 data

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power.data <- read.table(unzip(temp),sep=';',na.strings='?',nrows=2880,header=TRUE,skip=66636)
unlink(temp)

#read data variable names from same zip file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
power.names <- read.table(unzip(temp),sep=';',na.strings='?',header=TRUE,nrows=1)
unlink(temp)
names(power.data)<-names(power.names)

#convert to date, added POSIXct object variable named 'timeobject'
power.data[,1]<-as.Date(power.data[,1],'%d/%m/%Y')
timeobject<-strptime(paste(power.data[,1],power.data[,2]),'%Y-%m-%d  %H:%M:%S')
power.data<-cbind(power.data,timeobject)

#create plots, save it in png file
png(file='plot4.png')
par(mfrow=c(2,2))
#1st panel
with(power.data,plot(timeobject,Global_active_power,type='l',xlab='',ylab='Global Active Power'))
#2nd panel
with(power.data,plot(timeobject,Voltage,type='l',xlab='datetime',ylab='Voltage',lwd=1))
#3rd panel
with(power.data,plot(timeobject,Sub_metering_1,type='l',xlab='',ylab='Energy sub metering'))
with(power.data,lines(timeobject,Sub_metering_2,col='red'))
with(power.data,lines(timeobject,Sub_metering_3,col='blue'))
legend('topright',lty=1,col=c('black','red','blue'),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),bty='n')
#4th panel
with(power.data,plot(timeobject,Global_reactive_power,type='l',xlab='datetime'))
dev.off()
