library(lubridate)
library(data.table)
library(dplyr)

# Function to read dataframe
read_data <- function() {
  filepath <- "household_power_consumption.txt"
  
  if (!file.exists(filepath)) {
    archive_name <- "data.zip"
    data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(data_url, destfile = archive_name, method="curl")
    unzip(archive_name)
  }
  
  date_interval <- interval(dmy("01.02.2007"), dmy("03.02.2007"))
  
  df <- as_tibble(fread(filepath))
  
  df <-df %>% 
    # Parse data
    mutate(Date = dmy_hms(paste(Date, Time))) %>%
    # Filter data in specified interval, remove N/A in GAP
    filter(Date %within% date_interval, Global_active_power != "?") %>%
    # Parse GAP as numeric
    mutate(Global_active_power = as.numeric(Global_active_power))
  
  df
}

# Function to draw second plot
make_plot2 <- function(df) {
  with(
    df,
    plot(
      x = Date,
      y = Global_active_power,
      ylab = "Global Active Power (kilowatts)",
      xlab = "",
      type = "l",
    )
  )
}

# Function to draw third plot
make_plot3 <- function(df) {
  with(
    df,
    plot(
      x = Date,
      y = Sub_metering_1,
      ylab = "Energy sub metering",
      xlab = "",
      type = "l",
    )
  )
  
  with(
    df,
    lines(
      x = Date,
      y = Sub_metering_2,
      col = "red",
    )
  )
  
  with(
    df,
    lines(
      x = Date,
      y = Sub_metering_3,
      col = "blue",
    )
  )
  
  legend(
    x = "topright", 
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    col = c("black", "red", "blue"), 
    lty = c(1,1)
  )
}

# Function to make time x lable
add_time_label <- function(df, plot_func) {
  # Remove default x lable
  par(xaxt = "n")
  
  # Make a plot
  plot_func(df)
  
  # Return par
  par(xaxt = "s")
  
  # Indexes to label
  idxs <- c(1, nrow(df) / 2 + 1, nrow(df))
  
  # Find data to label
  at = df$Date[idxs]
  
  # For each data make labels (week day label)
  labels = unique(lubridate::wday(at, label = TRUE))
  
  axis(1, at = at, labels = labels)
}