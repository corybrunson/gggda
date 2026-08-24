skip_if_not_installed("deldir")

test_that("`geom_voronoi()` accepts contrived data with required aesthetics", {
  t <- seq(0, 2) * 2/3*pi
  rx <- c(-.1, .1, .1, -.1); ry <- c(-.1, -.1, .1, .1)
  d <- data.frame(
    x = cos(t),
    y = sin(t),
    group = LETTERS[seq(3L)],
    cell = I(list(
      data.frame(x = cos(t[1L]) + rx, y = sin(t[1L]) + ry, border = FALSE),
      data.frame(x = cos(t[2L]) + rx, y = sin(t[2L]) + ry, border = FALSE),
      data.frame(x = cos(t[3L]) + rx, y = sin(t[3L]) + ry, border = FALSE)
    ))
  )
  expect_no_error(
    p <- ggplot(d, aes(x, y, cell = cell, fill = group)) + 
      geom_voronoi(stat = "identity")
  )
})

test_that("`geom_thiessen()` accepts contrived data with required aesthetics", {
  t <- seq(0, 2) * 2/3*pi
  rx <- c(-.1, .1, .1, -.1); ry <- c(-.1, -.1, .1, .1)
  d <- data.frame(
    x = cos(t),
    y = sin(t),
    group = LETTERS[seq(3L)],
    cell = I(list(
      data.frame(x = cos(t[1L]) + rx, y = sin(t[1L]) + ry, border = FALSE),
      data.frame(x = cos(t[2L]) + rx, y = sin(t[2L]) + ry, border = FALSE),
      data.frame(x = cos(t[3L]) + rx, y = sin(t[3L]) + ry, border = FALSE)
    ))
  )
  expect_no_error(
    p <- ggplot(d, aes(x, y, cell = cell, colour = group)) + 
      geom_thiessen(stat = "identity")
  )
})

test_that("full voronoi pipelines render without error", {
  set.seed(3314L)
  d <- data.frame(x = runif(9), y = runif(9))
  p <- ggplot(d, aes(x, y))
  
  expect_no_error(layer_data(p + stat_voronoi() + geom_voronoi()))
  expect_no_error(layer_data(p + stat_voronoi() + geom_thiessen()))
})
