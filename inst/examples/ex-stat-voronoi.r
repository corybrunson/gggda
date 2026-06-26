eurodist %>% 
  cmdscale(k = 6) %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column(var = "city") ->
  euro_mds
# planar regions (note superimposed perimeters)
ggplot(euro_mds, aes(V1, V2, label = city)) +
  coord_equal() +
  stat_voronoi(color = "black", fill = "transparent", linetype = "dashed") +
  geom_point() +
  geom_text(alpha = .5, size = 3)
# intersection of plane with full-dimensional regions, tight bounds
ggplot(euro_mds, aes_c(aes_coord(euro_mds, "V"), aes(label = city))) +
  coord_equal() +
  stat_voronoi(color = "black", buffer = .01) +
  geom_point(aes(V1, V2)) +
  geom_text(aes(V1, V2), alpha = .5, size = 3)
