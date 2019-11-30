package_vec <- c("readr", "tidyr", "dplyr")

lapply(package_vec, require, character.only = TRUE)

plot3 <- function(data_file_path, pic_file_path, pic_name) {
    electric_df <- read_delim(data_file_path, delim = ";", na = "?")
    electric_df <-
        (
            electric_df %>% mutate(
                Date = parse_date(Date, format = "%d/%m/%Y"),
                datetime_combo = as.POSIXct(paste(Date, Time))
            ) %>% filter(Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))
        )
    plot(electric_df$datetime_combo, 
         electric_df$Sub_metering_1, 
         type = "l", 
         xlab = "",
         ylab = "Energy sub metering")
    lines(electric_df$datetime_combo, electric_df$Sub_metering_2, col = "red")
    lines(electric_df$datetime_combo, electric_df$Sub_metering_3, col = "blue")
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty = c(1, 1, 1), 
           col = c("black", "red", "blue"))
    pic_path <- file.path(pic_file_path, pic_name)
    dev.copy(png, pic_path)
    dev.off()
}

plot3("/Users/steve/Downloads/EDA_data/household_power_consumption.txt", 
      "/Users/steve/Downloads", 
      "test_beta_3.png")
