# Mobile Data Pricing Project Makefile

# Final HTML report target
Final_project_2.html: Final_project_2.Rmd \
                     output/regional_summary.rds \
                     output/price_distribution.png
	Rscript -e "rmarkdown::render('Final_project_2.Rmd', output_file = 'Final_project_2.html')"
               
# Data cleaning
data/clean_data.rds: code/01_data_cleaning.R data/Data_pricing.xlsx
	Rscript code/01_data_cleaning.R

# Analysis and visualization
output/regional_summary.rds output/price_distribution.png: \
                           code/02_analysis.R \
                           code/03_visualization.R \
                           data/clean_data.rds
	Rscript code/02_analysis.R && \
	Rscript code/03_visualization.R

# Clean all generated files
.PHONY: clean
clean:
	rm -f output/*.rds && \
	rm -f output/*.png && \
	rm -f Final_project_2.html

# Shortcut to build everything
.PHONY: all
all: Final_project_2.html