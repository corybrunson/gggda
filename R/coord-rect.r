#' @title Cartesian coordinates and plotting window with fixed aspect ratios
#'
#' @description Geometric data analysis often requires that coordinates lie on
#'   the same scale. The coordinate system `CoordRect`, alias `CoordSquare`,
#'   provides control of both coordinate and window aspect ratios.
#' 
#' @importFrom scales expand_range censor rescale
#' @inheritParams ggplot2::coord_fixed
#' @param window_ratio aspect ratio of plotting window
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
    
    # adapted from `CoordCartesian$setup_panel_params`
    
    expansion_x <- default_expansion(scale_x, expand = self$expand)
    # expansion_x <- default_expansion(scale_x, expand = params$expand[c(4, 2)])
    limits_x <- scale_x$get_limits()
    # continuous_range_x <- ggplot2:::expand_limits_scale(
    continuous_range_x <- expand_limits_scale_continuous(
      scale_x, expansion_x, limits_x, coord_limits = self$limits$x
    )
    aesthetic_x <- scale_x$aesthetics[1]
    
    expansion_y <- default_expansion(scale_y, expand = self$expand)
    # expansion_y <- default_expansion(scale_y, expand = params$expand[c(3, 1)])
    limits_y <- scale_y$get_limits()
    # continuous_range_y <- ggplot2:::expand_limits_scale(
    continuous_range_y <- expand_limits_scale_continuous(
      scale_y, expansion_y, limits_y, coord_limits = self$limits$y
    )
    aesthetic_y <- scale_y$aesthetics[1]
    
    # synchronize limits and ranges according to `window_ratio` after adjusting
    # for `ratio` (if it is provided; it isn't in `ordr::CoordScaffold`)
    adj_ratio <- self$window_ratio / (self$ratio %||% 1)
    limits <- reconcile_rectangle(limits_x, limits_y, adj_ratio)
    continuous_range <- reconcile_rectangle(
      continuous_range_x, continuous_range_y, adj_ratio
    )
    
    view_scales_x <- list(
      # ggplot2:::view_scale_primary(scale_x, limits$x, continuous_range$x),
      view_scale_primary(scale_x, limits$x, continuous_range$x),
      # sec = ggplot2:::view_scale_secondary(scale_x, limits$x, continuous_range$x),
      sec = view_scale_secondary(scale_x, limits$x, continuous_range$x),
      range = continuous_range$x
    )
    names(view_scales_x) <- 
      c(aesthetic_x, paste0(aesthetic_x, ".", names(view_scales_x)[-1]))
    
    view_scales_y <- list(
      # ggplot2:::view_scale_primary(scale_y, limits$y, continuous_range$y),
      view_scale_primary(scale_y, limits$y, continuous_range$y),
      # sec = ggplot2:::view_scale_secondary(scale_y, limits$y, continuous_range$y),
      sec = view_scale_secondary(scale_y, limits$y, continuous_range$y),
      range = continuous_range$y
    )
    names(view_scales_y) <- 
      c(aesthetic_y, paste0(aesthetic_y, ".", names(view_scales_y)[-1]))
    
    c(view_scales_x, view_scales_y)
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

# mimic `ggplot2:::check_coord_limits()`
check_coord_limits <- function(limits) {
  if (is.null(limits)) return(invisible(NULL))
  stopifnot(
    is.vector(limits),
    length(limits) == 2L
  )
}

# mimic `ggplot2:::default_expansion()`
default_expansion <- function(
    scale,
    continuous = expansion(mult = 0.05),
    expand = TRUE
) {
  if (! expand) return(expansion(0, 0))
  forbid_discrete(scale)
  if (! inherits(scale$expand, "waiver"))
    scale$expand
  else
    continuous
}

