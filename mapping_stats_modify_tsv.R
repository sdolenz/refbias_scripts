library(readr)
library(stringr)
library(purrr)

# Get a list of all TSV files in the current directory
file_paths <- list.files(pattern = "\\.tsv$", full.names = TRUE)
# Function to add MQ column to a TSV file
add_MQ_column <- function(file_path) {
  # Read the TSV file
  data <- read_tsv(file_path)
  
  # Extract the file name
  file_name <- basename(file_path)
  
  # Check if the filename contains "new" or "local"
  if (grepl("sensitive|verysensitive|local", file_name)) {
    # Extract the 6th string as MQ value
    MQ_value <- str_split(file_name, "_")[[1]][6]
  } else {
    # Extract the 5th string as MQ value
    MQ_value <- str_split(file_name, "_")[[1]][5]
  }
  
  # Add the "MQ" value as a new column to the data frame
  data$MQ <- MQ_value
  
  # Write the modified data frame back to the TSV file
  write_tsv(data, file_path)
}

# Apply the function to all TSV files
walk(file_paths, add_MQ_column)
