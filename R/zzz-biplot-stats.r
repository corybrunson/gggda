# ------------------------------------------------------------------------------
# Generated by 'build-pre/build.r': do not edit by hand.
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
#' @template return-layer
#' @family biplot layers
#' @include utils.r
#' @import ggplot2
#' @inheritParams ggplot2::layer
#' @template param-stat
#' @template biplot-ord-aes
#' @inheritParams stat_rows
#' @template param-referent
#' @inheritParams ggplot2::stat_density_2d
#' @inheritParams ggplot2::stat_density_2d_filled
#' @inheritParams ggplot2::stat_ellipse
#' @inheritParams stat_bagplot
#' @inheritParams stat_center
#' @inheritParams stat_star
#' @inheritParams stat_chull
#' @inheritParams stat_peel
#' @inheritParams stat_cone
#' @inheritParams stat_depth
#' @inheritParams stat_depth_filled
#' @inheritParams stat_projection
#' @inheritParams stat_rule
#' @inheritParams stat_scale
#' @inheritParams stat_spantree
#' @example inst/examples/ex-stat-ellipse-iris.r
NULL

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsDensity2d <- ggproto(
  "StatRowsDensity2d", StatDensity2d,
  
  setup_data = setup_rows_xy_data,
  
  compute_group = ord_formals(StatDensity2d, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_density_2d <- function(
  mapping = NULL,
  data = NULL,
  geom = "density_2d",
  position = "identity",
  ...,
  contour = TRUE,
  contour_var = "density",
  n = 100,
  h = NULL,
  adjust = c(1, 1),
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsDensity2d,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      contour = contour,
      contour_var = contour_var,
      n = n,
      h = h,
      adjust = adjust,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsDensity2d <- ggproto(
  "StatColsDensity2d", StatDensity2d,
  
  setup_data = setup_cols_xy_data,
  
  compute_group = ord_formals(StatDensity2d, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_density_2d <- function(
  mapping = NULL,
  data = NULL,
  geom = "density_2d",
  position = "identity",
  ...,
  contour = TRUE,
  contour_var = "density",
  n = 100,
  h = NULL,
  adjust = c(1, 1),
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsDensity2d,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      contour = contour,
      contour_var = contour_var,
      n = n,
      h = h,
      adjust = adjust,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsDensity2dFilled <- ggproto(
  "StatRowsDensity2dFilled", StatDensity2dFilled,
  
  setup_data = setup_rows_xy_data,
  
  compute_group = ord_formals(StatDensity2dFilled, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_density_2d_filled <- function(
  mapping = NULL,
  data = NULL,
  geom = "density_2d_filled",
  position = "identity",
  ...,
  contour = TRUE,
  contour_var = "density",
  n = 100,
  h = NULL,
  adjust = c(1, 1),
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsDensity2dFilled,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      contour = contour,
      contour_var = contour_var,
      n = n,
      h = h,
      adjust = adjust,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsDensity2dFilled <- ggproto(
  "StatColsDensity2dFilled", StatDensity2dFilled,
  
  setup_data = setup_cols_xy_data,
  
  compute_group = ord_formals(StatDensity2dFilled, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_density_2d_filled <- function(
  mapping = NULL,
  data = NULL,
  geom = "density_2d_filled",
  position = "identity",
  ...,
  contour = TRUE,
  contour_var = "density",
  n = 100,
  h = NULL,
  adjust = c(1, 1),
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsDensity2dFilled,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      contour = contour,
      contour_var = contour_var,
      n = n,
      h = h,
      adjust = adjust,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsEllipse <- ggproto(
  "StatRowsEllipse", StatEllipse,
  
  setup_data = setup_rows_xy_data,
  
  compute_group = ord_formals(StatEllipse, "compute_group")
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
  
  setup_data = setup_cols_xy_data,
  
  compute_group = ord_formals(StatEllipse, "compute_group")
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
StatRowsBagplot <- ggproto(
  "StatRowsBagplot", StatBagplot,
  
  setup_data = setup_rows_data,
  
  compute_group = ord_formals(StatBagplot, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_bagplot <- function(
  mapping = NULL,
  data = NULL,
  geom = "bagplot",
  position = "identity",
  fraction = 0.5,
  coef = 3,
  median = TRUE,
  fence = TRUE,
  outliers = TRUE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsBagplot,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      fraction = fraction,
      coef = coef,
      median = median,
      fence = fence,
      outliers = outliers,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsBagplot <- ggproto(
  "StatColsBagplot", StatBagplot,
  
  setup_data = setup_cols_data,
  
  compute_group = ord_formals(StatBagplot, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_bagplot <- function(
  mapping = NULL,
  data = NULL,
  geom = "bagplot",
  position = "identity",
  fraction = 0.5,
  coef = 3,
  median = TRUE,
  fence = TRUE,
  outliers = TRUE,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsBagplot,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      fraction = fraction,
      coef = coef,
      median = median,
      fence = fence,
      outliers = outliers,
      na.rm = FALSE,
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
  
  setup_data = setup_rows_xy_data,
  
  compute_group = ord_formals(StatCenter, "compute_group")
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
  
  setup_data = setup_cols_xy_data,
  
  compute_group = ord_formals(StatCenter, "compute_group")
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
  
  setup_data = setup_rows_xy_data,
  
  compute_group = ord_formals(StatStar, "compute_group")
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
  
  setup_data = setup_cols_xy_data,
  
  compute_group = ord_formals(StatStar, "compute_group")
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
  
  setup_data = setup_rows_data,
  
  compute_group = ord_formals(StatChull, "compute_group")
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
  
  setup_data = setup_cols_data,
  
  compute_group = ord_formals(StatChull, "compute_group")
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
StatRowsPeel <- ggproto(
  "StatRowsPeel", StatPeel,
  
  setup_data = setup_rows_data,
  
  compute_group = ord_formals(StatPeel, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_peel <- function(
  mapping = NULL,
  data = NULL,
  geom = "polygon",
  position = "identity",
  breaks = c(0.5),
  cut = c("above", "below"),
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsPeel,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      breaks = breaks,
      cut = cut,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsPeel <- ggproto(
  "StatColsPeel", StatPeel,
  
  setup_data = setup_cols_data,
  
  compute_group = ord_formals(StatPeel, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_peel <- function(
  mapping = NULL,
  data = NULL,
  geom = "polygon",
  position = "identity",
  breaks = c(0.5),
  cut = c("above", "below"),
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsPeel,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      breaks = breaks,
      cut = cut,
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
  
  setup_data = setup_rows_data,
  
  compute_group = ord_formals(StatCone, "compute_group")
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
  
  setup_data = setup_cols_data,
  
  compute_group = ord_formals(StatCone, "compute_group")
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
StatRowsDepth <- ggproto(
  "StatRowsDepth", StatDepth,
  
  setup_data = setup_rows_data,
  
  compute_group = ord_formals(StatDepth, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_depth <- function(
  mapping = NULL,
  data = NULL,
  geom = "contour",
  position = "identity",
  contour = TRUE,
  contour_var = "depth",
  notion = "halfspace",
  n = 100,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsDepth,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      contour = contour,
      contour_var = contour_var,
      notion = notion,
      n = n,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsDepth <- ggproto(
  "StatColsDepth", StatDepth,
  
  setup_data = setup_cols_data,
  
  compute_group = ord_formals(StatDepth, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_depth <- function(
  mapping = NULL,
  data = NULL,
  geom = "contour",
  position = "identity",
  contour = TRUE,
  contour_var = "depth",
  notion = "halfspace",
  n = 100,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsDepth,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      contour = contour,
      contour_var = contour_var,
      notion = notion,
      n = n,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsDepthFilled <- ggproto(
  "StatRowsDepthFilled", StatDepthFilled,
  
  setup_data = setup_rows_data,
  
  compute_group = ord_formals(StatDepthFilled, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_depth_filled <- function(
  mapping = NULL,
  data = NULL,
  geom = "contour_filled",
  position = "identity",
  contour = TRUE,
  contour_var = "depth",
  notion = "halfspace",
  n = 100,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatRowsDepthFilled,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      contour = contour,
      contour_var = contour_var,
      notion = notion,
      n = n,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsDepthFilled <- ggproto(
  "StatColsDepthFilled", StatDepthFilled,
  
  setup_data = setup_cols_data,
  
  compute_group = ord_formals(StatDepthFilled, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_depth_filled <- function(
  mapping = NULL,
  data = NULL,
  geom = "contour_filled",
  position = "identity",
  contour = TRUE,
  contour_var = "depth",
  notion = "halfspace",
  n = 100,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
) {
  layer(
    mapping = mapping,
    data = data,
    stat = StatColsDepthFilled,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      contour = contour,
      contour_var = contour_var,
      notion = notion,
      n = n,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsProjection <- ggproto(
  "StatRowsProjection", StatProjection,
  
  extra_params = c(StatProjection$extra_params, "ref_subset", "ref_elements"),
  
  setup_params = setup_referent_params,
  
  setup_data = setup_rows_xy_data,
  
  compute_group = ord_formals(StatProjection, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_projection <- function(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  referent = NULL,
  ref_subset = NULL, ref_elements = "active",
  ...,
  show.legend = NA,
  inherit.aes = TRUE
) {
  LayerRef <- layer(
    mapping = mapping,
    data = data,
    stat = StatRowsProjection,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      referent = referent,
      ref_subset = ref_subset,
      ref_elements = ref_elements,
      na.rm = FALSE,
      ...
    )
  )
  class(LayerRef) <- c("LayerRef", class(LayerRef))
  LayerRef
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsProjection <- ggproto(
  "StatColsProjection", StatProjection,
  
  extra_params = c(StatProjection$extra_params, "ref_subset", "ref_elements"),
  
  setup_params = setup_referent_params,
  
  setup_data = setup_cols_xy_data,
  
  compute_group = ord_formals(StatProjection, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_projection <- function(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  referent = NULL,
  ref_subset = NULL, ref_elements = "active",
  ...,
  show.legend = NA,
  inherit.aes = TRUE
) {
  LayerRef <- layer(
    mapping = mapping,
    data = data,
    stat = StatColsProjection,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      referent = referent,
      ref_subset = ref_subset,
      ref_elements = ref_elements,
      na.rm = FALSE,
      ...
    )
  )
  class(LayerRef) <- c("LayerRef", class(LayerRef))
  LayerRef
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsRule <- ggproto(
  "StatRowsRule", StatRule,
  
  extra_params = c(StatRule$extra_params, "ref_subset", "ref_elements"),
  
  setup_params = setup_referent_params,
  
  setup_data = setup_rows_xy_data,
  
  compute_group = ord_formals(StatRule, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_rule <- function(
  mapping = NULL,
  data = NULL,
  geom = "rule",
  position = "identity",
  fun.lower = "minpp",
  fun.upper = "maxpp",
  fun.offset = "minabspp",
  fun.args = list(),
  referent = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  ref_subset = NULL, ref_elements = "active",
  ...
) {
  LayerRef <- layer(
    mapping = mapping,
    data = data,
    stat = StatRowsRule,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      fun.lower = fun.lower,
      fun.upper = fun.upper,
      fun.offset = fun.offset,
      fun.args = fun.args,
      referent = referent,
      ref_subset = ref_subset,
      ref_elements = ref_elements,
      na.rm = FALSE,
      ...
    )
  )
  class(LayerRef) <- c("LayerRef", class(LayerRef))
  LayerRef
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatColsRule <- ggproto(
  "StatColsRule", StatRule,
  
  extra_params = c(StatRule$extra_params, "ref_subset", "ref_elements"),
  
  setup_params = setup_referent_params,
  
  setup_data = setup_cols_xy_data,
  
  compute_group = ord_formals(StatRule, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_rule <- function(
  mapping = NULL,
  data = NULL,
  geom = "rule",
  position = "identity",
  fun.lower = "minpp",
  fun.upper = "maxpp",
  fun.offset = "minabspp",
  fun.args = list(),
  referent = NULL,
  show.legend = NA,
  inherit.aes = TRUE,
  ref_subset = NULL, ref_elements = "active",
  ...
) {
  LayerRef <- layer(
    mapping = mapping,
    data = data,
    stat = StatColsRule,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      fun.lower = fun.lower,
      fun.upper = fun.upper,
      fun.offset = fun.offset,
      fun.args = fun.args,
      referent = referent,
      ref_subset = ref_subset,
      ref_elements = ref_elements,
      na.rm = FALSE,
      ...
    )
  )
  class(LayerRef) <- c("LayerRef", class(LayerRef))
  LayerRef
}

#' @rdname ordr-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatRowsScale <- ggproto(
  "StatRowsScale", StatScale,
  
  setup_data = setup_rows_xy_data,
  
  compute_group = ord_formals(StatScale, "compute_group")
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
  
  setup_data = setup_cols_xy_data,
  
  compute_group = ord_formals(StatScale, "compute_group")
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
  
  setup_data = setup_rows_data,
  
  compute_group = ord_formals(StatSpantree, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_rows_spantree <- function(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  engine = "mlpack",
  method = "euclidean",
  show.legend = NA,
  inherit.aes = TRUE,
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
      engine = engine,
      method = method,
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
  
  setup_data = setup_cols_data,
  
  compute_group = ord_formals(StatSpantree, "compute_group")
)

#' @rdname biplot-stats
#' @export
stat_cols_spantree <- function(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  engine = "mlpack",
  method = "euclidean",
  show.legend = NA,
  inherit.aes = TRUE,
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
      engine = engine,
      method = method,
      na.rm = FALSE,
      ...
    )
  )
}
