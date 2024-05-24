source("./utils.R")

df <- read_data()

make_voltage_plot <- function(df) {
  with(
    df,
    plot(
      Date,
      Voltage,
      type = "s",
      xlab = "datetime"
    )
  )
}

make_reactive_plot <- function(df) {
  with(
    df,
    plot(
      Date,
      Global_reactive_power,
      type = "s",
      xlab = "datetime"
    )
  )
}

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

add_time_label(df, make_plot2)
add_time_label(df, make_voltage_plot)
add_time_label(df, make_plot3)
add_time_label(df, make_reactive_plot)

dev.off()