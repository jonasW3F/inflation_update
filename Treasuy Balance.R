# Load the ggplot2 package
library(ggplot2)
library(scales)

treasury_balance <- read.csv("treasury_balance.csv")
# Assuming your data frame is named df
# Example data frame
# df <- data.frame(
#   month = c("2023-01", "2023-02", "2023-03", "2023-04"),
#   currency = c(1000, 1500, 1200, 1300)
# )
treasury_balance$month <- as.Date(paste0(treasury_balance$month, "-01"), format = "%Y-%m-%d")

# Create the bar chart
ggplot(treasury_balance, aes(x = month, y = currency)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  theme_minimal() +
  labs(title = "Monthly Balance",
       x = "Month",
       y = "DOT") +
  scale_y_continuous(labels = comma) +  # Format y-axis labels with commas
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(subset(treasury_balance, month >= "2023-10-01"), aes(x = month, y = currency)) +
  geom_bar(stat = "identity", fill = "#E6007A") +
  geom_line(aes(group = 1), color = "black", size = 1) +  # Add line to connect bars
  geom_point(color = "black", size = 2) +  # Optional: Add points to highlight data values
  theme_minimal() +
  labs(title = "Monthly Balance",
       x = "Month",
       y = "DOT") +
  scale_y_continuous(labels = comma) +  # Format y-axis labels with commas
  theme(axis.text.x = element_text(angle = 45, hjust = 1))