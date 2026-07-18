# Centers and spreads for bivariate data

Centers and spreads for bivariate data

## Usage

``` r
stat_center(
  mapping = NULL,
  data = NULL,
  geom = "point",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  fun.data = NULL,
  fun = NULL,
  fun.center = NULL,
  fun.min = NULL,
  fun.max = NULL,
  fun.ord = NULL,
  fun.args = list()
)

stat_star(
  mapping = NULL,
  data = NULL,
  geom = "segment",
  position = "identity",
  show.legend = NA,
  inherit.aes = TRUE,
  ...,
  fun.data = NULL,
  fun = NULL,
  fun.center = NULL,
  fun.ord = NULL,
  fun.args = list()
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

  Additional arguments passed to
  [`ggplot2::layer()`](https://ggplot2.tidyverse.org/reference/layer.html).

- fun.data:

  A function that is given the complete data and should return a data
  frame with variables `ymin`, `y`, and `ymax`.

- fun.center:

  Deprecated alias to `fun`.

- fun.min, fun, fun.max:

  Alternatively, supply three individual functions that are each passed
  a vector of values and should return a single number.

- fun.ord:

  Alternatively to the
  [`ggplot2::stat_summary_bin()`](https://ggplot2.tidyverse.org/reference/stat_summary.html)
  parameters, supply a summary function that takes a matrix as input and
  returns a named column summary vector. Overridden by `fun.data` and
  `fun`, cannot be used together with `fun.min` and `fun.max`.

- fun.args:

  Optional additional arguments passed on to the functions.

## Value

A [ggproto](gggda-ggproto.md)
[layer](https://ggplot2.tidyverse.org/reference/layer.html).

## Multidimensional position aesthetics

This statistical transformation is compatible with the convenience
function [`aes_coord()`](aes-coord.md).

Some transformations (e.g. `stat_center()`) commute with projection to
the lower (1 or 2)-dimensional biplot space. If they detect aesthetics
of the form `..coord[0-9]+`, then `..coord1` and `..coord2` are
converted to `x` and `y` while any remaining are ignored.

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

- `xmin,ymin,xmax,ymax`:

  results of `fun.min,fun.max` applied to `x,y`

## See also

Other stat layers: [`stat_bagplot()`](stat_bagplot.md),
[`stat_chull()`](stat_chull.md), [`stat_cone()`](stat_cone.md),
[`stat_depth()`](stat_depth.md), [`stat_rule()`](stat_rule.md),
[`stat_scale()`](stat_scale.md), [`stat_spantree()`](stat_spantree.md)

## Examples

``` r
ggplot(mpg, aes(x = displ, y = cty, shape = drv)) +
  geom_point() +
  stat_center(fun = "median", size = 5, alpha = .5)


ggplot(mpg, aes(x = displ, y = cty, shape = drv, linetype = drv)) +
  stat_center(size = 3) +
  stat_star()
```
