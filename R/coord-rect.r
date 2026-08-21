#' @title Cartesian coordinates and plotting window with fixed aspect ratios
#'
#' @description The coordinate system `CoordRect`, alias `CoordSquare`, provides
#'   control of both coordinate and window aspect ratios and synchronizes tick
#'   marks and grid lines between the axes.
#'
#' @details Geometric data analysis often requires that coordinates lie on the
#'   same scale. Plots of geometric data on a unit aspect ratio may benefit from
#'   visual cues to this property, including a fully square plot window and
#'   commensurate axis scales.
#'
#'   The `window_ratio` argument controls the aspect ratio of the plot window
#'   and defaults to `1`. The `sync_breaks` argument controls whether break
#'   positions, which apply to tick marks and grid lines, are synchronized
#'   between the axes. It computes breaks based on the geometric mean of the
#'   axis lengths.
#'
#' @importFrom scales expand_range censor rescale
#' @inheritParams ggplot2::coord_cartesian
#' @inheritParams ggplot2::coord_fixed
#' @param window_ratio Numeric; aspect ratio of plotting window.
#' @param sync_breaks Logical; if `TRUE`, break positions on both axes are
#'   computed from a common step size, resulting in a regular lattice. Defaulted
#'   to when `ratio == 1`.
#' @returns A `Coord` [ggproto][gggda-ggproto] object.
#' @example inst/examples/ex-coord-rect.r
#' @export
coord_rect <- function(
    ratio = 1, window_ratio = ratio,
    xlim = NULL, ylim = NULL,
    expand = TRUE, clip = "on",
    sync_breaks = (ratio == 1)
) {
  check_coord_limits(xlim)
  check_coord_limits(ylim)
  ggproto(
    NULL, CoordRect,
    limits = list(x = xlim, y = ylim),
    ratio = ratio, window_ratio = window_ratio,
    expand = expand,
    clip = clip,
    sync_breaks = sync_breaks
  )
}

#' @rdname coord_rect
#' @usage NULL
#' @export
coord_square <- function(
    xlim = NULL, ylim = NULL, expand = TRUE, clip = "on"
) {
  coord_rect(
    ratio = 1, window_ratio = 1,
    xlim = xlim, ylim = ylim, expand = expand, clip = clip,
    sync_breaks = TRUE
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
CoordRect <- ggproto(
  "CoordRect", CoordFixed,
  
  setup_panel_params = function(self, scale_x, scale_y, params = list()) {
    
    # window ratio adjusted for aspect ratio (if provided)
    adj_ratio <- self$window_ratio / (self$ratio %||% 1)
    
    # rescale limits to desired window ratio
    self$limits <- reconcile_rectangle(
      self$limits$x %||% scale_x$get_limits(),
      self$limits$y %||% scale_y$get_limits(),
      adj_ratio
    )
    
    # train coordinates with fixed aspect ratio
    res <- ggproto_parent(CoordFixed, self)$setup_panel_params(
      scale_x = scale_x, scale_y = scale_y, params = params
    )
    
    # rescale ranges to desired window ratio
    res[c("x.range", "y.range")] <- reconcile_rectangle(
      res$x.range, res$y.range,
      adj_ratio
    )
    
    # synchronize breaks across axes
    if (isTRUE(self$sync_breaks)) {
      if (scale_x$is_discrete() || scale_y$is_discrete()) {
        stop("Synchronized breaks are only available for continuous axes.")
      } else {
        synced <- sync_breaks(
          res$x$continuous_range, res$y$continuous_range
        )
        res$x$breaks <- synced$x
        res$x$minor_breaks <- scale_x$get_breaks_minor(
          b = synced$x, limits = res$x$continuous_range
        )
        res$y$breaks <- synced$y
        res$y$minor_breaks <- scale_y$get_breaks_minor(
          b = synced$y, limits = res$y$continuous_range
        )
      }
    }
    
    # return coordinates
    res
  }
)

reconcile_rectangle <- function(xlim, ylim, ratio) {
  sides <- c(diff(xlim), diff(ylim))
  # by how much to scale each dimension to achieve desired aspect ratio
  sfs <- c(1, ratio) / sides
  sfs <- sfs / min(sfs)
  # new limits
  list(
    x = mean(xlim) + c(-1, 1) * sides[[1]] / 2 * sfs[[1]],
    y = mean(ylim) + c(-1, 1) * sides[[2]] / 2 * sfs[[2]]
  )
}

# mimic `ggplot2:::check_coord_limits()` but without {cli}
check_coord_limits <- function(limits) {
  if (is.null(limits)) return(invisible(NULL))
  stopifnot(
    is.vector(limits),
    length(limits) == 2L
  )
}

# synchronize axis break positions
sync_breaks <- function(limits_x, limits_y, n = 5L) {
  lo <- min(limits_x[1L], limits_y[1L])
  hi <- max(limits_x[2L], limits_y[2L])
  # anchor `n` to geometric mean dimension
  gm <- diff(limits_x) / diff(limits_y)
  if (gm < 1) gm <- 1 / gm
  n <- ceiling(n * sqrt(gm))
  common <- labeling::extended(lo, hi, n)
  step <- abs(diff(common)[1L])
  
  make_breaks <- function(lims) {
    lo_b <- ceiling(lims[1L] / step) * step
    hi_b <- floor(lims[2L] / step) * step
    if (lo_b > hi_b) return(numeric(0L))
    seq(lo_b, hi_b, by = step)
  }
  
  bx <- make_breaks(limits_x)
  by <- make_breaks(limits_y)
  
  # resort to independent breaks if synchronized breaks are too few
  if (length(bx) < 2L) bx <- labeling::extended(limits_x[1L], limits_x[2L], n)
  if (length(by) < 2L) by <- labeling::extended(limits_y[1L], limits_y[2L], n)
  
  list(x = bx, y = by)
}
