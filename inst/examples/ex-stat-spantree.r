eurodist %>% 
  cmdscale(k = 6) %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column(var = "city") ->
  euro_mds
ggplot(euro_mds, aes(V1, V2, label = city)) +
  stat_spantree() +
  geom_label(alpha = .25)
ggplot(euro_mds, aes_c(aes_coord(euro_mds, "V"), aes(label = city))) +
  stat_spantree() +
  geom_label(aes(x = V1, y = V2), alpha = .25)
