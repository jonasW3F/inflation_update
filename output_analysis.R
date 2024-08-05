output <- read.csv("~/Documents/Projects/runtimes/relay/polkadot/output.csv")
library(ggplot2)
library(dplyr)
library(knitr)


output$staker_apy <- output$out_stake_reward / output$in_current_issuance / (output$in_staking_rate/100)
output$inpos <- output$out_stake_reward / output$in_current_issuance

# Load necessary library
library(ggplot2)

combined_plot <- ggplot(output, aes(x = in_staking_rate)) +
  geom_line(aes(y = staker_apy, color = "Staker APY")) +
  geom_line(aes(y = inpos, color = "Inflation to stakers")) +
  scale_y_continuous(limits = c(0, 0.5)) +
  geom_hline(yintercept = output$in_max_inflation[1] / maxStakerReward / 100, linetype = "dashed", color = "black") +
  annotate("text", x=50, y=output$in_max_inflation[1] / maxStakerReward / 100 + 0.01, label="Total Inflation") + 
  labs(
    x = "Staking Rate",
    y = "Value",
    color = "Metric") +
  theme_minimal()

# Print the combined plot
print(combined_plot)


create_apy_table <- function(df, target_rate = 60, range = 20, step = 5) {
  # Filter rows around the target staking rate
  filtered_df <- df %>%
    filter(in_staking_rate >= (target_rate - range) & in_staking_rate <= (target_rate + range)) %>%
    slice(seq(1, n(), by = step))
  
  # Select and round the staker APY and inpos values
  result_df <- filtered_df %>%
    select(in_staking_rate, staker_apy) %>%
    mutate(in_staking_rate = paste0(in_staking_rate, "%"),
           staker_apy = paste0(round(staker_apy * 100, 2), "%"))
  
  # Convert the result to a markdown table
  markdown_table <- kable(result_df, format = "markdown")
  
  return(markdown_table)
}


# Usage:
# Assuming your data frame is named 'df'
print(create_apy_table(output))
clipr::write_clip(create_apy_table(output))

print(paste0("Treasury inflow per spending period ", polkadotutils::normalize(output$in_current_issuance[1], "p") * ((output$in_max_inflation[1] / maxStakerReward) / 100) * (1 - maxStakerReward) / 365 * 24))
