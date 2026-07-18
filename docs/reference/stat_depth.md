# Depth estimates and contours

Estimate data depth using
[`ddalpha::depth.()`](https://rdrr.io/pkg/ddalpha/man/depth..html).

## Usage

``` r
stat_depth(
  mapping = NULL,
  data = NULL,
  geom = "contour",
  position = "identity",
  contour = TRUE,
  contour_var = "depth",
  notion = "zonoid",
  notion_params = list(),
  n = 100L,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)

stat_depth_filled(
  mapping = NULL,
  data = NULL,
  geom = "contour_filled",
  position = "identity",
  contour = TRUE,
  contour_var = "depth",
  notion = "zonoid",
  notion_params = list(),
  n = 100L,
  show.legend = NA,
  inherit.aes = TRUE,
  ...
)
```

## Arguments

- mapping:

  Set of aesthetic mappings created by
  [`aes()`](https://ggplot2.tidyverse.org/reference/aes.html). If
  specified and `inherit.aes = TRUE` (the default), it is combined with
  the default mapping at the top level of the plot. You must supply
  `mapping` if there is no plot mapping.

- data:

  The data to be displayed in this layer. There are three options:

  If `NULL`, the default, the data is inherited from the plot data as
  specified in the call to
  [`ggplot()`](https://ggplot2.tidyverse.org/reference/ggplot.html).

  A `data.frame`, or other object, will override the plot data. All
  objects will be fortified to produce a data frame. See
  [`fortify()`](https://ggplot2.tidyverse.org/reference/fortify.html)
  for which variables will be created.

  A `function` will be called with a single argument, the plot data. The
  return value must be a `data.frame`, and will be used as the layer
  data. A `function` can be created from a `formula` (e.g.
  `~ head(.x, 10)`).

- geom:

  The geometric object to use to display the data for this layer. When
  using a `stat_*()` function to construct a layer, the `geom` argument
  can be used to override the default coupling between stats and geoms.
  The `geom` argument accepts the following:

  - A `Geom` ggproto subclass, for example `GeomPoint`.

  - A string naming the geom. To give the geom as a string, strip the
    function name of the `geom_` prefix. For example, to use
    `geom_point()`, give the geom as `"point"`.

  - For more information and other ways to specify the geom, see the
    [layer
    geom](https://ggplot2.tidyverse.org/reference/layer_geoms.html)
    documentation.

- position:

  A position adjustment to use on the data for this layer. This can be
  used in various ways, including to prevent overplotting and improving
  the display. The `position` argument accepts the following:

  - The result of calling a position function, such as
    `position_jitter()`. This method allows for passing extra arguments
    to the position.

  - A string naming the position adjustment. To give the position as a
    string, strip the function name of the `position_` prefix. For
    example, to use `position_jitter()`, give the position as
    `"jitter"`.

  - For more information and other ways to specify the position, see the
    [layer
    position](https://ggplot2.tidyverse.org/reference/layer_positions.html)
    documentation.

- contour:

  If `TRUE`, contour the results of the depth estimation.

- contour_var:

  Character string identifying the variable to contour by. Can be one of
  `"depth"` or `"ndepth"`. See the section on computed variables for
  details.

- notion:

  Character; the name of the depth function (passed to
  [`ddalpha::depth.()`](https://rdrr.io/pkg/ddalpha/man/depth..html)).

- notion_params:

  List of additional parameters passed via `...` to
  [`ddalpha::depth.()`](https://rdrr.io/pkg/ddalpha/man/depth..html).

- n:

  Number of grid points in each direction.

- show.legend:

  logical. Should this layer be included in the legends? `NA`, the
  default, includes if any aesthetics are mapped. `FALSE` never
  includes, and `TRUE` always includes. It can also be a named logical
  vector to finely select the aesthetics to display. To include legend
  keys for all levels, even when no data exists, use `TRUE`. If `NA`,
  all levels are shown in legend, but unobserved levels are omitted.

- inherit.aes:

  If `FALSE`, overrides the default aesthetics, rather than combining
  with them. This is most useful for helper functions that define both
  data and aesthetics and shouldn't inherit behaviour from the default
  plot specification, e.g.
  [`annotation_borders()`](https://ggplot2.tidyverse.org/reference/annotation_borders.html).

- ...:

  Arguments passed on to
  [`ggplot2::geom_contour`](https://ggplot2.tidyverse.org/reference/geom_contour.html)

  `bins`

  : Number of contour bins. Overridden by `breaks`.

  `binwidth`

  : The width of the contour bins. Overridden by `bins`.

  `breaks`

  : One of:

    - Numeric vector to set the contour breaks

    - A function that takes the range of the data and binwidth as input
      and returns breaks as output. A function can be created from a
      formula (e.g. ~ fullseq(.x, .y)).

    Overrides `binwidth` and `bins`. By default, this is a vector of
    length ten with [`pretty()`](https://rdrr.io/r/base/pretty.html)
    breaks.

## Value

A [ggproto](gggda-ggproto.md)
[layer](https://ggplot2.tidyverse.org/reference/layer.html).

## Details

Depth is an extension of the univariate notion of rank to bivariate (and
sometimes multivariate) data (Rousseeuw &al, 1999). It comes in several
flavors and is the basis for [bagplots](stat_bagplot.md).

`stat_depth()` is adapted from
[`ggplot2::stat_density_2d()`](https://ggplot2.tidyverse.org/reference/geom_density_2d.html)
and returns depth values over a grid in the same format, so it is neatly
paired with
[`ggplot2::geom_contour()`](https://ggplot2.tidyverse.org/reference/geom_contour.html).

## Multidimensional position aesthetics

This statistical transformation is compatible with the convenience
function [`aes_coord()`](aes-coord.md).

Some transformations (e.g. [`stat_center()`](stat_center.md)) commute
with projection to the lower (1 or 2)-dimensional biplot space. If they
detect aesthetics of the form `..coord[0-9]+`, then `..coord1` and
`..coord2` are converted to `x` and `y` while any remaining are ignored.

Other transformations (e.g. [`stat_spantree()`](stat_spantree.md)) yield
different results in a lower-dimensional biplot when they are computed
before versus after projection. If the stat layer detects these
aesthetics, then the transformation is performed before projection, and
the results in the first two dimensions are returned as `x` and `y`.

A small number of transformations ([`stat_rule()`](stat_rule.md)) are
incompatible with these aesthetics but will accept
[`aes_coord()`](aes-coord.md) without warning.

## Computed variables

These are calculated during the statistical transformation and can be
accessed with [delayed
evaluation](https://ggplot2.tidyverse.org/reference/aes_eval.html).

`stat_depth()` and `stat_depth_filled()` compute different variables
depending on whether contouring is turned on or off. With contouring off
(`contour = FALSE`), both stats behave the same, and the following
variables are provided:

- `depth`:

  the depth estimate

- `ndepth`:

  depth estimate, scaled to a maximum of 1

With contouring on (`contour = TRUE`), either
[`ggplot2::stat_contour()`](https://ggplot2.tidyverse.org/reference/geom_contour.html)
or
[`ggplot2::stat_contour_filled()`](https://ggplot2.tidyverse.org/reference/geom_contour.html)
is run after the depth estimate has been obtained, and the computed
variables are determined by these stats.

## References

Rousseeuw PJ, Ruts I, & Tukey JW (1999) "The Bagplot: A Bivariate
Boxplot". *The American Statistician*, **53**(4): 382–387.
[doi:10.1080/00031305.1999.10474494](https://doi.org/10.1080/00031305.1999.10474494)

## See also

Other stat layers: [`stat_bagplot()`](stat_bagplot.md),
[`stat_center()`](stat_center.md), [`stat_chull()`](stat_chull.md),
[`stat_cone()`](stat_cone.md), [`stat_rule()`](stat_rule.md),
[`stat_scale()`](stat_scale.md), [`stat_spantree()`](stat_spantree.md)

## Examples

``` r
# base Motor Trends plot
b <- ggplot(mtcars, aes(wt, disp)) + geom_point()

# depth raster
b + geom_raster(stat = "depth", aes(fill = after_stat(depth)))

# depth grid
b + stat_depth(
  geom = "point", contour = FALSE,
  aes(size = after_stat(depth)), n = 20
)


# depth contours
b + geom_contour(stat = "depth", contour = TRUE)

# depth bands
b + geom_contour_filled(stat = "depth_filled", contour = TRUE, alpha = .75)

# contours colored by group
b + stat_depth(aes(color = factor(cyl)))

# custom depth notion
b + stat_depth(
  aes(color = factor(cyl)),
  notion = "halfspace", notion_params = list(exact = TRUE)
)


# contours faceted by group
b + stat_depth_filled(alpha = .75) +
  facet_wrap(facets = vars(factor(cyl)))

# scaled to the unit interval
b + stat_depth_filled(contour_var = "ndepth", alpha = .75) +
  facet_wrap(facets = vars(factor(cyl)))
```
