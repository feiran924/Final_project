
FROM rocker/r-ubuntu

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        pandoc \
        libcurl4-openssl-dev \
        libssl-dev \
        libxml2-dev \
        libfontconfig1-dev \
        libharfbuzz-dev \
        libfribidi-dev \
        libfreetype6-dev \
        libpng-dev \
        libtiff5-dev \
        libjpeg-dev \
    && rm -rf /var/lib/apt/lists/*


# 2. Install renv and here package explicitly
RUN R -e "install.packages(c('renv', 'here'), repos='https://cloud.r-project.org')"

# 2. Configure renv environment before installation
ENV RENV_WATCHDOG_ENABLED=FALSE
ENV RENV_PATHS_CACHE=/renv/cache 


# Set up project structure
WORKDIR /project
RUN mkdir -p data code output report renv

# Copy only renv files first (better caching)
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R

# Force include 'here' in renv
RUN R -e "renv::consent(TRUE); \
           if (!'here' %in% installed.packages()) install.packages('here'); \
           renv::hydrate('here'); \
           renv::restore()"

# Verify installation
RUN R -e "library(here); \
           renv::record('here'); \
           writeLines(as.character(packageVersion('here')), '/project/here_version.txt')"

COPY data/Data_pricing.xlsx ./data/
COPY code code
COPY Makefile .
COPY Final_project_2.Rmd .

# Create report directory (only if doesn't exist)
RUN mkdir -p report

RUN R -e "if (!requireNamespace('here', quietly = TRUE)) { \
             install.packages('here', repos='https://cloud.r-project.org'); \
             library(here) \
           }; \
           packageVersion('here')"
           
# Set the default command to run your report script
CMD ["Rscript", "-e", "library(here); library(renv); renv::activate(); source('code/04_render_report.R')"]