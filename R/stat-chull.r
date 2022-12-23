#' @title Restrict geometric data to boundary points for its convex hull
#'
#' @description As used in a **[ggplot2][ggplot2::ggplot2]** vignette, this stat
#'   layer restricts a dataset with `x` and `y` variables to the points that lie
#'   on its convex hull.
#'

#' @inheritParams ggplot2::layer
#' @template return-layer
#' @family stat layers
#' @example inst/examples/ex-stat-chull.r
#' @export
stat_chull <- function(
  mapping = NULL, data = NULL, geom = "polygon", position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    data = data,
    mapping = mapping,
    stat = StatChull,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatChull <- ggproto(
  "StatChull", Stat,

  required_aes = c("x", "y"),

  compute_group = function(
    data, scales
  ) {
    coord_cols <- get_aes_coord(data)

    data[chull(data[, coord_cols, drop = FALSE]), , drop = FALSE]
  }
)
