
#' @rdname ggbiplot
#' @export
GeomIsolines <- ggproto(
  "GeomIsolines", GeomAbline,
  
  required_aes = c("x", "y"),
  default_aes = aes(
    colour = "black", size = .5, linetype = "dashed", alpha = .5
  ),
  
  draw_panel = function(
    data, panel_params, coord,
    ids = 1, by = 1
  ) {
    ranges <- coord$range(panel_params)
    
    if (is.null(ids)) ids <- 1:nrow(data)
    
    # convert to intercepts and slopes
    data <- do.call(rbind, lapply(ids, function(i) {
      # vector
      w_i <- unlist(data[i, c("x", "y")])
      # calibrated vector
      c_i <- w_i / sum(w_i ^ 2)
      # range of isolines
      kran <- isoline_range(c_i, ranges$x, ranges$y, by)
      k <- seq(kran[1] * by, kran[2] * by, by = by)
      # slope of isolines
      m_i <- - w_i[1] / w_i[2]
      # component of final data frame from this original vector
      suppressWarnings(data.frame(
        x = k * c_i[1],
        y = k * c_i[2],
        intercept = k * c_i[2] - m_i * k * c_i[1],
        slope = m_i,
        data[i, -match(c("x", "y"), names(data))]
      ))
    }))
    
    ggplot2::GeomAbline$draw_panel(
      data = data, panel_params = panel_params, coord = coord
    )
  }
)

#' @rdname ggbiplot
#' @export
geom_u_isolines <- function(
  mapping = NULL, data = NULL, position = "identity",
  ids = 1, by = 1,
  ...,
  na.rm = FALSE,
  show.legend = NA, inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = "u",
    geom = GeomIsolines,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ids = ids,
      by = by,
      ...
    )
  )
}

#' @rdname ggbiplot
#' @export
geom_v_isolines <- function(
  mapping = NULL, data = NULL, position = "identity",
  ids = 1, by = 1,
  ...,
  na.rm = FALSE,
  show.legend = NA, inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = "v",
    geom = GeomIsolines,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ids = ids,
      by = by,
      ...
    )
  )
}

#' @rdname ggbiplot
#' @export
geom_biplot_isolines <- function(
  mapping = NULL, data = NULL, position = "identity",
  .matrix = "v", ids = 1, by = 1,
  ...,
  na.rm = FALSE,
  show.legend = NA, inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = .matrix,
    geom = GeomIsolines,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ids = ids,
      by = by,
      ...
    )
  )
}

isoline_range <- function(u, xran, yran, by) {
  m <- u[2] / u[1]
  ran <- if (m > 0) {
    c(project_onto(c(xran[1], yran[1]), u),
      project_onto(c(xran[2], yran[2]), u))
  } else if (m < 0) {
    c(project_onto(c(xran[1], yran[2]), u),
      project_onto(c(xran[2], yran[1]), u))
  } else if (m == 0) {
    c(project_onto(c(xran[1], 0), u),
      project_onto(c(xran[2], 0), u))
  } else if (is.infinite(m)) {
    c(project_onto(c(0, yran[1]), u),
      project_onto(c(0, yran[2]), u))
  }
  c(ceiling(min(ran) / by), floor(max(ran) / by))
}

project_onto <- function(x, y) {
  (sum(x * y) / sum(y ^ 2))
}
