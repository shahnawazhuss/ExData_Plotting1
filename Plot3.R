#Section to Create Directories for Data and Plots Storage
if(!dir.exists("./Data")){
        dir.create("./Data")
}
plotdir<-"./Data/Plots"
if(!dir.exists(plotdir)){
        dir.create("./Data/Plots")
}
############################################################
#Section to Download Data 
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destzipfile="./Data/household_power_consumption.zip"
destfile="./Data/household_power_consumption.txt"
if(!file.exists(destfile)){
        download.file(fileURL,destfile = destzipfile)
        unzip(destzipfile,exdir="./Data")
}
############################################################
#Section to Read Data and Subset Data reqired
power<-read.table(destfile,header = TRUE,sep=";")
powerbydates<-subset(power, power$Date=="1/2/2007"|power$Date=="2/2/2007")
############################################################
#Section to transform Data as required 
powerbydates<-mutate(powerbydates,"absoluteTime"=paste(powerbydates$Date,powerbydates$Time))
powerbydates$absoluteTime<-strptime(powerbydates$absoluteTime,format = "%d/%m/%Y %H:%M:%S")
powerbydates$Sub_metering_1=as.numeric(as.character(powerbydates$Sub_metering_1))
powerbydates$Sub_metering_2=as.numeric(as.character(powerbydates$Sub_metering_2))
powerbydates$Sub_metering_3=as.numeric(as.charcater(powerbydates$Sub_metering_3))
############################################################
#Section to Create Plot
with(powerbydates,plot(powerbydates$absoluteTime,powerbydates$Sub_metering_1,type = "n",xlab = "",ylab = "Energy sub metering"))
lines(powerbydates$absoluteTime,powerbydates$Sub_metering_1)
lines(powerbydates$absoluteTime,powerbydates$Sub_metering_2,col="red")
lines(powerbydates$absoluteTime,powerbydates$Sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main="Energy sub-metering")
dev.copy(png,"./Data/Plots/Plot3.png")
dev.off()
