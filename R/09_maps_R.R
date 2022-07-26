# ICTP-SFAIR/Serrapilheira
# Traingin Program inQuantitative Biology and Ecology
# Computational Methods
# Maps in R

# Packages ----
library(sf) # works with shapefiles
library(tmap) # visualisation
library(dplyr)
library(rnaturalearth)
library(rnaturalearthhires)
library(raster) # works with rasters files

data(World)

# package tmap has a syntax similar to ggplot. The functions start all with tm_
tm_shape(World) +
  tm_borders()

# Examining an sf object ----

# A simple examination with head(), str() or dplyr::glimpse()
# can tell us the class, dimensions, and other characteristics of object World.

# head(World)
names(World)

class(World)

dplyr::glimpse(World)

# What happens when you execute plot(World)?
# How would you plot only one of the variables?
# What happens when you execute

# plots the columns
plot(World[1])
# same as
plot(World[,1])

# plots the lines
plot(World[1,])
plot(World[23,])

# Ploting one variable as a "rate"
plot(World["pop_est"])
plot(World["well_being"])


# The geometry “column” and geometries as objects ----

# A key difference between data frames and sf objects is the presence of geometry,
# that looks like a column when printing the summary of any sf object

head(World[, 1:4])

# When calling World$geometry, however, we perceive it’s not a single column.
# Actually, geometries are a class in their own, sfc

class(World)
class(World$geometry)

# For practical purposes, the existence of geometries and sf objects
# like data.frames facilitates a lot the manipulation of sf objects,
# including extracting and assigning geometries to existant data frames
# and the possibility to drop the geometries,
# (literally, function sf::st_drop_geometry() and use the data frame)

head(sf::st_coordinates(World)) # retrieve coordinates in matrix form
# x <- sf::st_coordinates(World) # You can assing only the coordinates more usefull for points

# extracting the data as data frame
no_geom <- sf::st_drop_geometry(World)
class(no_geom)

# bounding boxes (the limits)
st_bbox(World)

# Manipulating sf objects ----

names(World)

unique(World$continent)

# using tidyverse to manipulate the data, filtering and ploting

World %>%
  filter(continent == "South America") %>%
  tm_shape() +
  tm_borders()

# You can also create new variables and use them in your maps:

World %>%
  mutate(our_countries = if_else(iso_a3 %in% c("COL","BRA", "MEX","ARG"), "red", "grey")) %>%
  tm_shape() +
  tm_borders() +
  tm_fill(col = "our_countries") +
  tm_add_legend("fill",
                "Our Countries",
                col = "red")

# SHAPEFILE: Loading, ploting, and saving a shapefile from the disk ----

# Getting country polygons from rnaturalearth package
bra <- ne_states(country = "brazil", returnclass = "sf")
plot(bra)

# EXPORTING THE SHAPEFILE

# Criating directory (folder) for the shp
if (!dir.exists("data/shapefiles")) dir.create("data/shapefiles",
                                               recursive = TRUE)
st_write(obj = bra,
         dsn = "data/shapefiles/bra.shp",
         delete_layer = TRUE)


# LOADING THE SHAPEFILE

bra2 <- read_sf("data/shapefiles/bra.shp")
class(bra)
plot(bra2)

# RASTER: Loading, ploting, and saving a raster from the disk ----

if (!dir.exists("data/raster")) dir.create("data/raster",
                                               recursive = TRUE)

# Getting raster from the dataset worldclim
tmax_data <- getData(name = "worldclim",
                     var = "tmax",
                     res = 10,
                     path = "data/raster/")

plot(tmax_data)

# Examining the raster

is(tmax_data) #the data are a raster stack, several rasters piled
extent(tmax_data) # returns the "limits" of the raster
res(tmax_data)# get the resolution of a raster

