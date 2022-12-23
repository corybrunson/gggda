# plot petal measurements of Anderson irises with medioids
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  stat_center(fun.center = "median", size = 5, shape = 0L) +
  geom_point(alpha = .5) +
  scale_color_brewer(type = "qual")

# plot sepal measurements of Anderson irises with centroids and stars
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  stat_star(alpha = .5, fun.center = "mean") +
  geom_point(alpha = .5) +
  stat_center(fun.center = "mean", size = 4, shape = 1L) +
  scale_color_brewer(type = "qual")
