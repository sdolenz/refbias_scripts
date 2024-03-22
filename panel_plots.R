library(tidyverse)
library(readr)
library(ggplot2)
library(cowplot)  

# Get the list of TSV files in the directory
file_paths <- list.files(path = "new_tsvs", pattern = "*mapping_stats_byMQ.tsv", full.names = TRUE)

# Iterate through each TSV file
for (file_path in file_paths) {
  # Read the TSV file
  data <- read_tsv(file_path)

  # Convert Read_Length column to numeric
  data$Read_Length <- as.numeric(data$Read_Length)
  data$Mismapped_Reads <- as.numeric(data$Mismapped_Reads)
  data$Correctly_Mapped_Reads <- as.numeric(data$Correctly_Mapped_Reads)
  data$Unmapped_Reads <- as.numeric(data$Unmapped_Reads)
  data$MQ <- factor(data$MQ)

  # Create separate plots for each column and facet wrap them
  p1 <- ggplot(data, aes(x = Read_Length, y = Mismapped_Reads, color = MQ)) +
    geom_line() +
    labs(x = "", y = "Number of Reads", color = "MQ") +
    theme_minimal() +
    scale_x_continuous(limits = c(20, NA), breaks = seq(20, 200, by = 20), labels = seq(20, 200, by = 20)) +  # Set x-axis breaks and labels
    scale_y_continuous(limits = c(0, NA)) +
    theme(axis.title.x = element_blank(), 
        legend.position = "none")

  p2 <- ggplot(data, aes(x = Read_Length, y = Correctly_Mapped_Reads, color = MQ)) +
      geom_line() +
      labs(x = "Read Length", y = "", color = "MQ") +
      theme_minimal() +
      scale_x_continuous(limits = c(20, NA), breaks = seq(20, 200, by = 20), labels = seq(20, 200, by = 20)) +  # Set x-axis breaks and labels
      scale_y_continuous(limits = c(0, NA)) +  
      theme(axis.title.y = element_blank(), 
          legend.position = "none")

  p3 <- ggplot(data, aes(x = Read_Length, y = Unmapped_Reads, color = MQ)) +
    geom_line() +
    labs(x = "", y = "", color = "MQ") +
    theme_minimal() +
    scale_x_continuous(limits = c(20, NA), breaks = seq(20, 200, by = 20), labels = seq(20, 200, by = 20)) +  # Set x-axis breaks and labels
    scale_y_continuous(limits = c(0, NA)) +
    theme(axis.title.y = element_blank(),  
        axis.title.x = element_blank())

  # Facet wrap the three plots together
  facet_plots <- list(p1, p2, p3)
  facet_titles <- c("Mismapped Reads", "Correctly Mapped Reads", "Unmapped Reads")

  # Plot the facet wrapped plots
  facet_grid <- plot_grid(plotlist = facet_plots, ncol = 3, align = "h", labels = facet_titles)

  # Create the combined plot title
  plot_title <- sub("_mapping_stats_byMQ.tsv", "", basename(file_path))

  # Add a larger plot title
  facet_grid <- facet_grid +
    ggtitle(plot_title) +
    theme(plot.title = element_text(size = 16, face = "bold"))  

  # Save the plot to a PDF file 
  output_file <- gsub(".tsv", "_plots.pdf", basename(file_path))  
  ggsave(filename = file.path("panel_plots", output_file), plot = facet_grid, width = 20, height = 8) 
}

