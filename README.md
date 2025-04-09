# My Final Project

This repository contains the code and report for my final project.

# Mobile Data Pricing Analysis

This project analyzes global mobile data pricing across 237 countries, collected in 2023.

## Repository Structure

- `data/`: Contains the raw and cleaned data files
- `code/`: R scripts for data processing, analysis, and visualization
- `output/`: Generated tables and figures


## How to Generate the Report

## Synchronizing the Package Environment
To ensure you have the exact package versions used to create this report, follow these steps:

1. **Clone the Repository**: Clone this repository to your local machine using:
   ```bash
   git clone https://github.com/ziqiguo567/Final_project.git
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