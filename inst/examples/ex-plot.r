# note: behavior depends on installed packages with class-specific methods

# class 'prcomp'
iris_pca <- prcomp(iris[, -5L], scale = TRUE)
iris_pca_ord <- as_tbl_ord(iris_pca)
plot(iris_pca)
plot(iris_pca_ord)
screeplot(iris_pca)
screeplot(iris_pca_ord)
biplot(iris_pca)
biplot(iris_pca_ord)

# class 'correspondence'
haireye_ca <- MASS::corresp(rowSums(HairEyeColor, dims = 2L), nf = 2L)
haireye_ca_ord <- as_tbl_ord(haireye_ca)
plot(haireye_ca)
plot(haireye_ca_ord)
screeplot(haireye_ca)
screeplot(haireye_ca_ord)
biplot(haireye_ca)
biplot(haireye_ca_ord)

# class 'lra' (no plotting methods are implemented here)
arrests_lra <- lra(subset(USArrests, select = -UrbanPop))
arrests_lra_ord <- as_tbl_ord(arrests_lra)
plot(arrests_lra_ord)
screeplot(arrests_lra_ord)
biplot(arrests_lra_ord, var.axes = FALSE)
