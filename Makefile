# Define variables
PROJECTFILES = Final_project_2.Rmd data/Data_pricing.xlsx code/01_data_cleaning.R code/02_analysis.R code/03_visualization.R code/04_render_report.R
RENVFILES = renv.lock renv/activate.R renv/settings.json

# Main report generation rule with two options (Docker or direct)
report/Final_project_2.html: code/04_render_report.R Final_project_2.Rmd output/regional_summary.rds output/price_distribution.png
	Rscript code/04_render_report.R

# Data processing rules
data/clean_data.rds: code/01_data_cleaning.R data/Data_pricing.xlsx
	Rscript code/01_data_cleaning.R

output/regional_summary.rds output/price_distribution.png: code/02_analysis.R code/03_visualization.R data/clean_data.rds
	Rscript code/02_analysis.R && Rscript code/03_visualization.R

# Standalone Docker build (optional)
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

# Docker-based report generation
.PHONY: report
report: 
	@echo "Running report generation in Docker..."
	docker run --rm \
		-v "$(shell pwd)/data:/project/data" \
		-v "$(shell pwd)/code:/project/code" \
		-v "$(shell pwd)/output:/project/output" \
		-v "$(shell pwd)/report:/project/report" \
		-v "$(shell pwd)/Final_project_2.Rmd:/project/Final_project_2.Rmd" \
		-v "$(shell pwd)/.Rprofile:/project/.Rprofile" \
		-v "$(shell pwd)/renv.lock:/project/renv.lock" \
		ziqiguo567/mobile-data-pricing \
		make report/Final_project_2.html

# Utility rules
.PHONY: clean
clean:
	rm -rf output/*.rds output/*.png output/*.csv report/*.html data/*.rds

.PHONY: install
install:
	Rscript -e "renv::restore()"