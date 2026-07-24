UScitiesD %>% 
  cmdscale(k = 3) %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column(var = "city") ->
  usa_mds
usa_mds$coastal <- c(rep(FALSE, 4L), rep(TRUE, 6L))
# polygon-based rendering (cell interiors and perimeter paths)
usa_mds %>%
  ggplot(aes(-V1, -V2, label = city)) +
  coord_equal() +
  geom_voronoy(aes(fill = coastal), colour = NA) +
  geom_text(size = 3)
# segment-based rendering (de-duplicated cell boundaries)
usa_mds %>%
  ggplot(aes(-V1, -V2, label = city)) +
  coord_equal() +
  geom_thiessen(aes(colour = coastal)) +
  geom_text(size = 3)
