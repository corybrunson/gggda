d <- mtcars[seq(6L), ]
names(d) <- paste0("..coord", seq(ncol(d)))
m <- as.data.frame(cmdscale(dist(d), k = 3L))

test_that("available `StatSpantree` engines produce right-sized trees", {
  n_mst <- (nrow(m) - 1L)
  {
    skip_if_not_installed("mlpack")
    p <- ggplot(m, aes(V1, V2)) +
      stat_spantree(aes_coord(m, V1:V3), engine = "mlpack")
    expect_equal(nrow(layer_data(p)), n_mst)
  }
  {
    skip_if_not_installed("vegan")
    p <- ggplot(m, aes(V1, V2)) +
      stat_spantree(aes_coord(m, V1:V3), engine = "vegan")
    expect_equal(nrow(layer_data(p)), n_mst)
  }
  {
    skip_if_not_installed("ade4")
    p <- ggplot(m, aes(V1, V2)) +
      stat_spantree(aes_coord(m, V1:V3), engine = "ade4")
    expect_equal(nrow(layer_data(p)), n_mst)
  }
})
