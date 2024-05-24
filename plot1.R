source("./utils.R")

df <- read_data()

png(filename = "plot1.png", width = 480, height = 480)

hist(
  df$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)

dev.off()