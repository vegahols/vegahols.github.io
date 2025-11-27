#!/bin/bash

# Build all Highcharts visualizations
Rscript r/build.R
echo ""
echo "📦 Next steps:"
echo "   git add docs/ r/"
echo "   git commit -m 'Update charts'"
echo "   git push"
