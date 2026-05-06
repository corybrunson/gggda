set.seed(158628L)
d <- data.frame(x = rlogis(n = 6), y = rlogis(n = 6))

p <- ggplot(d, aes(x, y))

test_that("`stat_scale()` scales coordinates and does nothing else", {
  p_orig <- p + geom_point()
  d_orig <- layer_data(p_orig)
  
  p_scale <- p + stat_scale(mult = -pi)
  d_scale <- layer_data(p_scale)
  
  expect_setequal(names(d_orig), names(d_scale))
  expect_equivalent(-pi * d_orig[, c("x", "y")], d_scale[, c("x", "y")])
})
