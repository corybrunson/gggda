#' @title Bivariate data peelings
#'
#' @description Use convex hulls (and eventually other peelings) to order
#'   bivariate data.
#' 

#' @details Methods for peeling bivariate data into concentric tiers generalize
#'   the univariate concept of rank to separate core versus peripheral cases
#'   (Green, 1981).
#'
#'   The code for peeling convex hulls was adapted from [aplpack::plothulls()].
#'   Other peeling options should be implemented soon.
#' 

#' @template ref-green1981

#' @importFrom grDevices chull
#' @param x,y Numeric vectors of the same length.
#' @param num A positive integer; the number of hulls to peel. Pass `Inf` for
#'   all hulls.
#' @param by A positive integer; with what frequency to include consecutive
#'   hulls, pairs with `num`.
#' @param breaks A numeric vector of fractions (between `0` and `1`) of the data
#'   to contain in each hull; overridden by `num`.
#' @param cut Character; one of `"above"` and `"below"`, indicating whether each
#'   hull should contain at least or at most `breaks` of the data, respectively.
#' @example inst/examples/ex-peel.r
#' @export
peel_hulls <- function(
    x, y,
    num = NULL, by = 1L,
    breaks = c(.5), cut = c("above", "below")
) {
  
  # behave like `chull()`: assume first two columns are `x` and `y`
  
  # deploy a peeling function
  res <- if (is.null(num)) {
    peel_hulls_at(x, y, breaks = breaks, cut = cut)
  } else {
    peel_hulls_by(x, y, num = num, by = by)
  }
  
  res
}

peel_hulls_by <- function(
    x, y, num = Inf, by = 1L
) {
  
  n <- length(x)
  stopifnot(n == length(y))
  if (num == Inf) num <- n
  
  # ensure that `num` is meaningful
  num <- as.integer(num)
  stopifnot(num > 0L, by > 0L)
  by <- as.integer(by)
  
  # initialize output
  res <- matrix(NA_real_, nrow = 0L, ncol = 5L)
  colnames(res) <- c("x", "y", "i", "hull", "prop")
  
  # obtain sequential hulls
  i_orig <- seq(n)
  for (i in seq(num)) {
    
    # peel hull and remove from point cloud
    i_hull <- chull(x, y)
    x_hull <- x[i_hull]; y_hull <- y[i_hull]; i_peel <- i_orig[i_hull]
    i_orig <- i_orig[-i_hull]; x <- x[-i_hull]; y <- y[-i_hull]
    
    # break if data set has been exhausted
    if (length(i_hull) == 0L) break
    
    if ( by == 1L || (i %% by) == 1L ) {
      # append data
      res <- rbind(res, cbind(x_hull, y_hull, i_peel, i, length(x) / n))
    }
  }
  
  return(res)
}

peel_hulls_at <- function(
    x, y, breaks = c(.5), cut = c("above", "below")
) {
  
  n <- length(x)
  stopifnot(n == length(y))
  breaks <- rev(sort(unique(breaks)))
  cut <- match.arg(cut, c("above", "below"))
  
  # initialize output
  res <- matrix(NA_real_, nrow = 0L, ncol = 6L)
  colnames(res) <- c("x", "y", "i", "hull", "frac", "prop")
  
  i_orig <- seq(n)
  
  # initial convex hull contains all points
  cut_prop <- length(x) / n
  i_hull <- chull(x, y)
  x_hull <- x[i_hull]; y_hull <- y[i_hull]; i_peel <- i_orig[i_hull]
  i_orig <- i_orig[-i_hull]; x <- x[-i_hull]; y <- y[-i_hull]
  h <- 1L
  
  # sequentially obtain proportional hulls
  dupe <- FALSE
  for (i in seq_along(breaks)) {
    
    # peel convex hulls until next one drops below `breaks[i]`
    while (length(x) / n >= breaks[i] && length(x) > 0L) {
      dupe <- FALSE
      cut_prop <- length(x) / n
      i_hull <- chull(x, y)
      x_hull <- x[i_hull]; y_hull <- y[i_hull]; i_peel <- i_orig[i_hull]
      i_orig <- i_orig[-i_hull]; x <- x[-i_hull]; y <- y[-i_hull]
      h <- h + 1L
    }
    # peel last hull to cut below `breaks`
    if (cut_prop > breaks[i] && cut == "below") {
      dupe <- FALSE
      cut_prop <- length(x) / n
      i_hull <- chull(x, y)
      # if (length(i_hull) == 0L && nonempty) break
      x_hull <- x[i_hull]; y_hull <- y[i_hull]
      x <- x[-i_hull]; y <- y[-i_hull]
      h <- h + 1L
    }
    
    # break if data set has been exhausted
    if (length(i_hull) == 0L) break
    
    if (! dupe) {
      # append data
      res <- rbind(res, cbind(x_hull, y_hull, i_peel, h, breaks[i], cut_prop))
    }
    dupe <- TRUE
  }
  
  return(res)
}
