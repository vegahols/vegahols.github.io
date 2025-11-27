# Helper functions for chart generation
# Utility functions used across multiple chart scripts

source("r/config.R")

library(highcharter)
library(htmlwidgets)

#' Save a Highcharts widget to HTML file
#'
#' @param hc A highchart object
#' @param filename Output filename (e.g., "sales.html")
#' @param title Page title
#' @return NULL (side effect: saves file)
save_chart <- function(hc, filename, title) {
  original_dir <- getwd()
  dir.create(OUTPUT_DIR, showWarnings = FALSE)
  setwd(OUTPUT_DIR)

  tryCatch({
    saveWidget(
      hc,
      file = filename,
      selfcontained = FALSE,
      libdir = LIB_DIR,
      title = title
    )
    cat(paste("✓", filename, "generated\n"))
  }, error = function(e) {
    cat(paste("✗ Error generating", filename, ":", e$message, "\n"))
  }, finally = {
    setwd(original_dir)
  })
}

#' Load CSV data from data directory
#'
#' @param filename CSV filename (e.g., "sales.csv")
#' @return Data frame
load_data <- function(filename) {
  filepath <- file.path("r/data", filename)

  if (!file.exists(filepath)) {
    stop(paste("Data file not found:", filepath))
  }

  read.csv(filepath, stringsAsFactors = FALSE)
}

#' Get common month labels
#'
#' @return Character vector of month abbreviations
get_months <- function() {
  c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
}

#' Generate Grid Pro table HTML
#'
#' @param title Table title
#' @param subtitle Table subtitle
#' @param data Data frame to display
#' @param columns List of column configurations
#' @param filename Base filename for CSV export (without .csv)
#' @param page_size Default page size (default: 10)
#' @return Complete HTML string
generate_table_html <- function(title, subtitle, data, columns, filename, page_size = 10) {
  source("r/table_theme.R")

  # Convert data to Grid Pro format (column-based)
  data_json <- jsonlite::toJSON(data, dataframe = "columns", auto_unbox = FALSE)

  # Get theme CSS
  css <- get_table_css()

  # Get Grid Pro config
  config <- get_grid_pro_config(page_size)

  # Build columns config, handling formatters separately
  columns_for_json <- lapply(columns, function(col) {
    # Remove formatter from JSON serialization
    col_copy <- col
    col_copy$formatter <- NULL
    col_copy
  })

  columns_json <- jsonlite::toJSON(columns_for_json, auto_unbox = TRUE)

  # Replace formatter placeholders with actual JavaScript functions
  for (i in seq_along(columns)) {
    if (!is.null(columns[[i]]$formatter)) {
      # Find the column in JSON and add the formatter
      pattern <- sprintf('"id"\\s*:\\s*"%s"', columns[[i]]$id)
      replacement <- sprintf('"id": "%s", "cells": { "formatter": %s }',
                           columns[[i]]$id,
                           columns[[i]]$formatter)
      columns_json <- sub(pattern, replacement, columns_json)
    }
  }

  # Get download function
  download_fn <- get_csv_download_function(filename)

  # Generate complete HTML
  sprintf('<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>%s</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@highcharts/grid-pro/css/grid-pro.css" />
  <style>%s</style>
  <script src="https://cdn.jsdelivr.net/npm/@highcharts/grid-pro/grid-pro.js"></script>
</head>
<body>
  <div id="container">
    <h1>%s</h1>
    <p class="subtitle">%s</p>
    <div class="controls">
      <button class="btn" onclick="downloadCSV()">Download CSV</button>
    </div>
    <div id="grid"></div>
  </div>

  <script>
    const data = %s;

    const grid = Grid.grid("grid", {
      dataTable: {
        columns: data
      },
      columnDefaults: %s,
      columns: %s,
      pagination: %s,
      style: %s
    });

    %s
  </script>
</body>
</html>',
    title,
    css,
    title,
    subtitle,
    data_json,
    jsonlite::toJSON(config$columnDefaults, auto_unbox = TRUE),
    columns_json,
    jsonlite::toJSON(config$pagination, auto_unbox = TRUE),
    jsonlite::toJSON(config$style, auto_unbox = TRUE),
    download_fn
  )
}

#' Save a Grid Pro table to HTML file
#'
#' @param html_content Complete HTML content with Grid Pro table
#' @param filename Output filename (e.g., "customers.html")
#' @return NULL (side effect: saves file)
save_table <- function(html_content, filename) {
  dir.create(OUTPUT_DIR, showWarnings = FALSE)

  tryCatch({
    writeLines(html_content, file.path(OUTPUT_DIR, filename))
    cat(paste("✓", filename, "generated\n"))
  }, error = function(e) {
    cat(paste("✗ Error generating", filename, ":", e$message, "\n"))
  })
}
