test_that("`stat_chull()` excludes points not on the convex hull", {
  d <- data.frame(x = c(0, 1, 0, .5), y = c(0, 0, 1, .5))
  p <- ggplot(d, aes(x, y)) + stat_chull()
  expect_true(all(c(layer_data(p)$x, layer_data(p)$y) %in% c(0, 1)))
})

d <- data.frame(x = c(1, 1, 0, .25), y = c(0, 1, 1, .25))
p <- ggplot(d, aes(x, y)) + stat_cone()
p0 <- ggplot(d, aes(x, y)) + stat_cone(origin = TRUE)

test_that("`stat_cone()` excludes points not on the conical hull", {
  expect_true(all(c(layer_data(p)$x, layer_data(p)$y) %in% c(0, 1)))
  expect_true(all(c(layer_data(p0)$x, layer_data(p0)$y) %in% c(0, 1)))
})

test_that("`stat_cone()` proceeds from the origin", {
  expect_equal(layer_data(p)$x[[2L]], 1)
  expect_equal(layer_data(p)$y[[2L]], 1)
  expect_equal(layer_data(p0)$x[[1L]], 0)
  expect_equal(layer_data(p0)$y[[1L]], 0)
  expect_equal(layer_data(p0)$x[[3L]], 1)
  expect_equal(layer_data(p0)$y[[3L]], 1)
})
