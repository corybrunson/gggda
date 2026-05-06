#' @section Multidimensional position aesthetics:

#' This statistical transformation is compatible with the convenience function
#' [aes_coord()].
#'
#' Some transformations (e.g. [stat_center()]) commute with projection to the
#' lower (1 or 2)-dimensional biplot space. If they detect aesthetics of the
#' form `..coord[0-9]+`, then `..coord1` and `..coord2` are converted to `x` and
#' `y` while any remaining are ignored.
#'
#' Other transformations (e.g. [stat_spantree()]) yield different results in a
#' lower-dimensional biplot when they are computed before versus after
#' projection. If the stat layer detects these aesthetics, then the
#' transformation is performed before projection, and the results in the first
#' two dimensions are returned as `x` and `y`.
#'
#' A small number of transformations ([stat_rule()]) are incompatible with
#' these aesthetics but will accept `aes_coord()` without warning.
#' 
