# ===============================================
# Task 7b
# Name: Fadhil Nadhif Muharam
# Date: October 30th, 2023
# ===============================================

# Initialization
rm(list = ls())

library(terra)
library(tidyterra)
library(ggplot2)
library(sp)
library(sf)

# Folder paths 

setwd("/Users/nadhif/Library/CloudStorage/OneDrive-HandelshögskolaniStockholm/PhD/Fall 2023/Applied Empirical Economics/Problem Set/Fadhil Nadhif Muharam/Task7b")

assign("indir", "Raw/Data", envir = .GlobalEnv)
assign("outdir", "Analysis/Output", envir = .GlobalEnv)

# Exercise 1: Load Municipalities Data

k1 <- file.path(indir, "KommunRT90/Kommun_RT90_region.shp")

kommuns <- st_read(k1)

# This gets the type
class(kommuns)

# This gets the CRS
crs_kommuns <- st_crs(kommuns)
crs_kommuns

# Plotting
plot(kommuns)

plot_filepath <- file.path(outdir, "kommuns.png")


# Exercise 2: Overlaying the railway data

r1 <- file.path(indir, "jl_riks/jl_riks.shp")

rail <- st_read(r1)

# This gets the type
class(rail)

# This gets the CRS
crs_rail <- st_crs(rail)
crs_rail

# Plotting
plot(rail)

# Reprojecting the railway data

rail_reprojected <- st_transform(rail, crs = crs_kommuns)

# Overlaying data

plot(kommuns, col = "grey")
plot(rail_reprojected, add = TRUE, col = "maroon" )

plot_filepath <- file.path(outdir, "railway.png")
