# Highcharts + R Demo

Interactive data visualizations using R and Highcharts, deployed via GitHub Pages.

## Features

- **Charts** - Line, bar, pie charts using highcharter
- **Tables** - Interactive data tables with Highcharts Grid Pro
- **Maps** - Geographic visualizations with Highcharts Maps
- **Auto-generated dashboard** - Index with live previews and embed codes
- **No build step** - Pure static files, push to deploy
- **R-native workflow** - All config in R files

## Quick Start

1. **Install dependencies**:
   ```bash
   Rscript r/install_deps.R
   ```

2. **Build**:
   ```bash
   Rscript r/build.R
   ```

3. **Deploy**:
   ```bash
   git add .
   git commit -m "Update visualizations"
   git push
   ```

4. **Enable GitHub Pages** (first time):
   - Settings → Pages
   - Source: `main` branch, `/docs` folder

## File Structure

```
r/
├── config.R          # Colors and settings
├── theme.R           # Chart styling
├── table_theme.R     # Table styling
├── helpers.R         # Shared functions
├── build.R           # Build script
├── charts/           # Chart files (.R)
├── tables/           # Table files (.R)
├── maps/             # Map files (.R)
└── data/             # CSV data files

docs/
├── index.html        # Auto-generated dashboard
├── *.html            # Individual visualizations
└── lib/              # JavaScript libraries
```

## Add Visualizations

### Charts

Create `r/charts/name.R`:

```r
# CHART_TITLE: Your Chart
# CHART_DESC: Description
# CHART_TYPE: Line Chart
# CHART_FILE: name.html

source("r/config.R")
source("r/theme.R")
source("r/helpers.R")

generate_name_chart <- function() {
  hc <- highchart() %>%
    hc_add_series(data = c(1, 2, 3), type = "line") %>%
    apply_full_theme("Title", "Subtitle")

  save_chart(hc, "name.html", "Title")
}
```

### Tables

Create `r/tables/name.R`:

```r
# VIZ_TITLE: Your Table
# VIZ_DESC: Description
# VIZ_TYPE: Data Table
# VIZ_FILE: name.html

source("r/helpers.R")

generate_name_table <- function() {
  data <- data.frame(Name = c("A", "B"), Value = c(1, 2))

  columns <- list(
    list(id = "Name"),
    list(id = "Value")
  )

  html <- generate_table_html(
    title = "Your Table",
    subtitle = "Description",
    data = data,
    columns = columns,
    filename = "name"
  )

  save_table(html, "name.html")
}
```

### Maps

Create `r/maps/name.R` - See `r/maps/norway.R` for example.

## Metadata Formats

- **Charts**: `CHART_TITLE`, `CHART_DESC`, `CHART_TYPE`, `CHART_FILE`
- **Tables**: `VIZ_TITLE`, `VIZ_DESC`, `VIZ_TYPE`, `VIZ_FILE`
- **Maps**: `MAP_TITLE`, `MAP_DESC`, `MAP_TYPE`, `MAP_FILE`

## Load Data from CSV

```r
# Place CSV in r/data/
data <- load_data("file.csv")

# Use in visualization
hc <- highchart() %>%
  hc_add_series(data = data$column)
```

## Resources

- [Highcharter Docs](https://jkunst.com/highcharter/)
- [Highcharts API](https://api.highcharts.com/highcharts/)
- [Grid Pro Docs](https://www.highcharts.com/docs/grid/)
- [Maps Docs](https://www.highcharts.com/docs/maps/)
- [GitHub Pages](https://docs.github.com/pages)

## License

Highcharts requires a license for commercial use. See [licensing](https://www.highcharts.com/products/highcharts/#non-commercial).
