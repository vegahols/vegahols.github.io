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
