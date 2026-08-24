test_that("`StatVoronoi` returns expected columns with {deldir} engine", {
  skip_if_not_installed("deldir")
  
  d <- data.frame(x = c(0, 1, 0.5, 0.2, 0.8),
                  y = c(0, 0, 1, 0.5, 0.3),
                  z = seq_len(5))
  p <- ggplot(d, aes(x, y, alpha = z)) + stat_voronoi(engine = "deldir")
  l <- layer_data(p)
  
  expect_equal(l$x, d$x)
  expect_equal(l$y, d$y)
  
  expect_true("cell" %in% names(l))
  expect_equal(length(l$cell), nrow(d))
  expect_type(l$cell, "list")
  
  for (i in seq_along(l$cell)) {
    cell_df <- l$cell[[i]]
    expect_s3_class(cell_df, "data.frame")
    expect_named(cell_df, c("x", "y", "border"))
    expect_type(cell_df$x, "double")
    expect_type(cell_df$y, "double")
    expect_type(cell_df$border, "logical")
  }
})

test_that("`StatVoronoi` returns expected columns with {geometry} engine", {
  skip_if_not_installed("deldir")
  
  d <- data.frame(x = c(0, 1, 0.5, 0.2, 0.8),
                  y = c(0, 0, 1, 0.5, 0.3),
                  z = seq_len(5))
  p <- ggplot(d, aes(x, y, alpha = z)) + stat_voronoi(engine = "geometry")
  l <- layer_data(p)

  expect_equal(l$x, d$x)
  expect_equal(l$y, d$y)

  expect_true("cell" %in% names(l))
  expect_equal(length(l$cell), nrow(d))
  expect_type(l$cell, "list")

  for (i in seq_along(l$cell)) {
    cell_df <- l$cell[[i]]
    expect_s3_class(cell_df, "data.frame")
    expect_named(cell_df, c("x", "y", "border"))
    expect_type(cell_df$x, "double")
    expect_type(cell_df$y, "double")
    expect_type(cell_df$border, "logical")
  }
})

set.seed(3314L)
d <- data.frame(x = runif(9), y = runif(9), z = rnorm(9))
dd <- data.frame(x1 = runif(9), x2 = runif(9), x3 = rnorm(9), a = seq_len(9))

test_that("`stat_voronoi()` handles higher-dimensional coordinates", {
  p <- ggplot(dd, aes_c(aes_coord(dd, "x"), aes(alpha = a))) + stat_voronoi()
  l <- layer_data(p)
  expect_true(length(unique(l$group)) <= 9L)
  expect_true("x" %in% names(l))
  expect_true("y" %in% names(l))
})

test_that("`stat_voronoi()` preserves auxiliary aesthetics", {
  p <- ggplot(d, aes(x, y)) + stat_voronoi(aes(fill = z))
  l <- layer_data(p)
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
