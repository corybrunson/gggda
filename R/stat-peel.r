#' @title Convex hulls and hull peelings
#'
#' @description Restrict planar data to the boundary points of its convex hull,
#'   or of nested convex hulls containing specified fractions of points.
#'

#' @details As used in a **[ggplot2][ggplot2::ggplot2]** vignette,
#'   `stat_chull()` restricts a dataset with `x` and `y` variables to the points
#'   that lie on its convex hull.
#'
#'   Building on this, `stat_peel()` returns hulls from a _convex hull peeling_:
#'   a subset of sequentially removed hulls containing specified fractions of
#'   the data.
#' 

#' @template ref-barnett1976

#' @template aes-coord

#' @section Computed variables: These are calculated during the statistical
#'   transformation and can be accessed with [delayed
#'   evaluation][ggplot2::aes_eval].
#' \describe{
#'   \item{`hull`}{the position of `breaks` that defines each hull}
#'   \item{`frac`}{the value of `breaks` that defines each hull}
#'   \item{`prop`}{the actual proportion of data within each hull}
#' }

#' @include peel.r
#' @inheritParams ggplot2::layer
#' @inheritParams peel_hulls
#' @template param-layer
#' @template return-layer
#' @family stat layers
#' @example inst/examples/ex-stat-peel.r
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

#' @rdname stat_chull
#' @export
stat_peel <- function(
    mapping = NULL, data = NULL, geom = "polygon", position = "identity",
    num = NULL, by = 1L, breaks = c(.5), cut = c("above", "below"),
    show.legend = NA, 
    inherit.aes = TRUE,
    ...
) {
  layer(
    data = data,
    mapping = mapping,
    stat = StatPeel,
    geom = geom, 
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      num = num,
      by = by,
      breaks = breaks,
      cut = cut,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatPeel <- ggproto(
  "StatPeel", StatChull,
  
  compute_group = function(
    data, scales,
    num = NULL, by = 1L, breaks = c(.5), cut = c("above", "below")
  ) {
    # save(data, scales, num, by, breaks, cut,
    #      file = "stat-peel-compute-group.rda")
    # load(file = "stat-peel-compute-group.rda")
    
    coord_cols <- get_aes_coord(data)
    
    # peel data (matrix output)
    peel_data <- peel_hulls(
      data[, coord_cols[seq(2L)]],
      num = num, by = by, breaks = breaks, cut = cut
    )
    
    # reformat result
    peel_data <- as.data.frame(peel_data)
    names(peel_data)[seq(2L)] <- names(data)[coord_cols[seq(2L)]]
    
    # factorize hull numbers
    hull_levels <- seq(max(c(
      peel_data$hull,
      if ((! is.null(num)) && is.finite(num)) num else NULL
    )))
    peel_data$hull <- factor(peel_data$hull, levels = hull_levels)
    
    # interact existing group with hull
    peel_data$group <- 
      interaction(unique(data$group), peel_data$hull, lex.order = TRUE)
    
    peel_data
  }
)
