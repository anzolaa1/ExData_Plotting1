### plot1.R

### Descarga el archivo de datos, y lo descomprime
### Download the data file and decompresses
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file, "household_power_consumption.zip", method = "wget", quiet = FALSE)
unzip(zipfile = "household_power_consumption.zip", list = FALSE, overwrite = TRUE)

### Instala el paquete "pryr"
### Install the package "pryr"
install.packages("pryr")

### Habilita el uso del paquete "pryr"
### Enables the package "pryr"
require("pryr")

### Calculando el tamaño de una sola línea de datos
### Calculating the size of a single data line
first_line <- read.table("household_power_consumption.txt", header = FALSE, nrows = 1)
size_one_line <- object_size(first_line)
size_kb <- 2075260 * size_one_line / 1024

if (size_kb < as.numeric(system("awk '/MemFree/ {print $2}' /proc/meminfo", intern = TRUE))) {
        table <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"))
        table$Date2 <- strptime(paste(table$Date,table$Time), "%d/%m/%Y %H:%M:%S")
        data <- subset(table, Date2 >= "2007-02-01 00:00:00" & Date2 < "2007-02-03 00:00:00")
        png("plot1.png")
                hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
        dev.off()
}

