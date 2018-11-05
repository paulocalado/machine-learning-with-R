library(ggplot2)
library(dplyr)

#ggplot2 layers = Data, Aesthetics, Geometries, Facets, Statistics, Coordinates, Theme

  mtcars %>%   # Data layer
    ggplot() + # Data layer
    aes(x=mpg,y=wt) + # Aesthetics Layer
    geom_point() +  #Geometries Layer
    facet_grid( cyl ~ .)+ #Facets Layer
    stat_smooth() + # Statistics Layer
    coord_cartesian(xlim = c(15,25)) + #Coordinates Layer
    theme_bw()
  