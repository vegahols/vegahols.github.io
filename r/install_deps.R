#!/usr/bin/env Rscript

# Install required R packages
# Note: Most dependencies installed system-wide via apt
# Only highcharter needs to be installed from CRAN (not available via apt)

packages <- c("highcharter")

# Create user library if it doesn't exist
user_lib <- Sys.getenv("R_LIBS_USER")
if (!dir.exists(user_lib)) {
  dir.create(user_lib, recursive = TRUE)
  cat(paste("Created user library at:", user_lib, "\n"))
}

cat("Checking dependencies...\n\n")

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    cat(paste("Installing", pkg, "...\n"))
    install.packages(pkg, repos = "https://cloud.r-project.org", lib = user_lib)
  } else {
    cat(paste("✓", pkg, "already installed\n"))
  }
}

cat("\n✓ All dependencies ready!\n")
cat("\nSystem packages (via apt): htmlwidgets, rlist, assertthat, rjson\n")
cat("User packages: highcharter\n")
