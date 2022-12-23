# PCA of Anderson's iris measurements
iris_pca <- princomp(iris[, 1:4])
iris_scores <- cbind(as.data.frame(iris_pca$scores), Species = iris$Species)
iris_loadings <- cbind(as.data.frame(unclass(iris_pca$loadings)),
                       Measurement = dimnames(iris_pca$loadings)[[1]])

# biplot with labeled arrows
ggplot(iris_loadings, aes(x = Comp.1, y = Comp.2)) +
  geom_vector() +
  geom_text_radiate(aes(label = Measurement)) +
  geom_point(data = iris_scores, alpha = .5, aes(color = Species))
