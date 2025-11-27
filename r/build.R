#!/usr/bin/env Rscript

# Master build script
# Generates all charts and tables, auto-generates the index page

cat("🚀 Building all visualizations...\n\n")

# Function to extract metadata from visualization file (chart or table)
extract_metadata <- function(file_path) {
  lines <- readLines(file_path, n = 20)

  metadata <- list()

  # Try VIZ_* format first (for tables), then fall back to CHART_* format
  title_line <- grep("VIZ_TITLE:|CHART_TITLE:", lines, value = TRUE)[1]
  desc_line <- grep("VIZ_DESC:|CHART_DESC:", lines, value = TRUE)[1]
  type_line <- grep("VIZ_TYPE:|CHART_TYPE:", lines, value = TRUE)[1]
  file_line <- grep("VIZ_FILE:|CHART_FILE:", lines, value = TRUE)[1]

  metadata$title <- gsub(".*(VIZ_TITLE|CHART_TITLE):\\s*", "", title_line)
  metadata$desc <- gsub(".*(VIZ_DESC|CHART_DESC):\\s*", "", desc_line)
  metadata$type <- gsub(".*(VIZ_TYPE|CHART_TYPE):\\s*", "", type_line)
  metadata$file <- gsub(".*(VIZ_FILE|CHART_FILE):\\s*", "", file_line)
  metadata$category <- ifelse(grepl("Table", metadata$type), "table", "chart")

  metadata
}

# Discover all chart files
chart_files <- list.files("r/charts", pattern = "\\.R$", full.names = TRUE)
charts_metadata <- list()

# Generate each chart and collect metadata
cat("📊 Charts:\n")
for (chart_file in chart_files) {
  cat(paste("  Generating:", basename(chart_file), "\n"))

  # Extract metadata
  metadata <- extract_metadata(chart_file)
  charts_metadata[[length(charts_metadata) + 1]] <- metadata

  # Source and run chart
  source(chart_file)
  chart_name <- gsub("\\.R$", "", basename(chart_file))
  func_name <- paste0("generate_", chart_name, "_chart")

  if (exists(func_name)) {
    do.call(func_name, list())
  }
}

# Discover all table files
table_files <- list.files("r/tables", pattern = "\\.R$", full.names = TRUE)
tables_metadata <- list()

# Generate each table and collect metadata
if (length(table_files) > 0) {
  cat("\n📋 Tables:\n")
  for (table_file in table_files) {
    cat(paste("  Generating:", basename(table_file), "\n"))

    # Extract metadata
    metadata <- extract_metadata(table_file)
    tables_metadata[[length(tables_metadata) + 1]] <- metadata

    # Source and run table
    source(table_file)
    table_name <- gsub("\\.R$", "", basename(table_file))
    func_name <- paste0("generate_", table_name, "_table")

    if (exists(func_name)) {
      do.call(func_name, list())
    }
  }
}

cat("\n")

# Auto-generate index page from discovered charts and tables
generate_card <- function(viz, category = "chart") {
  button_text <- ifelse(category == "chart", "View Full Chart", "View Full Table")

  sprintf('
      <div class="card">
        <div class="card-header">
          <h2>%s</h2>
          <span class="card-type">%s</span>
        </div>
        <div class="chart-preview">
          <iframe src="%s" frameborder="0"></iframe>
        </div>
        <p style="color: #7f8c8d; font-size: 0.9rem; margin-bottom: 0.75rem;">%s</p>
        <div class="card-actions">
          <a href="%s" class="btn btn-primary">%s</a>
          <button class="btn btn-secondary" onclick="toggleEmbed(\'%s\')">Embed Code</button>
        </div>
        <div class="embed-code" id="embed-%s">
          <button class="copy-btn" onclick="copyEmbed(\'%s\')">Copy</button>
          <code>&lt;iframe src="https://vegahols.github.io/%s" width="100%%" height="500" frameborder="0"&gt;&lt;/iframe&gt;</code>
        </div>
      </div>',
    viz$title, viz$type,
    viz$file,
    viz$desc,
    viz$file,
    button_text,
    gsub("\\.html$", "", viz$file),
    gsub("\\.html$", "", viz$file),
    gsub("\\.html$", "", viz$file),
    viz$file
  )
}

# Generate chart cards
charts_html <- paste(sapply(charts_metadata, function(c) generate_card(c, "chart")), collapse = "\n")

# Generate table cards
tables_html <- if (length(tables_metadata) > 0) {
  paste(sapply(tables_metadata, function(t) generate_card(t, "table")), collapse = "\n")
} else {
  ""
}

