# VIZ_TITLE: Customer Overview
# VIZ_DESC: Interactive customer data table
# VIZ_TYPE: Data Table
# VIZ_FILE: customers.html

# Customer Table using Highcharts Grid Pro
# Displays customer information in an interactive table

source("r/table_theme.R")
source("r/helpers.R")

generate_customers_table <- function() {
  # Generate sample data
  # In production: data <- load_data("customers.csv")
  set.seed(123)

  customers <- data.frame(
    Name = c("Acme Corp", "TechStart Inc", "Global Solutions", "Innovation Labs", "Digital Ventures"),
    Contact = c("John Smith", "Sarah Johnson", "Mike Chen", "Emily Brown", "David Lee"),
    Revenue = c(125000, 89000, 156000, 67000, 198000),
    Region = c("North", "East", "West", "South", "North"),
    Status = c("Active", "Active", "Active", "Pending", "Active")
  )

  # Convert data to Grid Pro format
  data_json <- jsonlite::toJSON(customers, dataframe = "columns", auto_unbox = FALSE)

  # Create HTML with Grid Pro
  html_content <- sprintf('<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>Customer Overview</title>
  <style>
    body {
      background-color: white;
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
    }
    #container {
      max-width: 1200px;
      margin: 0 auto;
    }
    h1 {
      color: #2c3e50;
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 8px;
    }
    .subtitle {
      color: #7f8c8d;
      font-size: 14px;
      margin-bottom: 20px;
    }
    .highcharts-data-grid-container {
      border: 1px solid #e8ecef;
      border-radius: 8px;
      overflow: hidden;
    }
  </style>
  <script src="https://code.highcharts.com/dashboards/datagrid.js"></script>
</head>
<body>
  <div id="container">
    <h1>Customer Overview</h1>
    <p class="subtitle">Interactive customer data table with sorting and filtering</p>
    <div id="grid"></div>
  </div>

  <script>
    const data = %s;

    const dataGrid = new DataGrid.DataGrid("grid", {
      dataTable: {
        columns: data
      },
      columnDefaults: {
        sorting: {
          sortable: true
        },
        cells: {
          editable: false
        }
      },
      columns: [{
        id: "Name",
        header: {
          format: "Company Name"
        }
      }, {
        id: "Contact",
        header: {
          format: "Contact Person"
        }
      }, {
        id: "Revenue",
        header: {
          format: "Revenue ($)"
        },
        cells: {
          formatter: function() {
            return "$" + this.value.toLocaleString();
          }
        }
      }, {
        id: "Region",
        header: {
          format: "Region"
        }
      }, {
        id: "Status",
        header: {
          format: "Status"
        }
      }]
    });
  </script>
</body>
</html>', data_json)

  # Save table
  save_table(html_content, "customers.html")
}

# Run if executed directly
if (!interactive()) {
  generate_customers_table()
}
