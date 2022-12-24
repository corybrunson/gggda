t <- 2 * pi * seq(0, 1, .125)
d <- data.frame(x = cos(t), y = sin(t), r = format(t, digits = 2L))
p <- ggplot(d, aes(x, y)) + geom_vector()

test_that("`geom_vector()` starts all vectors at the origin", {
  expect_true(all(layer_data(p)$xend == 0))
  expect_true(all(layer_data(p)$yend == 0))
})

test_that("`geom_vector()` provides an arrow", {
  expect_equal(class(layer_grob(p)[[1]]$arrow), "arrow")
})
