# PCA of Anderson's iris measurements
iris_pca <- prcomp(iris[, 1:4])
iris_scores <- cbind(as.data.frame(iris_pca$x), Species = iris$Species)
iris_loadings <- as.data.frame(iris_pca$rotation)

# biplot with arrows
ggplot(iris_scores, aes(x = PC1, y = PC2)) +
  geom_point(alpha = .5, aes(color = Species)) +
  geom_vector(data = iris_loadings)
