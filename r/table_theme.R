# Table theming for Highcharts Grid Pro
# Provides consistent styling for tables to match charts

source("r/config.R")

#' Generate Grid Pro theme configuration
#'
#' @return A list of Grid Pro styling options
get_grid_pro_theme <- function() {
  list(
    style = list(
      fontFamily = CHART_CONFIG$fontFamily,
      fontSize = "13px",
      color = "#2c3e50"
    ),
    header = list(
      style = list(
        backgroundColor = "#f8f9fa",
        color = "#2c3e50",
        fontWeight = "600",
        fontSize = "13px",
        borderBottom = "2px solid #e8ecef"
      )
    ),
    row = list(
      style = list(
        backgroundColor = "#ffffff",
        borderBottom = "1px solid #f0f3f5"
      ),
      hoverStyle = list(
        backgroundColor = "#f8f9fa"
      )
    )
  )
}
