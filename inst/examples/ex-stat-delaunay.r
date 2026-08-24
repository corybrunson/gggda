UScitiesD %>%
  cmdscale(k = 6) %>%
  as.data.frame() %>%
  tibble::rownames_to_column(var = "city") ->
  usa_mds
# Delaunay triangulation in the first two MDS dimensions
ggplot(usa_mds, aes(V1, V2, label = city)) +
  coord_equal() +
  stat_delaunay() +
  geom_point()
# intersection of full-dimensional triangulation with the plane
ggplot(usa_mds, aes_c(aes_coord(usa_mds, "V"), aes(label = city))) +
  coord_equal() +
  stat_delaunay() +
  geom_point(aes(V1, V2))
# overlay Delaunay edges and Voronoi cells
ggplot(usa_mds, aes(V1, V2, label = city)) +
  coord_equal() +
  stat_voronoi(fill = "transparent", color = "grey55") +
  stat_delaunay(color = "black", linetype = "dashed") +
  geom_point(aes(V1, V2))
