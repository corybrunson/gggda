#' @title Delaunay triangulation
#'
#' @description Compute Delaunay triangulation from point data.
#'

#' @details The Delaunay triangulation of a set of points in a metric space is
#'   the dual of the Voronoi tessellation: each edge connects two points whose
#'   Voronoi cells share a boundary, and the boundary perpendicularly bisects
#'   the edge. When computed in higher-dimensional real space,
#'   `StatDelaunay$compute_layer()` projects these edges onto the first two
#'   dimensions.
#'
#'   Each row of the output data frame represents one edge of the triangulation,
#'   with columns `x`, `y`, `xend`, `yend` giving the (projected) endpoint
#'   coordinates, as expected by the default [ggplot2::geom_segment()].
#'
#'   By default, [deldir::deldir()] is deployed on 2-dimensional data while
#'   [geometry::delaunayn()] is deployed on higher-dimensional data; the user
#'   may use the `engine` argument to override the default in 2 dimensions, but
#'   in higher dimensions the **geometry** package is required.
#' 

#' @template ref-voronoi1908

#' @template aes-coord

#' @section Computed variables: These are calculated during the statistical
#'   transformation and can be accessed with [delayed
#'   evaluation][ggplot2::aes_eval].
#' \describe{
#'   \item{`xend,yend,x,y`}{endpoints of triangulation edges (segments)}
#' }

#' @inheritParams ggplot2::layer
#' @param engine A single character string specifying the package implementation
#'   to use; `"deldir"` or `"geometry"`. Only `"geometry"` can handle
#'   higher-dimensional data.
#' @template param-layer
#' @template return-layer
#' @family stat layers
#' @example inst/examples/ex-stat-delaunay.r
#' @export
stat_delaunay <- function(
    mapping = NULL, data = NULL, geom = "segment", position = "identity",
    engine = NULL,
    show.legend = NA,
    inherit.aes = TRUE,
    ...
) {
  layer(
    data = data,
    mapping = mapping,
    stat = StatDelaunay,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      engine = engine,
      na.rm = FALSE,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatDelaunay <- ggproto(
  "StatDelaunay", Stat,

  required_aes = c("x|..coord1", "y|..coord2"),

  compute_layer = function(
    self, data, params, panel
  ) {
    engine <- params$engine
    if (! is.null(engine)) engine <- match.arg(engine, c("deldir", "geometry"))

    coord_cols <- get_aes_coord(data)
    coords <- as.matrix(data[, coord_cols, drop = FALSE])

    data$x <- coords[, 1L]
    data$y <- coords[, 2L]

    # select and deploy engine based on data dimension
    engine <- select_voronoy_engine(engine, ncol(coords))

    edges <- switch(engine,
      deldir   = delaunay_edges_deldir(coords),
      geometry = delaunay_edges_geometry(coords)
    )

    if (is.null(edges) || nrow(edges) == 0L) {
      data <- data[0L, , drop = FALSE]
      data$xend <- numeric(0L)
      data$yend <- numeric(0L)
      return(data)
    }

    # merge edges with original data by endpoint index
    # (each edge row carries the aesthetics of its first endpoint)
    seg_data <- data.frame(
      x = coords[edges$i, 1L],
      y = coords[edges$i, 2L],
      xend = coords[edges$j, 1L],
      yend = coords[edges$j, 2L],
      group = seq_len(nrow(edges)),
      row.names = NULL
    )

    # bind original data columns (excluding coord overrides) to edges
    orig_cols <- setdiff(names(data), c("x", "y", "group", coord_cols))
    if (length(orig_cols) > 0L) {
      seg_data <- cbind(seg_data, data[edges$i, orig_cols, drop = FALSE])
    }

    seg_data
  },

  parameters = function(self, extra = FALSE) {
    panel_args <- c("na.rm", "engine")
    if (extra) {
      panel_args <- union(panel_args, self$non_missing_aes)
    }
    panel_args
  }
)

delaunay_edges_deldir <- function(coords) {
  n <- nrow(coords)
  if (n < 2L) return(NULL)

  if (n == 2L) {
    return(data.frame(i = 1L, j = 2L))
  }

  del <- deldir::deldir(coords[, 1L], coords[, 2L])
  delsgs <- del$delsgs

  # delsgs columns: x1, y1, x2, y2, ind1, ind2
  data.frame(
    i = delsgs$ind1,
    j = delsgs$ind2
  )
}

delaunay_edges_geometry <- function(coords) {
  n <- nrow(coords)
  if (n < 2L) return(NULL)

  if (n == 2L) {
    return(data.frame(i = 1L, j = 2L))
  }

  tri <- geometry::delaunayn(coords, options = "Qz")
  if (nrow(tri) == 0L) return(NULL)

  # extract all unique edges from simplices
  edge_keys <- character(0L)
  edge_i <- integer(0L)
  edge_j <- integer(0L)

  for (k in seq_len(nrow(tri))) {
    verts <- tri[k, ]
    nv <- length(verts)
    if (nv >= 2L) {
      for (a in seq_len(nv - 1L)) {
        for (b in seq.int(a + 1L, nv)) {
          vi <- min(verts[a], verts[b])
          vj <- max(verts[a], verts[b])
          key <- paste(vi, vj, sep = "|")
          if (! key %in% edge_keys) {
            edge_keys <- c(edge_keys, key)
            edge_i <- c(edge_i, vi)
            edge_j <- c(edge_j, vj)
          }
        }
      }
    }
  }

  if (length(edge_i) == 0L) return(NULL)

  data.frame(i = edge_i, j = edge_j)
}
