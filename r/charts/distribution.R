# CHART_TITLE: Market Share Distribution
# CHART_DESC: Horizontal stacked bar chart showing market share by region
# CHART_TYPE: Stacked Bar
# CHART_FILE: distribution.html

# Horizontal Stacked Bar Chart (100% stacked)
# Shows percentage distribution across categories

library(highcharter)
library(htmlwidgets)
source("r/config.R")
source("r/theme.R")
source("r/helpers.R")

generate_distribution_chart <- function() {
  # Sample data: Market share by product category across regions
  regions <- c("North", "South", "East", "West")

  hc <- highchart() %>%
    hc_chart(type = "bar") %>%
    hc_xAxis(categories = regions) %>%
    hc_yAxis(
      title = list(text = "Market Share"),
      labels = list(format = "{value}%")
    ) %>%
    hc_plotOptions(
      series = list(
        stacking = "percent",
        dataLabels = list(
          enabled = TRUE,
          format = "{point.percentage:.0f}%"
        )
      )
    ) %>%
    hc_add_series(
      name = "Product A",
      data = c(45, 32, 28, 51),
      color = COLORS$primary
    ) %>%
    hc_add_series(
      name = "Product B",
      data = c(30, 41, 38, 27),
      color = COLORS$secondary
    ) %>%
    hc_add_series(
      name = "Product C",
      data = c(25, 27, 34, 22),
      color = COLORS$tertiary
    ) %>%
    hc_tooltip(
      shared = TRUE,
      pointFormat = '<span style="color:{series.color}">{series.name}</span>: <b>{point.percentage:.1f}%</b><br/>'
    ) %>%
    apply_full_theme("Market Share Distribution", "Percentage distribution by region")

  save_chart(hc, "distribution.html", "Market Share Distribution")
}

# Run if executed directly
if (!interactive()) {
  generate_distribution_chart()
}
