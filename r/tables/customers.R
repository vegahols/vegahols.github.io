# VIZ_TITLE: Customer Overview
# VIZ_DESC: Interactive customer data table
# VIZ_TYPE: Data Table
# VIZ_FILE: customers.html

# Customer Table using DT (DataTables for R)
# Displays customer information with sorting, filtering, and pagination

library(DT)
library(htmlwidgets)
source("r/config.R")
source("r/helpers.R")

generate_customers_table <- function() {
  # Generate sample data
  # In production: data <- load_data("customers.csv")
  set.seed(123)

  customers <- data.frame(
    Company = c("Acme Corp", "TechStart Inc", "Global Solutions", "Innovation Labs", "Digital Ventures",
                "Future Systems", "Smart Analytics", "Data Insights", "Cloud Nine", "Peak Performance",
                "Next Gen Tech", "Prime Solutions", "Elite Consulting", "Apex Industries", "Summit Corp"),
    Contact = c("John Smith", "Sarah Johnson", "Mike Chen", "Emily Brown", "David Lee",
                "Lisa Anderson", "Robert Taylor", "Maria Garcia", "James Wilson", "Patricia Martinez",
                "Michael Davis", "Jennifer Rodriguez", "William Lopez", "Elizabeth Lee", "Christopher Kim"),
    Revenue = c(125000, 89000, 156000, 67000, 198000,
                143000, 92000, 178000, 134000, 156000,
                98000, 187000, 112000, 165000, 145000),
    Region = c("North", "East", "West", "South", "North",
               "East", "West", "South", "North", "East",
               "West", "South", "North", "East", "West"),
    Status = c("Active", "Active", "Active", "Pending", "Active",
               "Active", "Pending", "Active", "Active", "Active",
               "Pending", "Active", "Active", "Active", "Pending")
  )

  # Format revenue column
  customers$Revenue <- paste0("$", format(customers$Revenue, big.mark = ","))

  # Create DT table with sorting, filtering, and pagination
  dt <- datatable(
    customers,
    options = list(
      pageLength = 10,
      lengthMenu = c(5, 10, 25, 50),
      searching = TRUE,
      ordering = TRUE,
      dom = 'Blfrtip',
      buttons = c('csv'),
      columnDefs = list(
        list(className = 'dt-center', targets = c(3, 4))
      )
    ),
    class = 'cell-border stripe',
    rownames = FALSE,
    caption = htmltools::tags$caption(
      style = 'caption-side: top; text-align: left;',
      htmltools::h1(style = 'color: #2c3e50; font-size: 24px; font-weight: 600; margin-bottom: 8px;', 'Customer Overview'),
      htmltools::p(style = 'color: #7f8c8d; font-size: 14px; margin-bottom: 20px;', 'Search, sort, and filter customer data')
    )
  )

  # Save table
  original_dir <- getwd()
  dir.create(OUTPUT_DIR, showWarnings = FALSE)
  setwd(OUTPUT_DIR)

  tryCatch({
    saveWidget(dt, file = "customers.html", selfcontained = FALSE, libdir = LIB_DIR, title = "Customer Overview")
    cat(paste("✓ customers.html generated\n"))
  }, error = function(e) {
    cat(paste("✗ Error generating customers.html:", e$message, "\n"))
  }, finally = {
    setwd(original_dir)
  })
}

# Run if executed directly
if (!interactive()) {
  generate_customers_table()
}
