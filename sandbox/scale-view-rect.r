#' @title Dimensions-specific view scale constructor
#'
#' @description Construct a view scale for a fixed aspect ratio and specified
#'   window dimensions.
#'   
#' @details This ggproto was adapted (currently simply copied and renamed) from
#' `ggplot2:::ViewScale`.
#'
#' @export
ViewScaleRect <- ggproto(
  "ViewScaleRect", NULL,
  scale = ggproto(NULL, Scale),
  guide = guide_none(),
  position = NULL,
  aesthetics = NULL,
  name = waiver(),
  scale_is_discrete = FALSE,
  limits = NULL,
  continuous_range = NULL,
  breaks = NULL,
  minor_breaks = NULL,
  
  is_empty = function(self) {
    is.null(self$get_breaks()) && is.null(self$get_breaks_minor())
  },
  is_discrete = function(self) self$scale_is_discrete,
  dimension = function(self) self$continuous_range,
  get_limits = function(self) self$limits,
  get_breaks = function(self) self$breaks,
  get_breaks_minor = function(self) self$minor_breaks,
  get_labels = function(self, breaks = self$get_breaks()) {
    self$scale$get_labels(breaks)
  },
  get_transformation = function(self) self$scale$get_transformation(),
  rescale = function(self, x) {
    self$scale$rescale(x, self$limits, self$continuous_range)
  },
  reverse = function(self, x) {
    self$scale$rescale(x, rev(self$limits), rev(self$continuous_range))
  },
  map = function(self, x) {
    if (self$is_discrete()) {
      self$scale$map(x, self$limits)
    } else {
      x
    }
  },
  make_title = function(self, ...) {
    self$scale$make_title(...)
  },
  mapped_breaks = function(self) {
    self$map(self$get_breaks())
  },
  mapped_breaks_minor = function(self) {
    b <- self$get_breaks_minor()
    if (is.null(b)) {
      return(NULL)
    }
    self$map(b)
  },
  break_positions = function(self) {
    self$rescale(self$get_breaks())
  },
  break_positions_minor = function(self) {
    b <- self$get_breaks_minor()
    if (is.null(b)) {
      return(NULL)
    }
    
    self$rescale(b)
  }
)
