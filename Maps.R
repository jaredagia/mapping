rm(list = ls())
require(pacman)
pacman::p_load(ggplot2,ggmap,readxl,sf,tmap,dplyr,ggspatial,ggtext)

# Load Nigeria Shapefile
nigeria <- st_read("Nigeria_Poly.shp")

# Plot Kano State
kano_nig <- nigeria %>% filter(grepl("Kano",wikimedia)) 

kano <- st_read("NGA_adm2.shp") %>% 
  filter(NAME_1 =="Kano")

kano_study <- kano %>% filter(grepl("Dala|Fagge|Gezawa|Gwale|Kano|Kumbotso|Nassaraw|Tarauni|Ungogo", NAME_2))

 # Calculate centroids for labeling
 nigeria$centroid <- st_centroid(nigeria$geometry)
 kano$centroid <- st_centroid(kano$geometry) 
 kano_study$centroid <- st_centroid(kano_study$geometry) 
 
 # Extract centroid coordinates
 nigeria_coords <- as.data.frame(st_coordinates(nigeria$centroid))
 nigeria_coords$state_name <- nigeria$name  

 kano_coords <- as.data.frame(st_coordinates(kano$centroid))
 kano_coords$NAME_2 <- kano$NAME_2  

 study_coords <- as.data.frame(st_coordinates(kano_study$centroid))
 study_coords$NAME_2 <- kano_study$NAME_2 
 
#Map of Nigeria showing Kano State
plot1 <- ggplot() +
  geom_sf(data = nigeria, fill = "lightyellow", color = "black") +  # Base map
  geom_sf(data = kano_nig, fill = "red", color = "black")+
  geom_text(data = nigeria_coords, aes(X, Y, label = state_name), size = 4, color = "black") + 
  coord_sf(datum = NA) + 
  theme_minimal() +
  theme(
    panel.grid.major = element_line(color = "grey", linetype = "dashed"), # Customize grid lines
    panel.background = element_rect(fill = "lightyellow"),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )  +
  geom_text(aes(x = Inf, y = Inf, label = "Map of Nigeria showing Kano State"),
            hjust = 1.5, vjust = 2.0,
            size = 4, fontface = "bold", color = "black",
            inherit.aes = FALSE)

ggsave("Map_Files/Nigeria.png", plot = plot1, width = 8, height = 6, dpi = 300)

#Map of Kano State showing Kano City
plot2 <- ggplot() +
  geom_sf(data = kano, fill = "lightyellow", color = "black") +  # Base map
  geom_sf(data = kano_study, fill = "red", color = "black") +
  geom_text(data = kano_coords, aes(X, Y, label = NAME_2), size = 3, color = "black") + 
  coord_sf(datum = NA) +  # Use coord_sf to add grid lines
  theme_minimal() +
  theme(
    panel.grid.major = element_line(color = "grey", linetype = "dashed"), # Customize grid lines
    panel.background = element_rect(fill = "lightyellow"),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  ) +
  geom_text(aes(x = Inf, y = Inf, label = "Map of Kano State showing Kano City"),
            hjust = 1.3, vjust = 2.0,
            size = 4, fontface = "bold", color = "black",
            inherit.aes = FALSE)

ggsave("Map_Files/Kano.png", plot = plot2, width = 8, height = 6, dpi = 300)

#Map of study area
plot3 <- ggplot() +
  geom_sf(data = kano_study, fill = "red", color = "black") +  # Base map
  geom_text(data = study_coords, aes(X, Y, label = NAME_2), size = 4, color = "black") + 
  coord_sf(datum = NA) +  # Use coord_sf to add grid lines
  theme_minimal() +
  theme(
    panel.grid.major = element_line(color = "grey", linetype = "dashed"), # Customize grid lines
    panel.background = element_rect(fill = "lightyellow"),
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  ) +
  geom_text(aes(x = Inf, y = Inf, label = "Study Area"),
            hjust = 4.2, vjust = 2.5,
            size = 4, fontface = "bold", color = "black",
            inherit.aes = FALSE)

ggsave("Map_Files/Study_Area.png", plot = plot3, width = 8, height = 6, dpi = 300)

