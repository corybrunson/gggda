#' @title Multivariate coordinates
#' @description Compute position aesthetics from high-dimensional data.
#' @export
aes_coord <- function(data, coords = NULL, ...) {
  # process coordinate aesthetics
  if (! is.null(enexpr(coords))) {
    coords <- names(tidyselect::eval_select(rlang::enquo(coords), data))
    coords <- lapply(coords, function(nm) rlang::quo(!! rlang::sym(nm)))
    names(coords) <- paste0("..coord", seq_along(coords))
  } else {
    coords <- aes()
  }
  # process other aesthetics
  other_aes <- aes(...)
  # concatenate aesthetics
  aes <- c(coords, other_aes)
  class(aes) <- "uneval"
  aes
}

# get high-dimensional coordinate mapping from a data frame in a stat layer:
# `aes_coord()` if specified, otherwise 'x' and 'y'
get_aes_coord <- function(data) {
  coord_cols <- grep("^\\.\\.coord[0-9]+$", names(data))
  if (length(coord_cols) == 0L) coord_cols <- match(c("x", "y"), names(data))
  coord_cols
}
