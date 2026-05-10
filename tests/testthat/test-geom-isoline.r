d <- data.frame(x = 3, y = 4)
p <- ggplot(d, aes(x, y))

test_that("default settings yield multiple isolines", {
  p1 <- p + geom_isoline()
  # only one row
  l1 <- layer_data(p1)
  expect_equal(nrow(l1), 1L)
  # several lines
  g1 <- layer_grob(p1)
  expect_true(length(g1[[1L]]$children[[1L]]) > 2)
})

test_that("text is rotated relative to isolines", {
  p1 <- p + geom_isoline(text.size = 3, text.angle = 0)
  p2 <- p + geom_isoline(text.size = 5, text.angle = -20)
  l1 <- layer_data(p1)
  l2 <- layer_data(p2)
  g1 <- layer_grob(p1)[[1L]]
  g2 <- layer_grob(p2)[[1L]]
  # same `angle`
  expect_equivalent(l1, l2)
  # same segments
  expect_equal(g1$children[[1]]$x0, g2$children[[1]]$x0)
  expect_equal(g1$children[[1]]$x1, g2$children[[1]]$x1)
  expect_equal(g1$children[[1]]$y0, g2$children[[1]]$y0)
  expect_equal(g1$children[[1]]$y1, g2$children[[1]]$y1)
  # proportionate text sizes
  expect_equal(
    unique(g1$children[[2]]$gp$fontsize / g2$children[[2]]$gp$fontsize),
    3/5
  )
  # offset text rotations
  expect_equal(unique(g1$children[[2]]$rot - g2$children[[2]]$rot), 20)
})

# TODO: Test that endpoints lie outside plotting window.
