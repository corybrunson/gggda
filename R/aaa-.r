#' @title ggproto classes created and adapted for gggda
#'
#' @description **gggda** introduces several [ggproto][ggplot2::ggproto] classes
#'   for coordinate systems, statistical transformations, and geometric
#'   constructions specific to multivariate analysis or following geometric data
#'   analysis principles.
#'
#' @details The new ggprotos are inspired by two entangled but distinct threads
#'   in multivariate data visualization: First, several geometric constructions
#'   have been proposed to generalize both numeric and graphical summaries of
#'   univariate data to the bivariate setting. Among these are various "peeling"
#'   procedures like that by successive convex hulls, which generalize the
#'   concept of rank (Green, 1981); and the depth-based bag-and-bolster plot,
#'   designed as a bivariate analog of the box-and-whisker plot (Rousseeuw &al,
#'   1999). Second, the use of biplots to visualize singular value--decomposed
#'   data benefits from being able to encode variables with different graphical
#'   elements than the markers used to encode cases---for example, vectors
#'   (arrows emanating from the origin; Gabriel, 1971), calibrated axes (Gower &
#'   Hand, 1996), and prediction regions (Gardner & le Roux, 2002).
#'
#' @template ref-green1981
#' @template ref-rousseeuw1999
#' @template ref-gabriel1971
#' @template ref-gower1996
#' @template ref-gardner2002
#'
#' @seealso [`ggplot2::ggplot2-ggproto`] and [ggplot2::ggproto] for explanations
#'   of base ggproto classes in **ggplot2** and how to create new ones.
#' @name gggda-ggproto
NULL
