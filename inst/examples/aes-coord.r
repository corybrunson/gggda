us_mds <- as.data.frame(cmdscale(UScitiesD, k = 4))
iris_pca <- as.data.frame(unclass(princomp(iris[, 1:4])$loadings))

# secret names for indexed artificial dimensions
aes_coord(us_mds, prefix = "V")
aes_coord(iris_pca, prefix = "Comp.")

# concatenation is possible so long as duplicates are avoided
aes_c(aes(x = V1), aes(y = V2))
us_mds$city <- attr(UScitiesD, "Label")
ggplot(us_mds,
       aes_c(aes_coord(us_mds, "V"), aes(x = V1, y = V2, label = city))) +
  stat_spantree() +
  geom_label()
# secret coordinates cannot be manipulated directly; pre-process data instead
us_mds[, 1:2] <- -us_mds[, 1:2]
ggplot(us_mds, 
       aes_c(aes_coord(us_mds, "V"), aes(x = V1, y = V2, label = city))) +
  stat_spantree() +
  geom_label()
