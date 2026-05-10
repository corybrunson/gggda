#' @title Rulers through or offset from the origin
#'
#' @description `geom_rule()` renders segments through or orthogonally
#'   translated from the origin.

#' @details As implemented here, a rule is just an [axis][geom_axis] that has a
#'   fixed range, usually the limits of the data. `geom_rule()` defaults to
#'   [`stat = "identity"`][ggplot2::stat_identity()] to avoid the problem of
#'   failing to pass referent data to the referential [stat_rule()]. Therefore,
#'   the user must provide the `lower` and `upper` aesthetics, which are used as
#'   euclidean lengths in the plotting window. Meanwhile, `stat_rule()` defaults
#'   to `geom = "rule"`; see [stat_rule()] for details on this pairing.
#' 

#' @section Aesthetics:

#' `geom_rule()` understands the following aesthetics (required aesthetics are
#' in bold):

#' - **`x`**
#' - **`y`**
#' - **`lower`**
#' - **`upper`**
#' - `yintercept` _or_ `xintercept` _or_ `xend` and `yend`
#' - `linetype`
#' - `linewidth`
#' - `size`
#' - `hjust`
#' - `vjust`
#' - `colour`
#' - `alpha`
#' - `label`
#' - `family`
#' - `fontface`
#' - `center`, `scale`
#' - `group`
#' 

