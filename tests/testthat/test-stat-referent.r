# disjoint data sets with common columns
df1 <- mtcars[seq(6), c("hp", "wt")]
df2 <- mtcars[seq(7, 10), c("hp", "wt")]

test_that("only inherited data influences plotting window", {
  p1 <- ggplot(df1, aes(x = hp/100, y = wt)) +
    coord_equal() +
    geom_point()
  p1r2 <- ggplot(df1, aes(x = hp/100, y = wt)) +
    coord_equal() +
    stat_referent(referent = df2)
  p12 <- ggplot(rbind(df1, df2), aes(x = hp/100, y = wt)) +
    coord_equal() +
    geom_point()
  
  # different inherited data results in different ranges
  expect_false(isTRUE(all.equal(
    layer_scales(p1)$x$range$range,
    layer_scales(p12)$x$range$range
  )))
  expect_false(isTRUE(all.equal(
    layer_scales(p1)$y$range$range,
    layer_scales(p12)$y$range$range
  )))
  # new referent data results in same ranges
  expect_equal(layer_scales(p1)$x$range$range, layer_scales(p1r2)$x$range$range)
  expect_equal(layer_scales(p1)$y$range$range, layer_scales(p1r2)$y$range$range)
})

test_that("reference data does not affect computation in base layer", {
  expect_equal(
    StatReferent$compute_group(df1) %>% head(n = 2),
    StatReferent$compute_group(df1, referent = df2) %>% head(n = 2)
  )
})

test_that("mapping and referent parameters together yield new plotting data", {
  df2_setup <- StatReferent$setup_params(
    df1,
    list(mapping = aes(x = hp/100, y = wt), referent = df2)
  )$referent
  expect_equal(names(df2_setup), c("x", "y"))
  expect_equal(nrow(df2_setup), 4L)
})

test_that("passing a function to `referent` evaluates it at `data`", {
  p <- ggplot(mtcars, aes(x = hp/100, y = wt)) +
    stat_referent(
      data = head,
      referent = function(d) as.data.frame(lapply(d, mean))
    )
  b <- ggplot_build(p)
  # original data
  expect_identical(b@plot@data, mtcars)
  # head of original data
  expect_equal(nrow(b@data[[1]]), 6L)
  # means of original data
  expect_equal(
    b@plot@layers$stat_referent$stat_params$referent,
    as.data.frame(lapply(mtcars, mean))
  )
  # means of head of original data
  expect_equal(
    lapply(subset(layer_data(p, 1), select = c(x, y)), mean),
    lapply(head(subset(transform(mtcars, x = hp/100, y = wt),
                       select = c(x, y))), mean)
  )
  
})
