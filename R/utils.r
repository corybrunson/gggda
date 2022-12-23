
#' @importFrom rlang "%||%"

is_const <- function(x) length(unique(x)) == 1L

default_arrow <- grid::arrow(
  angle = 30,
  length = unit(.02, "native"),
  ends = "last",
  type = "open"
)
