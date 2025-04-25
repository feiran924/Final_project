here::i_am("code/04_render_report.R")
library(rmarkdown)
# Rendering a report in production mode
render("Final_project_2.Rmd", output_file = here::here("report", "Final_project_2.html"))