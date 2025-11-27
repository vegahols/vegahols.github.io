# VIZ_TITLE: Customer Overview
# VIZ_DESC: Interactive customer data table
# VIZ_TYPE: Data Table
# VIZ_FILE: customers.html

# Customer Table using Highcharts Grid Pro
# Displays customer information with sorting, filtering, and pagination

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

  # Define column configurations
  columns <- list(
    list(
      id = "Company",
      header = list(format = "Company Name")
    ),
    list(
      id = "Contact",
      header = list(format = "Contact Person")
    ),
    list(
      id = "Revenue",
      header = list(format = "Revenue"),
      formatter = 'function() { return "$" + this.value.toLocaleString(); }'
    ),
    list(
      id = "Region",
      header = list(format = "Region")
    ),
    list(
      id = "Status",
      header = list(format = "Status")
    )
  )

  # Generate table HTML using helper
  html_content <- generate_table_html(
    title = "Customer Overview",
    subtitle = "Search, sort, and filter customer data",
    data = customers,
    columns = columns,
    filename = "customers-export",
    page_size = 10
  )

  # Save table
  save_table(html_content, "customers.html")
}

# Run if executed directly
if (!interactive()) {
  generate_customers_table()
}
