# Configuration settings for all charts
# This file contains shared configuration that applies to all visualizations

# Chart settings
CHART_CONFIG <- list(
  backgroundColor = "#ffffff",
  fontFamily = "Arial, sans-serif"
)

# Color palette - Modern pastel primary colors
COLORS <- list(
  primary = "#5B9BD5",    # Modern blue
  secondary = "#FF6B6B",  # Coral red
  tertiary = "#FFD166",   # Warm gold
  accent = "#81C784",     # Soft green
  success = "#6FCF97",    # Success green
  info = "#B39DDB"        # Soft purple
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

# Navigation menu styling (for hamburger menu)
NAVIGATION_CONFIG <- list(
  menuStyle = list(
    border = "1px solid #e0e0e0",
    borderRadius = "6px",
    background = "#ffffff",
    boxShadow = "0 2px 8px rgba(0,0,0,0.1)"
  )
)

# Output settings
OUTPUT_DIR <- "docs"
LIB_DIR <- "lib"
