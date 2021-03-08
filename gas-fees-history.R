library(lubridate)
library(ggplot2)
library(plotly)

df <- read.csv("export-0xe5ecfb44bccd7a585fa7f4a8e02c450e525af2e4.csv")

df$date <- as_datetime(df$UnixTimestamp)

df <- df[, c("date", "TxnFee.USD.")]
rownames(df) <- NULL

plot <- plot_ly(df, x = ~date, y = ~TxnFee.USD., type = "scatter", mode = "lines") %>%
  layout(title = "Transaction Fees (in USD) of Bonding Curve Contract",
         yaxis = list(title = "Transaction Fees (USD)"))
