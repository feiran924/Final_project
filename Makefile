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

# Rule to build Docker image
project_image: $(PROJECTFILES) $(RENVFILES)
	docker build -t ziqiguo567/mobile-data-pricing .
	touch $@
	
# Docker-based report generation (alternative approach)
.PHONY: report
report: project_image
	docker run -v "$$(pwd)/report":/project/report ziqiguo567/mobile-data-pricing

# Utility rules
.PHONY: clean
clean:
	rm -rf output/*.rds output/*.png output/*.csv report/*.html data/*.rds

.PHONY: install
install:
	Rscript -e "renv::restore()"