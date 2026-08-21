phi <- (1 + sqrt(5)) / 2
p <- ggplot(mtcars, aes(mpg, hp/10)) + geom_point()

test_that("window dimensions are in correct proportion", {
  
  # square axes & window
  b <- ggplot_build(p + coord_rect(ratio = 1))
  # expect_equal(
  #   diff(b$layout$panel_params[[1L]]$x$limits),
  #   diff(b$layout$panel_params[[1L]]$y$limits)
  # )
  expect_equal(
    diff(b$layout$panel_params[[1L]]$x.range),
    diff(b$layout$panel_params[[1L]]$y.range)
  )
  
  # golden rectangle axes & window
  b <- ggplot_build(p + coord_rect(ratio = 1 / phi))
  # expect_equal(
  #   diff(b$layout$panel_params[[1L]]$x$limits),
  #   diff(b$layout$panel_params[[1L]]$y$limits)
  # )
  expect_equal(
    diff(b$layout$panel_params[[1L]]$x.range),
    diff(b$layout$panel_params[[1L]]$y.range)
  )
  
  # square axes, golden rectangle window
  b <- ggplot_build(p + coord_rect(window_ratio = 1 / phi))
  # expect_equal(
  #   diff(b$layout$panel_params[[1L]]$y$limits) /
  #     diff(b$layout$panel_params[[1L]]$x$limits),
  #   1 / phi
  # )
  expect_equal(
    diff(b$layout$panel_params[[1L]]$y.range) / 
      diff(b$layout$panel_params[[1L]]$x.range),
    1 / phi
  )
  
  # 2x4 rectangle axes, golden rectangle window
  b <- ggplot_build(p + coord_rect(ratio = 1/2, window_ratio = 1 / phi))
  # expect_equal(
  #   diff(b$layout$panel_params[[1L]]$y$limits) /
  #     diff(b$layout$panel_params[[1L]]$x$limits),
  #   2 / phi
  # )
  expect_equal(
    diff(b$layout$panel_params[[1L]]$y.range) / 
      diff(b$layout$panel_params[[1L]]$x.range),
    2 / phi
  )
  
})

test_that("default to synchronize breaks iff ratio = 1", {
  
  coord1 <- coord_rect()
  expect_true(coord1$sync_breaks)
  
  coord2 <- coord_rect(ratio = 1 / phi)
  expect_false(coord2$sync_breaks)
})

test_that("synchronized breaks produce equal step sizes on both axes", {
  
  b <- ggplot_build(p + coord_rect(ratio = 1, window_ratio = 2))
  pp <- b$layout$panel_params[[1L]]
  x_step <- unique(diff(pp$x$breaks))
  y_step <- unique(diff(pp$y$breaks))
  expect_equal(x_step, y_step)
})

test_that("synchronized minor breaks inherit the common step", {
  
  b <- ggplot_build(p + coord_rect(ratio = 1))
  pp <- b$layout$panel_params[[1L]]
  
  x_minor_step <- unique(diff(pp$x$minor_breaks))
  y_minor_step <- unique(diff(pp$y$minor_breaks))
  expect_equal(x_minor_step, y_minor_step)
})
