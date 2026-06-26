skip_if_not_installed("deldir")
skip_if_not_installed("geometry")

set.seed(3314L)
d <- data.frame(x = runif(9), y = runif(9), z = rnorm(9))
dd <- data.frame(x1 = runif(9), x2 = runif(9), x3 = rnorm(9))
p <- ggplot(d, aes(x, y))
pp <- ggplot(dd, aes_coord(dd, prefix = "x"))

test_that("`stat_voronoi()` works as expected with {deldir} engine", {
  expect_no_error(layer_data(p + stat_voronoi(engine = "deldir")))
  expect_warning(layer_data(pp + stat_voronoi(engine = "deldir")))
})

test_that("`stat_voronoi()` works as expected with {geometry} engine", {
  expect_no_error(layer_data(p + stat_voronoi(engine = "geometry")))
  expect_no_warning(layer_data(pp + stat_voronoi(engine = "geometry")))
})

test_that("`stat_voronoi()` computes `cell` list-column", {
  l <- layer_data(p + stat_voronoi())
  expect_true("cell" %in% names(l))
  expect_equal(nrow(l), nrow(d))
  expect_type(l$cell, "list")
  expect_is(l$cell[[1L]], "data.frame")
  expect_identical(names(l$cell[[2L]]), c("x", "y", "border"))
})

test_that("`stat_voronoi()` handles higher-dimensional coordinates", {
  l <- layer_data(ggplot(dd, aes_coord(dd, "x")) + stat_voronoi())
  expect_true(length(unique(l$group)) <= 9L)
  expect_true("x" %in% names(l))
  expect_true("y" %in% names(l))
})

test_that("`stat_voronoi()` preserves auxiliary aesthetics", {
  l <- layer_data(p + stat_voronoi(aes(fill = z)))
  expect_true("fill" %in% names(l))
  expect_false(any(is.na(l$fill)))
})

eurodist %>% 
  cmdscale(k = 6) %>% 
  as.data.frame() %>% 
  tibble::rownames_to_column(var = "city") ->
  euro_mds

test_that("`StatVoronoi` handles degenerate data", {
  d1 <- transform(euro_mds[1L, , drop = FALSE], class = "A")
  d2 <- transform(euro_mds[seq(2L), , drop = FALSE], class = c("A", "B"))
  d3 <- transform(euro_mds[c(1L, 1L), , drop = FALSE], class = c("A", "B"))
  p1 <- ggplot(d1, aes(V1, V2, label = city, fill = class))
  p2 <- ggplot(d2, aes(V1, V2, label = city, fill = class))
  p3 <- ggplot(d3, aes(V1, V2, label = city, fill = class))
  
  expect_no_error(p1 + stat_voronoi() + geom_point())
  expect_no_error(p2 + stat_voronoi() + geom_point())
  expect_no_error(p3 + stat_voronoi() + geom_point())
})
