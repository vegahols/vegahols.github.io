# Table theming for Highcharts Grid Pro
# Provides consistent styling for tables to match charts

source("r/config.R")

#' Get common table CSS styles
#'
#' @return A string containing CSS styles for tables
get_table_css <- function() {
  '* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  body {
    background-color: white;
    font-family: Arial, sans-serif;
    padding: 20px;
  }
  #container {
    max-width: 1200px;
    margin: 0 auto;
  }
  h1 {
    color: #2c3e50;
    font-size: 24px;
    font-weight: 600;
    margin-bottom: 8px;
  }
  .subtitle {
    color: #7f8c8d;
    font-size: 14px;
    margin-bottom: 20px;
  }
  .controls {
    margin-bottom: 15px;
  }
  .btn {
    padding: 8px 16px;
    background-color: #4A90E2;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 500;
    transition: background-color 0.2s;
  }
  .btn:hover {
    background-color: #357ABD;
  }
  #grid {
    border: 1px solid #e8ecef;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0,0,0,0.08);
  }'
}

#' Get Grid Pro configuration options
#'
#' @param page_size Default page size (default: 10)
#' @return A list of Grid Pro configuration options
get_grid_pro_config <- function(page_size = 10) {
  list(
    columnDefaults = list(
      filtering = list(enabled = TRUE)
    ),
    pagination = list(
      enabled = TRUE,
      pageSize = page_size,
      controls = list(
        pageSizeSelector = list(
          enabled = TRUE,
          options = c(5, 10, 25, 50)
        ),
        pageInfo = TRUE,
        firstLastButtons = TRUE,
        previousNextButtons = TRUE,
        pageButtons = list(
          enabled = TRUE,
          count = 7
        )
      )
    )
  )
}

#' Get CSV download JavaScript function
#'
#' @param filename The filename for the CSV export
#' @return A string containing the JavaScript function
get_csv_download_function <- function(filename) {
  sprintf('function downloadCSV() {
    if (grid) {
      grid.downloadCSV();
    }
  }', filename)
}
