# CHART_TITLE: Market Share
# CHART_DESC: Product distribution breakdown
# CHART_TYPE: Pie Chart
# CHART_ICON: 🥧
# CHART_FILE: market.html

# Market Share Pie Chart
# Generates market share distribution as a pie chart

source("r/theme.R")
source("r/helpers.R")

generate_market_chart <- function() {
  # Generate sample data
  # In production: data <- load_data("market.csv")
  products <- c("Product A", "Product B", "Product C", "Product D", "Product E")
  shares <- c(35, 25, 20, 12, 8)

  # Create data in format Highcharts expects for pie charts
  # Use distinct colors: blue, coral, gold, green, purple
  pie_data <- lapply(seq_along(products), function(i) {
    list(
      name = products[i],
      y = shares[i],
      color = c(COLORS$primary, COLORS$secondary, COLORS$tertiary,
                COLORS$accent, COLORS$info)[i]
    )
  })

  # Create pie chart
  hc <- highchart() %>%
    apply_common_theme() %>%
    hc_title(
      text = "Market Share Distribution",
      style = TYPOGRAPHY$title
    ) %>%
    hc_subtitle(
      text = "Pie chart showing product market share percentages",
      style = TYPOGRAPHY$subtitle
    ) %>%
    hc_add_series(
      name = "Market Share",
      data = pie_data,
      type = "pie",
      dataLabels = list(
        enabled = TRUE,
        format = '{point.name}: {point.percentage:.1f}%',
        style = list(fontSize = "13px")
      )
    ) %>%
    hc_tooltip(
      pointFormat = '<b>{point.percentage:.1f}%</b>',
      style = list(fontSize = "13px")
    ) %>%
    hc_plotOptions(
      pie = list(
        allowPointSelect = TRUE,
        cursor = "pointer",
        showInLegend = TRUE
      )
    ) %>%
    hc_legend(itemStyle = TYPOGRAPHY$legend)

  # Save chart
  save_chart(hc, "market.html", "Market Share Distribution")
}

# Run if executed directly
if (!interactive()) {
  generate_market_chart()
}
