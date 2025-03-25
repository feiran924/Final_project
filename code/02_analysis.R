here::i_am("code/02_analysis.R")

# Load required packages
library(dplyr)
library(here)
library(kableExtra)  # Add this line
library(tidyr)       # For data manipulation

# Load cleaned data
clean_data <- readRDS(
  file = here::here("data", "clean_data.rds")
)

regional_summary <- clean_data %>%
  group_by(`Continental region`) %>%
  summarize(
    `Avg Price (USD)` = round(mean(`Average price of 1GB (USD)`, na.rm = TRUE), 2),
    `Min Price (USD)` = round(min(`Cheapest 1GB for 30 days (USD)`, na.rm = TRUE), 2),
    `Max Price (USD)` = round(max(`Most expensive 1GB (USD)`, na.rm = TRUE), 2),
    `Number of Countries` = n_distinct(Currency)
  ) %>%
  arrange(desc(`Avg Price (USD)`))  # Corrected parenthesis

# Render table with styling
kable(regional_summary, 
      caption = "Table 1: Regional Summary of Mobile Data Pricing (USD)") %>%
  kable_styling(bootstrap_options = "striped", 
                full_width = FALSE, 
                font_size = 14)

# Save the table object
saveRDS(
  regional_summary,
  file = here::here("output", "regional_summary.rds")
)
