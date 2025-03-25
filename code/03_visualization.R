here::i_am("code/03_visualization.R")

# Load required packages
library(ggplot2)
library(here)

# Read cleaned data
clean_data <- readRDS(
  file = here::here("data/clean_data.rds")
)

# Create boxplot visualization
price_boxplot <- 
  ggplot(clean_data, aes(x = reorder(`Continental region`, `Average price of 1GB (USD)`, median), 
                       y = `Average price of 1GB (USD)`)) +
  geom_boxplot(fill = "skyblue", outlier.color = "red") +
  labs(
    title = "Distribution of 1GB Mobile Data Prices by Region",
    x = "Continental Region",
    y = "Price (USD)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    plot.title = element_text(face = "bold")
  )

# Save the plot
ggsave(
  here::here("output/price_distribution.png"),
  plot = price_boxplot,
  device = "png",
  width = 8,
  height = 6,
  units = "in",
  dpi = 300
)
