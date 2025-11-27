# Configuration settings for all charts
# This file contains shared configuration that applies to all visualizations

# Chart settings
CHART_CONFIG <- list(
  backgroundColor = "#ffffff",
  fontFamily = "Arial, sans-serif"
)

# Color palette - Modern, neutral, professional
COLORS <- list(
  primary = "#4A90E2",    # Clear blue
  secondary = "#50C9C3",  # Teal
  tertiary = "#7BC74D",   # Fresh green
  accent = "#F5A623",     # Amber
  success = "#5CB85C",    # Success green
  info = "#5BC0DE"        # Info blue
)

# Typography
TYPOGRAPHY <- list(
  title = list(
    fontSize = "24px",
    fontWeight = "600",
    color = "#2c3e50"
  ),
  subtitle = list(
    fontSize = "14px",
    color = "#7f8c8d"
  ),
  label = list(
    fontSize = "13px",
    color = "#34495e"
  ),
  legend = list(
    fontSize = "13px",
    fontWeight = "400",
    color = "#34495e"
  )
)

# Export menu settings
EXPORT_CONFIG <- list(
  enabled = TRUE,
  buttons = list(
    contextButton = list(
      theme = list(fill = "#ffffff", stroke = "#e0e0e0")
    )
  ),
  menuItemStyle = list(fontSize = "13px", fontWeight = "400")
)

# Output settings
OUTPUT_DIR <- "docs"
LIB_DIR <- "lib"
