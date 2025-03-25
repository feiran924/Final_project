# Mobile Data Pricing Analysis

This project analyzes global mobile data pricing across 237 countries, collected in 2023.

## Repository Structure

- `data/`: Contains the raw and cleaned data files
- `code/`: R scripts for data processing, analysis, and visualization
- `output/`: Generated tables and figures


## How to Generate the Report

1. Clone this repository
2. Run `make` in the terminal to:
   - Clean and prepare the data
   - Perform analyses
   - Generate visualizations
   - Render the final HTML report

The final report will be created as `Final_project_2.html`.

## Code Locations

- **Data cleaning**: `code/01_data_cleaning.R`
- **Table generation**: `code/02_analysis.R` (creates regional summary table)
- **Figure generation**: `code/03_visualization.R` (creates price distribution boxplot)

## Dependencies

- R (v4.0 or higher)
- R packages: readxl, dplyr, ggplot2, knitr, kableExtra