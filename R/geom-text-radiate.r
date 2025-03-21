#' @title Text radiating outward from the origin
#' 

#' @description `geom_text_radiate()` is adapted from `ggbiplot()` in the
#'   off-CRAN extensions of the same name (Vu, 2014; Telford, 2017; Gegzna,
#'   2018). It renders text at specified positions and angles that radiate out
#'   from the origin. This layer and its associated ggproto are **deprecated**.

#' @section Aesthetics:

#' `geom_text_radiate()` understands the following aesthetics (required
#' aesthetics are in bold):

#' - **`x`**
#' - **`y`**
#' - **`label`**
#' - `alpha`
#' - `angle`
#' - `colour`
#' - `family`
#' - `fontface`
#' - `hjust`
#' - `lineheight`
#' - `size`
#' - `vjust`
#' - `group`
#' 

#' @template ref-ggbiplot

#' @import ggplot2
#' @inheritParams ggplot2::geom_text
#' @template return-layer
#' @family geom layers
#' @export
geom_text_radiate <- function(
    mapping = NULL, data = NULL, stat = "identity", position = "identity",
    ...,
    parse = FALSE,
    check_overlap = FALSE,
    na.rm = FALSE,
    show.legend = NA, inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomTextRadiate,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      parse = parse,
      check_overlap = check_overlap,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomTextRadiate <- ggproto(
  "GeomTextRadiate", GeomText,
  
  required_aes = c("x", "y", "label"),
  non_missing_aes = c("x", "y"),
  
  draw_panel = function(
    data, panel_params, coord,
    parse = FALSE,
    na.rm = FALSE,
    check_overlap = FALSE
  ) {
    rlang::warn(
      "`GeomTextRadiate` is deprecated; use `GeomVector` instead.",
      .frequency = "regularly", .frequency_id = "GeomTextRadiate$draw_panel"
    )
    
    if (is.character(data$hjust)) {
      data$hjust <- compute_just(data$hjust, data$x)
    }
    data$hjust <- 0.5 + (data$hjust - 0.625 - 0.5) * sign(data$x)
    data$angle <- as.numeric(data$angle) + (180 / pi) * atan(data$y / data$x)
    
    lab <- data$label
    if (parse) {
      lab <- parse_safe(as.character(lab))
    }
    
    data <- coord$transform(data, panel_params)
    if (is.character(data$vjust)) {
      data$vjust <- compute_just(data$vjust, data$y)
    }
    if (is.character(data$hjust)) {
      data$hjust <- compute_just(data$hjust, data$x)
    }
    
    grid::textGrob(
      lab,
      data$x, data$y, default.units = "native",
      hjust = data$hjust, vjust = data$vjust,
      rot = data$angle,
      gp = grid::gpar(
        col = alpha(data$colour, data$alpha),
        fontsize = data$size * .pt,
        fontfamily = data$family,
        fontface = data$fontface,
        lineheight = data$lineheight
      ),
      check.overlap = check_overlap
    )
  }
)
