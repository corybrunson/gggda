#' @title Voronoi tiles
#'
#' @description Compute Voronoi regions from point data.
#' 

#' @details The Voronoi tessellation (also associated with the names Dirichlet
#'   and Thiessen) of a set of points in a metric space comprises the
#'   nearest-neighbor classification region around each point. When computed in
#'   higher-dimensional real space, `StatVoronoi$compute_layer()` computes their
#'   intersections with the plane.
#'
#'   `stat_voronoi()` is designed to pair with [geom_voronoi()]. In particular,
#'   `GeomVoronoi` is the only `ggproto` that recognizes the computed variable
#'   `cell`, in which `StatVoronoi` stores a list of data frames for the Voronoi
#'   cells.
#'
#'   Because linear discriminant analysis (LDA) assumes constant within-group
#'   inertia, the Voronoi regions about the group centroids serve as prediction
#'   regions in an LDA biplot (Gardner, 2001). When the LDA models more than
#'   three groups, proper prediction regions must be constructed in model space,
#'   then intersected with the biplot plane.
#'
#'   Voronoi cells are only delimited within a rectangular border, set to a
#'   fraction (`buffer`) of the data range beyond the extrema in each dimension.
#'
#'   By default, [deldir::deldir()] is deployed on 2-dimensional data while
#'   [geometry::delaunayn()] is deployed on higher-dimensional data; the user
#'   may use the `engine` argument to override the default in 2 dimensions, but
#'   in higher dimensions the **geometry** package is required.
#' 

#' @template ref-voronoi1908
#' @template ref-gardner2001

#' @template aes-coord

#' @section Computed variables: These are calculated during the statistical
#'   transformation and can be accessed with [delayed
#'   evaluation][ggplot2::aes_eval].
#' \describe{
#'   \item{`cell`}{a list-column of data frames, each containing the cell
#'     vertex coordinates (`x`, `y`) and the border indicator `border`}
#' }

