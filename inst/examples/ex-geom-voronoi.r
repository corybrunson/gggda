UScitiesD %>% 
  cmdscale(k = 3) %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column(var = "city") ->
  usa_mds
usa_mds$coastal <- c(rep(FALSE, 4L), rep(TRUE, 6L))
usa_mds %>%
  ggplot(aes(-V1, -V2, label = city)) +
  coord_equal() +
  geom_voronoi(aes(fill = coastal), color = "darkgrey") +
  geom_text(size = 3)
