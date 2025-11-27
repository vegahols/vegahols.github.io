#!/bin/bash

# Regenerate Highcharts visualization with R
echo "🚀 Generating Highcharts visualization..."
echo ""
Rscript r/generate_data.R
echo ""
echo "📦 Next steps:"
echo "   git add docs/"
echo "   git commit -m 'Update chart'"
echo "   git push"
