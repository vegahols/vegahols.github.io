# Highcharts + R Demo

A simple, no-build demo using R's official Highcharts wrapper (`highcharter`) to create interactive visualizations, deployed via GitHub Pages.

## Features

- **Official R wrapper** - Uses `highcharter` package for R-native workflow
- **No build step** - Pure static files, push to deploy
- **Developer friendly** - All chart config in R, single source of truth
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

1. **Edit** `r/generate_data.R` - All chart configuration in R
2. **Run** `./generate.sh` - Generates HTML with Highcharts
3. **Commit & Push** - GitHub Pages updates automatically

### Example: Modify the Chart

Edit `r/generate_data.R`:

```r
# Change data
sales <- c(120, 135, 140, 160, 175, 190, 210, 225, 240, 255, 270, 290)

# Change chart type
hc_add_series(type = "column")  # bar chart

# Change colors
hc_add_series(color = "#ff6b6b")

# Add multiple series
hc_add_series(name = "Revenue", data = revenue) %>%
hc_add_series(name = "Costs", data = costs)
```

Then:
```bash
./generate.sh
git add docs/
git commit -m "Update chart"
git push
```

## How It Works

1. **R generates complete HTML** - `highcharter` creates self-contained visualization
2. **Libraries optimized** - Highcharts libs separated for browser caching
3. **GitHub Pages serves** - Static files, no build process
4. **Fast deployment** - Commit and push, live in seconds

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

Edit `r/generate_data.R` to load your actual data instead of generating random data.

**From CSV files**:

Place your CSV in the `r/` folder, then modify `r/generate_data.R`:

```r
# Replace the random data generation with:
data <- read.csv("r/sales_data.csv")
sales <- data$sales
months <- data$month

# Then create chart with your data:
hc <- highchart() %>%
  hc_xAxis(categories = months) %>%
  hc_add_series(name = "Sales", data = sales, type = "line")
```

Then run: `Rscript r/generate_data.R`

**From databases**:

Add this to `r/generate_data.R` (requires DBI package: `install.packages("DBI")`):

```r
library(DBI)
con <- dbConnect(RSQLite::SQLite(), "data/mydb.db")
data <- dbGetQuery(con, "SELECT month, revenue FROM sales WHERE year = 2024")
dbDisconnect(con)

hc <- highchart() %>%
  hc_xAxis(categories = data$month) %>%
  hc_add_series(name = "Revenue", data = data$revenue, type = "line")
```

**From APIs**:

Add this to `r/generate_data.R` (jsonlite is already installed system-wide):

```r
library(jsonlite)
response <- fromJSON("https://api.example.com/sales")

hc <- highchart() %>%
  hc_add_series(name = "Sales", data = response$data$values, type = "line")
```

**Summary**: Edit `r/generate_data.R` → Replace data generation → Run `Rscript r/generate_data.R` → Commit and push.

### Multiple Charts

Create additional R scripts and generate multiple pages:

```r
# Save to different files
saveWidget(hc, file = "docs/chart1.html", ...)
saveWidget(hc2, file = "docs/chart2.html", ...)
```

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
