# Motor Trends base plot with factorized cylinder counts
p <- mtcars %>% 
  transform(name = rownames(mtcars)) %>%
  transform(cyl = factor(cyl)) %>% 
  ggplot(aes(x = wt, y = disp, label = name)) +
  theme_bw()
# basic bagplot
p + geom_bagplot()
# group by cylinder count
p + geom_bagplot(
  fraction = 0.4, coef = 1.2,
  aes(fill = cyl, linetype = cyl, color = cyl)
)
# using normally unmapped aesthetics
p + geom_bagplot(
  fraction = 0.4, coef = 1.2,
  aes(fill = cyl, linetype = cyl, color = cyl),
  median.color = "black",
  fence.linetype = sync(), fence.colour = "black",
  outlier.shape = "asterisk", outlier.colour = "black"
)
# label outliers
p + geom_bagplot(
  fraction = 0.4, coef = 1.2,
  outlier_labels = TRUE,
  aes(fill = cyl, linetype = cyl, color = cyl)
)
