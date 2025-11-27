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
  map_data <- list(
    list("hc-key" = "no-bu", value = 280000),
    list("hc-key" = "no-ag", value = 307000),
    list("hc-key" = "no-ak", value = 618000),
    list("hc-key" = "no-os", value = 697000),
    list("hc-key" = "no-fi", value = 76000),
    list("hc-key" = "no-tr", value = 167000),
    list("hc-key" = "no-of", value = 296000),
    list("hc-key" = "no-vl", value = 637000),
    list("hc-key" = "no-mr", value = 265000),
    list("hc-key" = "no-te", value = 175000),
    list("hc-key" = "no-vf", value = 250000),
    list("hc-key" = "no-ro", value = 480000),
    list("hc-key" = "no-td", value = 469000),
    list("hc-key" = "no-no", value = 243000),
    list("hc-key" = "no-in", value = 371000)
  )

  # Generate custom HTML with async map loading (like reference implementation)
  html_content <- sprintf('<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>Norway Regional Population</title>
  <script src="https://code.highcharts.com/highcharts.js"></script>
  <script src="https://code.highcharts.com/maps/modules/map.js"></script>
  <script src="https://code.highcharts.com/modules/exporting.js"></script>
  <style>
    body {
      background-color: #ffffff;
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }
    #container {
      width: 100%%;
      height: 100vh;
      min-height: 500px;
    }
  </style>
</head>
<body>
  <div id="container"></div>

  <script>
    (async () => {
      // Load topology
      const topology = await fetch("norway-highcharts.topo.json").then(r => r.json());

      // Map data
      const data = %s;

      // Create map
      Highcharts.mapChart("container", {
        chart: {
          backgroundColor: "#ffffff"
        },
        title: {
          text: "Norway Regional Population",
          style: {
            fontSize: "24px",
            fontWeight: "600",
            color: "#2c3e50"
          }
        },
        subtitle: {
          text: "Population distribution by region",
          style: {
            fontSize: "14px",
            color: "#7f8c8d"
          }
        },
        mapNavigation: {
          enabled: true,
          buttonOptions: {
            verticalAlign: "bottom"
          }
        },
        colorAxis: {
          min: 0,
          stops: [
            [0, "%s"],
            [0.33, "%s"],
            [0.67, "%s"],
            [1, "%s"]
          ]
        },
        series: [{
          type: "map",
          mapData: topology,
          data: data,
          joinBy: "hc-key",
          name: "Population",
          borderColor: "#FFFFFF",
          borderWidth: 0.5,
          states: {
            hover: {
              borderColor: "#000000",
              borderWidth: 1
            }
          }
        }],
        tooltip: {
          useHTML: true,
          headerFormat: "",
          pointFormat: "<b>{point.name}</b><br/>Population: {point.value:,.0f}"
        },
        credits: {
          enabled: false
        },
        exporting: {
          enabled: true
        }
      });
    })();
  </script>
</body>
</html>',
    jsonlite::toJSON(map_data, auto_unbox = TRUE),
    COLORS$accent,
    COLORS$primary,
    COLORS$tertiary,
    COLORS$secondary
  )

  # Save HTML file
  dir.create(OUTPUT_DIR, showWarnings = FALSE)
  writeLines(html_content, file.path(OUTPUT_DIR, "norway.html"))
  cat("✓ norway.html generated\n")
}

# Run if executed directly
if (!interactive()) {
  generate_norway_chart()
}
