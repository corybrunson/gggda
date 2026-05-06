# data set with exactly two convex hulls
set.seed(0)
d <- data.frame(x = runif(12), y = runif(12))

p <- ggplot(d, aes(x, y))

test_that("`stat_peel()` successfully computes expected variables", {
  p_breaks <- p + stat_peel(breaks = seq(0, 1, .1))
  p_by <- p + stat_peel(by = 1/4)
  # no computed `frac` variable
  p_num <- p + stat_peel(num = 3)
  
  d_breaks <- layer_data(p_breaks)
  d_by <- layer_data(p_by)
  d_num <- layer_data(p_num)
  
  # breaks
  expect_true(all(c("hull", "frac", "prop") %in% names(d_breaks)))
  expect_true(inherits(d_breaks$hull, "factor"))
  expect_equal(typeof(d_breaks$frac), "double")
  expect_equal(typeof(d_breaks$prop), "double")
  
  # by
  expect_true(all(c("hull", "frac", "prop") %in% names(d_by)))
  expect_true(inherits(d_by$hull, "factor"))
  expect_equal(typeof(d_by$frac), "double")
  expect_equal(typeof(d_by$prop), "double")
  
  # num
  expect_true(all(c("hull", "prop") %in% names(d_num)))
  expect_true(inherits(d_num$hull, "factor"))
  expect_null(d_num$frac)
  expect_equal(typeof(d_num$prop), "double")
})
