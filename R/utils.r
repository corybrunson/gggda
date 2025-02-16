
#' @importFrom rlang "%||%"

is_const <- function(x) length(unique(x)) == 1L

# get custom multivariable coordinate mapping from a data frame in a stat layer:
# `..coord1` etc. as from `ordr::ord_aes()` if specified, otherwise 'x' and 'y'
get_ord_aes <- function(data) {
  ord_cols <- grep("^\\.\\.coord[0-9]+$", names(data))
  if (length(ord_cols) == 0) ord_cols <- match(c("x", "y"), names(data))
  ord_cols
}
