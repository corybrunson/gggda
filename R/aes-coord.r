#' @title Multidimensional coordinate mappings
#'
#' @description Allow stat layers to receive a sequence of positional variables
#'   rather than only `x` and `y`.
#' 

#' @details
#'
#' These functions coordinate (pun intended) the use of more than two positional
#' variables in plot layers. Pass multidimensional coordinates to a stat via
#' `mapping = coord_aes(...)` and reconcile the recovered coordinates with `x`
#' and `y` (which are overridden if present) in `Stat*$compute_*()`; see the
#' [StatChull] source code for an example.
#' 
#' The `uneval` method of [base::c()] allows for aesthetic mappings to be
#' concatenated.
#' 

#' @name aes-coord
#' @param .data,data A data frame. `.data` stands in for the data passed to
#'   [ggplot2::ggplot()], while `data` is expected to have been pre-processed
#'   before being passed to a `Stat*$compute_*()` function.
#' @param prefix A regular expression used to identify the coordinate columns
#'   of `.data`.
#' @inherit ggplot2::aes return
#' @seealso [ggplot2::aes()] for standard **ggplot2** aesthetic mappings.
NULL

#' @rdname aes-coord
#' @export
coord_aes <- function(.data, prefix) {
  # select and order variable names
  coord_cols <- names(.data)[grep(paste0(prefix, "[0-9]+"), names(.data))]
  if (length(coord_cols) == 0L) 
    stop("No variables found that match '", prefix, "[0-9]+'.")
  coord_nums <- as.numeric(gsub(prefix, "", coord_cols))
  coord_order <- order(coord_nums)
  if (! all(coord_nums[coord_order] == seq_along(coord_nums)))
    rlang::warn(
      "Multidimensional coordinates are not indexed in sequence.",
      .frequency = "once", .frequency_id = "coord_aes"
    )
  coord_cols <- coord_cols[coord_order]
  # process names as aesthetics
  coord_aes <- lapply(coord_cols, \(s) rlang::quo(!! rlang::sym(s)))
  names(coord_aes) <- paste0("..coord", seq_along(coord_aes))
  class(coord_aes) <- "uneval"
  coord_aes
}

#' @rdname aes-coord
#' @export
get_coord_aes <- function(data) {
  coord_cols <- grep("^\\.\\.coord[0-9]+$", names(data))
  if (length(coord_cols) == 0) coord_cols <- match(c("x", "y"), names(data))
  coord_cols
}

# WARNING: This is experimental and might cause unforeseen problems.
#' @rdname aes-coord
#' @export
c.uneval <- function(..., recursive = FALSE) {
  # NB: Unlike `modifyList()`, this does not overwrite duplicate aesthetics.
  res <- c(unlist(lapply(list(...), unclass)))
  class(res) <- "uneval"
  res
}
