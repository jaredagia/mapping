##Nigeria Mapping in R: Kano State and Study Area

This repository contains an R script that generates maps using shapefiles to visualize:
1. The entire country of Nigeria, highlighting Kano State
2. Kano State, highlighting key Local Government Areas (LGAs)
3. The specific study area within Kano City

What’s Included
1. Maps.R — the R script with step-by-step explanations for loading shapefiles, 
filtering regions, calculating centroids, and plotting maps.
2. Shapefiles — required for national and LGA-level boundaries (Nigeria_Poly.shp, NGA_adm2.shp)
3. Output Maps — saved as PNG images.

 Output Maps
1. Map of Nigeria showing Kano State; Nigeria.png
2. Map of Kano showing urban LGAs; Kano.png
3. Map of study area within Kano City; Study_Area.png

How to use
1. Open Maps.R in RStudio or your R environment
2. Ensure the shapefiles (.shp, .dbf, .shx, etc.) are in your working directory
3. Run the script to generate maps