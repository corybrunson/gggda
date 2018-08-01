#' Functionality for singular value decompositions
#' 

svd <- function(x, LINPACK = FALSE){
  res <- base::svd(x = x, nu = min(nrow(x), ncol(x)), nv = min(nrow(x), ncol(x)), LINPACK = LINPACK)
  class(res) <- "svd"
  attr(res, "x") <- x
  res
}

as_tbl_ord.svd <- as_tbl_ord_default

recover_u.svd <- function(x){
  res <- x$u
  colnames(res) <- recover_coord.svd(x)
  rownames(res) <- rownames(attr(x, "x"))
  res
}

recover_v.svd <- function(x){
  res <- x$v
  colnames(res) <- recover_coord.svd(x)
  rownames(res) <- t(colnames(attr(x, "x")))
  res
}

recover_coord.svd <- function(x) paste0("SV", 1:ncol(x$u))

augment_u.svd <- function(x){
  .name <- rownames(attr(x, "x"))
  if (is.null(.name)) {
    tibble_pole(nrow(attr(x, "x")))
  } else {
    tibble(.name = .name)
  }
}

augment_v.svd <- function(x){
  .name <- colnames(attr(x, "x"))
  if (is.null(.name)) {
    tibble_pole(ncol(attr(x, "x")))
  } else {
    tibble(.name = .name)
  }
}

augment_coord.svd <- function(x){
  tibble(
    .name = recover_coord(x),
    .value = x$d[1:ncol(x$u)]
  )
}

reconstruct.svd <- function(x){
  x$u %*% diag(x$d) %*% t(x$v)
}

get_singular_values <- function(x){
  if (class(x) != "svd"){
    stop("get_singular_values() can only be called on a singular value decomposition output")
  }
  else {
    x$d
  }
}

get_diagonal_matrix <- function(x){
  if (class(x) != "svd"){
    stop("get_diagonal_matrix() can only be called on a singular value decomposition output")
  }
  else {
    diag(x$d)
  }
}

