ggplot(USJudgeRatings, aes(x = INTG, y = PREP)) +
  geom_point() +
  stat_chull(alpha = .5)
ggplot(USJudgeRatings, aes(x = INTG, y = PREP)) +
  stat_peel(
    aes(alpha = after_stat(hull)),
    breaks = seq(.1, .9, .2)
  )
ggplot(USJudgeRatings, aes(x = INTG, y = PREP)) +
  stat_peel(
    aes(alpha = after_stat(hull)),
    num = 6, by = 2, color = "black"
  )

# specify fractions of points
# FIXME: These peels should not be empty!
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  stat_peel(fill = "transparent", breaks = .5) +
  geom_point()
# specify number of peels
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  stat_peel(fill = "transparent", num = 3) +
  geom_point()
# mapping to opacity overrides transparency
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  stat_peel(aes(alpha = after_stat(hull)), fill = "transparent", num = 3) +
  geom_point()
