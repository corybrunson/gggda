test_that("`stat_center()` computes correct named group centers", {
  m <- aggregate(iris[, c("Petal.Length", "Petal.Width")],
                 iris[, "Species", drop = FALSE],
                 "median")
  p <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width, group = Species)) +
    stat_center(fun.center = "median")
  expect_true(all(layer_data(p)$x == m$Petal.Length))
  expect_true(all(layer_data(p)$y == m$Petal.Width))
})

test_that("`stat_center()` computes correct custom group centers", {
  most <- function(x) {
    x[which(factor(x) == names(which.max(table(factor(x)))))[1]]
  }
  m <- aggregate(iris[, c("Petal.Length", "Petal.Width")],
                 iris[, "Species", drop = FALSE],
                 most)
  p <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width, group = Species)) +
    stat_center(fun.center = most)
  expect_true(all(layer_data(p)$x == m$Petal.Length))
  expect_true(all(layer_data(p)$y == m$Petal.Width))
})

test_that("`stat_star()` computes stars", {
  m <- aggregate(iris[, c("Petal.Length", "Petal.Width")],
                 iris[, "Species", drop = FALSE],
                 "mean")
  p <- ggplot(iris, aes(x = Petal.Length, y = Petal.Width, group = Species)) +
    stat_star(fun.center = mean)
  l <- aggregate(layer_data(p)[, c("x", "y")],
                 layer_data(p)[, "group", drop = FALSE],
                 unique)
  expect_true(all(m$Petal.Length == l$x))
  expect_true(all(m$Petal.Width == l$y))
})
