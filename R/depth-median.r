#' @title Depth median
#'
#' @description Compute the depth median of a data set.
#'
#' @details This function is called internally by [stat_bagplot()] and can be
#'   passed to [stat_center()] but is also exported directly for data analysis.
#'
#' @param x Matrix of data whose depth median is to be calculated; see
#'   [ddalpha::depth.()].
#' @inheritParams ddalpha::depth.
#' @returns A one-row matrix of depth median coordinates.
#' @example inst/examples/ex-depth-median.r
#' @export
depth_median <- function(x, notion = "zonoid", ...) {
  x <- as.matrix(x)
  d <- ddalpha::depth.(x, x, notion = notion)
  i <- which(d == max(d))
  apply(x[i, , drop = FALSE], 2L, mean, na.rm = FALSE, simplify = TRUE)
}
