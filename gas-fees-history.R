# Load the necessary packages
library(lubridate)
library(ggplot2)
library(plotly)

# Read csv file into R
df <- read.csv("export-0xe5ecfb44bccd7a585fa7f4a8e02c450e525af2e4.csv")

# Convert UNIX time to datetime
df$date <- as_datetime(df$UnixTimestamp)

# Extract out the two relevant columns and remove row names from the data frame
df <- df[, c("date", "TxnFee.USD.")]
rownames(df) <- NULL

# Plot the data
plot <- plot_ly(df, x = ~date, y = ~TxnFee.USD., type = "scatter", mode = "lines") %>%
  layout(title = "Transaction Fees (in USD) of Bonding Curve Contract",
         yaxis = list(title = "Transaction Fees (USD)"))
