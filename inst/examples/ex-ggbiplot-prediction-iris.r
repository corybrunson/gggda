# PCA of iris data
iris_pca <- ordinate(iris, 1:4, prcomp, scale = TRUE)

# row-principal (interpolative) biplot
iris_pca %>%
  augment_ord() %>%
  ggbiplot() +
  theme_bw() +
  scale_color_brewer(type = "qual", palette = 2) +
  geom_cols_axis(aes(label = .name, center = .center, scale = .scale)) +
  geom_rows_point(aes(color = Species), alpha = .5) +
  ggtitle("Interpolative biplot of Anderson iris measurements")

# row-principal predictive biplot
iris_pca %>%
  augment_ord() %>%
  ggbiplot(axis.type = "predictive") +
  theme_bw() +
  scale_color_brewer(type = "qual", palette = 2) +
  geom_cols_axis(aes(label = .name, center = .center, scale = .scale)) +
  geom_rows_point(aes(color = Species), alpha = .5) +
  ggtitle("Predictive biplot of Anderson iris measurements")
