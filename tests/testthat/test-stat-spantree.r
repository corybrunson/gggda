k <- 6L
m <- UScitiesD %>% cmdscale(k = k) %>% as.data.frame()
m$city <- rownames(m)
# independent aesthetics
p <- ggplot(m) + geom_text(aes(x = V1, y = V2, label = city))
# simultaneous aesthetics
q <- ggplot(m, aes(x = V1, y = V2, label = city)) + geom_text()

test_that("`StatSpantree` can process artificial coordinates", {
  # NB: Use `ade4::mstree()` for simplicity; it depends on no other packages.
  skip_if_not_installed("ade4")
  
  # produce low-dimensional plot (independent aesthetics)
  p1 <- p + stat_spantree(aes_coord(m, "V"), engine = "ade4")
  d1.1 <- layer_data(p1, 1)
  d1.2 <- layer_data(p1, 2)
  expect_setequal(d1.1$x, c(d1.2$x, d1.2$xend))
  expect_setequal(d1.1$y, c(d1.2$y, d1.2$yend))
  
  # produce low-dimensional plot (simultaneous aesthetics)
  q1 <- q + stat_spantree(aes_coord(m, "V"), engine = "ade4")
  e1.1 <- layer_data(q1, 1)
  e1.2 <- layer_data(q1, 2)
  expect_setequal(e1.1$x, c(e1.2$x, e1.2$xend))
  expect_setequal(e1.1$y, c(e1.2$y, e1.2$yend))
  
})

n_mst <- nrow(m) - 1L
test_that("{mlpack} engine works with `StatSpantree`", {
  skip_if_not_installed("mlpack")
  p <- ggplot(m, aes(V1, V2)) + stat_spantree(engine = "mlpack")
  expect_equal(nrow(layer_data(p)), n_mst)
})
test_that("{vegan} engine works with `StatSpantree`", {
  skip_if_not_installed("vegan")
  p <- ggplot(m, aes(V1, V2)) + stat_spantree(engine = "vegan")
  expect_equal(nrow(layer_data(p)), n_mst)
})
test_that("{ade4} engine works with `StatSpantree`", {
  skip_if_not_installed("ade4")
  p <- ggplot(m, aes(V1, V2)) + stat_spantree(engine = "ade4")
  expect_equal(nrow(layer_data(p)), n_mst)
})
