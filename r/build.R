#!/usr/bin/env Rscript

# Master build script
# Generates all charts and the index page

cat("🚀 Building all charts...\n\n")

# Source all chart files
chart_files <- list.files("r/charts", pattern = "\\.R$", full.names = TRUE)

for (chart_file in chart_files) {
  cat(paste("Generating:", basename(chart_file), "\n"))
  source(chart_file)

  # Call the generate function (convention: generate_<name>_chart)
  chart_name <- gsub("\\.R$", "", basename(chart_file))
  func_name <- paste0("generate_", chart_name, "_chart")

  if (exists(func_name)) {
    do.call(func_name, list())
  }
}

cat("\n")

# Generate index page
index_html <- '<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Highcharts Dashboard</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: Arial, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      padding: 2rem;
    }
    .container { max-width: 1200px; margin: 0 auto; }
    h1 { color: white; margin-bottom: 0.5rem; font-size: 2.5rem; }
    .subtitle { color: rgba(255,255,255,0.9); margin-bottom: 2rem; font-size: 1.1rem; }
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 1.5rem;
    }
    .card {
      background: white;
      padding: 2rem;
      border-radius: 12px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
      transition: transform 0.2s;
      text-decoration: none;
      color: inherit;
      display: block;
    }
    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 40px rgba(0,0,0,0.3);
    }
    .card h2 { color: #2c3e50; margin-bottom: 0.5rem; font-size: 1.5rem; }
    .card p { color: #7f8c8d; font-size: 0.95rem; line-height: 1.5; }
    .chart-type {
      display: inline-block;
      background: #f0f0f0;
      padding: 0.25rem 0.75rem;
      border-radius: 12px;
      font-size: 0.8rem;
      color: #666;
      margin-top: 0.5rem;
    }
    .footer {
      text-align: center;
      color: white;
      margin-top: 3rem;
      opacity: 0.9;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>📊 Analytics Dashboard</h1>
    <p class="subtitle">Interactive data visualizations powered by R and Highcharts</p>
    <div class="grid">
      <a href="sales.html" class="card">
        <h2>📈 Sales Trend</h2>
        <p>Monthly sales performance tracking over time</p>
        <span class="chart-type">Line Chart</span>
      </a>
      <a href="revenue.html" class="card">
        <h2>💰 Revenue Comparison</h2>
        <p>Quarterly revenue analysis and comparison</p>
        <span class="chart-type">Bar Chart</span>
      </a>
      <a href="market.html" class="card">
        <h2>🥧 Market Share</h2>
        <p>Product market share distribution breakdown</p>
        <span class="chart-type">Pie Chart</span>
      </a>
    </div>
    <div class="footer">
      <p>Generated with R + Highcharts • Updated automatically</p>
    </div>
  </div>
</body>
</html>'

writeLines(index_html, "docs/index.html")
cat("✓ index.html generated\n")

cat("\n✅ All charts built successfully!\n")
cat("📦 Ready to commit and push to GitHub Pages\n")
