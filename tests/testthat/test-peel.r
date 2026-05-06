
test_that("`peel_hulls()` `prop` agree even while `frac` doesn't", {
  # data set with exactly two convex hulls
  set.seed(0)
  x <- runif(12); y <- runif(12)
  pc1 <- peel_hulls(x, y, breaks = seq(0, 1, .1))
  pc2 <- peel_hulls(x, y, breaks = seq(0, 1, .1), cut = "below")
  
  expect_true(any(pc1[, "frac"] != pc2[, "frac"]))
  expect_equal(pc1[, "prop"], pc2[, "prop"])
})