#' @inheritParams ggplot2::layer
#' @param buffer Numeric; a fraction of the data range by which to extend the
#'   Voronoi tessellation in each coordinate.
#' @param engine A single character string specifying the package implementation
#'   to use; `"deldir"` or `"geometry"`. Only `"geometry"` can handle
#'   higher-dimensional data.
#' @template param-layer
#' @template return-layer
#' @family stat layers
#' @example inst/examples/ex-stat-voronoi.r
#' @export
stat_voronoi <- function(
    mapping = NULL, data = NULL, geom = "voronoi", position = "identity",
    buffer = 1,
    engine = NULL,
    show.legend = NA,
    inherit.aes = TRUE,
    ...
) {
  if (! is.null(engine)) engine <- match.arg(engine, c("deldir", "geometry"))

  layer(
    data = data,
    mapping = mapping,
    stat = StatVoronoi,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      buffer = buffer,
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
StatVoronoi <- ggproto(
  "StatVoronoi", Stat,

  required_aes = c("x|..coord1", "y|..coord2"),

  compute_layer = function(
    self, data, params, panel
  ) {
    # save(self, data, params, panel,
    #      file = "stat-voronoi-compute-layer.rda")
    # load(file = "stat-voronoi-compute-layer.rda")
    
    # necessary when overriding `$compute_layer()`
    buffer <- params$buffer %||% 1
    engine <- params$engine
    
    if (! is.numeric(buffer) || length(buffer) < 1L ||
        length(buffer) > 2L || anyNA(buffer)) {
      stop("`buffer` must be a numeric vector of length 1 or 2.")
    }
    buffer <- rep(buffer, length.out = 2L)

    coord_cols <- get_aes_coord(data)
    coords <- as.matrix(data[, coord_cols, drop = FALSE])
    
    data$x <- coords[, 1L]
    data$y <- coords[, 2L]
    # NB: For plotting, each cell must constitute its own group.
    data$group <- seq_len(nrow(data))

    # FIXME: Why are these limits always `NULL`?
    coord_limits <- panel$coord$limits
    x_ran <- coord_limits$x %||% range(coords[, 1L], na.rm = TRUE)
    y_ran <- coord_limits$y %||% range(coords[, 2L], na.rm = TRUE)
    x_diff <- diff(x_ran)
    y_diff <- diff(y_ran)
    if (x_diff == 0) x_diff <- 1
    if (y_diff == 0) y_diff <- 1
    x_pad <- x_diff * buffer[1L]
    y_pad <- y_diff * buffer[2L]
    limits <- c(
      x_ran[1L] - x_pad, x_ran[2L] + x_pad,
      y_ran[1L] - y_pad, y_ran[2L] + y_pad
    )

    # select and deploy engine based on data dimension
    del_engines <- c("deldir", "geometry")
    engine_installed <- del_engines %in% .packages(all.available = TRUE)
    names(engine_installed) <- del_engines
    if (! any(engine_installed)) {
      stop("No Voronoi engine installed; requires one of the following:\n",
           "{", paste(del_engines, collapse = "}, {"), "}")
    }
    if (is.null(engine)) {
      if (ncol(coords) == 2L) {
        engine <- del_engines[which.max(engine_installed)]
      } else if (engine_installed["geometry"]) {
        engine <- "geometry"
      } else {
        stop("Higher-dimensional Voronoi tessellation requires {geometry}.")
      }
    } else if (engine == "deldir" && ncol(coords) > 2L) {
      if (engine_installed["geometry"]) {
        warning(paste0(
          "{deldir} takes only 2-dimensional data;",
          " using {geometry} instead."
        ))
        engine <- "geometry"
      } else {
        stop("Higher-dimensional Voronoi tessellation requires {geometry}.")
      }
    }
    
    cell_list <- switch(engine,
      deldir   = voronoi_cells_deldir(coords, limits),
      geometry = voronoi_cells_geometry(coords, limits)
    )

    data$cell <- cell_list
    data
  },

  parameters = function(self, extra = FALSE) {
    panel_args <- c("na.rm", "buffer", "engine")
    if (extra) {
      panel_args <- union(panel_args, self$non_missing_aes)
    }
    panel_args
  }
)

# use `deldir::deldir()` for at least 3 points; otherwise handle trivially
# assume data are 2-dimensional
voronoi_cells_deldir <- function(coords, limits) {
  if (nrow(coords) >= 3L) {
    del <- deldir::deldir(coords[, 1L], coords[, 2L], rw = limits)
    tiles <- deldir::tile.list(del)
    
    cell_list <- lapply(tiles, function(tile) {
      data.frame(
        x = tile$x,
        y = tile$y,
        border = tile$bp
      )
    })
    names(cell_list) <- NULL
    
  } else if (nrow(coords) == 2L) {
    cell_list <- voronoi_cells_2(coords, limits)
  } else if (nrow(coords) == 1L) {
    cell_list <- voronoi_cells_1(coords, limits)
  }

  cell_list
}

# use `geometry::delaunayn()` to identify Delaunay neighbors, then clip each
# cell against its neighbors' bisectors
voronoi_cells_geometry <- function(coords, limits) {
  n <- nrow(coords)
  bound <- bound_coord(limits)
  norms_sq <- rowSums(coords^2)

  # adjacency list from triangulation
  adj <- vector("list", n)
  if (n >= 3L) {
    tri <- geometry::delaunayn(coords, options = "Qz")
    if (nrow(tri) > 0L) {
      for (k in seq_len(nrow(tri))) {
        verts <- tri[k, ]
        nv <- length(verts)
        if (nv >= 2L) {
          for (i_idx in seq_len(nv)) {
            vi <- verts[i_idx]
            for (j_idx in seq_len(nv)) {
              if (i_idx != j_idx) {
                adj[[vi]] <- c(adj[[vi]], verts[j_idx])
              }
            }
          }
        }
      }
    }
  }
  adj <- lapply(adj, unique)

  result_list <- vector("list", n)

  for (i in seq_len(n)) {
    neigh <- adj[[i]]
    if (length(neigh) == 0L) {
      neigh <- seq_len(n)[-i]
    }

    # third and fourth columns for whether point lies on x,y border
    poly <- cbind(bound, c(-1, 1, 1, -1), c(-1, -1, 1, 1))
    for (j in neigh) {
      if (i == j) next
      a <- coords[j, 1L] - coords[i, 1L]
      b <- coords[j, 2L] - coords[i, 2L]
      c <- (norms_sq[j] - norms_sq[i]) / 2
      poly <- clip_halfplane(poly, a, b, c)
      if (nrow(poly) < 3L) break
    }

    if (nrow(poly) >= 3L) {
      result_list[[i]] <- data.frame(
        x = poly[, 1L], y = poly[, 2L], border = poly[, 3L] | poly[, 4L]
      )
    } else {
      result_list[[i]] <- data.frame(
        x = numeric(0L), y = numeric(0L), border = logical(0L)
      )
    }
  }

  result_list
}

voronoi_cells_1 <- function(coords, limits) {
  stopifnot(nrow(coords) == 1L)
  
  bound <- bound_coord(limits)
  
  list(data.frame(x = bound[, 1L], y = bound[, 2L], border = TRUE))
}

voronoi_cells_2 <- function(coords, limits) {
  stopifnot(nrow(coords) == 2L)
  
  bound <- bound_coord(limits)
  norms_sq <- rowSums(coords^2)
  
  # third and fourth columns for whether point lies on x,y border
  poly <- cbind(bound, c(-1, 1, 1, -1), c(-1, -1, 1, 1))
  a <- coords[2L, 1L] - coords[1L, 1L]
  b <- coords[2L, 2L] - coords[1L, 2L]
  c <- (norms_sq[2L] - norms_sq[1L]) / 2
  
  poly1 <- clip_halfplane(poly,  a,  b,  c)
  poly2 <- clip_halfplane(poly, -a, -b, -c)
  
  list(
    data.frame(x = poly1[, 1L], y = poly1[, 2L],
               border = poly1[, 3L] | poly1[, 4L]),
    data.frame(x = poly2[, 1L], y = poly2[, 2L],
               border = poly2[, 3L] | poly2[, 4L])
  )
}

# coordinate matrix for bounding box
bound_coord <- function(limits) {
  matrix(c(
    limits[1L], limits[3L],
    limits[2L], limits[3L],
    limits[2L], limits[4L],
    limits[1L], limits[4L]
  ), ncol = 2L, byrow = TRUE)
}

# clip a convex polygon by a half-plane a*x + b*y <= c
# `poly` is 2-column matrix of ordered vertex coordinates
clip_halfplane <- function(poly, a, b, c) {
  n <- nrow(poly)
  if (n < 3L) return(poly)
  # TODO: Externalize `eps`.
  eps <- 1e-12
  out <- vector("list", n * 2L + 1L)
  k <- 0L
  for (i in seq_len(n)) {
    j <- if (i < n) i + 1L else 1L
    xi <- poly[i, 1L]; yi <- poly[i, 2L]; bi <- poly[i, c(3L, 4L)]
    xj <- poly[j, 1L]; yj <- poly[j, 2L]; bj <- poly[j, c(3L, 4L)]
    fi <- a * xi + b * yi - c
    fj <- a * xj + b * yj - c
    inside_i <- fi <= eps
    inside_j <- fj <= eps
    if (inside_i) {
      if (inside_j) {
        k <- k + 1L
        out[[k]] <- c(xj, yj, bj)
      } else {
        denom <- fj - fi
        t <- -fi / denom
        k <- k + 1L
        out[[k]] <- c(xi + t * (xj - xi), yi + t * (yj - yi),
                      ifelse(bi == bj, bj, 0))
      }
    } else if (inside_j) {
      denom <- fj - fi
      t <- -fi / denom
      k <- k + 1L
      out[[k]] <- c(xi + t * (xj - xi), yi + t * (yj - yi),
                    ifelse(bi == bj, bj, 0))
      k <- k + 1L
      out[[k]] <- c(xj, yj, bj)
    }
  }
  if (k < 3L) return(matrix(numeric(0), ncol = 4L))
  do.call(rbind, out[seq_len(k)])
}
