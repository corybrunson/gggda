# ------------------------------------------------------------------------------
# Generated by 'build/build.r': do not edit by hand.
# ------------------------------------------------------------------------------

#' @title Convenience stats for row and column matrix factors
#' 
#' @description These statistical transformations (stats) adapt
#'   conventional **ggplot2** stats to one or the other matrix factor
#'   of a tbl_ord, in lieu of [stat_rows()] or [stat_cols()]. They
#'   accept the same parameters as their corresponding conventional
#'   stats.
#' 
#' @name biplot-stats
#' @family biplot layers
#' @include utils.r
#' @import ggplot2
#' @inheritParams ggplot2::layer
#' @template param-stat
#' @template biplot-ord-aes
#' @inheritParams stat_rows
#' @inheritParams ggplot2::stat_ellipse
#' @inheritParams stat_center
#' @inheritParams stat_star
#' @inheritParams stat_chull
#' @inheritParams stat_cone
#' @inheritParams stat_scale
#' @inheritParams stat_spantree
#' @example inst/examples/ex-stat-ellipse-iris.r
NULL

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsEllipse <- ggproto(
  "StatRowsEllipse", StatEllipse,
  
  setup_data = setup_rows_xy_data
)

#' @rdname biplot-stats
#' @export
stat_rows_ellipse <- function(
  mapping = NULL,
  data = NULL,
  geom = "path",
  position = "identity",
  ...,
  type = "t",
  level = 0.95,
  segments = 51,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsEllipse,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      type = type,
      level = level,
      segments = segments,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsEllipse <- ggproto(
  "StatColsEllipse", StatEllipse,
  
  setup_data = setup_cols_xy_data
)

#' @rdname biplot-stats
#' @export
stat_cols_ellipse <- function(
  mapping = NULL,
  data = NULL,
  geom = "path",
  position = "identity",
  ...,
  type = "t",
  level = 0.95,
  segments = 51,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsEllipse,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      type = type,
      level = level,
      segments = segments,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsCenter <- ggproto(
  "StatRowsCenter", StatCenter,
  
  setup_data = setup_rows_xy_data
)

#' @rdname biplot-stats
#' @export
stat_rows_center <- function(
  mapping = NULL,
  data = NULL,
  geom = "point",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  fun.data = NULL,
  fun.center = NULL,
  fun.min = NULL,
  fun.max = NULL,
  fun.args = list()
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsCenter,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      fun.data = fun.data,
      fun.center = fun.center,
      fun.min = fun.min,
      fun.max = fun.max,
      fun.args = fun.args,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsCenter <- ggproto(
  "StatColsCenter", StatCenter,
  
  setup_data = setup_cols_xy_data
)

#' @rdname biplot-stats
#' @export
stat_cols_center <- function(
  mapping = NULL,
  data = NULL,
  geom = "point",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  fun.data = NULL,
  fun.center = NULL,
  fun.min = NULL,
  fun.max = NULL,
  fun.args = list()
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsCenter,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      fun.data = fun.data,
      fun.center = fun.center,
      fun.min = fun.min,
      fun.max = fun.max,
      fun.args = fun.args,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsStar <- ggproto(
  "StatRowsStar", StatStar,
  
  setup_data = setup_rows_xy_data
)

#' @rdname biplot-stats
#' @export
stat_rows_star <- function(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  fun.data = NULL,
  fun.center = NULL,
  fun.args = list()
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsStar,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      fun.data = fun.data,
      fun.center = fun.center,
      fun.args = fun.args,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsStar <- ggproto(
  "StatColsStar", StatStar,
  
  setup_data = setup_cols_xy_data
)

#' @rdname biplot-stats
#' @export
stat_cols_star <- function(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  fun.data = NULL,
  fun.center = NULL,
  fun.args = list()
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsStar,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      fun.data = fun.data,
      fun.center = fun.center,
      fun.args = fun.args,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsChull <- ggproto(
  "StatRowsChull", StatChull,
  
  setup_data = setup_rows_data
)

#' @rdname biplot-stats
#' @export
stat_rows_chull <- function(
  mapping = NULL,
  data = NULL,
  geom = "polygon",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsChull,
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

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsChull <- ggproto(
  "StatColsChull", StatChull,
  
  setup_data = setup_cols_data
)

#' @rdname biplot-stats
#' @export
stat_cols_chull <- function(
  mapping = NULL,
  data = NULL,
  geom = "polygon",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsChull,
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

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsCone <- ggproto(
  "StatRowsCone", StatCone,
  
  setup_data = setup_rows_data
)

#' @rdname biplot-stats
#' @export
stat_rows_cone <- function(
  mapping = NULL,
  data = NULL,
  geom = "path",
  position = "identity",
  origin = FALSE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsCone,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      origin = origin,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsCone <- ggproto(
  "StatColsCone", StatCone,
  
  setup_data = setup_cols_data
)

#' @rdname biplot-stats
#' @export
stat_cols_cone <- function(
  mapping = NULL,
  data = NULL,
  geom = "path",
  position = "identity",
  origin = FALSE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsCone,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      origin = origin,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsScale <- ggproto(
  "StatRowsScale", StatScale,
  
  setup_data = setup_rows_xy_data
)

#' @rdname biplot-stats
#' @export
stat_rows_scale <- function(
  mapping = NULL,
  data = NULL,
  geom = "point",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  mult = 1
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsScale,
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

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsScale <- ggproto(
  "StatColsScale", StatScale,
  
  setup_data = setup_cols_xy_data
)

#' @rdname biplot-stats
#' @export
stat_cols_scale <- function(
  mapping = NULL,
  data = NULL,
  geom = "point",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  mult = 1
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsScale,
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

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsSpantree <- ggproto(
  "StatRowsSpantree", StatSpantree,
  
  setup_data = setup_rows_data
)

#' @rdname biplot-stats
#' @export
stat_rows_spantree <- function(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  method = "euclidean",
  show.legend = NA,
  inherit.aes = TRUE,
  check.aes = TRUE,
  check.param = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsSpantree,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      method = method,
      check.aes = check.aes,
      check.param = check.param,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsSpantree <- ggproto(
  "StatColsSpantree", StatSpantree,
  
  setup_data = setup_cols_data
)

#' @rdname biplot-stats
#' @export
stat_cols_spantree <- function(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  method = "euclidean",
  show.legend = NA,
  inherit.aes = TRUE,
  check.aes = TRUE,
  check.param = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsSpantree,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      method = method,
      check.aes = check.aes,
      check.param = check.param,
      na.rm = FALSE,
      ...
    )
  )
}
