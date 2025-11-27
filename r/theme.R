# Theme and styling functions for Highcharts
# These functions apply consistent styling across all charts

source("r/config.R")

#' Apply common theme to a Highcharts object
#'
#' @param hc A highchart object
#' @return A highchart object with theme applied
apply_common_theme <- function(hc) {
  hc %>%
    hc_chart(
      backgroundColor = CHART_CONFIG$backgroundColor,
      style = list(fontFamily = CHART_CONFIG$fontFamily)
    ) %>%
    hc_credits(enabled = FALSE) %>%
    hc_exporting(
      enabled = EXPORT_CONFIG$enabled,
      buttons = EXPORT_CONFIG$buttons,
      menuItemStyle = EXPORT_CONFIG$menuItemStyle
    ) %>%
    hc_add_theme(
      hc_theme(
        navigation = NAVIGATION_CONFIG
      )
    )
}

#' Apply title and subtitle styling
#'
#' @param hc A highchart object
#' @param title Chart title
#' @param subtitle Chart subtitle (optional)
#' @return A highchart object with titles styled
apply_title_style <- function(hc, title, subtitle = NULL) {
  hc <- hc %>%
    hc_title(text = title, style = TYPOGRAPHY$title)

  if (!is.null(subtitle)) {
    hc <- hc %>%
      hc_subtitle(text = subtitle, style = TYPOGRAPHY$subtitle)
  }

  hc
}

#' Apply axis styling
#'
#' @param hc A highchart object
#' @param y_axis_title Y-axis title (default: "Units")
#' @return A highchart object with axes styled
apply_axis_style <- function(hc, y_axis_title = "Units") {
  hc %>%
    hc_xAxis(labels = list(style = TYPOGRAPHY$label)) %>%
    hc_yAxis(
      title = list(text = y_axis_title, style = TYPOGRAPHY$label),
      labels = list(style = TYPOGRAPHY$label)
    )
}

#' Apply tooltip and legend styling
#'
#' @param hc A highchart object
#' @return A highchart object with tooltip and legend styled
apply_interactive_style <- function(hc) {
  hc %>%
    hc_tooltip(
      crosshairs = TRUE,
      shared = TRUE,
      borderWidth = 2,
      style = list(fontSize = "13px")
    ) %>%
    hc_legend(itemStyle = TYPOGRAPHY$legend)
}

#' Apply full theme to a chart
#'
#' @param hc A highchart object
#' @param title Chart title
#' @param subtitle Chart subtitle (optional)
#' @param y_axis_title Y-axis title (default: "Units")
#' @return A fully themed highchart object
apply_full_theme <- function(hc, title, subtitle = NULL, y_axis_title = "Units") {
  hc %>%
    apply_common_theme() %>%
    apply_title_style(title, subtitle) %>%
    apply_axis_style(y_axis_title) %>%
    apply_interactive_style()
}
