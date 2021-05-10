
#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

as_tbl_ord_default <- function(x) {
  class(x) <- c("tbl_ord", class(x))
  x
}

tbl_ord_factors <- c(
  rows = "rows", columns = "cols", cols = "cols", dims = "dims",
  u = "rows", v = "cols", uv = "dims",
  U = "rows", V = "cols", UV = "dims",
  left = "rows", right = "cols",
  cases = "rows", variables = "cols",
  subjects = "rows", measures = "cols",
  scores = "rows", loadings = "cols",
  rowprincipal = "rows", colprincipal = "cols",
  both = "dims", symmetric = "dims"
)
match_factor <- function(x) {
  x <- match.arg(x, names(tbl_ord_factors))
  unname(tbl_ord_factors[x])
}
switch_inertia <- function(x) {
  x <- match.arg(x, names(tbl_ord_factors))
  switch(tbl_ord_factors[x], rows = c(1, 0), cols = c(0, 1), dims = c(.5, .5))
}

method_classes <- function(generic.function) {
  stringr::str_replace(
    stringr::str_subset(
      rownames(attr(utils::methods(generic.function), "info")),
      paste0("^", generic.function, "\\.")
    ),
    paste0("^", generic.function, "\\."), ""
  )
}

tibble_pole <- function(nrow) {
  as_tibble(matrix(nrow = nrow, ncol = 0))
}

factor_coord <- function(x) {
  if (any(duplicated(x))) stop("Duplicated coordinates detected.")
  factor(x, levels = x)
}

# `ggbiplot` utilities

matrix_stat <- function(.matrix, stat) {
  .matrix <- match_factor(.matrix)
  if (stat == "identity") return(.matrix)
  stringr::str_c(.matrix, stat, sep = "_")
}
rows_stat <- function(stat) matrix_stat("rows", stat)
cols_stat <- function(stat) matrix_stat("cols", stat)

# get ordination coordinate mapping from a data frame in a stat layer:
# `ord_aes()` if specified, otherwise 'x' and 'y'
get_ord_aes <- function(data) {
  ord_cols <- grep("^\\.\\.coord[0-9]+$", names(data))
  if (length(ord_cols) == 0) ord_cols <- match(c("x", "y"), names(data))
  ord_cols
}

# restrict to a matrix factor
setup_rows_data <- function(data, params) {
  data[data$.matrix == "rows", -match(".matrix", names(data)), drop = FALSE]
}
setup_cols_data <- function(data, params) {
  data[data$.matrix == "cols", -match(".matrix", names(data)), drop = FALSE]
}
# restrict to a matrix factor and to the first two coordinates
# (for stat layers that only accept 'x' and 'y')
setup_rows_xy_data <- function(data, params) {
  data <- setup_rows_data(data, params)
  
  ord_cols <- get_ord_aes(data)
  # if necessary, restore 'x' and 'y' from first and second coordinates
  if (any(is.na(match(c("x", "y"), names(data)[ord_cols])))) {
    xy_cols <- match(c("..coord1", "..coord2"), names(data)[ord_cols])
    names(data)[xy_cols] <- c("x", "y")
  }
  
  data
}
setup_cols_xy_data <- function(data, params) {
  data <- setup_cols_data(data, params)
  
  ord_cols <- get_ord_aes(data)
  # if necessary, restore 'x' and 'y' from first and second coordinates
  if (any(is.na(match(c("x", "y"), names(data)[ord_cols])))) {
    xy_cols <- match(c("..coord1", "..coord2"), names(data)[ord_cols])
    names(data)[xy_cols] <- c("x", "y")
  }
  
  data
}

is_const <- function(x) length(unique(x)) == 1L

family_arg <- function(family_fun) {
  if (! is.null(family_fun)) {
    if (is.character(family_fun)) {
      family_fun <- get(family_fun, mode = "function", envir = parent.frame())
    }
    if (is.function(family_fun)) {
      family_fun <- family_fun()
    }
  }
  family_fun
}
