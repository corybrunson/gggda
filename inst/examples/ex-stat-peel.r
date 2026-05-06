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
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  stat_peel(aes(fill = Species, alpha = after_stat(frac)),
            breaks = seq(.1, .9, .2)) +
  scale_alpha_continuous(trans = scales::reverse_trans()) +
  geom_point()
# specify number of peels
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  stat_peel(fill = "transparent", num = 3) +
  geom_point()
# mapping to opacity overrides transparency
ggplot(iris, aes(Sepal.Width, Sepal.Length, color = Species)) +
  stat_peel(aes(alpha = after_stat(hull)), fill = "transparent", num = 3) +
  geom_point()
