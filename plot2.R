source("./utils.R")

df <- read_data()

png(filename = "plot2.png", width = 480, height = 480)

add_time_label(df, make_plot2)

dev.off()