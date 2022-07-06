# ------------------------------------------------------------------------------
# Generated by 'build/build.r': do not edit by hand.
# ------------------------------------------------------------------------------

#' @title Convenience geoms for row and column matrix factors
#' 
#' @description These geometric element layers (geoms) pair
#'   conventional **ggplot2** geoms with [stat_rows()] or
#'   [stat_cols()] in order to render elements for one or the other
#'   matrix factor of a tbl_ord. They understand the same aesthetics
#'   as their corresponding conventional geoms.
#' 
#' @name biplot-geoms
#' @family biplot layers
#' @include utils.r
#' @import ggplot2
#' @importFrom ggrepel
#'   GeomTextRepel
#'   GeomLabelRepel
#'   geom_text_repel
#'   geom_label_repel
#' @inheritParams ggplot2::layer
#' @template param-geom
#' @inheritParams ggplot2::geom_point
#' @inheritParams ggplot2::geom_path
#' @inheritParams ggplot2::geom_polygon
#' @inheritParams ggplot2::geom_text
#' @inheritParams ggplot2::geom_label
#' @inheritParams ggrepel::geom_text_repel
#' @inheritParams ggrepel::geom_label_repel
#' @inheritParams geom_axis
#' @inheritParams geom_lineranges
#' @inheritParams geom_pointranges
#' @inheritParams geom_isoline
#' @inheritParams geom_text_radiate
#' @inheritParams geom_vector
NULL

#' @export
ggrepel::geom_text_repel
#' @export
ggrepel::geom_label_repel

compute_just <- getFromNamespace("compute_just", "ggplot2")
to_unit <- getFromNamespace("to_unit", "ggrepel")

#' @rdname biplot-geoms
#' @export
geom_rows_point <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomPoint,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_point <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomPoint,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_rows_path <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  lineend = "butt",
  linejoin = "round",
  linemitre = 10,
  arrow = NULL,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomPath,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      lineend = lineend,
      linejoin = linejoin,
      linemitre = linemitre,
      arrow = arrow,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_path <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  lineend = "butt",
  linejoin = "round",
  linemitre = 10,
  arrow = NULL,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomPath,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      lineend = lineend,
      linejoin = linejoin,
      linemitre = linemitre,
      arrow = arrow,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_rows_polygon <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  rule = "evenodd",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomPolygon,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      rule = rule,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_polygon <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  rule = "evenodd",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomPolygon,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      rule = rule,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_rows_text <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  parse = FALSE,
  nudge_x = 0,
  nudge_y = 0,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  if (! missing(nudge_x) || ! missing(nudge_y)) {
    if (! missing(position)) {
      stop("Specify either `position` or `nudge_x`/`nudge_y`", call. = FALSE)
    }
    position <- position_nudge(nudge_x, nudge_y)
  }

  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomText,
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

#' @rdname biplot-geoms
#' @export
geom_cols_text <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  parse = FALSE,
  nudge_x = 0,
  nudge_y = 0,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  if (! missing(nudge_x) || ! missing(nudge_y)) {
    if (! missing(position)) {
      stop("Specify either `position` or `nudge_x`/`nudge_y`", call. = FALSE)
    }
    position <- position_nudge(nudge_x, nudge_y)
  }

  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomText,
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

