t <- 2 * pi * seq(0, 1, .125)
d <- data.frame(x = cos(t), y = sin(t), r = format(t, digits = 2L))
p <- ggplot(d, aes(x, y, label = r)) + geom_text_radiate()

test_that("`geom_text_radiate()` horizontally adjusts by abscissa value", {
  expect_true(all(sign(layer_grob(p)[[1]]$hjust) == - sign(layer_data(p)$x)))
})

test_that("`geom_text_radiate()` rotates text within (-pi/2,pi/2]", {
  d_rot <- layer_grob(p)[[1]]$rot
  expect_true(all(d_rot > -90 & d_rot <= 90))
})
