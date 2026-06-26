#' @title Voronoi tiles
#'
#' @description Render Voronoi cells as polygon interiors and perimeter paths.
#'
#' @details `geom_voronoi()` is designed to pair with [`stat_voronoi()`].
#'  `GeomVoronoi$draw_panel()` un-nests the computed `cell`s, which overwrite
#'  `x` and `y`.
#'  
#'  Interiors are plotted using polygon grobs while perimeters are plotted using
#'  path grobs. Perimeter segments along the border are omitted. The `alpha`
#'  aesthetic only applies to interiors. If points coincide, then multiple cells
#'  are superimposed.
#'
#' @section Aesthetics: `geom_voronoi()` understands the following aesthetics
#'   (required aesthetics are in bold):
#' \itemize{
#'   \item **`cell`** (computed)
#'   \item `alpha`
#'   \item `colour`
#'   \item `fill`
#'   \item `linetype`
#'   \item `linewidth`
#' }
#' 

#' @import ggplot2
#' @importFrom dplyr mutate filter lead lag first last
#' @importFrom dplyr group_by ungroup group_modify
#' @inheritParams ggplot2::layer
#' @template param-geom
#' @template return-layer
#' @family geom layers
#' @example inst/examples/ex-geom-voronoi.r
#' @export
geom_voronoi <- function(
    mapping = NULL, data = NULL,
    stat = "voronoi", position = "identity",
    ...,
    na.rm = FALSE,
    show.legend = NA,
    inherit.aes = TRUE
) {
  layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomVoronoi,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @rdname gggda-ggproto
#' @format NULL
#' @usage NULL
#' @export
GeomVoronoi <- ggproto(
  "GeomVoronoi", GeomPolygon,
  
  required_aes = c("cell"),
  
  default_aes = aes(
    linewidth = 0.5, linetype = 1L,
    colour = "black", fill = "grey55", alpha = 0.5
  ),

  draw_panel = function(
    self, data, panel_params, coord
  ) {
    # save(self, data, panel_params, coord,
    #      file = "geom-voronoi-draw-panel.rda")
    # load(file = "geom-voronoi-draw-panel.rda")
    
    data <- subset(data, select = -c(x, y))
    data <- unnest(data, cell)
    data <- as.data.frame(data)
    
    if (is.null(data) || nrow(data) == 0L) {
      return(zeroGrob())
    }
    
    # polygon grob for cell faces
    face_data <- transform(data, colour = "transparent")
    # face polygon grob
    face_grob <- GeomPolygon$draw_panel(face_data, panel_params, coord)
    
    # path grob for cell edges, omitting border edges
    edge_data <- data %>%
      group_by(group) %>%
      mutate(
        # vertices to keep
        keep = ! border |
          ! lead(border, default = first(border)) |
          ! lag(border, default = last(border)),
        # where to start the path
        run_start = border & (! lead(border, default = first(border))),
        segment_id = cumsum(run_start) * keep
      ) %>%
      filter(keep) %>%
      # duplicate endpoints to close entirely interior paths
      group_modify(~ close_interior_loop(.x, start = "run_start")) %>%
      ungroup() %>%
      mutate(group = paste(group, segment_id, sep = "."))
    # don't use transparency for edges
    edge_data[["alpha"]] <- NA
    # edge path grob
    edge_grob <- if (nrow(edge_data) > 0L) {
      GeomPath$draw_panel(
        data = edge_data, panel_params = panel_params, coord = coord
      )
    } else {
      zeroGrob()
    }
    
    grob <- grid::grobTree(face_grob, edge_grob)
    grob$name <- grid::grobName(grob, "geom_voronoi")
    grob
  }
)

# bind a duplicate of the first row after the last
close_interior_loop <- function(.data, start) {
  if (any(.data[[start]])) { .data } else {
    bind_rows(.data, .data[1L, , drop = FALSE])
  }
}
