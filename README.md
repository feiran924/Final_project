# Mobile Data Pricing Project

This repository contains the code and resources for the Mobile Data Pricing Project, a data analysis project that processes, analyzes, and visualizes mobile data pricing information. The project uses R for data processing and visualization, with a reproducible workflow managed by `renv` and Docker.

## Project Structure

- **`Final_project_2.Rmd`**: R Markdown file for generating the final report.
- **`code/`**: R scripts for data processing and report generation:
  - `01_data_cleaning.R`: Cleans raw data from `Data_pricing.xlsx`.
  - `02_analysis.R`: Performs data analysis and generates summary statistics.
  - `03_visualization.R`: Creates visualizations (e.g., price distribution plots).
  - `04_render_report.R`: Renders the final report.
- **`data/`**: Raw data (`Data_pricing.xlsx`) and cleaned data (`clean_data.rds`).
- **`output/`**: Analysis outputs (e.g., `regional_summary.rds`, `price_distribution.png`).
- **`report/`**: Generated report (`Final_project_2.html`).
- **`renv/`**: Manages R package dependencies using `renv`.
- **`renv.lock`**: Specifies exact package versions for reproducibility.
- **`Makefile`**: Automates build, report generation, and Docker tasks.
- **Docker**: Uses a custom image (`ziqiguo567/mobile-data-pricing`) for reproducibility.

## Prerequisites

- **Docker**: Install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
- **R and RStudio** (optional): For local development, install [R](https://www.r-project.org/) and [RStudio](https://posit.co/download/rstudio-desktop/).
- **Git**: Install [Git](https://git-scm.com/) for version control.
- **Make**: Available on macOS/Linux; for Windows, use WSL or [MinGW](http://www.mingw.org/).

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/mobile-data-pricing.git
cd mobile-data-pricing
```

### 2. Set Up Docker (Recommended)

The project uses Docker for reproducible execution.

#### Pull the Docker Image

```bash
docker pull ziqiguo567/mobile-data-pricing
```

#### (Optional) Build the Docker Image

To build the image locally:

```bash
make docker-build
```

#### (Optional) Push the Docker Image

To share a modified image:

```bash
make docker-push
```

### 3. Set Up Local R Environment (Optional)

For local development, restore R package dependencies:

```bash
make install
```

## Usage

### Generate the Report (Docker)

Generate the final report (`report/Final_project_2.html`):

```bash
make report
```

### Generate the Report (Local)

For local execution (requires R and dependencies):

```bash
make local-report
```

### Data Processing

Key data processing steps:

- **Clean Data**: Generate `data/clean_data.rds`:

  ```bash
  Rscript code/01_data_cleaning.R
  ```

- **Analysis and Visualization**: Generate `output/regional_summary.rds` and `output/price_distribution.png`:

  ```bash
  Rscript code/02_analysis.R && Rscript code/03_visualization.R
  ```

### Clean Up

Remove generated files:

```bash
make clean
```

## Workflow

1. Clean raw data (`Data_pricing.xlsx`) into `clean_data.rds`.
2. Perform analysis to create summary statistics.
3. Generate visualizations (e.g., price distribution plots).
4. Render the final report from `Final_project_2.Rmd`.
5. Use `make report` (Docker) or `make local-report` (local) to run all steps.

## Notes

- **Reproducibility**: Use `renv::snapshot()` to update `renv.lock` after installing new packages.
- **Docker Volumes**: The `Makefile` mounts project directories for file access.
- **Cross-Platform**: Supports Linux, macOS, and Windows.
- **Large Files**: Use [Git LFS](https://git-lfs.github.com/) for large datasets.

## Troubleshooting

- **Missing Packages**: If errors occur (e.g., `no package called 'here'`), run `make install` or check `renv.lock`.
- **Docker Issues**: Ensure Docker is running and the image is available. Rebuild with `make docker-build` if needed.
- **Permissions**: Verify Docker has access to the project directory (`ls -l`).
- **Git Push**: Use a [Personal Access Token](https://github.com/settings/tokens) for HTTPS authentication.

## Contributing

1. Fork the repository.
2. Create a branch (`git checkout -b feature/your-feature`).
3. Commit changes (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

## License

MIT License (see `LICENSE` file, if included).

## Contact

For questions, open an issue on GitHub.