#' @title Restrict points to the boundary of their convex or conical hull
#'
#' @description As used in a **[ggplot2][ggplot2::ggplot2]** vignette,
#'   `stat_chull()` restricts a dataset with `x` and `y` variables to the points
#'   that bound its convex hull. `stat_cone()` restricts a dataset with `x` and
#'   `y` variables to the points that bound its conical hull, optionally
#'   including the origin.
#'

#' @inheritParams ggplot2::layer
#' @param origin Logical; whether to include the origin with the conical hull.
#'   Defaults to `FALSE`.
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
  default_aes = aes(alpha = .25),

  compute_group = function(
    data, scales
  ) {
    coord_cols <- get_aes_coord(data)

    data[chull(data[, coord_cols, drop = FALSE]), , drop = FALSE]
  }
)

#' @rdname stat_chull
#' @export
stat_cone <- function(
    mapping = NULL, data = NULL, geom = "polygon", position = "identity",
    origin = FALSE,
    show.legend = NA,
    inherit.aes = TRUE,
    ...
) {
  layer(
    data = data,
    mapping = mapping,
    stat = StatCone,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = FALSE,
      origin = origin,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatCone <- ggproto(
  "StatCone", StatChull,

  compute_group = function(
    data, scales,
    origin = FALSE
  ) {
    coord_cols <- get_aes_coord(data)

    # if the data set contains the origin, then the convex hull suffices
    if (any(apply(as.matrix(data[, coord_cols, drop = FALSE]) == 0, 1L, all))) {
      return(data[chull(data$x, data$y), , drop = FALSE])
    }

    # append the origin to the data set for the convex hull calculation
    hull_data <- rbind(data[, coord_cols, drop = FALSE],
                       rep(0, length(coord_cols)))
    hull <- chull(hull_data)
    # if the new origin is not in the convex hull, then the convex hull suffices
    orig <- match(nrow(data) + 1L, hull)
    if (is.na(orig)) return(data[hull, , drop = FALSE])

    # cycle the rows of the hull until the origin is first
    hull <- c(hull[seq(orig, length(hull))], hull[seq(0L, orig - 1L)[-1L]])
    # if origin is to be omitted, return the convex hull from the data
    if (! origin) return(data[hull[-1L], , drop = FALSE])

    # reduce additional columns: unique or bust
    data_only <- as.data.frame(lapply(subset(data, select = -coord_cols), only))
    # bind additional columns to origin
    data_orig <- hull_data[nrow(hull_data), , drop = FALSE]
    if (ncol(data_only) > 0) data_orig <- merge(data_orig, data_only)
    # append the origin data to the input data
    data <- rbind(data, data_orig)
    # return the convex hull
    data[hull, , drop = FALSE]
  }
)

# single unique value, or else NA
only <- function(x) {
  uniq <- unique(x)
  if (length(uniq) == 1L) {
    uniq
  } else {
    switch(
      class(x),
      integer = NA_integer_,
      numeric = NA_real_,
      character = NA_character_,
      factor = factor(NA_character_, levels = levels(x))
    )
  }
}
