#' @title Intervals depicting ranges, usually about center points
#' 
#' @description `geom_lineranges()` renders horizontal and vertical intervals
#'   for a specified subject or variable; `geom_pointranges()` additionally
#'   renders a point at their crosshairs.

#' @details The `geom_*ranges()` layers are shortcuts for equivalently-specified
#'   pairs of horizontal and vertical
#'   [`ggplot2::geom_*range()`][ggplot2::geom_linerange] layers. Rather than
#'   [ggplot2::stat_identity()], they default to [stat_center()], so that in
#'   practice the summary values do not need to be manually passed.
#' 

#' @section Aesthetics:

#' `geom_lineranges()` and `geom_pointranges()` understand the following
#' aesthetics (required aesthetics are in bold):

#' - **`x`**
#' - **`xmin`**
#' - **`xmax`**
#' - **`y`**
#' - **`ymin`**
#' - **`ymax`**`
#' - `alpha`
#' - `colour`
#' - `linewidth`
#' - `linetype`
#' - `size`
#' - `group`
#' 

#' @include key-intervals.r
#' @import ggplot2
#' @inheritParams ggplot2::geom_linerange
#' @template param-geom
#' @template return-layer
#' @family geom layers
#' @example inst/examples/ex-geom-intervals.r
#' @export
geom_lineranges <- function(
  mapping = NULL, data = NULL, stat = "center", position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA, inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomLineranges,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname geom_lineranges
#' @export
geom_pointranges <- function(
  mapping = NULL, data = NULL, stat = "center", position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA, inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomPointranges,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomPointranges <- ggproto(
  "GeomPointranges", GeomPointrange,
  
  required_aes = c("x", "xmin", "xmax", "y", "ymin", "ymax"),
  
  draw_key = draw_key_crosspoint,
  
  draw_panel = function(data, panel_params, coord, flatten = 4) {
    pt_data <- data
    pt_data$size = pt_data$size * flatten
    
    grob <- grid::gTree(children = grid::gList(
      GeomLineranges$draw_panel(data, panel_params, coord),
      GeomPoint$draw_panel(pt_data, panel_params, coord)
    ))
    grob$name <- grid::grobName(grob, "geom_pointranges")
    grob
  }
)

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomLineranges <- ggproto(
  "GeomLineranges", GeomLinerange,
  
  required_aes = c("x", "xmin", "xmax", "y", "ymin", "ymax"),
  
  draw_key = draw_key_crosslines,
  
  draw_panel = function(data, panel_params, coord) {
    x_data <- transform(data, x = xmin, xend = xmax, yend = y)
    y_data <- transform(data, xend = x, y = ymin, yend = ymax)
    data <- rbind(x_data, y_data)
    
    grob <- GeomSegment$draw_panel(data, panel_params, coord)
    grob$name <- grid::grobName(grob, "geom_lineranges")
    grob
  }
)
