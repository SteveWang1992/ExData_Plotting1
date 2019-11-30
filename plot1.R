package_vec <- c("readr", "tidyr", "dplyr")

lapply(package_vec, require, character.only = TRUE)

plot1 <- function(data_file_path, pic_file_path, pic_name) {
    electric_df <- read_delim(data_file_path, delim = ";", na = "?")
    electric_df <-
        (
            electric_df %>% mutate(
                Date = parse_date(Date, format = "%d/%m/%Y"),
                datetime_combo = as.POSIXct(paste(Date, Time))
            ) %>% filter(Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))
        )
    hist(electric_df$Global_active_power, 
         col = "red", 
         xlab = "Global Active Power (kilowatts)", 
         main = "Global Active Power")
    pic_path <- file.path(pic_file_path, pic_name)
    dev.copy(png, pic_path)
    dev.off()
}

plot1("/Users/steve/Downloads/EDA_data/household_power_consumption.txt", 
          "/Users/steve/Downloads/test_beta_1.png")
