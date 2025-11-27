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
  hc_chart(
    backgroundColor = "#ffffff",
    style = list(
      fontFamily = "Arial, sans-serif"
    )
  ) %>%
  hc_title(
    text = "Monthly Sales 2024",
    style = list(
      fontSize = "24px",
      fontWeight = "600",
      color = "#2c3e50"
    )
  ) %>%
  hc_subtitle(
    text = "Data generated with R, visualized with Highcharts",
    style = list(
      fontSize = "14px",
      color = "#7f8c8d"
    )
  ) %>%
  hc_xAxis(
    categories = months,
    labels = list(
      style = list(fontSize = "13px", color = "#34495e")
    )
  ) %>%
  hc_yAxis(
    title = list(
      text = "Units",
      style = list(fontSize = "13px", color = "#34495e")
    ),
    labels = list(
      style = list(fontSize = "13px", color = "#34495e")
    )
  ) %>%
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
    borderWidth = 2,
    style = list(fontSize = "13px")
  ) %>%
  hc_legend(
    itemStyle = list(
      fontSize = "13px",
      fontWeight = "400",
      color = "#34495e"
    )
  ) %>%
  hc_credits(enabled = FALSE) %>%
  hc_exporting(
    enabled = TRUE,
    buttons = list(
      contextButton = list(
        menuItems = c("downloadPNG", "downloadJPEG", "downloadPDF", "downloadSVG"),
        theme = list(
          fill = "#ffffff",
          stroke = "#e0e0e0",
          style = list(
            fontSize = "13px",
            fontWeight = "400"
          )
        )
      )
    )
  )

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
