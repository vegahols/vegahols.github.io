# CHART_TITLE: Revenue Comparison
# CHART_DESC: Quarterly revenue analysis
# CHART_TYPE: Bar Chart
# CHART_ICON: 💰
# CHART_FILE: revenue.html

# Revenue Bar Chart
# Generates quarterly revenue comparison as a bar chart

source("r/theme.R")
source("r/helpers.R")

generate_revenue_chart <- function() {
  # Generate sample data
  # In production: data <- load_data("revenue.csv")
  set.seed(123)
  quarters <- c("Q1 2024", "Q2 2024", "Q3 2024", "Q4 2024")
  revenue <- c(320, 410, 380, 450)

  # Create bar chart (horizontal bars)
  hc <- highchart() %>%
    apply_full_theme(
      title = "Quarterly Revenue Comparison",
      subtitle = "Bar chart showing revenue by quarter",
      y_axis_title = "Revenue ($K)"
    ) %>%
    hc_xAxis(categories = quarters) %>%
    hc_add_series(
      name = "Revenue",
      data = revenue,
      type = "bar",
      color = COLORS$secondary
    )

  # Save chart
  save_chart(hc, "revenue.html", "Quarterly Revenue Comparison")
}

# Run if executed directly
if (!interactive()) {
  generate_revenue_chart()
}
