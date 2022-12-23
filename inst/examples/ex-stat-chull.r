# plot petal measurements of Anderson irises with convex hulls
ggplot(iris, aes(x = Petal.Length, y = Petal.Width,
                 color = Species, fill = Species)) +
  geom_point() +
  scale_color_brewer(type = "qual", aesthetics = c("color", "fill")) +
  stat_chull(alpha = .2)
