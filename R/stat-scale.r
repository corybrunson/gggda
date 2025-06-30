#' @title Multiply artificial coordinates by a scale factor
#'
#' @description This is a simple stat that applies a constant scale factor to
#'   both positional coordinates. It can be handy in tandem with secondary axes.
#' 

#' @template aes-coord

#' @inheritParams ggplot2::layer
#' @param mult Numeric value used to scale the coordinates.
#' @template param-layer
#' @template return-layer
#' @family stat layers
#' @export
stat_scale <- function(
  mapping = NULL, data = NULL, geom = "point", position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  mult = 1
) {
  layer(
    data = data,
    mapping = mapping,
    stat = StatScale,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      mult = mult,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatScale <- ggproto(
  "StatScale", Stat,
  
  required_aes = c("x", "y"),
  
  compute_group = function(data, scales, mult = 1) {
    # rlang::warn(
    #   "`StatScale` is deprecated and will be removed next release.",
    #   .frequency = "regularly", .frequency_id = "StatScale$compute_group"
    # )
    data[, c("x", "y")] <- data[, c("x", "y")] * mult
    data
  }
)
