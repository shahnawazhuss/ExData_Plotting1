#Section to Create Directories for Data and Plots Storage
if(!dir.exists("./Data")){
        dir.create("./Data")
}
plotdir<-"./Data/Plots"
if(!dir.exists(plotdir)){
        dir.create("./Data/Plots")
}
############################################################
#Utilizing dplyr package
if (!"dplyr" %in% installed.packages()) {
        install.packages("dplyr")
}
library(dplyr)
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
power<-read.table(destfile,header = TRUE,sep=";",na.strings = "?")
powerbydates<-subset(power, power$Date=="1/2/2007"|power$Date=="2/2/2007")
############################################################
#Section to transform Data as required 
powerbydates<-mutate(powerbydates,"absoluteTime"=paste(powerbydates$Date,powerbydates$Time))
powerbydates$absoluteTime<-strptime(powerbydates$absoluteTime,format = "%d/%m/%Y %H:%M:%S")
powerbydates$Global_active_power=as.numeric(as.character(powerbydates$Global_active_power))
############################################################
#Section to Create Histogram
par(mar=c(4,4,1,1))
hist(powerbydates$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.copy(png,"./Data/Plots/Plot1.png",height=480,width=480)
dev.off()
