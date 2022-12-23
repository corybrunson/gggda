# sample from three circles centered at the origin
t1 <- runif(n = 24)
d1 <- data.frame(x = .5 * cos(2*pi*t1), y = .5 * sin(2*pi*t1))
t2 <- runif(n = 24)
d2 <- data.frame(x = cos(2*pi*t2), y = sin(2*pi*t2))
t3 <- runif(n = 24)
d3 <- data.frame(x = 2 * cos(2*pi*t3), y = 2 * sin(2*pi*t3))

# plot all samples
# (`data` is required for origin and unit circle geoms)
ggplot(data.frame(x = 0, y = 0)) +
  coord_equal() +
  geom_origin() +
  geom_unit_circle() +
  geom_point(aes(x, y), data = d1, shape = 15L) +
  geom_point(aes(x, y), data = d2, shape = 16L) +
  geom_point(aes(x, y), data = d3, shape = 17L)

# combine samples and facet plot
d <- rbind(
  transform(d1, radius = .5),
  transform(d2, radius = 1),
  transform(d3, radius = 2)
)
ggplot(d, aes(x, y, color = factor(radius))) +
  facet_wrap(vars(radius)) +
  coord_equal() +
  geom_origin(color = "black") +
  geom_unit_circle() +
  geom_point()
