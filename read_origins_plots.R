#libraries
library(tidyverse)
library(readr)
library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)


setwd("...your parent directory here.../read_origins/")


# Iterate over each mapper
for (mapper in c("bwaaln", "bwamem", "verysensitive_bowtie", "sensitive_bowtie", "local_bowtie")) {
  # Get the list of TSV files for the current mapper
  files <- Sys.glob(paste0(mapper, "_tsvs/**.tsv"))

  # Iterate over each TSV file
  for (file in files) {
    
    # Remove extension of file name
    name <- sub("tsvs/", "", tools::file_path_sans_ext(file))
    
    # Read file
    read_file <- read.delim(file)
    
    # Add species
    species <- read.delim("headers_all.tsv", sep = "\t")
    
    merged_tsv <- merge(read_file, species, by="Extracted.Header")
    
# Count of reads per read length bin per species
prop_tsv <- merged_tsv %>%
  group_by(Species, Read.Length) %>%
  summarise(count = n()) %>%
  ungroup()

# Count of reads per read length bin for all species
total_counts <- prop_tsv %>%
  group_by(Read.Length) %>%
  summarise(total_count = sum(count)) %>%
  ungroup()

# Merge the total counts with the prop_tsv data
prop_tsv <- merge(prop_tsv, total_counts, by = "Read.Length")

# Calculate the proportion and add column
prop_tsv <- prop_tsv %>%
  mutate(proportion = count / total_count) 

    # Save  
    prop_file_name <- paste("...your parent directory here.../read_origins/", mapper, "_proportion_tsvs/", name, "_proportion.tsv", sep="")
    write.table(prop_tsv, file = prop_file_name, sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)
  }
}


# Define the desired order of species
species_order <- c("elephant", "rhino", "bacteria", "human")

# Define colors for species
species_colors <- c("human" = "darkgreen", "bacteria" = "#CC0066", "elephant" = "#6699FF", "rhino" = "#6699FF")

# Iterate over each mapper
for (mapper in c("bwaaln", "bwamem", "verysensitive_bowtie", "sensitive_bowtie", "local_bowtie")) {
  # Get the list of TSV files for the current mapper
  files <- Sys.glob(paste0(mapper, "_proportion_tsvs/*.tsv"))
  
  # Iterate over each TSV file
  for (file in files) {
    
    print(file)
    # Read data from the current file
    plot_df <- read.delim(file, sep = "\t")
    
    # Extract the part of the file name for the plot title
    file_name <- tools::file_path_sans_ext(basename(file))
    plot_title <- str_replace(str_remove(file_name, "_proportion"), paste0("_", mapper), "")

    
    # Reorder the "Species" factor according to species_order
    plot_df$Species <- factor(plot_df$Species, levels = species_order)
      
    # Create a line plot
    line_plot <- ggplot(plot_df, aes(x = Read.Length, y = proportion, color = Species)) +
      geom_line(size = 1) +  # Adjust the size parameter for line thickness
      labs(x = "Read Length", y = "Proportion of Total Mapped Reads", title = plot_title) +
      scale_color_manual(values = species_colors) +
      scale_x_continuous(breaks = seq(20, max(plot_df$Read.Length), by = 20), labels = seq(20, max(plot_df$Read.Length), by = 20)) +  
      scale_y_continuous(limits = c(0, 1.0)) +
      theme_minimal()

    # Save the line plot as a PDF
    output_line <- paste("...your parent directory here.../read_origins/read_origins_plots/", plot_title, ".pdf", sep="")
    ggsave(output_line, line_plot, width = 8, height = 6)

 
  }

}
