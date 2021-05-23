#' @title Functionality for linear discriminant analysis ('lda') objects
#'
#' @description These methods extract data from, and attribute new data to,
#'   objects of class `"lda"` and `"lda_ord"` as returned by [MASS::lda()] and
#'   [lda_ord()].
#'
#' @details
#'
#' See [lda-ord] for details.
#' 

#' @name methods-lda
#' @include ord-tbl.r
#' @template param-methods
#' @example inst/examples/ex-methods-lda-iris.r
NULL

#' @rdname methods-lda
#' @export
as_tbl_ord.lda <- as_tbl_ord_default

#' @rdname methods-lda
#' @export
as_tbl_ord.lda_ord <- as_tbl_ord.lda

#' @rdname methods-lda
#' @export
recover_rows.lda <- function(x) {
  centroid <- colSums(x$prior * x$means)
  scale(x$means, center = centroid, scale = FALSE) %*% x$scaling
}

#' @rdname methods-lda
#' @export
recover_rows.lda_ord <- recover_rows.lda

#' @rdname methods-lda
#' @export
recover_cols.lda <- function(x) {
  x$scaling
}

#' @rdname methods-lda
#' @export
recover_cols.lda_ord <- function(x) {
  if (is.null(attr(x, "axes.scale"))) {
    x$scaling
  } else {
    attr(x, "axes.scale") %*% x$scaling
  }
}

#' @rdname methods-lda
#' @export
recover_inertia.lda <- function(x) x$svd^2

#' @rdname methods-lda
#' @export
recover_inertia.lda_ord <- recover_inertia.lda

#' @rdname methods-lda
#' @export
recover_coord.lda <- function(x) colnames(x$scaling)

#' @rdname methods-lda
#' @export
recover_coord.lda_ord <- recover_coord.lda

#' @rdname methods-lda
#' @export
recover_conference.lda <- function(x) {
  # `MASS::lda()` incorporates inertia into scores
  c(1, 0)
}

#' @rdname methods-lda
#' @export
recover_conference.lda_ord <- recover_conference.lda

#' @rdname methods-lda
#' @export
augmentation_rows.lda <- function(x) {
  res <- if (is.null(rownames(x$means))) {
    tibble_pole(nrow(x$means))
  } else {
    tibble(.name = rownames(x$means))
  }
  res <- transform(
    res,
    .prior = x$prior,
    .counts = x$counts
  )
  # discriminant scores as supplementary points
  olddata <- try(recover_olddata_lda(x))
  if (inherits(olddata, "try-error")) {
    warning("Could not locate data used to fit '", deparse(substitute(x)), "'.")
    return(res)
  }
  grouping <- try(recover_grouping_lda(x))
  res_sup <- if (is.null(rownames(olddata))) {
    if (inherits(grouping, "try-error")) {
      tibble_pole(nrow = x$N)
    } else {
      tibble(.grouping = grouping)
    }
  } else {
    if (inherits(grouping, "try-error")) {
      tibble(.name = rownames(olddata))
    } else {
      tibble(.name = rownames(olddata), .grouping = grouping)
    }
  }
  if (".grouping" %in% names(res_sup)) res$.grouping <- res$.name
  res$.supplement <- FALSE
  res_sup$.supplement <- TRUE
  as_tibble(dplyr::bind_rows(res, res_sup))
}

#' @rdname methods-lda
#' @export
augmentation_rows.lda_ord <- function(x) {
  res <- if (is.null(rownames(x$means))) {
    tibble_pole(nrow(x$means))
  } else {
    tibble(.name = rownames(x$means))
  }
  res <- transform(
    res,
    .prior = x$prior,
    .counts = x$counts
  )
  # discriminant scores as supplementary points
  olddata <- if (is.null(attr(x, "x"))) {
    try(recover_olddata_lda(x))
  } else attr(x, "x")
  if (inherits(olddata, "try-error") |
      (! is.matrix(olddata) & ! is.data.frame(olddata))) {
    warning("Could not locate data used to fit '", deparse(substitute(x)), "'.")
    return(res)
  }
  grouping <- if (is.null(attr(x, "grouping"))) {
    try(recover_grouping_lda(x))
  } else attr(x, "grouping")
  res_sup <- if (is.null(rownames(olddata))) {
    if (inherits(grouping, "try-error")) {
      tibble_pole(nrow = x$N)
    } else {
      tibble(.grouping = grouping)
    }
  } else {
    if (inherits(grouping, "try-error")) {
      tibble(.name = rownames(olddata))
    } else {
      tibble(.name = rownames(olddata), .grouping = grouping)
    }
  }
  if (".grouping" %in% names(res_sup)) res$.grouping <- res$.name
  res$.supplement <- FALSE
  res_sup$.supplement <- TRUE
  as_tibble(dplyr::bind_rows(res, res_sup))
}

#' @rdname methods-lda
#' @export
augmentation_cols.lda <- function(x) {
  .name <- rownames(x$scaling)
  if (is.null(.name)) {
    tibble_pole(nrow(x$scaling))
  } else {
    tibble(.name = .name)
  }
}

#' @rdname methods-lda
#' @export
augmentation_cols.lda_ord <- augmentation_cols.lda

#' @rdname methods-lda
#' @export
augmentation_coord.lda <- function(x) {
  tibble(
    .name = factor_coord(recover_coord(x)),
    .svd = x$svd
  )
}

#' @rdname methods-lda
#' @export
augmentation_coord.lda_ord <- augmentation_coord.lda

#' @rdname methods-lda
#' @export
supplementation_rows.lda <- function(x) {
  olddata <- if (is.null(attr(x, "x"))) {
    try(recover_olddata_lda(x))
  } else attr(x, "x")
  if (inherits(olddata, "try-error") |
      (! is.matrix(olddata) & ! is.data.frame(olddata))) {
    warning("Could not locate data used to fit '", deparse(substitute(x)), "'.")
    return(NULL)
  }
  centroid <- colSums(x$prior * x$means)
  scale(olddata, center = centroid, scale = FALSE) %*% x$scaling
}

#' @rdname methods-lda
#' @export
supplementation_rows.lda_ord <- supplementation_rows.lda

recover_olddata_lda <- function(object) {
  # simplified from `MASS:::predict.lda()`
  if(!is.null(Terms <- object$terms)) { # formula fit
    Terms <- delete.response(Terms)
    olddata <- model.frame(object)
    x <- model.matrix(Terms, olddata, contrasts = object$contrasts)
    xint <- match("(Intercept)", colnames(x), nomatch = 0L)
    if(xint > 0L) x <- x[, -xint, drop = FALSE]
  } else { # matrix or data-frame fit
    olddata <- eval.parent(object$call$x)
    if(!is.null(nas <- object$call$na.action))
      olddata <- eval(call(nas, olddata))
    if(is.null(dim(olddata)))
      dim(olddata) <- c(1L, length(olddata))  # a row vector
    x <- as.matrix(olddata)		# to cope with dataframes
  }
  x
}

recover_grouping_lda <- function(object) {
  if(!is.null(Terms <- object$terms)) { # formula fit
    resp <- deparse(object$call$formula[[2]])
    grouping <- eval.parent(object$call$data)[[resp]]
  } else { # matrix or data-frame fit
    grouping <- eval.parent(object$call[[3]])
  }
  grouping
}
