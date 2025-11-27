# MAP_TITLE: Norway Regional Population
# MAP_DESC: Interactive map showing population by region
# MAP_TYPE: Choropleth
# MAP_FILE: norway.html

# Norway Population Map using Highcharts Maps
# Displays population data by Norwegian regions with interactive features

library(highcharter)
library(htmlwidgets)
source("r/config.R")
source("r/theme.R")
source("r/helpers.R")

generate_norway_chart <- function() {
  # Regional population data (based on reference datasets.js)
  map_data <- data.frame(
    hckey = c("no-bu", "no-ag", "no-ak", "no-os", "no-fi", "no-tr",
              "no-of", "no-vl", "no-mr", "no-te", "no-vf", "no-ro",
              "no-td", "no-no", "no-in"),
    value = c(280000, 307000, 618000, 697000, 76000, 167000, 296000,
              637000, 265000, 175000, 250000, 480000, 469000, 243000, 371000),
    stringsAsFactors = FALSE
  )

  # Rename column to match map key
  names(map_data)[1] <- "hc-key"

  # Load Norway topology from docs directory
  norway_map <- jsonlite::fromJSON("docs/norway-highcharts.topo.json")

  # Create map chart with gradient color axis
  hc <- highchart(type = "map") %>%
    hc_add_series_map(
      map = norway_map,
      df = map_data,
      value = "value",
      joinBy = "hc-key",
      name = "Population",
      borderColor = "#FFFFFF",
      borderWidth = 0.5,
      states = list(
        hover = list(
          borderColor = "#000000",
          borderWidth = 1
        )
      )
    ) %>%
    hc_colorAxis(
      min = 0,
      stops = list(
        list(0, COLORS$accent),      # Light green for low values
        list(0.33, COLORS$primary),  # Blue for medium-low
        list(0.67, COLORS$tertiary), # Gold for medium-high
        list(1, COLORS$secondary)    # Coral red for high values
      )
    ) %>%
    hc_mapNavigation(
      enabled = TRUE,
      buttonOptions = list(
        verticalAlign = "bottom"
      )
    ) %>%
    hc_tooltip(
      useHTML = TRUE,
      headerFormat = "",
      pointFormat = "<b>{point.name}</b><br/>Population: {point.value:,.0f}"
    ) %>%
    apply_full_theme("Norway Regional Population", "Population distribution by region")

  save_chart(hc, "norway.html", "Norway Regional Population")
}

# Run if executed directly
if (!interactive()) {
  generate_norway_chart()
}
