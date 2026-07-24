test_that("`StatDelaunay` returns expected columns with {deldir} engine", {
  skip_if_not_installed("deldir")

  d <- data.frame(x = c(0, 1, 0.5, 0.2, 0.8),
                  y = c(0, 0, 1, 0.5, 0.3))
  l <- layer_data(ggplot(d, aes(x, y)) + stat_delaunay(engine = "deldir"))
  
  expect_all_true(c("x", "y", "xend", "yend", "group") %in% names(l))

  expect_type(l$x, "double")
  expect_type(l$y, "double")
  expect_type(l$xend, "double")
  expect_type(l$yend, "double")

  # edges should connect actual data points
  endpoints <- unique(c(l$x, l$xend, l$y, l$yend))
  expect_true(all(endpoints %in% unlist(d)))
})

test_that("`StatDelaunay` returns expected columns with {geometry} engine", {
  skip_if_not_installed("deldir")
  skip_if_not_installed("geometry")

  d <- data.frame(x = c(0, 1, 0.5, 0.2, 0.8),
                  y = c(0, 0, 1, 0.5, 0.3))
  l <- layer_data(ggplot(d, aes(x, y)) + stat_delaunay(engine = "geometry"))

  expect_all_true(c("x", "y", "xend", "yend", "group") %in% names(l))

  expect_type(l$x, "double")
  expect_type(l$y, "double")
  expect_type(l$xend, "double")
  expect_type(l$yend, "double")
})

set.seed(3314L)
d <- data.frame(x = runif(9), y = runif(9), z = rnorm(9))
dd <- data.frame(x1 = runif(9), x2 = runif(9), x3 = rnorm(9))

test_that("`stat_delaunay()` handles higher-dimensional coordinates", {
  skip_if_not_installed("geometry")

  l <- layer_data(ggplot(dd, aes_coord(dd, "x")) + stat_delaunay())
  expect_all_true(c("x", "y", "xend", "yend", "group") %in% names(l))
  expect_true(nrow(l) > 0L)
})

test_that("`stat_delaunay()` preserves auxiliary aesthetics", {
  p <- ggplot(d, aes(x, y))
  l <- layer_data(p + stat_delaunay(aes(colour = z)))
  expect_true("colour" %in% names(l))
})

test_that("`StatDelaunay` handles degenerate data", {
  skip_if_not_installed("deldir")

  # single point: no edges
  d1 <- data.frame(x = 0.5, y = 0.5)
  l1 <- layer_data(ggplot(d1, aes(x, y)) + stat_delaunay())
  expect_equal(nrow(l1), 0L)

  # two points: one edge
  d2 <- data.frame(x = c(0, 1), y = c(0, 1))
  l2 <- layer_data(ggplot(d2, aes(x, y)) + stat_delaunay())
  expect_equal(nrow(l2), 1L)

  # duplicate points
  d3 <- data.frame(x = c(0.5, 0.5), y = c(0.5, 0.5))
  expect_no_error(layer_data(ggplot(d3, aes(x, y)) + stat_delaunay()))
})
