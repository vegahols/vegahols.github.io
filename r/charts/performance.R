# CHART_TITLE: Quarterly Performance
# CHART_DESC: Vertical bar chart showing quarterly results
# CHART_TYPE: Column Chart
# CHART_FILE: performance.html

# Vertical Bar Chart (Column Chart)
# Shows data using vertical bars

library(highcharter)
library(htmlwidgets)
source("r/config.R")
source("r/theme.R")
source("r/helpers.R")

generate_performance_chart <- function() {
  quarters <- c("Q1", "Q2", "Q3", "Q4")

  hc <- highchart() %>%
    hc_chart(type = "column") %>%
    hc_xAxis(categories = quarters) %>%
    hc_yAxis(title = list(text = "Revenue (thousands)")) %>%
    hc_add_series(
      name = "2023",
      data = c(45, 52, 48, 61),
      color = COLORS$primary
    ) %>%
    hc_add_series(
      name = "2024",
      data = c(52, 58, 65, 72),
      color = COLORS$secondary
    ) %>%
    hc_plotOptions(
      column = list(
        dataLabels = list(
          enabled = TRUE,
          format = "{y}"
        )
      )
    ) %>%
    apply_full_theme("Quarterly Performance", "Revenue by quarter", "Revenue (thousands)")

  save_chart(hc, "performance.html", "Quarterly Performance")
}

# Run if executed directly
if (!interactive()) {
  generate_performance_chart()
}
