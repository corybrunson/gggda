# plot petal measurements of Anderson irises with convex hulls
ggplot(iris, aes(x = Petal.Length, y = Petal.Width,
                 color = Species, fill = Species)) +
  geom_point() +
  scale_color_brewer(type = "qual", aesthetics = c("color", "fill")) +
  stat_chull(alpha = .2)

# US arrests
us_arrests <- USArrests
us_arrests$State <- rownames(USArrests)
us_arrests$Region <- state.region[match(state.name, us_arrests$State)]

# plot US arrest rates with conical hulls
ggplot(us_arrests, aes(x = Murder, y = Assault, color = Region)) +
  geom_point() +
  stat_cone(origin = FALSE)

# plot centered US arrest rates with conical hulls (including origin)
us_arrests2 <- us_arrests
us_arrests2[, c(1,3,4)] <-
  scale(us_arrests2[, c(1,3,4)], center = TRUE, scale = FALSE)
ggplot(us_arrests2, aes(x = Murder, y = Assault, color = Region)) +
  geom_point() +
  stat_cone(origin = TRUE)
