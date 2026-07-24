#' @title Voronoi tessellation
#'
#' @description Render Voronoi cells as polygonal regions or boundary segments.
#'
#' @details `geom_voronoy()` and `geom_thiessen()` are designed to pair with
#'   [`stat_voronoy()`], which computes the data frame-valued list-column `cell`
#'   aesthetic.
#'
#'   `GeomVoronoy` un-nests `cell` and draws filled polygon interiors, by
#'   default omitting perimeters. `GeomThiessen` un-nests `cell` then extracts,
#'   uniquifies, and draws the edges shared by adjacent cells (so omits edges
#'   along the border) as segments.
#'
#' @section Aesthetics: `geom_voronoy()` and `geom_thiessen()` understand the
#'   following aesthetics (required aesthetics are in bold):
#' \itemize{
#'   \item **`cell`** (computed)
#'   \item `alpha`
#'   \item `colour`
#'   \item `fill`
#'   \item `linetype`
#'   \item `linewidth`
#' }
#' 

#' @import ggplot2
#' @inheritParams ggplot2::layer
#' @template param-geom
#' @template return-layer
#' @family geom layers
#' @example inst/examples/ex-geom-voronoy.r
#' @export
geom_voronoy <- function(
    mapping = NULL, data = NULL,
    stat = "voronoy", position = "identity",
    ...,
    na.rm = FALSE,
    show.legend = NA,
    inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomVoronoy,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomVoronoy <- ggproto(
  "GeomVoronoy", GeomPolygon,
  
  required_aes = c("cell"),
  
  default_aes = aes(
    linewidth = 0.5, linetype = 1L,
    colour = NA, fill = "grey55", alpha = 0.5
  ),

  draw_panel = function(
    self, data, panel_params, coord
  ) {
    data <- subset(data, select = -c(x, y))
    data <- unnest(data, cell)
    data <- as.data.frame(data)
    
    if (is.null(data) || nrow(data) == 0L) {
      return(zeroGrob())
    }
    
    GeomPolygon$draw_panel(data, panel_params, coord)
  }
)

#' @rdname geom_voronoy
#' @export
geom_thiessen <- function(
    mapping = NULL, data = NULL,
    stat = "voronoy", position = "identity",
    ...,
    na.rm = FALSE,
    show.legend = NA,
    inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomThiessen,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomThiessen <- ggproto(
  "GeomThiessen", GeomSegment,
  
  required_aes = c("cell"),
  
  default_aes = aes(
    colour = "black", linewidth = 0.5, linetype = 1L, alpha = NA,
    fill = "transparent"
  ),

  draw_panel = function(
    self, data, panel_params, coord
  ) {
    groups <- split(data, data$group)
    grobs <- lapply(groups, function(group) {
      self$draw_group(group, panel_params, coord)
    })
    do.call(grid::grobTree, grobs)
  },

  draw_group = function(
    self, data, panel_params, coord
  ) {
    data <- subset(data, select = -c(x, y))
    data <- unnest(data, cell)
    data <- as.data.frame(data)
    
    if (is.null(data) || nrow(data) == 0L) {
      return(zeroGrob())
    }
    
    # extract all edges
    cell_groups <- split(data, data$group)
    edge_list <- lapply(cell_groups, function(cell) {
      n <- nrow(cell)
      if (n < 2L) return(NULL)
      aes_names <- intersect(
        c("colour", "alpha", "linewidth", "linetype"), names(cell)
      )
      aes_vals <- cell[1L, aes_names, drop = FALSE]
      data.frame(
        x1 = cell$x,
        y1 = cell$y,
        x2 = cell$x[c(2:n, 1)],
        y2 = cell$y[c(2:n, 1)],
        border1 = cell$border,
        border2 = cell$border[c(2:n, 1)],
        aes_vals[rep(1L, n), , drop = FALSE],
        stringsAsFactors = FALSE
      )
    })
    edges <- do.call(rbind, edge_list)
    
    if (is.null(edges) || nrow(edges) == 0L) {
      return(zeroGrob())
    }
    
    # uniquify shared edges
    x1_min <- pmin(edges$x1, edges$x2)
    y1_min <- ifelse(
      edges$x1 < edges$x2, edges$y1,
      ifelse(edges$x1 > edges$x2, edges$y2,
             pmin(edges$y1, edges$y2))
    )
    x2_max <- pmax(edges$x1, edges$x2)
    y2_max <- ifelse(
      edges$x1 < edges$x2, edges$y2,
      ifelse(edges$x1 > edges$x2, edges$y1,
             pmax(edges$y1, edges$y2))
    )
    key <- paste(x1_min, y1_min, x2_max, y2_max, sep = "|")
    unique_edges <- edges[!duplicated(key), ]
    
    # omit border edges
    unique_edges <-
      unique_edges[!(unique_edges$border1 & unique_edges$border2), ]
    
    # Draw as segments via GeomSegment
    seg_data <- data.frame(
      x = unique_edges$x1, y = unique_edges$y1,
      xend = unique_edges$x2, yend = unique_edges$y2,
      colour = unique_edges$colour,
      linewidth = unique_edges$linewidth,
      linetype = unique_edges$linetype,
      alpha = unique_edges$alpha
    )
    
    GeomSegment$draw_panel(seg_data, panel_params, coord)
  }
)

