#' Fortify a bibble for plotting
#' 
#' These methods of \code{\link[ggplot2]{fortify}} and \code{\link[broom]{tidy}}
#' convert a \code{\link{bibble}} to a \code{\link{tibble}}.
#' 

#' @name bibble-fortification
#' @param model,x A \link{bibble}, i.e. an ordination object of class 
#'   \code{"bbl"}.
#' @param data Ignored.
#' @param ... Additional arguments received from \code{fortify} or \code{tidy}; 
#'   ignored.
#' @template matrix-param
#' @param include Character matched to \code{"coordinates"}, \code{"shared"}, or
#'   \code{"all"}; whether the fortified data frame should include only the 
#'   ordination coordinates or also augmented case and variable data, and, if
#'   the latter, whether only shared fields or all from both.

#' @rdname bibble-fortification
#' @export
fortify.bbl <- function(
  model, data, ...,
  .matrix = "uv",
  include = "all"
) {
  .matrix <- match_factor(.matrix)
  include <- match.arg(include, c("coordinates", "shared", "all"))
  
  if (grepl("u", .matrix)) {
    u <- as_tibble(get_u(model, align = TRUE))
    if (include != "coordinates") {
      u <- dplyr::bind_cols(
        u,
        augment_u(model)
      )
      u$.matrix <- "u"
    }
  }
  if (grepl("v", .matrix)) {
    v <- as_tibble(get_v(model, align = TRUE))
    if (include != "coordinates") {
      v <- dplyr::bind_cols(
        v,
        augment_v(model)
      )
      v$.matrix <- "v"
    }
  }
  
  switch(
    .matrix,
    u = u,
    v = v,
    uv = switch(
      include,
      #coordinates = {
      #  coord <- recover_coord(model)
      #  as_tibble(as.data.frame(rbind(u[coord], v[coord])))
      #},
      coordinates = as_tibble(as.data.frame(rbind(u, v))),
      shared = {
        int <- intersect(names(u), names(v))
        as_tibble(as.data.frame(rbind(u[int], v[int])))
      },
      all = as_tibble(as.data.frame(dplyr::bind_rows(u, v)))
    )
  )
}

#' @rdname bibble-fortification
#' @export
fortify_u <- function(model, include = "all") {
  include <- match.arg(include, c("coordinates", "all"))
  fortify(model = model, data = NULL, .matrix = "u", include = include)
}

#' @rdname bibble-fortification
#' @export
fortify_v <- function(model, include = "all") {
  include <- match.arg(include, c("coordinates", "all"))
  fortify(model = model, data = NULL, .matrix = "v", include = include)
}

#' @importFrom broom tidy
#' @export
broom::tidy

#' @rdname bibble-fortification
#' @export
tidy.bbl <- function(x, ..., .matrix = "uv", include = "all") {
  fortify.bbl(model = x, data = NULL, .matrix = .matrix, include = include)
}
