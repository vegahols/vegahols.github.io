# CHART_TITLE: Sales Trend
# CHART_DESC: Monthly sales performance
# CHART_TYPE: Line Chart
# CHART_FILE: sales.html

# Sales Line Chart
# Generates monthly sales trend as a line chart

source("r/theme.R")
source("r/helpers.R")

generate_sales_chart <- function() {
  # Generate sample data
  # In production: data <- load_data("sales.csv")
  set.seed(42)
  months <- get_months()
  sales <- round(rnorm(12, mean = 100, sd = 20))

  # Create line chart
  hc <- highchart() %>%
    apply_full_theme(
      title = "Monthly Sales Trend",
      subtitle = "Line chart showing sales performance over time",
      y_axis_title = "Units Sold"
    ) %>%
    hc_xAxis(categories = months) %>%
    hc_add_series(
      name = "Sales",
      data = sales,
      type = "line",
      color = COLORS$primary,
      marker = list(enabled = TRUE, radius = 5)
    )

  # Save chart
  save_chart(hc, "sales.html", "Monthly Sales Trend")
}

# Run if executed directly
if (!interactive()) {
  generate_sales_chart()
}