# mimic `ggplot2:::expand_limits_scale()` for a continuous scale
expand_limits_scale_continuous <- function (
    scale,
    expand = expansion(0, 0),
    limits = waiver(),
    coord_limits = NULL
) {
  limits <- if (! inherits(limits, "waiver"))
    limits
  else
    scale$get_limits()
  
  forbid_discrete(scale)
  
  transformation <- scale$get_transformation()
  coord_limits <- 
    coord_limits %||% transformation$inverse(c(NA_real_, NA_real_))
  coord_limits_scale <- transformation$transform(coord_limits)
  
  # expand_limits_continuous_trans(..., trans = transform_identity())
  limits <- ifelse(is.na(coord_limits_scale), limits, coord_limits_scale)
  if (all(is.finite(limits)) && diff(limits) < 0) {
    limits <- rev(expand_range4(rev(limits), expand))
  } else {
    limits <- expand_range4(limits, expand)
  }
  limits
}

# mimic `ggplot2:::expand_range4()`
expand_range4 <- function(limits, expand) {
  lower <- expand_range(limits, expand[1], expand[2])[1]
  upper <- expand_range(limits, expand[3], expand[4])[2]
  c(lower, upper)
}

# mimic `ggplot2:::view_scale_primary()`
view_scale_primary <- function(
    scale,
    limits = scale$get_limits(),
    continuous_range = scale$dimension(limits = limits)
) {
  forbid_discrete(scale)
  
  continuous_scale_sorted <- sort(continuous_range)
  breaks <- scale$get_breaks(continuous_scale_sorted)
  minor_breaks <- 
    scale$get_breaks_minor(b = breaks, limits = continuous_scale_sorted)
  breaks <- censor(breaks, continuous_scale_sorted, only.finite = FALSE)
  
  minor_breaks <- censor(minor_breaks, continuous_range, only.finite = FALSE)
  ggproto(
    NULL, ViewScaleRect,
    scale = scale,
    guide = scale$guide, 
    position = scale$position,
    aesthetics = scale$aesthetics, 
    name = scale$name,
    scale_is_discrete = scale$is_discrete(), 
    limits = limits,
    continuous_range = continuous_range, 
    breaks = breaks,
    minor_breaks = minor_breaks
  )
}

# mimic `ggplot2:::view_scale_secondary()`
view_scale_secondary <- function(
    scale,
    limits = scale$get_limits(),
    continuous_range = scale$dimension(limits = limits)
) {
  if (is.null(scale$secondary.axis) ||
      inherits(scale$secondary.axis, "waiver") || 
      scale$secondary.axis$empty()) {
    primary_scale <- view_scale_primary(scale, limits, continuous_range)
    scale_flip_position(primary_scale)
    primary_scale$guide <- guide_none()
    primary_scale
  } else {
    scale$secondary.axis$init(scale)
    break_info <- scale$secondary.axis$break_info(continuous_range, scale)
    names(break_info) <- gsub("sec\\.", "", names(break_info))
    position <- switch(
      scale$position,
      top = "bottom",
      bottom = "top",
      left = "right",
      right = "left",
      scale$position
    )
    ggproto(
      NULL, ViewScaleRect,
      scale = scale,
      guide = scale$secondary.axis$guide, 
      position = position,
      break_info = break_info,
      aesthetics = scale$aesthetics, 
      name = scale$sec_name(),
      make_title = function(self, title) self$scale$make_sec_title(title),
      continuous_range = sort(continuous_range), 
      dimension = function(self) self$break_info$range, 
      get_limits = function(self) self$break_info$range, 
      get_breaks = function(self) self$break_info$major_source, 
      get_breaks_minor = function(self) self$break_info$minor_source, 
      break_positions = function(self) self$break_info$major, 
      break_positions_minor = function(self) self$break_info$minor, 
      get_labels = function(self, breaks = self$get_breaks()) {
        self$break_info$labels
      }, 
      rescale = function(x) rescale(x, from = break_info$range, to = c(0, 1))
    )
  }
}

# mimic `ggplot2:::scale_flip_position()`
scale_flip_position <- function (scale) {
  scale$position <- switch(
    scale$position,
    top = "bottom",
    bottom = "top",
    left = "right",
    right = "left",
    scale$position
  )
  invisible()
}

forbid_discrete <- function(scale) {
  if (scale$is_discrete())
    stop("This coordinate system is designed only for continuous scales.")
}
