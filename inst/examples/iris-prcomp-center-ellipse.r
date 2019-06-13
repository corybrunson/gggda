# Scaled PCA of Anderson iris data with annotated biplot
iris[, -5] %>%
  prcomp(scale = TRUE) %>%
  as_tbl_ord() %>%
  confer_inertia(1) %>%
  mutate_u(species = iris$Species) %>%
  print() -> iris_pca
iris_pca %>%
  ggbiplot(aes(color = species)) +
  theme_bw() +
  scale_color_brewer(type = "qual", palette = 2) +
  geom_u_point(alpha = .5) +
  stat_u_center(fun.center = "mean", size = 3, shape = "triangle") +
  stat_u_ellipse() +
  geom_v_vector(color = "#444444") +
  ggtitle("Row-principal PCA biplot of Anderson iris data")
