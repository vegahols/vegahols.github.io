# Highcharts + R Demo

A simple, no-build demo using R's official Highcharts wrapper (`highcharter`) to create interactive visualizations, deployed via GitHub Pages.

## Features

- **Official R wrapper** - Uses `highcharter` package for R-native workflow
- **No build step** - Pure static files, push to deploy
- **Developer friendly** - All chart config in R, single source of truth
- **Auto-generated dashboard** - Index page with live chart previews and embed codes
- **GitHub Pages ready** - Works out of the box
- **Best practices** - Optimized library loading, clean structure

## Quick Start

### Prerequisites

- **R** with `highcharter` and `htmlwidgets` packages
- **Git**
- **GitHub account**

### Setup

1. **Install R dependencies** (first time only):
   ```bash
   Rscript r/install_deps.R
   ```

2. **Generate the chart**:
   ```bash
   ./generate.sh
   ```

3. **Deploy to GitHub**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

4. **Enable GitHub Pages**:
   - Go to Settings → Pages
   - Source: Deploy from branch
   - Branch: `main`, Folder: `/docs`
   - Save

5. **View at**: `https://<username>.github.io/<repo-name>/`

## Project Structure

```
.
├── docs/                    # GitHub Pages serves from here
│   ├── index.html          # Generated HTML with embedded chart
│   └── lib/                # Highcharts libraries (auto-generated)
├── r/
│   ├── generate_data.R     # Main script - creates the chart
│   └── install_deps.R      # Dependency installer
├── generate.sh             # Convenience script
├── .gitignore
└── README.md
```

## Workflow

The workflow is beautifully simple:

1. **Create/Edit** chart files in `r/charts/`
2. **Run** `./generate.sh` - Generates all charts and index
3. **Commit & Push** - GitHub Pages updates automatically

### Add a New Chart

**1. Create chart file** `r/charts/yourname.R`:

```r
# CHART_TITLE: Your Chart Title
# CHART_DESC: Brief description
# CHART_TYPE: Line Chart
# CHART_ICON: 📊
# CHART_FILE: yourname.html

source("r/theme.R")
source("r/helpers.R")

generate_yourname_chart <- function() {
  # Your data
  data <- c(10, 20, 30, 40)

  # Create chart
  hc <- highchart() %>%
    apply_full_theme("Your Title", "Subtitle") %>%
    hc_add_series(name = "Data", data = data, type = "line", color = COLORS$primary)

  # Save
  save_chart(hc, "yourname.html", "Your Title")
}
```

**2. Build**:
```bash
./generate.sh
```

**3. Done!** Your chart automatically appears on the dashboard index.

### Metadata Fields

Charts use metadata comments for automatic index generation:
- `CHART_TITLE` - Display title
- `CHART_DESC` - Short description
- `CHART_TYPE` - Chart type (Line Chart, Bar Chart, etc.)
- `CHART_ICON` - Emoji icon
- `CHART_FILE` - Output HTML filename

## How It Works

1. **Automatic discovery** - `build.R` finds all charts in `r/charts/`
2. **Metadata extraction** - Reads chart metadata from file comments
3. **Chart generation** - Generates HTML for each chart
4. **Auto-generated index** - Creates dashboard with interactive chart previews
5. **Interactive previews** - Each chart card shows a fully interactive 250px iframe preview
6. **No manual config** - Just add chart files and run build
7. **GitHub Pages serves** - Static files, no build process needed

## Customization

### Chart Types

`highcharter` supports all Highcharts chart types:

```r
# Line chart (default)
type = "line"

# Bar/Column charts
type = "column"
type = "bar"

# Area charts
type = "area"
type = "areaspline"

# Scatter/Bubble
type = "scatter"
type = "bubble"

# And many more...
```

### Load Real Data

Replace generated data with actual data from CSV files or databases.

**From CSV files**:

1. **Place CSV** in `r/data/` folder:
   ```
   r/data/sales_data.csv
   ```

2. **In your chart file** (e.g., `r/charts/sales.R`), use the helper:
   ```r
   # Replace generated data with:
   data <- load_data("sales_data.csv")
   sales <- data$sales
   months <- data$month

   # Then use in chart:
   hc <- highchart() %>%
     apply_full_theme("Sales", "From CSV data") %>%
     hc_xAxis(categories = months) %>%
     hc_add_series(name = "Sales", data = sales, type = "line")
   ```

3. **Build**: `./generate.sh`

The `load_data()` helper automatically looks in `r/data/` and handles errors.

**From databases**:

In your chart file (requires DBI package: `install.packages("DBI")`):

```r
library(DBI)
con <- dbConnect(RSQLite::SQLite(), "data/mydb.db")
data <- dbGetQuery(con, "SELECT month, revenue FROM sales WHERE year = 2024")
dbDisconnect(con)

hc <- highchart() %>%
  apply_full_theme("Revenue", "From database") %>%
  hc_xAxis(categories = data$month) %>%
  hc_add_series(name = "Revenue", data = data$revenue, type = "line")
```

**From APIs**:

In your chart file (jsonlite is already installed system-wide):

```r
library(jsonlite)
response <- fromJSON("https://api.example.com/sales")

hc <- highchart() %>%
  apply_full_theme("Sales", "Live API data") %>%
  hc_add_series(name = "Sales", data = response$data$values, type = "line")
```

### Multiple Charts

The system automatically handles multiple charts! Just add new chart files to `r/charts/` with metadata and run `./generate.sh`. See [Add a New Chart](#add-a-new-chart) section above.

## Best Practices

### Commit Generated Files
- Commit both `docs/index.html` and `docs/lib/`
- This is a **no-build deployment** - generated files are part of the repo
- Keeps deployment simple and fast

### Library Management
- Using `selfcontained = FALSE` for better performance
- Browser caches Highcharts libraries
- Smaller git diffs when updating charts

### Data Size
- Keep visualizations under 1MB for best performance
- For large datasets, consider server-side aggregation
- Use Highcharts' boost module for 1000+ points

### Development Workflow
```bash
# Make changes
vim r/generate_data.R

# Test locally
./generate.sh
open docs/index.html  # or python -m http.server -d docs

# Deploy
git add docs/
git commit -m "Descriptive message"
git push
```

## Dependencies

### System Packages (via apt)
```bash
sudo apt install r-cran-htmlwidgets r-cran-rlist r-cran-assertthat r-cran-rjson
```

### R Packages (user-installed)
- `highcharter` - Official Highcharts R wrapper (not available via apt)

Install with:
```bash
Rscript r/install_deps.R
```

Or manually:
```r
install.packages("highcharter")
```

### Browser Runtime
- Highcharts libraries (included in `docs/lib/`, auto-generated)

## Resources

- [Highcharter Documentation](https://jkunst.com/highcharter/)
- [Highcharts API Reference](https://api.highcharts.com/highcharts/)
- [GitHub Pages Quickstart](https://docs.github.com/en/pages/quickstart)
- [GitHub Pages Documentation](https://docs.github.com/pages)

## License

This demo is provided as-is for educational purposes.

**Note**: Highcharts requires a license for commercial use. See [Highcharts licensing](https://www.highcharts.com/products/highcharts/#non-commercial).
