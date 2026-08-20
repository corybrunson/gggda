eurodist %>% 
  cmdscale(k = 6) %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column(var = "city") ->
  euro_mds
# planar regions (note superimposed perimeters)
ggplot(euro_mds, aes(V1, V2, label = city)) +
  coord_equal() +
  stat_voronoy(color = "black", fill = "transparent", linetype = "dashed") +
  geom_point() +
  geom_text(alpha = .5, size = 3)
# intersection of plane with full-dimensional regions, tight bounds
ggplot(euro_mds, aes_c(aes_coord(euro_mds, "V"), aes(label = city))) +
  coord_equal() +
  stat_voronoy(color = "black", buffer = .01) +
  geom_point(aes(V1, V2)) +
  geom_text(aes(V1, V2), alpha = .5, size = 3)
# facet by a variable
set.seed(0)
euro_mds %>%
  transform(random = LETTERS[sample(3, nrow(euro_mds), replace = TRUE)]) %>%
  ggplot(aes_c(aes_coord(euro_mds, "V"), aes(label = city))) +
  coord_equal() +
  facet_grid(cols = vars(random)) +
  stat_voronoy(color = "black", buffer = .01) +
  geom_point(aes(V1, V2)) +
  geom_text(aes(V1, V2), alpha = .5, size = 3)
# overlay Voronoy tiles and Thiessen segments
set.seed(0)
euro_mds %>%
  transform(random = LETTERS[sample(3, nrow(euro_mds), replace = TRUE)]) %>%
  ggplot(aes_c(aes_coord(euro_mds, "V"), aes(label = city))) +
  coord_equal() +
  stat_voronoy(aes(fill = random), buffer = .01) +
  stat_voronoy(geom = "thiessen", linetype = "dotted", buffer = .03) +
  geom_point(aes(V1, V2)) +
  geom_text(aes(V1, V2), alpha = .5, size = 3)
