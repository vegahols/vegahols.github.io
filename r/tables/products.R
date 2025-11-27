# VIZ_TITLE: Product Inventory
# VIZ_DESC: Product catalog with pricing and stock levels
# VIZ_TYPE: Data Table
# VIZ_FILE: products.html

# Product Table using Highcharts Grid Pro
# Loads data from CSV file and displays with sorting, filtering, and pagination

source("r/config.R")
source("r/helpers.R")

generate_products_table <- function() {
  # Load data from CSV file
  products <- load_data("products.csv")

  # Format price column
  products$Price <- paste0("$", format(products$Price, nsmall = 2))

  # Define Grid Pro columns
  columns <- list(
    list(id = "ProductID", width = 80),
    list(id = "ProductName"),
    list(id = "Category"),
    list(id = "Price"),
    list(
      id = "Stock",
      formatter = 'function(cell) {
        const value = cell.value;
        const color = value > 100 ? "#5CB85C" : value > 50 ? "#F0AD4E" : "#D9534F";
        const bgColor = value > 100 ? "#E8F5E9" : value > 50 ? "#FFF3E0" : "#FFEBEE";
        return `<span style="background-color: ${bgColor}; color: ${color}; padding: 4px 12px; border-radius: 12px; font-weight: 500; font-size: 12px;">${value}</span>`;
      }'
    ),
    list(id = "Supplier")
  )

  # Generate HTML using helper
  html_content <- generate_table_html(
    title = "Product Inventory",
    subtitle = "Product catalog with pricing and stock levels",
    data = products,
    columns = columns,
    filename = "products",
    page_size = 10
  )

  # Save table using helper
  save_table(html_content, "products.html")
}

# Run if executed directly
if (!interactive()) {
  generate_products_table()
}
