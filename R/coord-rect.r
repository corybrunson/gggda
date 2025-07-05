#' @title Cartesian coordinates and plotting window with fixed aspect ratios
#'
#' @description Geometric data analysis often requires that coordinates lie on
#'   the same scale. The coordinate system `CoordRect`, alias `CoordSquare`,
#'   provides control of both coordinate and window aspect ratios.
#' 
#' @importFrom scales expand_range censor rescale
#' @inheritParams ggplot2::coord_cartesian
#' @inheritParams ggplot2::coord_fixed
#' @param window_ratio aspect ratio of plotting window
#' @returns A `Coord` [ggproto][gggda-ggproto] object.
#' @example inst/examples/ex-coord-rect.r
#' @export
coord_rect <- function(
    ratio = 1, window_ratio = ratio,
    xlim = NULL, ylim = NULL, expand = TRUE, clip = "on"
) {
  check_coord_limits(xlim)
  check_coord_limits(ylim)
  ggproto(
    NULL, CoordRect,
    limits = list(x = xlim, y = ylim),
    ratio = ratio, window_ratio = window_ratio,
    expand = expand,
    clip = clip
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
    xlim = xlim, ylim = ylim, expand = expand, clip = clip
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
