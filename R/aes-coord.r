#' @title Multidimensional coordinate mappings
#'
#' @description Allow stat layers to receive a sequence of positional variables
#'   rather than only `x` and `y`.
#' 

#' @details
#'
#' These functions coordinate (pun intended) the use of more than two positional
#' variables in plot layers. Pass multidimensional coordinates to a stat via
#' `mapping = aes_coord(...)` and reconcile the recovered coordinates with `x`
#' and `y` (which are overridden if present) in `Stat*$compute_*()`; see the
#' [StatChull] source code for an example. Use `aes_c()` to concatenate
#' aesthetic mappings.
#' 

#' @name aes-coord
#' @inheritParams base::c
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
aes_coord <- function(.data, prefix) {
  # select and order variable names
  coord_cols <- names(.data)[grep(paste0(prefix, "[0-9]+"), names(.data))]
  if (length(coord_cols) == 0L) 
    stop("No variables found that match '", prefix, "[0-9]+'.")
  coord_nums <- as.numeric(gsub(prefix, "", coord_cols))
  coord_order <- order(coord_nums)
  if (! all(coord_nums[coord_order] == seq_along(coord_nums)))
    rlang::warn(
      "Multidimensional coordinates are not indexed in sequence.",
      .frequency = "once", .frequency_id = "aes_coord"
    )
  coord_cols <- coord_cols[coord_order]
  
  # process names as aesthetics
  coord_mapping <- aes()
  for (i in seq_along(coord_cols)) {
    coord_mapping[[paste0("..coord", i)]] <- {{ rlang::sym(coord_cols[[i]]) }}
  }
  coord_mapping
}

#' @rdname aes-coord
#' @export
get_aes_coord <- function(data) {
  coord_cols <- grep("^\\.\\.coord[0-9]+$", names(data))
  if (length(coord_cols) == 0L) coord_cols <- match(c("x", "y"), names(data))
  coord_cols
}

# WARNING: This is experimental and might cause unforeseen problems.
#' @rdname aes-coord
#' @export
aes_c <- function(...) {
  c_list <- list(...)
  c_names <- lapply(c_list, names)
  c_dupe <- rev(duplicated(rev(unlist(c_names))))
  if (any(c_dupe)) {
    stop(
      "Some aesthetics matched by multiple arguments: ",
      paste0("`", paste0(unique(c_names[c_dupe]), collapse = "`, `"), "`")
    )
  }
  
  c_mapping <- aes()
  for (k in seq_along(c_list)) for (i in seq_along(c_list[[k]])) {
    c_mapping[[c_names[[k]][[i]]]] <- {{ c_list[[k]][[i]] }}
  }
  c_mapping
}
