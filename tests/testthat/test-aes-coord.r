d <- data.frame(
  x1 = runif(n = 6), x2 = runif(n = 6), x3 = runif(n = 6),
  colour = "black", size = 5
)

test_that("`coord_aes()` accepts multidimensional coordinates", {
  expect_no_error(a <- coord_aes(d, prefix = "x"))
  expect_s3_class(a, "uneval", exact = TRUE)
})

test_that("`coord_aes()` warns about non-sequential coordinates", {
  d <- d
  d$x5 <- runif(n = 6)
  rwv_old <- options(rlib_warning_verbosity = "verbose")$rlib_warning_verbosity
  expect_warning(coord_aes(d, prefix = "x"), regexp = "index")
  options(rlib_warning_verbosity = rwv_old)
})

test_that("`aes_c()` aborts when duplicates are passed", {
  expect_error(aes_c(coord_aes(d, prefix = "x"), aes(..coord1 = x)), "multiple")
  expect_error(aes_c(aes(..coord1 = x), coord_aes(d, prefix = "x")), "multiple")
})

test_that("`get_coord_aes()` retrieves `..coord*` columns, else `x,y`", {
  
  # absent `x,y`
  coord_cols <- grep("^x[0-9]+", names(d))
  names(d)[coord_cols] <- paste0("..coord", seq_along(coord_cols))
  expect_equal(get_coord_aes(d), coord_cols)
  
  # present `x,y`
  d$x <- rnorm(n = 6)
  d$y <- rnorm(n = 6)
  expect_equal(get_coord_aes(d), coord_cols)
  
  # absent `..coord*`
  d[coord_cols] <- NULL
  xy_cols <- match(c("x", "y"), names(d))
  expect_equal(get_coord_aes(d), xy_cols)
  
})
