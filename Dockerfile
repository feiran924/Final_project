
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

# Set up project structure
RUN mkdir /project
WORKDIR /project

RUN mkdir data
RUN mkdir code
RUN mkdir output
RUN mkdir report

COPY data data
COPY code code
COPY Makefile .
COPY Final_project_2.Rmd .

COPY .Rprofile .
COPY renv.lock .
RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.json renv

RUN Rscript -e "renv::restore(prompt=FALSE)"

# entry point
CMD make
