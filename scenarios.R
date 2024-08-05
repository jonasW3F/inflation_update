# Load necessary package
library(data.table)

# Function to dynamically create a data frame
create_table <- function(iterate_variable, iterate_values, fixed_values) {
  # Fixed current_issuance value
  current_issuance <- 14644857704117378589
  
  
  
  
  # Initialize an empty data frame
  data <- data.frame(n = integer(),
                     current_issuance = numeric(),
                     max_inflation_rate = numeric(),
                     falloff_rate = numeric(),
                     ideal_stake_rate = numeric(),
                     actual_stake_rate = numeric(),
                     min_inflation_rate = numeric(),
                     stringsAsFactors = FALSE)
  
  # Iterate over the specified values
  for (i in seq_along(iterate_values)) {
    temp_row <- fixed_values
    temp_row[[iterate_variable]] <- iterate_values[i]
    temp_row[["n"]] <- i
    temp_row[["current_issuance"]] <- current_issuance
    data <- rbind(data, temp_row)
  }
  
  return(data)
}

# Example usage:
# Specify which variable to iterate and its range
iterate_variable <- "actual_stake_rate"
iterate_values <- 10:100
maxStakerReward <- 0.85
totalInflation <- 8
stakerInflation = totalInflation*maxStakerReward

# Fixed values for other variables
fixed_values <- list(
  max_inflation_rate = stakerInflation,
  falloff_rate = 5,
  ideal_stake_rate = 59.33,  # This will be overridden by iterate_values
  actual_stake_rate = 58.50,
  min_inflation_rate = stakerInflation
)

# Create the table
table <- create_table(iterate_variable, iterate_values, fixed_values)
print(table)

# Load necessary package
library(clipr)

# Write the table to a CSV file
output_file <- "output.csv"
write.csv(table, "~/Documents/Projects/runtimes/relay/polkadot/stake-and-treasury.csv", row.names = FALSE)

# Convert the table to CSV format and copy to clipboard
csv_string <- paste(capture.output(write.csv(table, row.names = FALSE)), collapse = "\n")
write_clip(csv_string)
