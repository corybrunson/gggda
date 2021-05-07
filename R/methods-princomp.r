#' @title Functionality for principal components analysis ('princomp') objects
#'
#' @description These methods extract data from, and attribute new data to,
#'   objects of class `"princomp"` as returned by [stats::princomp()].
#'
#' @name methods-princomp
#' @include ord-tbl.r
#' @template param-methods
#' @example inst/examples/ex-methods-princomp-iris.r
#' @author Emily Paul
NULL

#' @rdname methods-princomp
#' @export
as_tbl_ord.princomp <- as_tbl_ord_default

#' @rdname methods-princomp
#' @export
recover_rows.princomp <- function(x) {
  x[["scores"]]
}

#' @rdname methods-princomp
#' @export
recover_cols.princomp <- function(x) {
  unclass(x[["loadings"]])
}

#' @rdname methods-princomp
#' @export
recover_inertia.princomp <- function(x) {
  (x[["sdev"]] ^ 2) * x[["n.obs"]]
}

#' @rdname methods-princomp
#' @export
recover_coord.princomp <- function(x) {
  colnames(x[["scores"]])
}

#' @rdname methods-princomp
#' @export
recover_conference.princomp <- function(x) {
  # `stats::princomp()` returns the rotated data
  c(1, 0)
}

#' @rdname methods-princomp
#' @export
augmentation_rows.princomp <- function(x) {
  .name <- rownames(x[["scores"]])
  if (is.null(.name)) {
    tibble_pole(nrow(x[["scores"]]))
  } else {
    tibble(.name = .name)
  }
}

#' @rdname methods-princomp
#' @export
augmentation_cols.princomp <- function(x) {
  .name <- rownames(x[["loadings"]])
  res <- if (is.null(.name)) {
    tibble_pole(nrow(x[["loadings"]]))
  } else {
    tibble(.name = .name)
  }
  bind_cols(res, tibble(
    .center = x[["center"]],
    .scale = x[["scale"]]
  ))
}

#' @rdname methods-princomp
#' @export
augmentation_coord.princomp <- function(x) {
  tibble(
    .name = factor_coord(recover_coord.princomp(x)),
    .sdev = x[["sdev"]]
  )
}
