#' @title **gggda** package
#'
#' @description This is a **[ggplot2](https://ggplot2.tidyverse.org/)** 
#'   extension for multivariate and geometric data analysis.
#'   

#' @docType package
#' @name gggda
#' @aliases gggda-package
#' @keywords internal
#'

#' @section Acknowledgments:
#'

#' This package was spun off from **[ordr::ordr]**.
#' Many users have identified problems and suggested improvements.
#'
#' Development benefitted from the use of equipment and the support of
#' colleagues at [UConn Health](https://health.uconn.edu/) and at [UF
#' Health](https://ufhealth.org/).
#' 
"_PACKAGE"

if (getRversion() >= "2.15.1") utils::globalVariables(c(
  "."
))

release_questions <- function() {
  c(
    "Do all functions have value sections detailing both structure and meaning?"
  )
}
