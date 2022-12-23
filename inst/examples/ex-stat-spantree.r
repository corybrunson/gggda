# classical multidimensional scaling of road distances between European cities
euro_mds <- as.data.frame(cmdscale(eurodist, k = 11))
euro_mds$City <- rownames(euro_mds)

# monoplot with minimal spanning tree based on first two eigenvectors
ggplot(euro_mds, aes(V1, V2)) +
  theme_bw() + coord_equal() +
  stat_spantree(color = "darkgrey") +
  geom_text(aes(label = City))

# monoplot with minimal spanning tree based on full-dimensional distances
ggplot(euro_mds, aes(V1, V2)) +
  theme_bw() + coord_equal() +
  stat_spantree(aes_coord(euro_mds, V1:V11), color = "darkgrey") +
  geom_text(aes(label = City))
