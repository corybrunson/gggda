
#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

#' @importFrom rlang "%||%"

is_const <- function(x) length(unique(x)) == 1L