#' @rdname biplot-geoms
#' @export
geom_rows_label <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  parse = FALSE,
  nudge_x = 0,
  nudge_y = 0,
  label.padding = unit(0.25, "lines"),
  label.r = unit(0.15, "lines"),
  label.size = 0.25,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  if (! missing(nudge_x) || ! missing(nudge_y)) {
    if (! missing(position)) {
      stop("Specify either `position` or `nudge_x`/`nudge_y`", call. = FALSE)
    }
    position <- position_nudge(nudge_x, nudge_y)
  }

  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomLabel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      parse = parse,
      label.padding = label.padding,
      label.r = label.r,
      label.size = label.size,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_label <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  parse = FALSE,
  nudge_x = 0,
  nudge_y = 0,
  label.padding = unit(0.25, "lines"),
  label.r = unit(0.15, "lines"),
  label.size = 0.25,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  if (! missing(nudge_x) || ! missing(nudge_y)) {
    if (! missing(position)) {
      stop("Specify either `position` or `nudge_x`/`nudge_y`", call. = FALSE)
    }
    position <- position_nudge(nudge_x, nudge_y)
  }

  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomLabel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      parse = parse,
      label.padding = label.padding,
      label.r = label.r,
      label.size = label.size,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_rows_text_repel <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  parse = FALSE,
  ...,
  box.padding = 0.25,
  point.padding = 1e-06,
  min.segment.length = 0.5,
  arrow = NULL,
  force = 1,
  force_pull = 1,
  max.time = 0.5,
  max.iter = 10000,
  max.overlaps = getOption("ggrepel.max.overlaps", default = 10),
  nudge_x = 0,
  nudge_y = 0,
  xlim = c(NA, NA),
  ylim = c(NA, NA),
  na.rm = FALSE,
  show.legend = NA,
  direction = c("both", "y", "x"),
  seed = NA,
  verbose = FALSE,
  inherit.aes = TRUE
) {
  if (! missing(nudge_x) || ! missing(nudge_y)) {
    if (! missing(position)) {
      stop("Specify either `position` or `nudge_x`/`nudge_y`", call. = FALSE)
    }
    position <- position_nudge(nudge_x, nudge_y)
  }

  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomTextRepel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      parse = parse,
      box.padding = to_unit(box.padding),
      point.padding = to_unit(point.padding),
      min.segment.length = to_unit(min.segment.length),
      arrow = arrow,
      force = force,
      force_pull = force_pull,
      max.time = max.time,
      max.iter = max.iter,
      max.overlaps = max.overlaps,
      xlim = xlim,
      ylim = ylim,
      na.rm = na.rm,
      direction = match.arg(direction),
      seed = seed,
      verbose = verbose,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_text_repel <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  parse = FALSE,
  ...,
  box.padding = 0.25,
  point.padding = 1e-06,
  min.segment.length = 0.5,
  arrow = NULL,
  force = 1,
  force_pull = 1,
  max.time = 0.5,
  max.iter = 10000,
  max.overlaps = getOption("ggrepel.max.overlaps", default = 10),
  nudge_x = 0,
  nudge_y = 0,
  xlim = c(NA, NA),
  ylim = c(NA, NA),
  na.rm = FALSE,
  show.legend = NA,
  direction = c("both", "y", "x"),
  seed = NA,
  verbose = FALSE,
  inherit.aes = TRUE
) {
  if (! missing(nudge_x) || ! missing(nudge_y)) {
    if (! missing(position)) {
      stop("Specify either `position` or `nudge_x`/`nudge_y`", call. = FALSE)
    }
    position <- position_nudge(nudge_x, nudge_y)
  }

  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomTextRepel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      parse = parse,
      box.padding = to_unit(box.padding),
      point.padding = to_unit(point.padding),
      min.segment.length = to_unit(min.segment.length),
      arrow = arrow,
      force = force,
      force_pull = force_pull,
      max.time = max.time,
      max.iter = max.iter,
      max.overlaps = max.overlaps,
      xlim = xlim,
      ylim = ylim,
      na.rm = na.rm,
      direction = match.arg(direction),
      seed = seed,
      verbose = verbose,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_rows_label_repel <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  parse = FALSE,
  ...,
  box.padding = 0.25,
  label.padding = 0.25,
  point.padding = 1e-06,
  label.r = 0.15,
  label.size = 0.25,
  min.segment.length = 0.5,
  arrow = NULL,
  force = 1,
  force_pull = 1,
  max.time = 0.5,
  max.iter = 10000,
  max.overlaps = getOption("ggrepel.max.overlaps", default = 10),
  nudge_x = 0,
  nudge_y = 0,
  xlim = c(NA, NA),
  ylim = c(NA, NA),
  na.rm = FALSE,
  show.legend = NA,
  direction = c("both", "y", "x"),
  seed = NA,
  verbose = FALSE,
  inherit.aes = TRUE
) {
  if (! missing(nudge_x) || ! missing(nudge_y)) {
    if (! missing(position)) {
      stop("Specify either `position` or `nudge_x`/`nudge_y`", call. = FALSE)
    }
    position <- position_nudge(nudge_x, nudge_y)
  }

  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomLabelRepel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      parse = parse,
      box.padding = to_unit(box.padding),
      label.padding = label.padding,
      point.padding = to_unit(point.padding),
      label.r = label.r,
      label.size = label.size,
      min.segment.length = to_unit(min.segment.length),
      arrow = arrow,
      force = force,
      force_pull = force_pull,
      max.time = max.time,
      max.iter = max.iter,
      max.overlaps = max.overlaps,
      xlim = xlim,
      ylim = ylim,
      na.rm = na.rm,
      direction = match.arg(direction),
      seed = seed,
      verbose = verbose,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_label_repel <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  parse = FALSE,
  ...,
  box.padding = 0.25,
  label.padding = 0.25,
  point.padding = 1e-06,
  label.r = 0.15,
  label.size = 0.25,
  min.segment.length = 0.5,
  arrow = NULL,
  force = 1,
  force_pull = 1,
  max.time = 0.5,
  max.iter = 10000,
  max.overlaps = getOption("ggrepel.max.overlaps", default = 10),
  nudge_x = 0,
  nudge_y = 0,
  xlim = c(NA, NA),
  ylim = c(NA, NA),
  na.rm = FALSE,
  show.legend = NA,
  direction = c("both", "y", "x"),
  seed = NA,
  verbose = FALSE,
  inherit.aes = TRUE
) {
  if (! missing(nudge_x) || ! missing(nudge_y)) {
    if (! missing(position)) {
      stop("Specify either `position` or `nudge_x`/`nudge_y`", call. = FALSE)
    }
    position <- position_nudge(nudge_x, nudge_y)
  }

  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomLabelRepel,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      parse = parse,
      box.padding = to_unit(box.padding),
      label.padding = label.padding,
      point.padding = to_unit(point.padding),
      label.r = label.r,
      label.size = label.size,
      min.segment.length = to_unit(min.segment.length),
      arrow = arrow,
      force = force,
      force_pull = force_pull,
      max.time = max.time,
      max.iter = max.iter,
      max.overlaps = max.overlaps,
      xlim = xlim,
      ylim = ylim,
      na.rm = na.rm,
      direction = match.arg(direction),
      seed = seed,
      verbose = verbose,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_rows_axis <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  axis_labels = TRUE,
  axis_ticks = TRUE,
  axis_text = TRUE,
  by = NULL,
  num = NULL,
  tick_length = 0.025,
  text_dodge = 0.15,
  label_dodge = 0.2,
  ...,
  parse = FALSE,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomAxis,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      axis_labels = axis_labels,
      axis_ticks = axis_ticks,
      axis_text = axis_text,
      by = by,
      num = num,
      tick_length = tick_length,
      text_dodge = text_dodge,
      label_dodge = label_dodge,
      parse = parse,
      check_overlap = check_overlap,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_axis <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  axis_labels = TRUE,
  axis_ticks = TRUE,
  axis_text = TRUE,
  by = NULL,
  num = NULL,
  tick_length = 0.025,
  text_dodge = 0.15,
  label_dodge = 0.2,
  ...,
  parse = FALSE,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomAxis,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      axis_labels = axis_labels,
      axis_ticks = axis_ticks,
      axis_text = axis_text,
      by = by,
      num = num,
      tick_length = tick_length,
      text_dodge = text_dodge,
      label_dodge = label_dodge,
      parse = parse,
      check_overlap = check_overlap,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_rows_lineranges <- function(
  mapping = NULL,
  data = NULL,
  stat = "center",
  position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
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

#' @rdname biplot-geoms
#' @export
geom_cols_lineranges <- function(
  mapping = NULL,
  data = NULL,
  stat = "center",
  position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
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

#' @rdname biplot-geoms
#' @export
geom_rows_pointranges <- function(
  mapping = NULL,
  data = NULL,
  stat = "center",
  position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
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

#' @rdname biplot-geoms
#' @export
geom_cols_pointranges <- function(
  mapping = NULL,
  data = NULL,
  stat = "center",
  position = "identity",
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
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

#' @rdname biplot-geoms
#' @export
geom_rows_isoline <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  isoline_text = TRUE,
  by = NULL,
  num = NULL,
  label_dodge = 0.1,
  ...,
  parse = FALSE,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomIsoline,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      isoline_text = isoline_text,
      by = by,
      num = num,
      label_dodge = label_dodge,
      parse = parse,
      check_overlap = check_overlap,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_isoline <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  isoline_text = TRUE,
  by = NULL,
  num = NULL,
  label_dodge = 0.1,
  ...,
  parse = FALSE,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomIsoline,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      isoline_text = isoline_text,
      by = by,
      num = num,
      label_dodge = label_dodge,
      parse = parse,
      check_overlap = check_overlap,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_rows_text_radiate <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  parse = FALSE,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
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

#' @rdname biplot-geoms
#' @export
geom_cols_text_radiate <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  ...,
  parse = FALSE,
  check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
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

#' @rdname biplot-geoms
#' @export
geom_rows_vector <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  arrow = default_arrow,
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = rows_stat(stat),
    geom = GeomVector,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      arrow = arrow,
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname biplot-geoms
#' @export
geom_cols_vector <- function(
  mapping = NULL,
  data = NULL,
  stat = "identity",
  position = "identity",
  arrow = default_arrow,
  ...,
  na.rm = FALSE,
  show.legend = NA,
  inherit.aes = TRUE
) {
  layer(
    mapping = mapping,
    data = data,
    stat = cols_stat(stat),
    geom = GeomVector,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      arrow = arrow,
      na.rm = na.rm,
      ...
    )
  )
}