# Generate complete index page
index_html <- paste0('<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Analytics Dashboard</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif;
      background: #f5f7fa;
      min-height: 100vh;
      padding: 2rem 1rem;
    }
    .container { max-width: 1200px; margin: 0 auto; }
    header {
      background: white;
      padding: 2rem;
      border-radius: 8px;
      margin-bottom: 2rem;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08);
    }
    h1 {
      color: #2c3e50;
      margin-bottom: 0.5rem;
      font-size: 2rem;
      font-weight: 600;
    }
    .subtitle {
      color: #7f8c8d;
      font-size: 1rem;
    }
    .grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
      gap: 1.5rem;
    }
    .card {
      background: white;
      padding: 1.5rem;
      border-radius: 8px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.08);
      border: 1px solid #e8ecef;
    }
    .card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }
    .card h2 {
      color: #2c3e50;
      font-size: 1.25rem;
      font-weight: 600;
    }
    .chart-preview {
      width: 100%;
      height: 250px;
      margin-bottom: 1rem;
      border-radius: 6px;
      overflow: hidden;
      border: 1px solid #e8ecef;
      background: #fafbfc;
    }
    .chart-preview iframe {
      width: 100%;
      height: 100%;
    }
    .card-type {
      background: #f0f3f5;
      color: #6c7a89;
      padding: 0.25rem 0.75rem;
      border-radius: 4px;
      font-size: 0.75rem;
      font-weight: 500;
    }
    .card-actions {
      display: flex;
      gap: 0.5rem;
      margin-top: 1rem;
    }
    .btn {
      padding: 0.5rem 1rem;
      border-radius: 6px;
      border: none;
      font-size: 0.875rem;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
      transition: all 0.2s;
      font-weight: 500;
    }
    .btn-primary {
      background: #4A90E2;
      color: white;
    }
    .btn-primary:hover {
      background: #357ABD;
    }
    .btn-secondary {
      background: #f0f3f5;
      color: #6c7a89;
    }
    .btn-secondary:hover {
      background: #e4e9ed;
    }
    .embed-code {
      display: none;
      margin-top: 1rem;
      padding: 0.75rem;
      background: #f8f9fa;
      border: 1px solid #e8ecef;
      border-radius: 6px;
      font-family: "Courier New", monospace;
      font-size: 0.75rem;
      color: #2c3e50;
      word-break: break-all;
      position: relative;
    }
    .embed-code.show { display: block; }
    .copy-btn {
      position: absolute;
      top: 0.5rem;
      right: 0.5rem;
      background: #4A90E2;
      color: white;
      border: none;
      padding: 0.25rem 0.75rem;
      border-radius: 4px;
      font-size: 0.75rem;
      cursor: pointer;
    }
    .copy-btn:hover { background: #357ABD; }
    .copy-btn.copied { background: #5CB85C; }
    footer {
      text-align: center;
      margin-top: 3rem;
      color: #95a5a6;
      font-size: 0.875rem;
    }
  </style>
</head>
<body>
  <div class="container">
    <header>
      <h1>Analytics Dashboard</h1>
      <p class="subtitle">Interactive data visualizations</p>
    </header>

    <section style="margin-bottom: 2rem;">
      <h2 style="color: #2c3e50; font-size: 1.5rem; font-weight: 600; margin-bottom: 1rem;">📊 Charts</h2>
      <div class="grid">
', charts_html, '
      </div>
    </section>

', if (tables_html != "") paste0('
    <section>
      <h2 style="color: #2c3e50; font-size: 1.5rem; font-weight: 600; margin-bottom: 1rem;">📋 Tables</h2>
      <div class="grid">
', tables_html, '
      </div>
    </section>
') else '', '

    <footer>
      <p>Generated with R + Highcharts</p>
    </footer>
  </div>

  <script>
    function toggleEmbed(chart) {
      const embed = document.getElementById("embed-" + chart);
      embed.classList.toggle("show");
    }

    function copyEmbed(chart) {
      const embed = document.getElementById("embed-" + chart);
      const code = embed.querySelector("code").textContent;
      const btn = embed.querySelector(".copy-btn");

      navigator.clipboard.writeText(code).then(() => {
        btn.textContent = "Copied!";
        btn.classList.add("copied");
        setTimeout(() => {
          btn.textContent = "Copy";
          btn.classList.remove("copied");
        }, 2000);
      });
    }
  </script>
</body>
</html>')

writeLines(index_html, "docs/index.html")
cat("✓ index.html generated\n")

cat("\n✅ All visualizations built successfully!\n")
cat(sprintf("   📊 %d charts, 📋 %d tables\n", length(charts_metadata), length(tables_metadata)))
cat("📦 Ready to commit and push to GitHub Pages\n")
