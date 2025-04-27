here::i_am("code/01_data_cleaning.R")

# Define path to raw data
absolute_path_to_data <- here::here("data", "Data_pricing.xlsx")

# Load raw data
raw_data <- readxl::read_excel(
  path = absolute_path_to_data,
  sheet = "Sheet1"
)

# Load required packages
library(dplyr)
library(labelled)
library(gtsummary)

# Clean and process data
clean_data <- raw_data %>%
  filter(is.na(`Global Totals (2023)`)) %>%
  mutate(
    `Average price of 1GB (USD)` = as.numeric(`Average price of 1GB (USD)`)
  )

# Add variable labels
var_label(clean_data) <- list(
  `Continental region` = "Continental Region",
  `Plans measured` = "Number of Plans Measured",
  `Average price of 1GB (local currency)` = "Avg Price (Local Currency)",
  `Currency` = "Currency Type",
  `Conversion rate (USD) (Frozen 07/09/2023)` = "USD Conversion Rate",
  `Average price of 1GB (USD)` = "Avg Price (USD)",
  `Cheapest 1GB (Local currency)` = "Cheapest Plan (Local)",
  `Cheapest 1GB for 30 days (USD)` = "Cheapest Plan (USD)",
  `Most expensive 1GB (Local currency)` = "Most Expensive Plan (Local)",
  `Most expensive 1GB (USD)` = "Most Expensive Plan (USD)",
  `Sample date` = "Date of Data Collection"
)

# Create categorical variable for price groups
clean_data <- clean_data %>%
  mutate(
    price_category = case_when(
      `Average price of 1GB (USD)` < 1 ~ "Low (<$1)",
      `Average price of 1GB (USD)` >= 1 & `Average price of 1GB (USD)` < 5 ~ "Medium ($1-$5)",
      `Average price of 1GB (USD)` >= 5 ~ "High (≥$5)"
    )
  )

# Save cleaned data
saveRDS(
  clean_data,
  file = here::here("data", "clean_data.rds")
)