#' @import ggplot2
#' @importFrom dplyr transmute group_by filter mutate ungroup distinct
#' @importFrom tidyr pivot_wider
#' @inheritParams ggplot2::layer
#' @inheritParams geom_axis
#' @inheritParams ggplot2::geom_text
#' @template param-geom
#' @param snap_rule Logical; whether to snap rule segments to grid values.
#' @template return-layer
#' @family geom layers
#' @example inst/examples/ex-geom-rule.r
#' @export
geom_rule <- function(
  mapping = NULL, data = NULL, stat = "identity", position = "identity",
  axis_labels = TRUE, axis_ticks = TRUE, axis_text = TRUE,
  by = NULL, num = NULL,
  snap_rule = TRUE,
  tick_length = .025,
  text_dodge = .03, text_rotate = 0,
  label_dodge = .03, label_rotate = 0,
  ...,
  # NB: Fallbacks declared here will be missed by `layer()` and `stat_*()`;
  # they must be coordinated with the internal `*_fallback`s.
  # axis_fallback
  axis.linewidth = sync(), axis.linetype = sync(),
  axis.colour = sync(), axis.color = NULL, axis.alpha = sync(),
  # label_fallback
  label.size = sync(),
  label.hjust = sync(), label.vjust = sync(),
  label.family = sync(), label.fontface = sync(),
  label.colour = sync(), label.color = NULL, label.alpha = sync(),
  # tick_fallback
  # TODO: Inherit from theme.
  tick.linewidth = 0.25, tick.linetype = "solid",
  tick.colour = sync(), tick.color = NULL, tick.alpha = sync(),
  # text_fallback
  # TODO: Inherit from theme.
  text.size = 2.6,
  text.hjust = sync(), text.vjust = sync(),
  # TODO: Inherit from theme.
  text.family = sync(), text.fontface = sync(),
  text.colour = sync(), text.color = NULL, text.alpha = sync(),
  parse = FALSE, check_overlap = FALSE,
  na.rm = FALSE,
  show.legend = NA, inherit.aes = TRUE
) {
  
  axis_gp <- list(
    linewidth = axis.linewidth,
    linetype  = axis.linetype,
    colour    = axis.color %||% axis.colour,
    alpha     = axis.alpha
  )
  
  label_gp <- list(
    size     = label.size,
    hjust    = label.hjust,
    vjust    = label.vjust,
    family   = label.family,
    fontface = label.fontface,
    colour   = label.color %||% label.colour,
    alpha    = label.alpha
  )
  
  tick_gp <- list(
    linewidth = tick.linewidth,
    colour    = tick.color %||% tick.colour,
    alpha     = tick.alpha
  )
  
  text_gp <- list(
    size     = text.size,
    hjust    = text.hjust,
    vjust    = text.vjust,
    family   = text.family,
    fontface = text.fontface,
    colour   = text.color %||% text.colour,
    alpha    = text.alpha
  )
  
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomRule,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      axis_labels = axis_labels, axis_ticks = axis_ticks, axis_text = axis_text,
      by = by, num = num,
      snap_rule = snap_rule,
      tick_length = tick_length,
      text_dodge = text_dodge, text_rotate = text_rotate,
      label_dodge = label_dodge, label_rotate = label_rotate,
      axis_gp  = axis_gp,
      label_gp = label_gp,
      tick_gp  = tick_gp,
      text_gp  = text_gp,
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
GeomRule <- ggproto(
  "GeomRule", GeomAxis,
  
  required_aes = c("x", "y", "lower", "upper"),
  optional_aes = c("yintercept", "xintercept", "xend", "yend"),
  
  setup_data = function(data, params) {
    
    data <- ensure_cartesian_polar(data)
    
    # offset?
    use_offset <- 
      ! is.null(data[["yintercept"]]) ||
      ! is.null(data[["xintercept"]]) ||
      (! is.null(data[["xend"]]) && ! is.null(data[["yend"]]))
    
    # compute endpoints
    data <- transform(
      data,
      xmin = lower * cos(angle), ymin = lower * sin(angle),
      xmax = upper * cos(angle), ymax = upper * sin(angle)
    )
    
    # recover and offset endpoints
    if (use_offset) {
      if (is.null(data[["xend"]]) || is.null(data[["yend"]]))
        data <- recover_offset_endpoints(data)
      
      data <- transform(
        data,
        xmin = xmin + xend, ymin = ymin + yend,
        xmax = xmax + xend, ymax = ymax + yend
      )
    }
    
    # drop position coordinates
    data$x <- data$y <- NULL
    
    data
  },
  
  draw_panel = function(
    data, panel_params, coord,
    axis_labels = TRUE, axis_ticks = TRUE, axis_text = TRUE,
    by = NULL, num = NULL,
    snap_rule = TRUE,
    tick_length = .025,
    text_dodge = .03, text_rotate = 0,
    label_dodge = .03, label_rotate = 0,
    axis_gp  = NULL, label_gp = NULL, tick_gp  = NULL, text_gp  = NULL,
    parse = FALSE, check_overlap = FALSE,
    na.rm = FALSE
  ) {
    
    if (! coord$is_linear()) {
      rlang::warn(
        "Rulers are not yet tailored to non-linear coordinates.",
        .frequency = "regularly",
        .frequency_id = "GeomRule$draw_panel-is_linear"
      )
    }
    
    # extract value ranges
    ranges <- coord$range(panel_params)
    
    data <- ensure_cartesian_polar(data)
    
    # introduce `axis` if missing
    if (is.null(data$axis)) data$axis <- 1L
    
    # remove lengthless vectors
    data <- subset(data, x^2 + y^2 > 0)
    
    # offset?
    use_offset <- ! is.null(data[["xend"]]) && ! is.null(data[["yend"]])
    
    # initialize grob list
    grobs <- list()
    
    # minimum of the plot width and height
    plot_whmin <- min(diff(ranges$x), diff(ranges$y))
    
    # recover slope and (if offset) intercepts
    if (is.null(data[["slope"]])) data$slope <- data$y / data$x
    if (use_offset) {
      if (is.null(data[["yintercept"]]) || is.null(data[["xintercept"]]))
        data <- recover_offset_intercepts(data)
    }
    
    # text dodge vector
    if (axis_labels || axis_text) {
      data <- transform(
        data,
        dodge_angle = if (use_offset) 
          atan2(yend, xend) 
        else 
          (atan(slope) + pi/2)
      )
    }
    
    # compute marks (`x_t` and `y_t`):
    # if no segments then first bound outside window
    if (axis_ticks || axis_text) {
      mark_data <- data
      
      # calculate rule values and positions
      mark_data <- calibrate_rules(mark_data, by, num, loose = FALSE)
    }
    
    # axis grobs: if `xend` & `yend` then segment else abline & vline
    axis_data <- unique(data)
    
    # specify independent aesthetics
    axis_fallback <- list()
    axis_aes <- GeomSegment$aesthetics()
    for (aes_name in axis_aes) {
      axis_data[[aes_name]] <- 
        (if (is.sync(axis_gp[[aes_name]])) 
          axis_data[[aes_name]]) %||%
        axis_gp[[aes_name]] %||% 
        axis_fallback[[aes_name]] %||% 
        axis_data[[aes_name]]
    }
    
    # NB: This step redefines positional aesthetics for a specific grob.
    
    if ((axis_ticks || axis_text) && snap_rule) {
      
      # compute extended value range
      mark_range <- 
        transmute(mark_data, axis, label, x = x_t + x_0, y = y_t + y_0)
      mark_range <- group_by(mark_range, axis)
      mark_range <-
        filter(mark_range, label == min(label) | label == max(label))
      mark_range <- mutate(
        mark_range,
        ext = ifelse(label == min(label), "min", "max")
      )
      mark_range <-
        filter(mark_range, all(c("min", "max") %in% ext))
      mark_range <- ungroup(mark_range)
      mark_range <- distinct(mark_range)
      mark_range <- pivot_wider(
        mark_range,
        id_cols = axis,
        names_from = ext, values_from = c(x, y), names_sep = ""
      )
      
      # extend segment to value range (when available)
      mark_axes <- match(axis_data$axis, mark_range$axis)
      mark_axes <- mark_axes[! is.na(mark_axes)]
      if (length(mark_axes) > 0L) {
        axis_data[mark_axes, c("xend", "yend", "x", "y")] <- 
          mark_range[, c("xmin", "ymin", "xmax", "ymax")]
      }
      if (length(mark_axes) < nrow(axis_data)) {
        axis_data <- subset(axis_data, axis_data$axis %in% mark_axes)
      }
      
    } else {
      
      # recognized segment positions
      axis_data <- transform(
        axis_data,
        xend = xmin, yend = ymin, x = xmax, y = ymax
      )
      
    }
    
    grobs <- c(grobs, list(GeomSegment$draw_panel(
      data = axis_data,
      panel_params = panel_params, coord = coord
    )))
    
    if (axis_labels) {
      label_data <- data
      
      # specify independent aesthetics
      label_fallback <- list()
      label_aes <- GeomText$aesthetics()
      for (aes_name in label_aes) {
        label_data[[aes_name]] <- 
          (if (is.sync(label_gp[[aes_name]])) 
            label_data[[aes_name]]) %||%
          label_gp[[aes_name]] %||% 
          label_fallback[[aes_name]] %||% 
          label_data[[aes_name]]
      }
      
      # NB: This step redefines positional aesthetics for a specific grob.
      
      # compute positions: if `xend` & `yend` then mid/endpoint else border
      # replace x,y with heads then opt for any positions closer to the origin
      # replace x,y with heads or tails, whichever is farther from the origin
      repl_min <- with(label_data, xmin^2 + ymin^2 > xmax^2 + ymax^2)
      label_data <- transform(
        label_data,
        x = ifelse(repl_min, xmin, xmax),
        y = ifelse(repl_min, ymin, ymax)
      )
      # adjust labels inward from borders
      label_data <- transform(
        label_data,
        hjust = ifelse(
          xmin < xmax,
          as.numeric(1 - repl_min),
          as.numeric(repl_min)
        )
      )
      label_data <- subset(label_data, select = -c(xmin, ymin, xmax, ymax))
      if (use_offset) label_data <- subset(label_data, select = -c(xend, yend))
      
      # dodge axis
      label_data <- transform(
        label_data,
        x = x + cos(dodge_angle) * plot_whmin * label_dodge,
        y = y + sin(dodge_angle) * plot_whmin * label_dodge
      )
      # update text angle
      label_data <- transform(
        label_data,
        angle = atan(tan(angle)) + label_rotate * pi / 180
      )
      # put total angle in degrees
      label_data$angle <- label_data$angle * 180 / pi
      
      # axis label grobs
      grobs <- c(grobs, list(GeomText$draw_panel(
        data = label_data,
        panel_params = panel_params, coord = coord
      )))
      
    }
    
    if (axis_ticks) {
      tick_data <- mark_data
      
      # specify independent aesthetics
      tick_fallback <- list(linewidth = 0.25, linetype = "solid")
      tick_aes <- GeomSegment$aesthetics()
      for (aes_name in tick_aes) {
        tick_data[[aes_name]] <- 
          (if (is.sync(tick_gp[[aes_name]])) 
            tick_data[[aes_name]]) %||%
          tick_gp[[aes_name]] %||% 
          tick_fallback[[aes_name]] %||% 
          tick_data[[aes_name]]
      }
      
      # tick mark radius
      rtick <- plot_whmin * tick_length / 2
      # tick mark vector
      tick_data <- transform(
        tick_data,
        xtick = - y / radius * rtick,
        ytick =   x / radius * rtick
      )
      
      # NB: This step redefines positional aesthetics for a specific grob.
      
      # endpoints of tick marks
      tick_data <- transform(
        tick_data,
        xend = x_t - xtick, x = x_t + xtick,
        yend = y_t - ytick, y = y_t + ytick
      )
      
      # tick mark grobs
      grobs <- c(grobs, list(GeomSegment$draw_panel(
        data = offset_xy(tick_data),
        panel_params = panel_params, coord = coord
      )))
      
    }
    
    if (axis_text) {
      text_data <- mark_data
      
      # specify independent aesthetics
      text_fallback <- list(size = 2.6)
      text_aes <- GeomText$aesthetics()
      for (aes_name in text_aes) {
        text_data[[aes_name]] <- 
          (if (is.sync(text_gp[[aes_name]])) 
            text_data[[aes_name]]) %||%
          text_gp[[aes_name]] %||% 
          text_fallback[[aes_name]] %||% 
          text_data[[aes_name]]
      }
      
      # omit labels at origin
      if (! use_offset) {
        text_data <-
          text_data[text_data$x_t != 0 | text_data$y_t != 0, , drop = FALSE]
      }
      
      # NB: This step redefines positional aesthetics for a specific grob.
      
      # dodge axis
      text_data <- transform(
        text_data,
        x = x_t - cos(dodge_angle) * plot_whmin * text_dodge,
        y = y_t - sin(dodge_angle) * plot_whmin * text_dodge
      )
      # update text angle and put in degrees
      text_data <- transform(
        text_data,
        angle = atan(tan(angle)) * 180 / pi + text_rotate
      )
      
      if (nrow(text_data) > 0L) {
        # mark text grobs
        grobs <- c(grobs, list(GeomText$draw_panel(
          data = offset_xy(text_data),
          panel_params = panel_params, coord = coord,
          parse = parse,
          check_overlap = check_overlap,
          na.rm = na.rm
        )))
      }
      
    }
    
    grob <- do.call(grid::grobTree, grobs)
    grob$name <- grid::grobName(grob, "geom_rule")
    grob
  },
  
  # update this to include segment and letter in key squares
  draw_key = draw_key_abline
)
