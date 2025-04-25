# Makefile for Mobile Data Pricing Project

# Docker Configuration
DOCKER_IMAGE := ziqiguo567/mobile-data-pricing

# Files that trigger rebuild
PROJECT_FILES := Final_project_2.Rmd code/01_data_cleaning.R code/02_analysis.R code/03_visualization.R code/04_render_report.R
RENV_FILES := renv.lock renv/activate.R renv/settings.json

# Cross-platform directory mounting
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    MOUNT_DIR := $(shell pwd)
endif
ifeq ($(UNAME_S),Darwin)
    MOUNT_DIR := $(shell pwd)
endif
ifeq ($(OS),Windows_NT)
    MOUNT_DIR := /$(shell pwd)
endif

# Cross-platform volume mounts
DOCKER_RUN := docker run --rm \
    -v "$(shell pwd):/project" \
    -v "$(shell pwd)/renv:/project/renv" \
    -v "$(shell pwd)/report:/project/report" \
    -e RENV_PATHS_ROOT=/project/renv

### Docker Targets ###
.PHONY: docker-build
docker-build:
	docker build -t $(DOCKER_IMAGE) .

### Main Targets ###
.PHONY: all
all: report

.PHONY: report
report:
	@mkdir -p report renv
	$(DOCKER_RUN) $(DOCKER_IMAGE)


### Local Development Targets ###
.PHONY: local-report
local-report: report/Final_project_2.html-local

report/Final_project_2.html-local: code/04_render_report.R Final_project_2.Rmd output/regional_summary.rds output/price_distribution.png
	Rscript code/04_render_report.R

### Data Processing Targets ###
data/clean_data.rds: code/01_data_cleaning.R data/Data_pricing.xlsx
	Rscript code/01_data_cleaning.R

output/regional_summary.rds output/price_distribution.png: code/02_analysis.R code/03_visualization.R data/clean_data.rds
	Rscript code/02_analysis.R && Rscript code/03_visualization.R

### Utility Targets ###
.PHONY: docker-push
docker-push:
	docker push $(DOCKER_IMAGE)

.PHONY: clean
clean:
	rm -rf output/*.rds output/*.png output/*.csv report/* Final_project_2.html docker-image

.PHONY: install
install:
	Rscript -e "renv::restore()"