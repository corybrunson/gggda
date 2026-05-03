#' @title Transformations with respect to reference data
#'

#' @description Compute statistics with respect to a reference data set with
#' shared positional variables.
#' 

#' @details
#'
#' Often in geometric data analysis a statistical transformation applied to data
#' \eqn{X} will also depend on data \eqn{Y}, for example when drawing the
#' projections of vectors \eqn{X} onto vectors \eqn{Y}. The stat layer
#' `stat_referent()` accepts \eqn{Y} as an argument to the `referent` argument
#' and pre-processes them using the existing positional aesthetic mappings to
#' `x` and `y`.
#'
#' If a function is passed to `referent`, then the reference data are obtained
#' by evaluating the function at the primary `data`. Alongside borrowing the
#' aesthetic mappings, the evaluation is done during addition via
#' [ggplot2::ggplot_add()] of the layer of custom class `LayerRef`.
#'
#' The ggproto can be used as a parent to more elaborate statistical
#' transformations, or the stat can be paired with geoms that expect the
#' `referent` argument and use it to position their transformations of \eqn{X}.
#' It pairs by default to [ggplot2::geom_blank()] so as to prevent possibly
#' confusing output.
#' 

#' @inheritParams ggplot2::layer
#' @template param-layer
#' @inheritParams ggplot2::ggplot_add
#' @param referent The reference data set, admitting the same 3 options as
#'   `data`; see Details.
#' @template return-layer
#' @family biplot layers
#' @example inst/examples/ex-stat-referent.r
#' @export
stat_referent <- function(
    mapping = NULL, data = NULL,
    geom = "blank", position = "identity",
    referent = NULL,
    show.legend = NA,
    inherit.aes = TRUE,
    ...
) {
  LayerRef <- layer(
    data = data,
    mapping = mapping,
    stat = StatReferent,
    geom = geom,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      referent = referent,
      na.rm = FALSE,
      ...
    )
  )
  
  # undocumented class for custom `ggplot_add()` method
  class(LayerRef) <- c("LayerRef", class(LayerRef))
  LayerRef
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
StatReferent <- ggproto(
  "StatReferent", Stat,
  
  required_aes = c("x", "y"),
  
  setup_params = function(data, params) {
    
    # if `mapping` parameter is missing, print informative message
    if (is.null(params$mapping)) {
      stop(
        "Aesthetic mapping not found in `$setup_params()`;\n",
        "  did you pass a referential stat to `layer(stat = ...)`?"
      )
      
      return(params)
    }
    
    # map aesthetics from referent data, in current environment
    # required `x` and `y` aesthetics should be in `data`
    # (code adapted from `ggplot2:::Layer$compute_aesthetics()`)
    # NB: No checks are conducted here as in `$compute_aesthetics()`.
    # TODO: Maybe do this in `LayerRef()` rather than here?
    if (! is.null(params$referent)) {
      # replace with mappings as applied to primary data
      params$referent <- lapply(
        params$mapping,
        rlang::eval_tidy, data = as.data.frame(params$referent)
      )
      params$referent <- as.data.frame(params$referent)
    }
    
    # discard combined mapping parameter
    params$mapping <- NULL
    
    params
  },
  
  compute_group = function(data, scales,
                           referent = NULL) data
)

# QUESTION: Why are the arguments apparently out of order?
#' @rdname stat_referent
#' @export
ggplot_add.LayerRef <- function(object, plot, ...) {
  
  # if function, then replace with evaluation at primary data
  if (is.function(object$stat_params$referent)) {
    object$stat_params$referent <- object$stat_params$referent(plot$data)
  }
  
  # store global position mappings as a parameter
  object$stat_params$mapping <- plot$mapping[c("x", "y")]
  
  NextMethod()
}
