#!/usr/bin/env Rscript

# Generate Highcharts visualization using the official R wrapper
# This script creates a chart and exports it as a complete HTML page

library(highcharter)
library(htmlwidgets)

# Generate sample data: monthly sales over one year
set.seed(42)
months <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
sales <- round(rnorm(12, mean = 100, sd = 20))

# Create a data frame for easier manipulation
data <- data.frame(
  month = months,
  sales = sales
)

# Create Highcharts line chart using highcharter
hc <- highchart() %>%
  hc_title(text = "Monthly Sales 2024") %>%
  hc_subtitle(text = "Data generated with R, visualized with Highcharts") %>%
  hc_xAxis(categories = months) %>%
  hc_yAxis(title = list(text = "Units")) %>%
  hc_add_series(
    name = "Sales",
    data = sales,
    type = "line",
    color = "#667eea",
    marker = list(
      enabled = TRUE,
      radius = 4
    )
  ) %>%
  hc_tooltip(
    crosshairs = TRUE,
    shared = TRUE,
    borderWidth = 2
  ) %>%
  hc_chart(
    backgroundColor = "#ffffff"
  ) %>%
  hc_credits(enabled = FALSE) %>%
  hc_exporting(enabled = TRUE)

# Save as HTML file
# Change to docs directory first for correct path resolution
original_dir <- getwd()
dir.create("docs", showWarnings = FALSE)
setwd("docs")

saveWidget(
  hc,
  file = "index.html",
  selfcontained = FALSE,
  libdir = "lib",
  title = "Highcharts + R Demo"
)

setwd(original_dir)
output_file <- "docs/index.html"

cat("✓ Chart generated successfully!\n")
cat(paste("✓ Output written to:", output_file, "\n"))
cat("✓ Ready to commit and push to GitHub Pages\n")
